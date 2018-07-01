Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15097C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C46247F2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C46247F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030530AbeGAR7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:59:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030429AbeGAQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:42 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9DB5AA6;
        Sun,  1 Jul 2018 16:30:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Siarhei Liakh <siarhei.liakh@concurrent-rt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Borislav Petkov" <bpetkov@suse.de>
Subject: [PATCH 4.14 007/157] x86: Call fixup_exception() before notify_die() in math_error()
Date:   Sun,  1 Jul 2018 18:21:19 +0200
Message-Id: <20180701160852.660457173@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>

commit 3ae6295ccb7cf6d344908209701badbbbb503e40 upstream.

fpu__drop() has an explicit fwait which under some conditions can trigger a
fixable FPU exception while in kernel. Thus, we should attempt to fixup the
exception first, and only call notify_die() if the fixup failed just like
in do_general_protection(). The original call sequence incorrectly triggers
KDB entry on debug kernels under particular FPU-intensive workloads.

Andy noted, that this makes the whole conditional irq enable thing even
more inconsistent, but fixing that it outside the scope of this.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Borislav  Petkov" <bpetkov@suse.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/traps.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -828,16 +828,18 @@ static void math_error(struct pt_regs *r
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
 
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, SIGFPE) == NOTIFY_STOP)
-		return;
 	cond_local_irq_enable(regs);
 
 	if (!user_mode(regs)) {
-		if (!fixup_exception(regs, trapnr)) {
-			task->thread.error_code = error_code;
-			task->thread.trap_nr = trapnr;
+		if (fixup_exception(regs, trapnr))
+			return;
+
+		task->thread.error_code = error_code;
+		task->thread.trap_nr = trapnr;
+
+		if (notify_die(DIE_TRAP, str, regs, error_code,
+					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		}
 		return;
 	}
 


