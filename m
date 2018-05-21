Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrYX+UFSMaxXpSmJaD/7jJeqlETzeOxIFNkq6rGFZerSn70QAprXHSvbxQITLGS2Lwm05Nu
ARC-Seal: i=1; a=rsa-sha256; t=1526937738; cv=none;
        d=google.com; s=arc-20160816;
        b=jRTlTYihclQ/BzRkWE/L0IUkVGUjXCYKX01uNjACjKI/ksUNgO3cVnP/GwH51cTodz
         8Bryhbahq2RvmvtsamHLIe3UCqCB48ZY2aCq0qUQWo2sddBFD8XwblxIBQaU/N4Z9IWS
         uFKNyTuS9e4eCk47Ib8vxhiFo2Rdi8+Hfq/kx4vLRcml9yc7yudO0oA0yLb7UURpOwp5
         0cTisslqEMu0E1gE6hOy2wLsUW61NiabXnjaMwHTtmrXZrHblxe7fsbjnQE8oQ1tDs2f
         TLNMaIFdaF6KlW3tEoLhl8XqSsv+fxEP8jf2sob9sEp/fhXwKrP7b3TaSciZT0ZZDmXa
         otMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5Arrt+/wthma1d29c0O9bkRrjfCaVFPGLO1yBjDxleA=;
        b=v+2xt9ABGlp3m5j1Yxxr3yn5TGD0y9kTl4KcdTQ87yhjSRrNduC3795uqJtJhX69Lu
         gr/RRGbAN1vORyjR3XNSpva6b1WFePda5L8Dm7YPtTSh4X/dabqLVEJ+QVValVLx0j3V
         KNhJvpQIIY/FyV28IbWLkmuXU5suq26u0BQMKtwnLx0r6VEJkk8xEN9o2IPgTn3r2I6o
         sCd5T8G5jN0ahiei60m/pFyXlvK097mhsuLFCXBR6ALDUuK6SMcFwZi8R2PHAHjyzkze
         ntL6+uHo/d8Ve/Q+5+9RUiHBlaLzClZdxZvv8H7ujZQoDjHyzulPIMD6dH9xCwrouss/
         NEEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EZ/goNVu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EZ/goNVu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 66/95] seccomp: Enable speculation flaw mitigations
Date: Mon, 21 May 2018 23:11:56 +0200
Message-Id: <20180521210459.982314713@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109975566640494?=
X-GMAIL-MSGID: =?utf-8?q?1601110265904339967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 5c3070890d06ff82eecb808d02d2ca39169533ef upstream

When speculation flaw mitigations are opt-in (via prctl), using seccomp
will automatically opt-in to these protections, since using seccomp
indicates at least some level of sandboxing is desired.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/seccomp.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -19,6 +19,8 @@
 #include <linux/compat.h>
 #include <linux/coredump.h>
 #include <linux/kmemleak.h>
+#include <linux/nospec.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seccomp.h>
@@ -227,6 +229,19 @@ static inline bool seccomp_may_assign_mo
 	return true;
 }
 
+/*
+ * If a given speculation mitigation is opt-in (prctl()-controlled),
+ * select it, by disabling speculation (enabling mitigation).
+ */
+static inline void spec_mitigate(struct task_struct *task,
+				 unsigned long which)
+{
+	int state = arch_prctl_spec_ctrl_get(task, which);
+
+	if (state > 0 && (state & PR_SPEC_PRCTL))
+		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_DISABLE);
+}
+
 static inline void seccomp_assign_mode(struct task_struct *task,
 				       unsigned long seccomp_mode)
 {
@@ -238,6 +253,8 @@ static inline void seccomp_assign_mode(s
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
+	/* Assume seccomp processes want speculation flaw mitigation. */
+	spec_mitigate(task, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
