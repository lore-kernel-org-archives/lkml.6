Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B00C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56432087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56432087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeI3ETs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:19:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52144 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728890AbeI3ESh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:37 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6H-0000H1-I3; Sat, 29 Sep 2018 22:48:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006qh-R9; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.160907828@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 023/131] seccomp: Move speculation migitation control
 to arch code
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 8bf37d8c067bb7eb8e7c381bdadf9bd89182b6bc upstream.

The migitation control is simpler to implement in architecture code as it
avoids the extra function call to check the mode. Aside of that having an
explicit seccomp enabled mode in the architecture mitigations would require
even more workarounds.

Move it into architecture code and provide a weak function in the seccomp
code. Remove the 'which' argument as this allows the architecture to decide
which mitigations are relevant for seccomp.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 29 ++++++++++++++++++-----------
 include/linux/nospec.h     |  2 ++
 kernel/seccomp.c           | 15 ++-------------
 3 files changed, 22 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -606,6 +606,24 @@ static int ssb_prctl_set(struct task_str
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
@@ -624,17 +642,6 @@ static int ssb_prctl_get(struct task_str
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
@@ -207,18 +207,7 @@ static inline bool seccomp_may_assign_mo
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
 
 static inline void seccomp_assign_mode(unsigned long seccomp_mode,
 				       unsigned long flags)
@@ -226,7 +215,7 @@ static inline void seccomp_assign_mode(u
 	current->seccomp.mode = seccomp_mode;
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
-		spec_mitigate(current, PR_SPEC_STORE_BYPASS);
+		arch_seccomp_spec_mitigate(current);
 	set_tsk_thread_flag(current, TIF_SECCOMP);
 }
 

