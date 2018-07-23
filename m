Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B3320856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B3320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbeGWNwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:52:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389417AbeGWNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:53 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C06ECBA;
        Mon, 23 Jul 2018 12:45:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 074/107] seccomp: Move speculation migitation control to arch code
Date:   Mon, 23 Jul 2018 14:42:08 +0200
Message-Id: <20180723122417.102669473@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/kernel/cpu/bugs.c |   29 ++++++++++++++++++-----------
 include/linux/nospec.h     |    2 ++
 kernel/seccomp.c           |   15 ++-------------
 3 files changed, 22 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -567,6 +567,24 @@ static int ssb_prctl_set(struct task_str
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
@@ -585,17 +603,6 @@ static int ssb_prctl_get(struct task_str
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
@@ -216,18 +216,7 @@ static inline bool seccomp_may_assign_mo
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
@@ -243,7 +232,7 @@ static inline void seccomp_assign_mode(s
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
-		spec_mitigate(task, PR_SPEC_STORE_BYPASS);
+		arch_seccomp_spec_mitigate(task);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 


