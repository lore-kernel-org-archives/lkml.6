Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A74C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429AD20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429AD20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeLERZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:25:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:60118 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeLERZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:25:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:25:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="107551099"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga003.jf.intel.com with ESMTP; 05 Dec 2018 09:25:44 -0800
Subject: [driver-core PATCH v8 6/9] async: Add support for queueing on
 specific NUMA node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     mcgrof@kernel.org, linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 05 Dec 2018 09:25:44 -0800
Message-ID: <154403074455.11544.16174906665321008150.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce four new variants of the async_schedule_ functions that allow
scheduling on a specific NUMA node.

The first two functions are async_schedule_near and
async_schedule_near_domain end up mapping to async_schedule and
async_schedule_domain, but provide NUMA node specific functionality. They
replace the original functions which were moved to inline function
definitions that call the new functions while passing NUMA_NO_NODE.

The second two functions are async_schedule_dev and
async_schedule_dev_domain which provide NUMA specific functionality when
passing a device as the data member and that device has a NUMA node other
than NUMA_NO_NODE.

The main motivation behind this is to address the need to be able to
schedule device specific init work on specific NUMA nodes in order to
improve performance of memory initialization.

I have seen a significant improvement in initialziation time for persistent
memory as a result of this approach. In the case of 3TB of memory on a
single node the initialization time in the worst case went from 36s down to
about 26s for a 10s improvement. As such the data shows a general benefit
for affinitizing the async work to the node local to the device.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/async.h |   82 +++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/async.c        |   53 +++++++++++++++++---------------
 2 files changed, 108 insertions(+), 27 deletions(-)

diff --git a/include/linux/async.h b/include/linux/async.h
index 6b0226bdaadc..f81d6dbffe68 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -14,6 +14,8 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/numa.h>
+#include <linux/device.h>
 
 typedef u64 async_cookie_t;
 typedef void (*async_func_t) (void *data, async_cookie_t cookie);
@@ -37,9 +39,83 @@ struct async_domain {
 	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
 				      .registered = 0 }
 
-extern async_cookie_t async_schedule(async_func_t func, void *data);
-extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
-					    struct async_domain *domain);
+async_cookie_t async_schedule_node(async_func_t func, void *data,
+				   int node);
+async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
+					  int node,
+					  struct async_domain *domain);
+
+/**
+ * async_schedule - schedule a function for asynchronous execution
+ * @func: function to execute asynchronously
+ * @data: data pointer to pass to the function
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * Note: This function may be called from atomic or non-atomic contexts.
+ */
+static inline async_cookie_t async_schedule(async_func_t func, void *data)
+{
+	return async_schedule_node(func, data, NUMA_NO_NODE);
+}
+
+/**
+ * async_schedule_domain - schedule a function for asynchronous execution within a certain domain
+ * @func: function to execute asynchronously
+ * @data: data pointer to pass to the function
+ * @domain: the domain
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * @domain may be used in the async_synchronize_*_domain() functions to
+ * wait within a certain synchronization domain rather than globally.
+ * Note: This function may be called from atomic or non-atomic contexts.
+ */
+static inline async_cookie_t
+async_schedule_domain(async_func_t func, void *data,
+		      struct async_domain *domain)
+{
+	return async_schedule_node_domain(func, data, NUMA_NO_NODE, domain);
+}
+
+/**
+ * async_schedule_dev - A device specific version of async_schedule
+ * @func: function to execute asynchronously
+ * @dev: device argument to be passed to function
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * @dev is used as both the argument for the function and to provide NUMA
+ * context for where to run the function. By doing this we can try to
+ * provide for the best possible outcome by operating on the device on the
+ * CPUs closest to the device.
+ * Note: This function may be called from atomic or non-atomic contexts.
+ */
+static inline async_cookie_t
+async_schedule_dev(async_func_t func, struct device *dev)
+{
+	return async_schedule_node(func, dev, dev_to_node(dev));
+}
+
+/**
+ * async_schedule_dev_domain - A device specific version of async_schedule_domain
+ * @func: function to execute asynchronously
+ * @dev: device argument to be passed to function
+ * @domain: the domain
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * @dev is used as both the argument for the function and to provide NUMA
+ * context for where to run the function. By doing this we can try to
+ * provide for the best possible outcome by operating on the device on the
+ * CPUs closest to the device.
+ * @domain may be used in the async_synchronize_*_domain() functions to
+ * wait within a certain synchronization domain rather than globally.
+ * Note: This function may be called from atomic or non-atomic contexts.
+ */
+static inline async_cookie_t
+async_schedule_dev_domain(async_func_t func, struct device *dev,
+			  struct async_domain *domain)
+{
+	return async_schedule_node_domain(func, dev, dev_to_node(dev), domain);
+}
+
 void async_unregister_domain(struct async_domain *domain);
 extern void async_synchronize_full(void);
 extern void async_synchronize_full_domain(struct async_domain *domain);
diff --git a/kernel/async.c b/kernel/async.c
index 4932e9193fa3..59ce133eef11 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -148,7 +148,25 @@ static void async_run_entry_fn(struct work_struct *work)
 	wake_up(&async_done);
 }
 
-static async_cookie_t __async_schedule(async_func_t func, void *data, struct async_domain *domain)
+/**
+ * async_schedule_node_domain - NUMA specific version of async_schedule_domain
+ * @func: function to execute asynchronously
+ * @data: data pointer to pass to the function
+ * @node: NUMA node that we want to schedule this on or close to
+ * @domain: the domain
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * @domain may be used in the async_synchronize_*_domain() functions to
+ * wait within a certain synchronization domain rather than globally.
+ *
+ * Note: This function may be called from atomic or non-atomic contexts.
+ *
+ * The node requested will be honored on a best effort basis. If the node
+ * has no CPUs associated with it then the work is distributed among all
+ * available CPUs.
+ */
+async_cookie_t async_schedule_node_domain(async_func_t func, void *data,
+					  int node, struct async_domain *domain)
 {
 	struct async_entry *entry;
 	unsigned long flags;
@@ -194,43 +212,30 @@ static async_cookie_t __async_schedule(async_func_t func, void *data, struct asy
 	current->flags |= PF_USED_ASYNC;
 
 	/* schedule for execution */
-	queue_work(system_unbound_wq, &entry->work);
+	queue_work_node(node, system_unbound_wq, &entry->work);
 
 	return newcookie;
 }
+EXPORT_SYMBOL_GPL(async_schedule_node_domain);
 
 /**
- * async_schedule - schedule a function for asynchronous execution
+ * async_schedule_node - NUMA specific version of async_schedule
  * @func: function to execute asynchronously
  * @data: data pointer to pass to the function
+ * @node: NUMA node that we want to schedule this on or close to
  *
  * Returns an async_cookie_t that may be used for checkpointing later.
  * Note: This function may be called from atomic or non-atomic contexts.
- */
-async_cookie_t async_schedule(async_func_t func, void *data)
-{
-	return __async_schedule(func, data, &async_dfl_domain);
-}
-EXPORT_SYMBOL_GPL(async_schedule);
-
-/**
- * async_schedule_domain - schedule a function for asynchronous execution within a certain domain
- * @func: function to execute asynchronously
- * @data: data pointer to pass to the function
- * @domain: the domain
  *
- * Returns an async_cookie_t that may be used for checkpointing later.
- * @domain may be used in the async_synchronize_*_domain() functions to
- * wait within a certain synchronization domain rather than globally.  A
- * synchronization domain is specified via @domain.  Note: This function
- * may be called from atomic or non-atomic contexts.
+ * The node requested will be honored on a best effort basis. If the node
+ * has no CPUs associated with it then the work is distributed among all
+ * available CPUs.
  */
-async_cookie_t async_schedule_domain(async_func_t func, void *data,
-				     struct async_domain *domain)
+async_cookie_t async_schedule_node(async_func_t func, void *data, int node)
 {
-	return __async_schedule(func, data, domain);
+	return async_schedule_node_domain(func, data, node, &async_dfl_domain);
 }
-EXPORT_SYMBOL_GPL(async_schedule_domain);
+EXPORT_SYMBOL_GPL(async_schedule_node);
 
 /**
  * async_synchronize_full - synchronize all asynchronous function calls

