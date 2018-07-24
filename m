Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AAFC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FD220852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FD220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbeGXVtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:49:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:61798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388838AbeGXVtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:49:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 13:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,399,1526367600"; 
   d="scan'208";a="74172840"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2018 13:40:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH 3/7] x86/intel_rdt: Enable user to trigger pseudo-locked region restore
Date:   Tue, 24 Jul 2018 13:40:14 -0700
Message-Id: <1905054751d4388177b14de220b6adb708e04c3d.1532463771.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1532463771.git.reinette.chatre@intel.com>
References: <cover.1532463771.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a new debugfs file that user can use to trigger the restoration
of a specific Cache Pseudo-Locked region at any time.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt          | 18 ++++++---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 45 ++++++++++++++++++++-
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index f662d3c530e5..4b124a54eee3 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -507,6 +507,17 @@ Cache Pseudo-Locking Debugging Interface
 The pseudo-locking debugging interface is enabled by default (if
 CONFIG_DEBUG_FS is enabled) and can be found in /sys/kernel/debug/resctrl.
 
+The debugging interface supports the restoration and measurement of the cache
+pseudo-locked region. When a pseudo-locked region is created a new debugfs
+directory is created for it in debugfs as /sys/kernel/debug/resctrl/<newdir>.
+Two write-only files, pseudo_lock_measure and pseudo_lock_restore, are present
+in this directory.
+
+A Cache Pseudo-Locked region can be restored by writing one of 'Yy1' or 'on'
+to pseudo_lock_restore. This would be needed if it is found that the memory
+has been evicted from the cache and will result in the memory being
+pseudo-locked to the original cache region.
+
 There is no explicit way for the kernel to test if a provided memory
 location is present in the cache. The pseudo-locking debugging interface uses
 the tracing infrastructure to provide two ways to measure cache residency of
@@ -525,11 +536,8 @@ the pseudo-locked region:
    the system, if any other measurements are in progress the counters and
    their corresponding event registers will be clobbered.
 
-When a pseudo-locked region is created a new debugfs directory is created for
-it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
-write-only file, pseudo_lock_measure, is present in this directory. The
-measurement on the pseudo-locked region depends on the number, 1 or 2,
-written to this debugfs file. Since the measurements are recorded with the
+The measurement on the pseudo-locked region depends on the number, 1 or 2,
+written to pseudo_lock_measure. Since the measurements are recorded with the
 tracing infrastructure the relevant tracepoints need to be enabled before the
 measurement is triggered.
 
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 693f99594e9f..246cff17ce66 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1290,7 +1290,7 @@ static int _pseudo_lock_restore(struct rdtgroup *rdtgrp)
 	return ret;
 }
 
-static int __attribute__ ((unused)) pseudo_lock_restore(struct rdtgroup *rdtgrp)
+static int pseudo_lock_restore(struct rdtgroup *rdtgrp)
 {
 	int ret;
 
@@ -1302,6 +1302,43 @@ static int __attribute__ ((unused)) pseudo_lock_restore(struct rdtgroup *rdtgrp)
 	return ret;
 }
 
+static ssize_t pseudo_lock_restore_trigger(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct rdtgroup *rdtgrp = file->private_data;
+	size_t buf_size;
+	char buf[32];
+	int ret;
+	bool bv;
+
+	buf_size = min(count, (sizeof(buf) - 1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] = '\0';
+	ret = strtobool(buf, &bv);
+	if (ret == 0 && bv) {
+		ret = debugfs_file_get(file->f_path.dentry);
+		if (ret)
+			return ret;
+		ret = pseudo_lock_restore(rdtgrp);
+		if (ret == 0)
+			ret = count;
+		debugfs_file_put(file->f_path.dentry);
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct file_operations pseudo_restore_fops = {
+	.write = pseudo_lock_restore_trigger,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 /**
  * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
  * @rdtgrp: resource group to which pseudo-lock region belongs
@@ -1385,10 +1422,14 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
 		plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
 						      debugfs_resctrl);
-		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
+		if (!IS_ERR_OR_NULL(plr->debugfs_dir)) {
 			debugfs_create_file("pseudo_lock_measure", 0200,
 					    plr->debugfs_dir, rdtgrp,
 					    &pseudo_measure_fops);
+			debugfs_create_file("pseudo_lock_restore", 0200,
+					    plr->debugfs_dir, rdtgrp,
+					    &pseudo_restore_fops);
+		}
 	}
 
 	dev = device_create(pseudo_lock_class, NULL,
-- 
2.17.0

