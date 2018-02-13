Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965553AbeBMSrL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:47:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965421AbeBMSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:47:10 -0500
Date: Tue, 13 Feb 2018 10:46:30 -0800
From: tip-bot for Jessica Yu <tipbot@zytor.com>
Message-ID: <tip-cea1e51c8357feb0e98464a82e1ad3ca2d0382a6@git.kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, jpoimboe@redhat.com,
        mhiramat@kernel.org, davem@davemloft.net,
        torvalds@linux-foundation.org, joe.lawrence@redhat.com,
        anil.s.keshavamurthy@intel.com, mbenes@suse.cz, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        ananth@linux.vnet.ibm.com, peterz@infradead.org, hpa@zytor.com,
        rostedt@goodmis.org, jikos@kernel.org
Reply-To: jeyu@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, pmladek@suse.com, peterz@infradead.org,
        hpa@zytor.com, rostedt@goodmis.org, jikos@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
        davem@davemloft.net, mhiramat@kernel.org,
        torvalds@linux-foundation.org, joe.lawrence@redhat.com,
        anil.s.keshavamurthy@intel.com, mbenes@suse.cz
In-Reply-To: <20180109235124.30886-3-jeyu@kernel.org>
References: <20180109235124.30886-3-jeyu@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes: Propagate error from
 disarm_kprobe_ftrace()
Git-Commit-ID: cea1e51c8357feb0e98464a82e1ad3ca2d0382a6
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

Commit-ID:  cea1e51c8357feb0e98464a82e1ad3ca2d0382a6
Gitweb:     https://git.kernel.org/tip/cea1e51c8357feb0e98464a82e1ad3ca2d0382a6
Author:     Jessica Yu <jeyu@kernel.org>
AuthorDate: Wed, 10 Jan 2018 00:51:24 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 18:20:00 +0100

kprobes: Propagate error from disarm_kprobe_ftrace()

Improve error handling when disarming ftrace-based kprobes. Like with
arm_kprobe_ftrace(), propagate any errors from disarm_kprobe_ftrace() so
that we do not disable/unregister kprobes that are still armed. In other
words, unregister_kprobe() and disable_kprobe() should not report success
if the kprobe could not be disarmed.

disarm_all_kprobes() keeps its current behavior and attempts to
disarm all kprobes. It returns the last encountered error and gives a
warning if not all probes could be disarmed.

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
Link: http://lkml.kernel.org/r/20180109235124.30886-3-jeyu@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 78 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2d98814..102160f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1011,23 +1011,27 @@ err_ftrace:
 }
 
 /* Caller must lock kprobe_mutex */
-static void disarm_kprobe_ftrace(struct kprobe *p)
+static int disarm_kprobe_ftrace(struct kprobe *p)
 {
-	int ret;
+	int ret = 0;
 
-	kprobe_ftrace_enabled--;
-	if (kprobe_ftrace_enabled == 0) {
+	if (kprobe_ftrace_enabled == 1) {
 		ret = unregister_ftrace_function(&kprobe_ftrace_ops);
-		WARN(ret < 0, "Failed to init kprobe-ftrace (%d)\n", ret);
+		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (%d)\n", ret))
+			return ret;
 	}
+
+	kprobe_ftrace_enabled--;
+
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
 	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 #define prepare_kprobe(p)	arch_prepare_kprobe(p)
 #define arm_kprobe_ftrace(p)	(-ENODEV)
-#define disarm_kprobe_ftrace(p)	do {} while (0)
+#define disarm_kprobe_ftrace(p)	(-ENODEV)
 #endif
 
 /* Arm a kprobe with text_mutex */
@@ -1046,18 +1050,18 @@ static int arm_kprobe(struct kprobe *kp)
 }
 
 /* Disarm a kprobe with text_mutex */
-static void disarm_kprobe(struct kprobe *kp, bool reopt)
+static int disarm_kprobe(struct kprobe *kp, bool reopt)
 {
-	if (unlikely(kprobe_ftrace(kp))) {
-		disarm_kprobe_ftrace(kp);
-		return;
-	}
+	if (unlikely(kprobe_ftrace(kp)))
+		return disarm_kprobe_ftrace(kp);
 
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	__disarm_kprobe(kp, reopt);
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
+
+	return 0;
 }
 
 /*
@@ -1639,11 +1643,12 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 static struct kprobe *__disable_kprobe(struct kprobe *p)
 {
 	struct kprobe *orig_p;
+	int ret;
 
 	/* Get an original kprobe for return */
 	orig_p = __get_valid_kprobe(p);
 	if (unlikely(orig_p == NULL))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (!kprobe_disabled(p)) {
 		/* Disable probe if it is a child probe */
@@ -1657,8 +1662,13 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 			 * should have already been disarmed, so
 			 * skip unneed disarming process.
 			 */
-			if (!kprobes_all_disarmed)
-				disarm_kprobe(orig_p, true);
+			if (!kprobes_all_disarmed) {
+				ret = disarm_kprobe(orig_p, true);
+				if (ret) {
+					p->flags &= ~KPROBE_FLAG_DISABLED;
+					return ERR_PTR(ret);
+				}
+			}
 			orig_p->flags |= KPROBE_FLAG_DISABLED;
 		}
 	}
@@ -1675,8 +1685,8 @@ static int __unregister_kprobe_top(struct kprobe *p)
 
 	/* Disable kprobe. This will disarm it if needed. */
 	ap = __disable_kprobe(p);
-	if (ap == NULL)
-		return -EINVAL;
+	if (IS_ERR(ap))
+		return PTR_ERR(ap);
 
 	if (ap == p)
 		/*
@@ -2109,12 +2119,14 @@ static void kill_kprobe(struct kprobe *p)
 int disable_kprobe(struct kprobe *kp)
 {
 	int ret = 0;
+	struct kprobe *p;
 
 	mutex_lock(&kprobe_mutex);
 
 	/* Disable this kprobe */
-	if (__disable_kprobe(kp) == NULL)
-		ret = -EINVAL;
+	p = __disable_kprobe(kp);
+	if (IS_ERR(p))
+		ret = PTR_ERR(p);
 
 	mutex_unlock(&kprobe_mutex);
 	return ret;
@@ -2486,34 +2498,50 @@ already_enabled:
 	return ret;
 }
 
-static void disarm_all_kprobes(void)
+static int disarm_all_kprobes(void)
 {
 	struct hlist_head *head;
 	struct kprobe *p;
-	unsigned int i;
+	unsigned int i, total = 0, errors = 0;
+	int err, ret = 0;
 
 	mutex_lock(&kprobe_mutex);
 
 	/* If kprobes are already disarmed, just return */
 	if (kprobes_all_disarmed) {
 		mutex_unlock(&kprobe_mutex);
-		return;
+		return 0;
 	}
 
 	kprobes_all_disarmed = true;
-	printk(KERN_INFO "Kprobes globally disabled\n");
 
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
+		/* Disarm all kprobes on a best-effort basis */
 		hlist_for_each_entry_rcu(p, head, hlist) {
-			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p))
-				disarm_kprobe(p, false);
+			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
+				err = disarm_kprobe(p, false);
+				if (err) {
+					errors++;
+					ret = err;
+				}
+				total++;
+			}
 		}
 	}
+
+	if (errors)
+		pr_warn("Kprobes globally disabled, but failed to disarm %d out of %d probes\n",
+			errors, total);
+	else
+		pr_info("Kprobes globally disabled\n");
+
 	mutex_unlock(&kprobe_mutex);
 
 	/* Wait for disarming all kprobes by optimizer */
 	wait_for_kprobe_optimizer();
+
+	return ret;
 }
 
 /*
@@ -2556,7 +2584,7 @@ static ssize_t write_enabled_file_bool(struct file *file,
 	case 'n':
 	case 'N':
 	case '0':
-		disarm_all_kprobes();
+		ret = disarm_all_kprobes();
 		break;
 	default:
 		return -EINVAL;
