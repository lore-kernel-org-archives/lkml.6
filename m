Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C15C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FE6206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FE6206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeI3EcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:32:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51534 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000HB-SJ; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006qN-MO; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.607011550@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 019/131] seccomp: Enable speculation flaw mitigations
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

From: Kees Cook <keescook@chromium.org>

commit 5c3070890d06ff82eecb808d02d2ca39169533ef upstream.

When speculation flaw mitigations are opt-in (via prctl), using seccomp
will automatically opt-in to these protections, since using seccomp
indicates at least some level of sandboxing is desired.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bwh: Backported to 3.16:
 - Apply to current task
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/seccomp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -16,6 +16,8 @@
 #include <linux/atomic.h>
 #include <linux/audit.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/seccomp.h>
 #include <linux/syscalls.h>
@@ -205,9 +207,24 @@ static inline bool seccomp_may_assign_mo
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
 static inline void seccomp_assign_mode(unsigned long seccomp_mode)
 {
 	current->seccomp.mode = seccomp_mode;
+	/* Assume seccomp processes want speculation flaw mitigation. */
+	spec_mitigate(current, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(current, TIF_SECCOMP);
 }
 

