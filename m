Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpMPRSNVLajLGU7coHsVZi8U5XzprmZ/b9vISZVKUudNCqqequCqUxW6NqBlTlWMUSkU8RJ
ARC-Seal: i=1; a=rsa-sha256; t=1526937467; cv=none;
        d=google.com; s=arc-20160816;
        b=lsz0aZDQva74Bwk4vZtwot05ctBuIrXHp8MSY8Lya1/s9X1pTh59FKhwTh/Ze0ry0O
         De5gNRoh872Ac0NdWrLlMtHrxtiwQOr7veMqbV/D8mepjJe99xvD6tEvaS0cy35IxonN
         zp2WEX7dyhFgEm5s4GViC7mtycfLSM2pybG6Pf1icGBNZ+NxZ4mUYWoZxC+ZFh/eht4a
         IUx4WWA+Ls5FjSZwB8XZGwKJncppaaI44bibyDATKQQKIEOTXzvFmV5n7zG2AUAnQIS7
         FdHq8MilQbO9/PFzije7LRVHdxjvtbVie146x9O5YldVfLQOSGKAIGBCXEX+gChaGPLu
         1Tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bOjoI9SJ/WZpc7byDnO8sq6cwRnyAl5s5fZb8v7A/GM=;
        b=aAbCoAILx/3Wip3tjH9KlPRoo+lsyNQbel0B9m8r4mkdAlqeDc3/172vuuZckmG9bq
         6EAyzJePUhtYySE5zr8p9Qah6+CmwJrjUpsxOqAGi+9snnPDZC1aDyr3UYSg0K7tMKFG
         AcsTo0a33/X5q9rEy5cB00frAITb4mw34Nbnq5g3U23rgCty0G4GVueTx3ycLdMblHMX
         PoS7eIfdwakVK3+Yn9EHPdr3Soekfk0fEa4ZQ/73Km9tpUUzzlY496qzvgB6kCKPnAkn
         d990moQXJKK2HhxiVRMzxCnsbqBwCUokDitw0ruPdIUhJJZQJR5tED9QK61Q5HcGqgt4
         GhfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o4QyC4X3;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o4QyC4X3;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 59/87] prctl: Add force disable speculation
Date: Mon, 21 May 2018 23:11:35 +0200
Message-Id: <20180521210425.491766021@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109981361107472?=
X-GMAIL-MSGID: =?utf-8?q?1601109981361107472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee upstream

For certain use cases it is desired to enforce mitigations so they cannot
be undone afterwards. That's important for loader stubs which want to
prevent a child from disabling the mitigation again. Will also be used for
seccomp(). The extra state preserving of the prctl state for SSB is a
preparatory step for EBPF dymanic speculation control.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/spec_ctrl.txt |   34 +++++++++++++++++++++-------------
 arch/x86/kernel/cpu/bugs.c  |   35 +++++++++++++++++++++++++----------
 fs/proc/array.c             |    3 +++
 include/linux/sched.h       |    9 +++++++++
 include/uapi/linux/prctl.h  |    1 +
 5 files changed, 59 insertions(+), 23 deletions(-)

--- a/Documentation/spec_ctrl.txt
+++ b/Documentation/spec_ctrl.txt
@@ -25,19 +25,21 @@ PR_GET_SPECULATION_CTRL
 -----------------------
 
 PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
-which is selected with arg2 of prctl(2). The return value uses bits 0-2 with
+which is selected with arg2 of prctl(2). The return value uses bits 0-3 with
 the following meaning:
 
-==== ================ ===================================================
-Bit  Define           Description
-==== ================ ===================================================
-0    PR_SPEC_PRCTL    Mitigation can be controlled per task by
-                      PR_SET_SPECULATION_CTRL
-1    PR_SPEC_ENABLE   The speculation feature is enabled, mitigation is
-                      disabled
-2    PR_SPEC_DISABLE  The speculation feature is disabled, mitigation is
-                      enabled
-==== ================ ===================================================
+==== ===================== ===================================================
+Bit  Define                Description
+==== ===================== ===================================================
+0    PR_SPEC_PRCTL         Mitigation can be controlled per task by
+                           PR_SET_SPECULATION_CTRL
+1    PR_SPEC_ENABLE        The speculation feature is enabled, mitigation is
+                           disabled
+2    PR_SPEC_DISABLE       The speculation feature is disabled, mitigation is
+                           enabled
+3    PR_SPEC_FORCE_DISABLE Same as PR_SPEC_DISABLE, but cannot be undone. A
+                           subsequent prctl(..., PR_SPEC_ENABLE) will fail.
+==== ===================== ===================================================
 
 If all bits are 0 the CPU is not affected by the speculation misfeature.
 
@@ -47,9 +49,11 @@ misfeature will fail.
 
 PR_SET_SPECULATION_CTRL
 -----------------------
+
 PR_SET_SPECULATION_CTRL allows to control the speculation misfeature, which
 is selected by arg2 of :manpage:`prctl(2)` per task. arg3 is used to hand
-in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE.
+in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE or
+PR_SPEC_FORCE_DISABLE.
 
 Common error codes
 ------------------
@@ -70,10 +74,13 @@ Value   Meaning
 0       Success
 
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
-        PR_SPEC_DISABLE
+        PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE
 
 ENXIO   Control of the selected speculation misfeature is not possible.
         See PR_GET_SPECULATION_CTRL.
+
+EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller
+        tried to enable it again.
 ======= =================================================================
 
 Speculation misfeature controls
@@ -84,3 +91,4 @@ Speculation misfeature controls
    * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, 0, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_FORCE_DISABLE, 0, 0);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -532,21 +532,37 @@ static void ssb_select_mitigation()
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
-	bool rds = !!test_tsk_thread_flag(task, TIF_RDS);
+	bool update;
 
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
 		return -ENXIO;
 
-	if (ctrl == PR_SPEC_ENABLE)
-		clear_tsk_thread_flag(task, TIF_RDS);
-	else
-		set_tsk_thread_flag(task, TIF_RDS);
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		/* If speculation is force disabled, enable is not allowed */
+		if (task_spec_ssb_force_disable(task))
+			return -EPERM;
+		task_clear_spec_ssb_disable(task);
+		update = test_and_clear_tsk_thread_flag(task, TIF_RDS);
+		break;
+	case PR_SPEC_DISABLE:
+		task_set_spec_ssb_disable(task);
+		update = !test_and_set_tsk_thread_flag(task, TIF_RDS);
+		break;
+	case PR_SPEC_FORCE_DISABLE:
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_force_disable(task);
+		update = !test_and_set_tsk_thread_flag(task, TIF_RDS);
+		break;
+	default:
+		return -ERANGE;
+	}
 
 	/*
 	 * If being set on non-current task, delay setting the CPU
 	 * mitigation until it is next scheduled.
 	 */
-	if (task == current && rds != !!test_tsk_thread_flag(task, TIF_RDS))
+	if (task == current && update)
 		speculative_store_bypass_update();
 
 	return 0;
@@ -558,7 +574,9 @@ static int ssb_prctl_get(struct task_str
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_PRCTL:
-		if (test_tsk_thread_flag(task, TIF_RDS))
+		if (task_spec_ssb_force_disable(task))
+			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
 	default:
@@ -571,9 +589,6 @@ static int ssb_prctl_get(struct task_str
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl)
 {
-	if (ctrl != PR_SPEC_ENABLE && ctrl != PR_SPEC_DISABLE)
-		return -ERANGE;
-
 	switch (which) {
 	case PR_SPEC_STORE_BYPASS:
 		return ssb_prctl_set(task, ctrl);
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -355,6 +355,9 @@ static inline void task_seccomp(struct s
 	case PR_SPEC_NOT_AFFECTED:
 		seq_printf(m, "not vulnerable");
 		break;
+	case PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE:
+		seq_printf(m, "thread force mitigated");
+		break;
 	case PR_SPEC_PRCTL | PR_SPEC_DISABLE:
 		seq_printf(m, "thread mitigated");
 		break;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2354,6 +2354,8 @@ static inline void memalloc_noio_restore
 #define PFA_SPREAD_PAGE  1      /* Spread page cache over cpuset */
 #define PFA_SPREAD_SLAB  2      /* Spread some slab caches over cpuset */
 #define PFA_LMK_WAITING  3      /* Lowmemorykiller is waiting */
+#define PFA_SPEC_SSB_DISABLE		4	/* Speculative Store Bypass disabled */
+#define PFA_SPEC_SSB_FORCE_DISABLE	5	/* Speculative Store Bypass force disabled*/
 
 
 #define TASK_PFA_TEST(name, func)					\
@@ -2380,6 +2382,13 @@ TASK_PFA_CLEAR(SPREAD_SLAB, spread_slab)
 TASK_PFA_TEST(LMK_WAITING, lmk_waiting)
 TASK_PFA_SET(LMK_WAITING, lmk_waiting)
 
+TASK_PFA_TEST(SPEC_SSB_DISABLE, spec_ssb_disable)
+TASK_PFA_SET(SPEC_SSB_DISABLE, spec_ssb_disable)
+TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
+
+TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
+TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
+
 /*
  * task->jobctl flags
  */
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -207,5 +207,6 @@ struct prctl_mm_map {
 # define PR_SPEC_PRCTL			(1UL << 0)
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
+# define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
 #endif /* _LINUX_PRCTL_H */
