Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F21CECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD03214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD03214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeIRFgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:36:22 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33462 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeIRFgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:36:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23XI-0007Jt-Qn; Mon, 17 Sep 2018 18:06:36 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23XH-0002Qk-NB; Mon, 17 Sep 2018 18:06:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 18 Sep 2018 02:05:28 +0200
Message-Id: <20180918000546.12552-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
X-XM-SPF: eid=1g23XH-0002Qk-NB;;;mid=<20180918000546.12552-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19k8zSfONK1fkIBvg66vTojWWt5ByYZX+Y=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in it's only caller send_sigtrap
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function fill_sigtrap_info now only has one caller so remove
it and put it's contents in it's caller.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/ptrace.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 94bd6e89129a..511ea0f16078 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1369,27 +1369,19 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 #endif
 }
 
-static void fill_sigtrap_info(struct task_struct *tsk,
-				struct pt_regs *regs,
-				int error_code, int si_code,
-				struct siginfo *info)
-{
-	tsk->thread.trap_nr = X86_TRAP_DB;
-	tsk->thread.error_code = error_code;
-
-	info->si_signo = SIGTRAP;
-	info->si_code = si_code;
-	info->si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
-}
-
-
 void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 					 int error_code, int si_code)
 {
 	struct siginfo info;
 
 	clear_siginfo(&info);
-	fill_sigtrap_info(tsk, regs, error_code, si_code, &info);
+	tsk->thread.trap_nr = X86_TRAP_DB;
+	tsk->thread.error_code = error_code;
+
+	info.si_signo = SIGTRAP;
+	info.si_code = si_code;
+	info.si_addr = user_mode(regs) ? (void __user *)regs->ip : NULL;
+
 	/* Send us the fake SIGTRAP */
 	force_sig_info(SIGTRAP, &info, tsk);
 }
-- 
2.17.1

