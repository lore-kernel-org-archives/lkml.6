Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeENSws (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:52:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:55035 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbeENSwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244653"
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
Subject: [PATCH 11/15] x86/split_lock: Add sysfs interface to control user mode behavior
Date: Mon, 14 May 2018 11:52:21 -0700
Message-Id: <1526323945-211107-12-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interface /sys/kernel/split_lock/user_mode to allow user to
choose to either generate SIGBUS (default) when hitting split lock in
user or re-execute the user faulting instruction without generating
SIGBUS signal.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/split_lock.c | 89 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 5d399b09c1c8..02b461c48b3c 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -32,6 +32,19 @@ static DECLARE_DELAYED_WORK(delayed_work, delayed_reenable_split_lock);
 
 static DEFINE_MUTEX(split_lock_mutex);
 
+enum {
+	USER_MODE_SIGBUS,
+	USER_MODE_RE_EXECUTE,
+	USER_MODE_LAST
+};
+
+static int user_mode_reaction = USER_MODE_SIGBUS;
+
+static const char * const user_modes[USER_MODE_LAST] = {
+	[USER_MODE_SIGBUS]     = "sigbus",
+	[USER_MODE_RE_EXECUTE] = "re-execute",
+};
+
 /*
  * On processors not supporting #AC exception for split lock feature,
  * MSR_TEST_CTL may not exist or MSR_TEST_CTL exists but the bit 29 is
@@ -214,6 +227,16 @@ static void delayed_reenable_split_lock(struct work_struct *w)
 		_setup_split_lock(ENABLE_SPLIT_LOCK_AC);
 }
 
+static unsigned long eflags_ac(struct pt_regs *regs)
+{
+	return regs->flags & X86_EFLAGS_AC;
+}
+
+static unsigned long cr0_am(struct pt_regs *regs)
+{
+	return read_cr0() & X86_CR0_AM;
+}
+
 /* Will the faulting instruction be re-executed? */
 static bool re_execute(struct pt_regs *regs)
 {
@@ -224,6 +247,24 @@ static bool re_execute(struct pt_regs *regs)
 	if (!user_mode(regs))
 		return true;
 
+	/*
+	 * Now check if the user faulting instruction can be re-executed.
+	 *
+	 * If both CR0.AM (Alignment Mask) and EFLAGS.AC (Alignment Check)
+	 * are set in user space, any misalignment including split lock
+	 * can trigger #AC. In this case, we just issue SIGBUS as standard
+	 * #AC handler to the user process because split lock is not the
+	 * definite reason for triggering this #AC.
+	 *
+	 * If either CR0.AM or EFLAGS.AC is zero, the only reason for
+	 * triggering this #AC is split lock. So the faulting instruction
+	 * can be re-executed if required by user.
+	 */
+	if (cr0_am(regs) == 0 || eflags_ac(regs) == 0)
+		/* User faulting instruction will be re-executed if required. */
+		if (user_mode_reaction == USER_MODE_RE_EXECUTE)
+			return true;
+
 	return false;
 }
 
@@ -323,8 +364,56 @@ static ssize_t enable_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute split_lock_ac_enable = __ATTR_RW(enable);
 
+static ssize_t
+user_mode_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int reaction;
+
+	for (reaction = 0; reaction < USER_MODE_LAST; reaction++) {
+		if (reaction == user_mode_reaction)
+			s += sprintf(s, "[%s] ", user_modes[reaction]);
+		else
+			s += sprintf(s, "%s ", user_modes[reaction]);
+	}
+
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s - 1) = '\n';
+
+	return s - buf;
+}
+
+static ssize_t
+user_mode_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int reaction, len, error = -EINVAL;
+	const char * const *s, *p;
+
+	p = memchr(buf, '\n', count);
+	len = p ? p - buf : count;
+
+	mutex_lock(&split_lock_mutex);
+	reaction = USER_MODE_SIGBUS;
+	for (s = &user_modes[reaction]; reaction <= USER_MODE_LAST;
+	     s++, reaction++) {
+		if (*s && len == strlen(*s) && !strncmp(buf, *s, len)) {
+			user_mode_reaction = reaction;
+			error = 0;
+			break;
+		}
+	}
+	mutex_unlock(&split_lock_mutex);
+
+	return error ? error : count;
+}
+
+static struct kobj_attribute split_lock_ac_user = __ATTR_RW(user_mode);
+
 static struct attribute *split_lock_attrs[] = {
 	&split_lock_ac_enable.attr,
+	&split_lock_ac_user.attr,
 	NULL,
 };
 
-- 
2.5.0
