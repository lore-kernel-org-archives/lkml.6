Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E50ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B93F20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B93F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbeGWNsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389813AbeGWNsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:37 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 42D5BBB3;
        Mon, 23 Jul 2018 12:47:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 070/107] seccomp: Enable speculation flaw mitigations
Date:   Mon, 23 Jul 2018 14:42:04 +0200
Message-Id: <20180723122416.895662079@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

commit 5c3070890d06ff82eecb808d02d2ca39169533ef upstream

When speculation flaw mitigations are opt-in (via prctl), using seccomp
will automatically opt-in to these protections, since using seccomp
indicates at least some level of sandboxing is desired.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 kernel/seccomp.c |   17 +++++++++++++++++
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
 #include <linux/slab.h>
@@ -214,6 +216,19 @@ static inline bool seccomp_may_assign_mo
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
@@ -225,6 +240,8 @@ static inline void seccomp_assign_mode(s
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
+	/* Assume seccomp processes want speculation flaw mitigation. */
+	spec_mitigate(task, PR_SPEC_STORE_BYPASS);
 	set_tsk_thread_flag(task, TIF_SECCOMP);
 }
 


