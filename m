Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeENSwc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:52:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:45335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244650"
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
Subject: [PATCH 10/15] x86/split_lock: Add a sysfs interface to allow user to enable or disable split lock during run time
Date: Mon, 14 May 2018 11:52:20 -0700
Message-Id: <1526323945-211107-11-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface /sys/kernel/split_lock/enable is added to allow user to
control split lock and show current split lock status during run time.

Writing 1 to the file enables split lock and writing 0 disables split
lock.

Reading the file shows current split lock eanble/disable status:
disabled when 0 and enabled when 1.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/split_lock.c | 65 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index bc66c21b0ca9..5d399b09c1c8 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -30,6 +30,8 @@ static DEFINE_SPINLOCK(sl_lock);
 static void delayed_reenable_split_lock(struct work_struct *w);
 static DECLARE_DELAYED_WORK(delayed_work, delayed_reenable_split_lock);
 
+static DEFINE_MUTEX(split_lock_mutex);
+
 /*
  * On processors not supporting #AC exception for split lock feature,
  * MSR_TEST_CTL may not exist or MSR_TEST_CTL exists but the bit 29 is
@@ -277,6 +279,60 @@ static struct syscore_ops split_lock_syscore_ops = {
 	.resume		= split_lock_bsp_resume,
 };
 
+static ssize_t
+enable_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", split_lock_ac);
+}
+
+static ssize_t enable_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	u32 val, l, h;
+	int cpu, ret;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != DISABLE_SPLIT_LOCK_AC && val != ENABLE_SPLIT_LOCK_AC)
+		return -EINVAL;
+
+	/* No need to update MSR if new setting is the same as old one. */
+	if (val == split_lock_ac)
+		return count;
+
+	mutex_lock(&split_lock_mutex);
+
+	split_lock_ac = val;
+	/* Read split lock setting on the current CPU. */
+	rdmsr(MSR_TEST_CTL, l, h);
+	/* Change the split lock setting. */
+	if (split_lock_ac == DISABLE_SPLIT_LOCK_AC)
+		l &= ~MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	else
+		l |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	/* Update the split lock setting on all online CPUs. */
+	for_each_online_cpu(cpu)
+		wrmsr_on_cpu(cpu, MSR_TEST_CTL, l, h);
+
+	mutex_unlock(&split_lock_mutex);
+
+	return count;
+}
+
+static struct kobj_attribute split_lock_ac_enable = __ATTR_RW(enable);
+
+static struct attribute *split_lock_attrs[] = {
+	&split_lock_ac_enable.attr,
+	NULL,
+};
+
+static struct attribute_group split_lock_attr_group = {
+	.attrs		= split_lock_attrs,
+	.name		= "split_lock",
+};
+
 static int __init split_lock_init(void)
 {
 	int ret;
@@ -284,11 +340,15 @@ static int __init split_lock_init(void)
 	if (!split_lock_ac_supported)
 		return -ENODEV;
 
+	ret = sysfs_create_group(kernel_kobj, &split_lock_attr_group);
+	if (ret)
+		goto out_fail;
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"x86/split_lock:online:",
 				NULL, split_lock_offline);
 	if (ret < 0)
-		goto out_fail;
+		goto out_group;
 
 	register_syscore_ops(&split_lock_syscore_ops);
 
@@ -296,6 +356,9 @@ static int __init split_lock_init(void)
 
 	return 0;
 
+out_group:
+	sysfs_remove_group(kernel_kobj, &split_lock_attr_group);
+
 out_fail:
 	return ret;
 }
-- 
2.5.0
