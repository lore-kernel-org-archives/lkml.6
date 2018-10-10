Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD31C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C347F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJKGcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:32:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:10107 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeJKGcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:32:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 16:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,366,1534834800"; 
   d="scan'208";a="98329227"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.156])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2018 16:07:42 -0700
Subject: [workqueue/driver-core PATCH v2 1/5] workqueue: Provide
 queue_work_node to queue work near a given NUMA node
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        alexander.h.duyck@linux.intel.com
Date:   Wed, 10 Oct 2018 16:07:42 -0700
Message-ID: <20181010230715.10609.83647.stgit@localhost.localdomain>
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

This patch provides a new function queue_work_node which is meant to
schedule work on a "random" CPU of the requested NUMA node. The main
motivation for this is to help assist asynchronous init to better improve
boot times for devices that are local to a specific node.

For now we just default to the first CPU that is in the intersection of the
cpumask of the node and the online cpumask. The only exception is if the
CPU is local to the node we will just use the current CPU. This should work
for our purposes as we are currently only using this for unbound work so
the CPU will be translated to a node anyway instead of being directly used.

As we are only using the first CPU to represent the NUMA node for now I am
limiting the scope of the function so that it can only be used with unbound
workqueues.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---

RFC->v1:
    Simplified queue_work_near to just convert node into a CPU.
v1->v2:
    Renamed queue_work_near to queue_work_node
    Added WARN_ON_ONCE if we use queue_work_node with per-cpu workqueue

 include/linux/workqueue.h |    2 +
 kernel/workqueue.c        |   84 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 60d673e15632..1f50c1e586e7 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -463,6 +463,8 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
+extern bool queue_work_node(int node, struct workqueue_struct *wq,
+			    struct work_struct *work);
 extern bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			struct delayed_work *work, unsigned long delay);
 extern bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0280deac392e..6ed7c2eb84b0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1492,6 +1492,90 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 }
 EXPORT_SYMBOL(queue_work_on);
 
+/**
+ * workqueue_select_cpu_near - Select a CPU based on NUMA node
+ * @node: NUMA node ID that we want to bind a CPU from
+ *
+ * This function will attempt to find a "random" cpu available on a given
+ * node. If there are no CPUs available on the given node it will return
+ * WORK_CPU_UNBOUND indicating that we should just schedule to any
+ * available CPU if we need to schedule this work.
+ */
+static int workqueue_select_cpu_near(int node)
+{
+	int cpu;
+
+	/* No point in doing this if NUMA isn't enabled for workqueues */
+	if (!wq_numa_enabled)
+		return WORK_CPU_UNBOUND;
+
+	/* Delay binding to CPU if node is not valid or online */
+	if (node < 0 || node >= MAX_NUMNODES || !node_online(node))
+		return WORK_CPU_UNBOUND;
+
+	/* Use local node/cpu if we are already there */
+	cpu = raw_smp_processor_id();
+	if (node == cpu_to_node(cpu))
+		return cpu;
+
+	/* Use "random" otherwise know as "first" online CPU of node */
+	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
+
+	/* If CPU is valid return that, otherwise just defer */
+	return (cpu < nr_cpu_ids) ? cpu : WORK_CPU_UNBOUND;
+}
+
+/**
+ * queue_work_node - queue work on a "random" cpu for a given NUMA node
+ * @node: NUMA node that we are targeting the work for
+ * @wq: workqueue to use
+ * @work: work to queue
+ *
+ * We queue the work to a "random" CPU within a given NUMA node. The basic
+ * idea here is to provide a way to somehow associate work with a given
+ * NUMA node.
+ *
+ * This function will only make a best effort attempt at getting this onto
+ * the right NUMA node. If no node is requested or the requested node is
+ * offline then we just fall back to standard queue_work behavior.
+ *
+ * Currently the "random" CPU ends up being the first available CPU in the
+ * intersection of cpu_online_mask and the cpumask of the node, unless we
+ * are running on the node. In that case we just use the current CPU.
+ *
+ * Return: %false if @work was already on a queue, %true otherwise.
+ */
+bool queue_work_node(int node, struct workqueue_struct *wq,
+		     struct work_struct *work)
+{
+	unsigned long flags;
+	bool ret = false;
+
+	/*
+	 * This current implementation is specific to unbound workqueues.
+	 * Specifically we only return the first available CPU for a given
+	 * node instead of cycling through individual CPUs within the node.
+	 *
+	 * If this is used with a per-cpu workqueue then the logic in
+	 * workqueue_select_cpu_near would need to be updated to allow for
+	 * some round robin type logic.
+	 */
+	WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND));
+
+	local_irq_save(flags);
+
+	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
+		int cpu = workqueue_select_cpu_near(node);
+
+		__queue_work(cpu, wq, work);
+		ret = true;
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(queue_work_node);
+
 void delayed_work_timer_fn(struct timer_list *t)
 {
 	struct delayed_work *dwork = from_timer(dwork, t, timer);

