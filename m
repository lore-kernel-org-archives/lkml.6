Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033063AbeE0PsR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:48:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:28379 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032820AbeE0PqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741108"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 14/16] x86/split_lock: Add debugfs interface to show and control firmware setting for split lock
Date: Sun, 27 May 2018 08:46:03 -0700
Message-Id: <1527435965-202085-15-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the firmware setting for split lock inherits from firmware
setting before kernel boots.

In cases like hard real time, user wants to identify split lock issues in
firmware even when #AC for split lock is not enabled in firmware before
kernel boots. The user may explicitly enable #AC for split lock for
firmware. Getting bang whenever there is a split lock in firmware helps
identify and fix the firmware split lock issue.

The debugfs interface /sys/kernel/debug/x86/split_lock/firmware shows the
firmware split lock setting: 0 for disabled and 1 for enabled.

User can override the firmware setting by writing 1 to enable #AC for
split lock in firmware and write 0 to disable #AC for split lock in
firmware.

When control flow comes to firmware (e.g. in S3, S4, S5, and EFI runtime),
kernel sets the firmware setting for split lock. Kernel restores to kernel
setting for split lock after coming back to kernel.

Please note: System Management Mode (SMM) is out of control of
kernel. So this interface cannot control split lock in SMM.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/test_ctl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index d774485a5ca4..8bdc01067be9 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -516,12 +516,38 @@ static const struct file_operations user_mode_ops = {
 	.llseek	= default_llseek,
 };
 
+static int firmware_show(void *data, u64 *val)
+{
+	*val = split_lock_ac_firmware;
+
+	return 0;
+}
+
+static int firmware_store(void *data, u64 val)
+{
+	if (val != DISABLE_SPLIT_LOCK_AC && val != ENABLE_SPLIT_LOCK_AC)
+		return -EINVAL;
+
+	/* No need to update setting if new setting is the same as old one. */
+	if (val == split_lock_ac_firmware)
+		return 0;
+
+	mutex_lock(&split_lock_mutex);
+	split_lock_ac_firmware = val;
+	mutex_unlock(&split_lock_mutex);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(firmware_ops, firmware_show, firmware_store, "%llx\n");
+
 static int __init debugfs_setup_split_lock(void)
 {
 	struct debugfs_file debugfs_files[] = {
 		{"enable",      0600, &enable_ops},
 		{"kernel_mode",	0600, &kernel_mode_ops },
 		{"user_mode",	0600, &user_mode_ops },
+		{"firmware",	0600, &firmware_ops },
 	};
 	struct dentry *split_lock_dir, *fd;
 	int i;
-- 
2.5.0
