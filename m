Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZotD9BZcmPizxhbMJKYGnjFKxxpShOEtbZrMJODpu/Ki9Uyn9Gvgmf2LhO2R5DKyz19SGyF
ARC-Seal: i=1; a=rsa-sha256; t=1526937724; cv=none;
        d=google.com; s=arc-20160816;
        b=noBoed7gAIXqzROnShxWT0+Rg+65UkFcKUQctFATPSLZEZRFmbEps0D/jXRU3hSKs9
         CDAbQXzdkQ+AY949sYKyGfF0vERGq/zvC21YYPGsmOTXq2axEUQKpC86N9LDFa08xLrZ
         iGr/bT+aRoUo65rI2fbaDkqHlNpzSw1/1BUVVXBKpX2iBfWpIuXcJRXntRqPVsoBymQl
         bnFyl1X82PBmQd0v7Wj19i3kfKKeoZOevCgaEK+dKz3JflmC+YrNPwav0IJfzqE9ApdW
         T/ZHYIKr9zChfxdp3yuVbR+WYOlggL0qJR9dtxiQ6qBGvq0ny51YUDcukbRdZDwcQ2Ex
         mGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=hjclePBVvlQyHb913oM46cZqeUMCtAtP+vDoSAy7ErQ=;
        b=RKNXH+/0Y/xO5sgZ4MVQECKS1S99q04t4xKXSd7dNx0j9xb4zEZOmrJF04fA0ckuY2
         rR0DOnl6Ko3vZHjy+xKbES/T8WZ4hdWDhwrzuLnMf9scdUCasvXiooDaAednGkFs3G6/
         5s0muI9ZIR5g/2bboaA/c961GzslhuK9wKTGwtNSZ7b1WMz5ynONXSSdy3uWyCQMyYkq
         urMiLowERORA3hyxhpY/RIAHF5bidHDNof/jnFK5DivsuL843VykRpq5BKWwvzNfswMA
         AJa3yrlMatiZB7pwWwn+Uo03vBjxOsVVjCWb4HQgktaE486NQOQbv+Z/A3dP7MNaxYTT
         d9rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KWZ0G31n;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KWZ0G31n;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 71/95] seccomp: Move speculation migitation control to arch code
Date: Mon, 21 May 2018 23:12:01 +0200
Message-Id: <20180521210500.629009894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109891840824631?=
X-GMAIL-MSGID: =?utf-8?q?1601110252376492529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 8bf37d8c067bb7eb8e7c381bdadf9bd89182b6bc upstream

The migitation control is simpler to implement in architecture code as it
avoids the extra function call to check the mode. Aside of that having an
explicit seccomp enabled mode in the architecture mitigations would require
even more workarounds.

Move it into architecture code and provide a weak function in the seccomp
code. Remove the 'which' argument as this allows the architecture to decide
which mitigations are relevant for seccomp.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   29 ++++++++++++++++++-----------
 include/linux/nospec.h     |    2 ++
 kernel/seccomp.c           |   15 ++-------------
 3 files changed, 22 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -569,6 +569,24 @@ static int ssb_prctl_set(struct task_str
 	return 0;
 }
 
+int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
+			     unsigned long ctrl)
+{
+	switch (which) {
+	case PR_SPEC_STORE_BYPASS:
+		return ssb_prctl_set(task, ctrl);
+	default:
+		return -ENODEV;
+	}
+}
+
+#ifdef CONFIG_SECCOMP
+void arch_seccomp_spec_mitigate(struct task_struct *task)
+{
+	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+}
+#endif
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -587,17 +605,6 @@ static int ssb_prctl_get(struct task_str
 	}
 }
 
-int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
-			     unsigned long ctrl)
-{
-	switch (which) {
-	case PR_SPEC_STORE_BYPASS:
-		return ssb_prctl_set(task, ctrl);
-	default:
-		return -ENODEV;
-	}
-}
-
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 {
 	switch (which) {
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -62,5 +62,7 @@ static inline unsigned long array_index_
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which);
 int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 			     unsigned long ctrl);
+/* Speculation control for seccomp enforced mitigation */
+void arch_seccomp_spec_mitigate(struct task_struct *task);
 
 #endif /* _LINUX_NOSPEC_H */
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -229,18 +229,7 @@ static inline bool seccomp_may_assign_mo
 	return true;
 }
 
-/*
- * If a given speculation mitigation is opt-in (prctl()-controlled),
- * select it, by disabling speculation (enabling mitigation).
- */
-static inline void spec_mitigate(struct task_struct *task,
-				 unsigned long which)
-{
-	int state = arch_prctl_spec_ctrl_get(task, which);
-
-	if (state > 0 && (state & PR_SPEC_PRCTL))
-		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
-}
+void __weak arch_seccomp_spec_mitigate(struct task_struct *task) { }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
 				       unsigned long seccomp_mode,
@@ -256,7 +245,7 @@ static inline void seccomp_assign_mode(s
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
-		spec_mitigate(task, PR_SPEC_STORE_BYPASS);
+		arch_seccomp_spec_mitigate(task);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 
