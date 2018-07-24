Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C46C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8247D20883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8247D20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeGXVtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:61798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388819AbeGXVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172844"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 4/7] x86/intel_rdt: Support restore of all pseudo-locked regions
Date:   Tue, 24 Jul 2018 13:40:15 -0700
Message-Id: <97783445912151c8fde002865bcc3ab5bb0576be.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An instruction like wbinvd would evict all data from pseudo-locked
regions within the cache hierarchy on which the instruction was run.

Add support for offloading the restoration of all pseudo-locked
regions since it is not possible to know which pseudo-locked regions
specifically are in need of restoration. The restoration could be
triggered from anywhere at which time the work to do so is scheduled
on the system wide workqueue. Since this is a severe event that could
be handled automatically (not triggered by user space) a warning is
printed to user when the restoration runs.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 42 +++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 246cff17ce66..d395e6982467 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -52,6 +52,12 @@ static unsigned int pseudo_lock_major;
 static unsigned long pseudo_lock_minor_avail = GENMASK(MINORBITS, 0);
 static struct class *pseudo_lock_class;
 
+/*
+ * Support the offloading of pseudo-locked region restoration.
+ */
+static void pseudo_lock_restore_work_fn(struct work_struct *work);
+static DECLARE_WORK(pseudo_lock_restore_work, pseudo_lock_restore_work_fn);
+
 /**
  * get_prefetch_disable_bits - prefetch disable bits of supported platforms
  *
@@ -1510,6 +1516,42 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
 	pseudo_lock_free(rdtgrp);
 }
 
+/**
+ * pseudo_lock_restore_work_fn - Restore all pseudo-locked regions
+ * @work: the work
+ *
+ * Instructions like wbinvd would cause pseudo-locked data to be evicted.
+ * Cases like this may be detected but it may not be obvious which
+ * pseudo-locked regions are affected. To handle severe cases like this
+ * pseudo_lock_restore_work_fn() will restore all pseudo-locked regions
+ * on the system.
+ * Since this may occur automatically a WARN will be triggered to notify
+ * the user of this event.
+ */
+static void pseudo_lock_restore_work_fn(struct work_struct *work)
+{
+	struct rdtgroup *rdtgrp;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (WARN_ON_ONCE(rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)) {
+			pr_err("Automatic restore of Pseudo-Locked region %s\n",
+			       rdtgrp->kn->name);
+			_pseudo_lock_restore(rdtgrp);
+		}
+	}
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+}
+
+void intel_rdtgroup_pseudo_lock_restore_all(void)
+{
+	if (static_branch_unlikely(&rdt_enable_key))
+		schedule_work(&pseudo_lock_restore_work);
+}
+EXPORT_SYMBOL(intel_rdtgroup_pseudo_lock_restore_all);
+
 static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
 {
 	struct rdtgroup *rdtgrp;
-- 
2.17.0

