Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932446AbeBPJrd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:47:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeBPJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:47:31 -0500
Date: Fri, 16 Feb 2018 01:46:30 -0800
From: tip-bot for Jessica Yu <tipbot@zytor.com>
Message-ID: <tip-12310e3437554328bcd75186cf331bc712cb30b2@git.kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jikos@kernel.org, davem@davemloft.net,
        mingo@kernel.org, jpoimboe@redhat.com, mhiramat@kernel.org,
        ananth@linux.vnet.ibm.com, jeyu@kernel.org,
        anil.s.keshavamurthy@intel.com, joe.lawrence@redhat.com, hpa@zytor.com,
        rostedt@goodmis.org, mbenes@suse.cz, pmladek@suse.com,
        tglx@linutronix.de
Reply-To: mbenes@suse.cz, rostedt@goodmis.org, hpa@zytor.com,
        joe.lawrence@redhat.com, anil.s.keshavamurthy@intel.com,
        tglx@linutronix.de, pmladek@suse.com, davem@davemloft.net,
        jikos@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, jeyu@kernel.org,
        ananth@linux.vnet.ibm.com, mhiramat@kernel.org, jpoimboe@redhat.com,
        mingo@kernel.org
In-Reply-To: <20180109235124.30886-2-jeyu@kernel.org>
References: <20180109235124.30886-2-jeyu@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes: Propagate error from arm_kprobe_ftrace()
Git-Commit-ID: 12310e3437554328bcd75186cf331bc712cb30b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  12310e3437554328bcd75186cf331bc712cb30b2
Gitweb:     https://git.kernel.org/tip/12310e3437554328bcd75186cf331bc712cb30b2
Author:     Jessica Yu <jeyu@kernel.org>
AuthorDate: Wed, 10 Jan 2018 00:51:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 09:12:52 +0100

kprobes: Propagate error from arm_kprobe_ftrace()

Improve error handling when arming ftrace-based kprobes. Specifically, if
we fail to arm a ftrace-based kprobe, register_kprobe()/enable_kprobe()
should report an error instead of success. Previously, this has lead to
confusing situations where register_kprobe() would return 0 indicating
success, but the kprobe would not be functional if ftrace registration
during the kprobe arming process had failed. We should therefore take any
errors returned by ftrace into account and propagate this error so that we
do not register/enable kprobes that cannot be armed. This can happen if,
for example, register_ftrace_function() finds an IPMODIFY conflict (since
kprobe_ftrace_ops has this flag set) and returns an error. Such a conflict
is possible since livepatches also set the IPMODIFY flag for their ftrace_ops.

arm_all_kprobes() keeps its current behavior and attempts to arm all
kprobes. It returns the last encountered error and gives a warning if
not all probes could be armed.

This patch is based on Petr Mladek's original patchset (patches 2 and 3)
back in 2015, which improved kprobes error handling, found here:

   https://lkml.org/lkml/2015/2/26/452

However, further work on this had been paused since then and the patches
were not upstreamed.

Based-on-patches-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: live-patching@vger.kernel.org
Link: http://lkml.kernel.org/r/20180109235124.30886-2-jeyu@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 100 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 25 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da2ccf1..2d98814 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -978,18 +978,36 @@ static int prepare_kprobe(struct kprobe *p)
 }
 
 /* Caller must lock kprobe_mutex */
-static void arm_kprobe_ftrace(struct kprobe *p)
+static int arm_kprobe_ftrace(struct kprobe *p)
 {
-	int ret;
+	int ret = 0;
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
-	WARN(ret < 0, "Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
-	kprobe_ftrace_enabled++;
-	if (kprobe_ftrace_enabled == 1) {
+	if (ret) {
+		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		return ret;
+	}
+
+	if (kprobe_ftrace_enabled == 0) {
 		ret = register_ftrace_function(&kprobe_ftrace_ops);
-		WARN(ret < 0, "Failed to init kprobe-ftrace (%d)\n", ret);
+		if (ret) {
+			pr_debug("Failed to init kprobe-ftrace (%d)\n", ret);
+			goto err_ftrace;
+		}
 	}
+
+	kprobe_ftrace_enabled++;
+	return ret;
+
+err_ftrace:
+	/*
+	 * Note: Since kprobe_ftrace_ops has IPMODIFY set, and ftrace requires a
+	 * non-empty filter_hash for IPMODIFY ops, we're safe from an accidental
+	 * empty filter_hash which would undesirably trace all functions.
+	 */
+	ftrace_set_filter_ip(&kprobe_ftrace_ops, (unsigned long)p->addr, 1, 0);
+	return ret;
 }
 
 /* Caller must lock kprobe_mutex */
@@ -1008,22 +1026,23 @@ static void disarm_kprobe_ftrace(struct kprobe *p)
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 #define prepare_kprobe(p)	arch_prepare_kprobe(p)
-#define arm_kprobe_ftrace(p)	do {} while (0)
+#define arm_kprobe_ftrace(p)	(-ENODEV)
 #define disarm_kprobe_ftrace(p)	do {} while (0)
 #endif
 
 /* Arm a kprobe with text_mutex */
-static void arm_kprobe(struct kprobe *kp)
+static int arm_kprobe(struct kprobe *kp)
 {
-	if (unlikely(kprobe_ftrace(kp))) {
-		arm_kprobe_ftrace(kp);
-		return;
-	}
+	if (unlikely(kprobe_ftrace(kp)))
+		return arm_kprobe_ftrace(kp);
+
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	__arm_kprobe(kp);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
+
+	return 0;
 }
 
 /* Disarm a kprobe with text_mutex */
@@ -1362,9 +1381,15 @@ out:
 
 	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
-		if (!kprobes_all_disarmed)
+		if (!kprobes_all_disarmed) {
 			/* Arm the breakpoint again. */
-			arm_kprobe(ap);
+			ret = arm_kprobe(ap);
+			if (ret) {
+				ap->flags |= KPROBE_FLAG_DISABLED;
+				list_del_rcu(&p->list);
+				synchronize_sched();
+			}
+		}
 	}
 	return ret;
 }
@@ -1573,8 +1598,14 @@ int register_kprobe(struct kprobe *p)
 	hlist_add_head_rcu(&p->hlist,
 		       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
 
-	if (!kprobes_all_disarmed && !kprobe_disabled(p))
-		arm_kprobe(p);
+	if (!kprobes_all_disarmed && !kprobe_disabled(p)) {
+		ret = arm_kprobe(p);
+		if (ret) {
+			hlist_del_rcu(&p->hlist);
+			synchronize_sched();
+			goto out;
+		}
+	}
 
 	/* Try to optimize kprobe */
 	try_to_optimize_kprobe(p);
@@ -2116,7 +2147,9 @@ int enable_kprobe(struct kprobe *kp)
 
 	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
 		p->flags &= ~KPROBE_FLAG_DISABLED;
-		arm_kprobe(p);
+		ret = arm_kprobe(p);
+		if (ret)
+			p->flags |= KPROBE_FLAG_DISABLED;
 	}
 out:
 	mutex_unlock(&kprobe_mutex);
@@ -2407,11 +2440,12 @@ static const struct file_operations debugfs_kprobe_blacklist_ops = {
 	.release        = seq_release,
 };
 
-static void arm_all_kprobes(void)
+static int arm_all_kprobes(void)
 {
 	struct hlist_head *head;
 	struct kprobe *p;
-	unsigned int i;
+	unsigned int i, total = 0, errors = 0;
+	int err, ret = 0;
 
 	mutex_lock(&kprobe_mutex);
 
@@ -2428,16 +2462,28 @@ static void arm_all_kprobes(void)
 	/* Arming kprobes doesn't optimize kprobe itself */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
-			if (!kprobe_disabled(p))
-				arm_kprobe(p);
+		/* Arm all kprobes on a best-effort basis */
+		hlist_for_each_entry_rcu(p, head, hlist) {
+			if (!kprobe_disabled(p)) {
+				err = arm_kprobe(p);
+				if (err)  {
+					errors++;
+					ret = err;
+				}
+				total++;
+			}
+		}
 	}
 
-	printk(KERN_INFO "Kprobes globally enabled\n");
+	if (errors)
+		pr_warn("Kprobes globally enabled, but failed to arm %d out of %d probes\n",
+			errors, total);
+	else
+		pr_info("Kprobes globally enabled\n");
 
 already_enabled:
 	mutex_unlock(&kprobe_mutex);
-	return;
+	return ret;
 }
 
 static void disarm_all_kprobes(void)
@@ -2494,6 +2540,7 @@ static ssize_t write_enabled_file_bool(struct file *file,
 {
 	char buf[32];
 	size_t buf_size;
+	int ret = 0;
 
 	buf_size = min(count, (sizeof(buf)-1));
 	if (copy_from_user(buf, user_buf, buf_size))
@@ -2504,7 +2551,7 @@ static ssize_t write_enabled_file_bool(struct file *file,
 	case 'y':
 	case 'Y':
 	case '1':
-		arm_all_kprobes();
+		ret = arm_all_kprobes();
 		break;
 	case 'n':
 	case 'N':
@@ -2515,6 +2562,9 @@ static ssize_t write_enabled_file_bool(struct file *file,
 		return -EINVAL;
 	}
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
