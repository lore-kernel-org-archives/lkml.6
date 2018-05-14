Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeENSxx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:53:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:45332 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752055AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244657"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 12/15] x86/split_lock: Add sysfs interface to show and control BIOS split lock setting
Date: Mon, 14 May 2018 11:52:22 -0700
Message-Id: <1526323945-211107-13-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the split lock BIOS setting inherits from BIOS setting
before kernel boots.

The sysfs interface /sys/kernel/split_lock/bios shows the BIOS split
lock setting: 0 for disabled and 1 for enabled.

User can override the BIOS setting by writing 1 to enable split
lock in BIOS and write 0 to disable split lock in BIOS.

When control flow comes to BIOS (e.g. in S3, S4, S5, and EFI runtime),
kernel sets the BIOS setting and restores to kernel setting after
coming back to kernel.

In cases (e.g. real time) user wants to identify split lock cases in BIOS
even when there is no BIOS setting before kernel boot, the user may
explicitly enable split lock for BIOS. Getting bang whenever there is
a split lock in BIOS helps identify and fix the BIOS split lock issue.

Please note: System Management Mode (SMM) is out of control of
kernel. So this interface cannot control split lock in SMM.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/split_lock.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 02b461c48b3c..020af331594d 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -411,9 +411,43 @@ user_mode_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute split_lock_ac_user = __ATTR_RW(user_mode);
 
+static ssize_t
+bios_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", split_lock_ac_bios);
+}
+
+static ssize_t
+bios_store(struct kobject *kobj, struct kobj_attribute *attr,
+	   const char *buf, size_t count)
+{
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != DISABLE_SPLIT_LOCK_AC && val != ENABLE_SPLIT_LOCK_AC)
+		return -EINVAL;
+
+	/* No need to update setting if new setting is the same as old one. */
+	if (val == split_lock_ac_bios)
+		return count;
+
+	mutex_lock(&split_lock_mutex);
+	split_lock_ac_bios = val;
+	mutex_unlock(&split_lock_mutex);
+
+	return count;
+}
+
+static struct kobj_attribute split_lock_ac_bios_enable = __ATTR_RW(bios);
+
 static struct attribute *split_lock_attrs[] = {
 	&split_lock_ac_enable.attr,
 	&split_lock_ac_user.attr,
+	&split_lock_ac_bios_enable.attr,
 	NULL,
 };
 
-- 
2.5.0
