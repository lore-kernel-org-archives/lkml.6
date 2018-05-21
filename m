Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpnfs+CV/tCNmDTREMiYVjsQvwudNUhXZdv9k2Vsdhw9aTuQNBgPwSqTi21TzQ+GH3Ua/v/
ARC-Seal: i=1; a=rsa-sha256; t=1526937689; cv=none;
        d=google.com; s=arc-20160816;
        b=fWUAzrgwxMXSc2i6lGMSUmC8C0qIlo2LHuRNy6MGwlyKcOHEY53ByRrnon9v3SEU2e
         oFfOeGQhS85bM4L54TW2t2tkXku/jWsLU4/AdMSRCQ3UEmarM0RAx4yyhw4reXPZgLPO
         csrrc9TqWFWTzKvaftVL3qBfX0Acxn2i9K3fGRqcbS1Dn8BiRvPAZl9OeuQ8ddds8a+G
         FCY7uiwvCLjhxRskIcTyQCoWgtkr/9kLTrtyH60IC425kyTpYmmSRmYpjOg6I5FaHXVF
         WXFRo1Z7T5WemZf4sUwiu4QpV+H56jJZFGa7olcU35WNS8xOglDgllv5khMQCHs8jwRy
         YwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6nQsHNO5pNRE+vb8gJRfC0bnF71kx3HVt3HmEiR26n4=;
        b=sVQZVzRha9B3KyJKvnLgJtUlsxJBqFptfHcTrOuL4QWDp2Wy/gERAxkO8pBbntJtCs
         gd9AfgC3xwhzCrXpPTTK60ATHXmbG1HWhaNpeIvfeYpen6V0hAsd1bMtxa0DQy2F/TVs
         jnNBhac4+zYqVyxt/YlgtE5dWluplOqA4et1vDZCDqRBGgXfoRUqVpyFcx+VntZzJOud
         L7Du8JnbOZl1BTPkl/zzOfo6hwLo2jB6HK/PF4dMfMYwtle9Ofs4IddoFUJWKGl2o5tk
         lqcltkkzT8aECsveVX3kqLVv1L9dKcHbvfaEAGBitJ8bZfD5Wzm22c0HLiwCJOtTgr3i
         Vmig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VKw3Hubf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VKw3Hubf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 68/95] prctl: Add force disable speculation
Date: Mon, 21 May 2018 23:11:58 +0200
Message-Id: <20180521210500.294116876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109981361107472?=
X-GMAIL-MSGID: =?utf-8?q?1601110214537754267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee upstream

For certain use cases it is desired to enforce mitigations so they cannot
be undone afterwards. That's important for loader stubs which want to
prevent a child from disabling the mitigation again. Will also be used for
seccomp(). The extra state preserving of the prctl state for SSB is a
preparatory step for EBPF dymanic speculation control.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/userspace-api/spec_ctrl.rst |   34 ++++++++++++++++++-----------
 arch/x86/kernel/cpu/bugs.c                |   35 +++++++++++++++++++++---------
 fs/proc/array.c                           |    3 ++
 include/linux/sched.h                     |   10 +++++++-
 include/uapi/linux/prctl.h                |    1 
 5 files changed, 59 insertions(+), 24 deletions(-)

--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
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
@@ -533,21 +533,37 @@ static void ssb_select_mitigation()
 
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
@@ -559,7 +575,9 @@ static int ssb_prctl_get(struct task_str
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
@@ -572,9 +590,6 @@ static int ssb_prctl_get(struct task_str
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
@@ -356,6 +356,9 @@ static inline void task_seccomp(struct s
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
@@ -1363,7 +1363,8 @@ static inline bool is_percpu_thread(void
 #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
 #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
 #define PFA_SPREAD_SLAB			2	/* Spread some slab caches over cpuset */
-
+#define PFA_SPEC_SSB_DISABLE		3	/* Speculative Store Bypass disabled */
+#define PFA_SPEC_SSB_FORCE_DISABLE	4	/* Speculative Store Bypass force disabled*/
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1388,6 +1389,13 @@ TASK_PFA_TEST(SPREAD_SLAB, spread_slab)
 TASK_PFA_SET(SPREAD_SLAB, spread_slab)
 TASK_PFA_CLEAR(SPREAD_SLAB, spread_slab)
 
+TASK_PFA_TEST(SPEC_SSB_DISABLE, spec_ssb_disable)
+TASK_PFA_SET(SPEC_SSB_DISABLE, spec_ssb_disable)
+TASK_PFA_CLEAR(SPEC_SSB_DISABLE, spec_ssb_disable)
+
+TASK_PFA_TEST(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
+TASK_PFA_SET(SPEC_SSB_FORCE_DISABLE, spec_ssb_force_disable)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -208,5 +208,6 @@ struct prctl_mm_map {
 # define PR_SPEC_PRCTL			(1UL << 0)
 # define PR_SPEC_ENABLE			(1UL << 1)
 # define PR_SPEC_DISABLE		(1UL << 2)
+# define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
 #endif /* _LINUX_PRCTL_H */
