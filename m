Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF396C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7412120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7412120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeGXVtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:61798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388819AbeGXVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172834"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:29 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 2/7] x86/intel_rdt: Enable a pseudo-locked region to be restored
Date:   Tue, 24 Jul 2018 13:40:13 -0700
Message-Id: <8c4815c47eebb1380e761f333988ff3a85f63082.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory that has been pseudo-locked to cache could be evicted if
an instruction like WBINVD has been used on a core in the cache
hierarchy. When this happens the region of cache would remained
orphaned.

Make it possible for pseudo-locked memory that may have been evicted
to be restored to its original cache region. In preparation for
the restoration to be triggered from user space as well as automatically
within the kernel the restoration does not assume that the
last_cmd_status log facility is available, instead, if any errors do
occur during restoration, they will be written to the kernel log buffer.

Temporarily add the unused attribute to the function. It will be removed
at the time the function is used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 111 ++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index f80c58f8adc3..693f99594e9f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -453,6 +453,16 @@ static int pseudo_lock_fn(void *_rdtgrp)
 #endif /* CONFIG_X86_64 */
 #endif /* CONFIG_KASAN */
 
+	/*
+	 * In the case of a pseudo-locked region restore, if the thread
+	 * does not get on the CPU and the process attempting
+	 * a restore is interrupted then the thread remains in runnable
+	 * state but the closid would have been freed and nothing is
+	 * waiting on this restoration anymore.
+	 */
+	if (!closid_allocated(rdtgrp->closid))
+		return 0;
+
 	/*
 	 * Make sure none of the allocated memory is cached. If it is we
 	 * will get a cache hit in below loop from outside of pseudo-locked
@@ -1191,6 +1201,107 @@ static const struct file_operations pseudo_measure_fops = {
 	.llseek = default_llseek,
 };
 
+/**
+ * _pseudo_lock_restore - Pseudo-Lock possibly evicted memory again
+ * @rdtgrp: Resource group to which pseudo-locked region belongs
+ *
+ * Pseudo-locked memory could be evicted from the cache with an instruction
+ * like WBINVD or when the cache is affected by platform power savings. In
+ * support of recovering from these situations the pseudo-locked region can
+ * be restored by pseudo-locking the memory again.
+ *
+ * Return: 0 if region was successfully restored, <0 on failure.
+ */
+static int _pseudo_lock_restore(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr = rdtgrp->plr;
+	struct task_struct *thread;
+	struct rdt_resource *r;
+	struct rdt_domain *dom;
+	int closid;
+	int ret;
+
+	plr->cpu = cpumask_first(&plr->d->cpu_mask);
+
+	if (!cpu_online(plr->cpu)) {
+		pr_err("Failed to restore region %s. Associated CPU offline.\n",
+		       rdtgrp->kn->name);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	closid = closid_alloc();
+	if (closid < 0) {
+		pr_err("Failed to restore region %s. No free closid.\n",
+		       rdtgrp->kn->name);
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	rdtgrp->closid = closid;
+
+	/*
+	 * Associate the newly allocated closid with the CBM of the
+	 * Cache Pseudo-Locked region.
+	 */
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(dom, &r->domains, list)
+			dom->have_new_ctrl = false;
+	}
+
+	plr->d->new_ctrl = plr->cbm;
+	plr->d->have_new_ctrl = true;
+
+	ret = update_domains(plr->r, rdtgrp->closid);
+	if (ret < 0) {
+		pr_err("Unable to program CBM of region %s\n",
+		       rdtgrp->kn->name);
+		goto out_closid;
+	}
+
+	plr->thread_done = 0;
+
+	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
+					cpu_to_node(plr->cpu),
+					"pseudo_lock/%u", plr->cpu);
+	if (IS_ERR(thread)) {
+		ret = PTR_ERR(thread);
+		pr_err("Locking thread error %d during restore of %s\n",
+		       ret, rdtgrp->kn->name);
+		goto out_closid;
+	}
+
+	kthread_bind(thread, plr->cpu);
+	wake_up_process(thread);
+
+	ret = wait_event_interruptible(plr->lock_thread_wq,
+				       plr->thread_done == 1);
+	if (ret < 0) {
+		pr_err("Locking thread interrupted during restore of %s\n",
+		       rdtgrp->kn->name);
+		goto out_closid;
+	}
+
+	ret = 0;
+
+out_closid:
+	closid_free(rdtgrp->closid);
+out:
+	return ret;
+}
+
+static int __attribute__ ((unused)) pseudo_lock_restore(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+	ret = _pseudo_lock_restore(rdtgrp);
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
 /**
  * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
  * @rdtgrp: resource group to which pseudo-lock region belongs
-- 
2.17.0

