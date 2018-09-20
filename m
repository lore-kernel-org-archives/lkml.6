Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F723ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1E521533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1E521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeIUEPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:15:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:14939 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbeIUEPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:15:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 15:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,282,1534834800"; 
   d="scan'208";a="85286849"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2018 15:29:45 -0700
Subject: [PATCH v4 4/5] async: Add support for queueing on specific node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, mingo@kernel.org, dave.hansen@intel.com,
        jglisse@redhat.com, akpm@linux-foundation.org, logang@deltatee.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com
Date:   Thu, 20 Sep 2018 15:29:45 -0700
Message-ID: <20180920222938.19464.34102.stgit@localhost.localdomain>
In-Reply-To: <20180920215824.19464.8884.stgit@localhost.localdomain>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two new variants of the async_schedule_ functions
that allow scheduling on a specific node. These functions are
async_schedule_on and async_schedule_on_domain which end up mapping to
async_schedule and async_schedule_domain but provide NUMA node specific
functionality. The original functions were moved to inline function
definitions that call the new functions while passing NUMA_NO_NODE.

The main motivation behind this is to address the need to be able to
schedule NVDIMM init work on specific NUMA nodes in order to improve
performance of memory initialization.

One additional change I made is I dropped the "extern" from the function
prototypes in the async.h kernel header since they aren't needed.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/linux/async.h |   20 +++++++++++++++++---
 kernel/async.c        |   36 +++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/async.h b/include/linux/async.h
index 6b0226bdaadc..9878b99cbb01 100644
--- a/include/linux/async.h
+++ b/include/linux/async.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/numa.h>
 
 typedef u64 async_cookie_t;
 typedef void (*async_func_t) (void *data, async_cookie_t cookie);
@@ -37,9 +38,22 @@ struct async_domain {
 	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
 				      .registered = 0 }
 
-extern async_cookie_t async_schedule(async_func_t func, void *data);
-extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
-					    struct async_domain *domain);
+async_cookie_t async_schedule_on(async_func_t func, void *data, int node);
+async_cookie_t async_schedule_on_domain(async_func_t func, void *data, int node,
+					struct async_domain *domain);
+
+static inline async_cookie_t async_schedule(async_func_t func, void *data)
+{
+	return async_schedule_on(func, data, NUMA_NO_NODE);
+}
+
+static inline async_cookie_t
+async_schedule_domain(async_func_t func, void *data,
+		      struct async_domain *domain)
+{
+	return async_schedule_on_domain(func, data, NUMA_NO_NODE, domain);
+}
+
 void async_unregister_domain(struct async_domain *domain);
 extern void async_synchronize_full(void);
 extern void async_synchronize_full_domain(struct async_domain *domain);
diff --git a/kernel/async.c b/kernel/async.c
index a893d6170944..1d7ce81c1949 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -56,6 +56,7 @@ synchronization with the async_synchronize_full() function, before returning
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/cpu.h>
 
 #include "workqueue_internal.h"
 
@@ -149,8 +150,11 @@ static void async_run_entry_fn(struct work_struct *work)
 	wake_up(&async_done);
 }
 
-static async_cookie_t __async_schedule(async_func_t func, void *data, struct async_domain *domain)
+static async_cookie_t __async_schedule(async_func_t func, void *data,
+				       struct async_domain *domain,
+				       int node)
 {
+	int cpu = WORK_CPU_UNBOUND;
 	struct async_entry *entry;
 	unsigned long flags;
 	async_cookie_t newcookie;
@@ -194,30 +198,40 @@ static async_cookie_t __async_schedule(async_func_t func, void *data, struct asy
 	/* mark that this task has queued an async job, used by module init */
 	current->flags |= PF_USED_ASYNC;
 
+	/* guarantee cpu_online_mask doesn't change during scheduling */
+	get_online_cpus();
+
+	if (node >= 0 && node < MAX_NUMNODES && node_online(node))
+		cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
+
 	/* schedule for execution */
-	queue_work(system_unbound_wq, &entry->work);
+	queue_work_on(cpu, system_unbound_wq, &entry->work);
+
+	put_online_cpus();
 
 	return newcookie;
 }
 
 /**
- * async_schedule - schedule a function for asynchronous execution
+ * async_schedule_on - schedule a function for asynchronous execution
  * @func: function to execute asynchronously
  * @data: data pointer to pass to the function
+ * @node: NUMA node to complete the work on
  *
  * Returns an async_cookie_t that may be used for checkpointing later.
  * Note: This function may be called from atomic or non-atomic contexts.
  */
-async_cookie_t async_schedule(async_func_t func, void *data)
+async_cookie_t async_schedule_on(async_func_t func, void *data, int node)
 {
-	return __async_schedule(func, data, &async_dfl_domain);
+	return __async_schedule(func, data, &async_dfl_domain, node);
 }
-EXPORT_SYMBOL_GPL(async_schedule);
+EXPORT_SYMBOL_GPL(async_schedule_on);
 
 /**
- * async_schedule_domain - schedule a function for asynchronous execution within a certain domain
+ * async_schedule_on_domain - schedule a function for asynchronous execution within a certain domain
  * @func: function to execute asynchronously
  * @data: data pointer to pass to the function
+ * @node: NUMA node to complete the work on
  * @domain: the domain
  *
  * Returns an async_cookie_t that may be used for checkpointing later.
@@ -226,12 +240,12 @@ async_cookie_t async_schedule(async_func_t func, void *data)
  * synchronization domain is specified via @domain.  Note: This function
  * may be called from atomic or non-atomic contexts.
  */
-async_cookie_t async_schedule_domain(async_func_t func, void *data,
-				     struct async_domain *domain)
+async_cookie_t async_schedule_on_domain(async_func_t func, void *data, int node,
+					struct async_domain *domain)
 {
-	return __async_schedule(func, data, domain);
+	return __async_schedule(func, data, domain, node);
 }
-EXPORT_SYMBOL_GPL(async_schedule_domain);
+EXPORT_SYMBOL_GPL(async_schedule_on_domain);
 
 /**
  * async_synchronize_full - synchronize all asynchronous function calls

