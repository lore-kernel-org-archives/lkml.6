Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB26C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A2620870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A2620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJKGdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:33:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:10238 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:33:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 16:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,366,1534834800"; 
   d="scan'208";a="98329309"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.156])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2018 16:08:21 -0700
Subject: [workqueue/driver-core PATCH v2 2/5] async: Add support for
 queueing on specific NUMA node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 10 Oct 2018 16:08:21 -0700
Message-ID: <20181010230747.10609.15866.stgit@localhost.localdomain>
In-Reply-To: <20181010230435.10609.77825.stgit@localhost.localdomain>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces four new variants of the async_schedule_ functions
that allow scheduling on a specific NUMA node.

The first two functions are async_schedule_near and
async_schedule_near_domain which end up mapping to async_schedule and
async_schedule_domain but provide NUMA node specific functionality. They
replace the original functions which were moved to inline function
definitions that call the new functions while passing NUMA_NO_NODE.

The second two functions are async_schedule_dev and
async_schedule_dev_domain which provide NUMA specific functionality when
passing a device as the data member and that device has a NUMA node other
than NUMA_NO_NODE.

The main motivation behind this is to address the need to be able to
schedule device specific init work on specific NUMA nodes in order to
improve performance of memory initialization.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

v1->v2:
    Replaced call to queue_work_near with call to queue_work_node

 include/linux/async.h |   36 +++++++++++++++++++++++++++++++++---
 kernel/async.c        |   47 ++++++++++++++++++++++-------------------------
 2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/include/linux/async.h b/include/linux/async.h
index 6b0226bdaadc..1f6cb0d50263 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -14,6 +14,8 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/numa.h>
+#include <linux/device.h>
 
 typedef u64 async_cookie_t;
 typedef void (*async_func_t) (void *data, async_cookie_t cookie);
@@ -37,9 +39,37 @@ struct async_domain {
 	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
 				      .registered = 0 }
 
-extern async_cookie_t async_schedule(async_func_t func, void *data);
-extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
-					    struct async_domain *domain);
+async_cookie_t async_schedule_near(async_func_t func, void *data,
+				   int node);
+async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
+					  int node,
+					  struct async_domain *domain);
+
+static inline async_cookie_t async_schedule(async_func_t func, void *data)
+{
+	return async_schedule_near(func, data, NUMA_NO_NODE);
+}
+
+static inline async_cookie_t
+async_schedule_domain(async_func_t func, void *data,
+		      struct async_domain *domain)
+{
+	return async_schedule_near_domain(func, data, NUMA_NO_NODE, domain);
+}
+
+static inline async_cookie_t
+async_schedule_dev(async_func_t func, struct device *dev)
+{
+	return async_schedule_near(func, dev, dev_to_node(dev));
+}
+
+static inline async_cookie_t
+async_schedule_dev_domain(async_func_t func, struct device *dev,
+			  struct async_domain *domain)
+{
+	return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
+}
+
 void async_unregister_domain(struct async_domain *domain);
 extern void async_synchronize_full(void);
 extern void async_synchronize_full_domain(struct async_domain *domain);
diff --git a/kernel/async.c b/kernel/async.c
index a893d6170944..c393c169dbcb 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -149,7 +149,21 @@ static void async_run_entry_fn(struct work_struct *work)
 	wake_up(&async_done);
 }
 
-static async_cookie_t __async_schedule(async_func_t func, void *data, struct async_domain *domain)
+/**
+ * async_schedule_near_domain - schedule a function for asynchronous execution within a certain domain
+ * @func: function to execute asynchronously
+ * @data: data pointer to pass to the function
+ * @node: NUMA node that we want to schedule this on or close to
+ * @domain: the domain
+ *
+ * Returns an async_cookie_t that may be used for checkpointing later.
+ * @domain may be used in the async_synchronize_*_domain() functions to
+ * wait within a certain synchronization domain rather than globally.  A
+ * synchronization domain is specified via @domain.  Note: This function
+ * may be called from atomic or non-atomic contexts.
+ */
+async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
+					  int node, struct async_domain *domain)
 {
 	struct async_entry *entry;
 	unsigned long flags;
@@ -195,43 +209,26 @@ static async_cookie_t __async_schedule(async_func_t func, void *data, struct asy
 	current->flags |= PF_USED_ASYNC;
 
 	/* schedule for execution */
-	queue_work(system_unbound_wq, &entry->work);
+	queue_work_node(node, system_unbound_wq, &entry->work);
 
 	return newcookie;
 }
+EXPORT_SYMBOL_GPL(async_schedule_near_domain);
 
 /**
- * async_schedule - schedule a function for asynchronous execution
+ * async_schedule_near - schedule a function for asynchronous execution
  * @func: function to execute asynchronously
  * @data: data pointer to pass to the function
+ * @node: NUMA node that we want to schedule this on or close to
  *
  * Returns an async_cookie_t that may be used for checkpointing later.
  * Note: This function may be called from atomic or non-atomic contexts.
  */
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
- *
- * Returns an async_cookie_t that may be used for checkpointing later.
- * @domain may be used in the async_synchronize_*_domain() functions to
- * wait within a certain synchronization domain rather than globally.  A
- * synchronization domain is specified via @domain.  Note: This function
- * may be called from atomic or non-atomic contexts.
- */
-async_cookie_t async_schedule_domain(async_func_t func, void *data,
-				     struct async_domain *domain)
+async_cookie_t async_schedule_near(async_func_t func, void *data, int node)
 {
-	return __async_schedule(func, data, domain);
+	return async_schedule_near_domain(func, data, node, &async_dfl_domain);
 }
-EXPORT_SYMBOL_GPL(async_schedule_domain);
+EXPORT_SYMBOL_GPL(async_schedule_near);
 
 /**
  * async_synchronize_full - synchronize all asynchronous function calls

