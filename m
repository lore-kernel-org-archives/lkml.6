Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519E720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519E720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeFTJtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:49:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeFTJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:48:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K9mnR63451673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 02:48:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K9mmIm3451670;
        Wed, 20 Jun 2018 02:48:48 -0700
Date:   Wed, 20 Jun 2018 02:48:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Siarhei Liakh <tipbot@zytor.com>
Message-ID: <tip-3ae6295ccb7cf6d344908209701badbbbb503e40@git.kernel.org>
Cc:     Siarhei.Liakh@concurrent-rt.com, linux-kernel@vger.kernel.org,
        bpetkov@suse.de, tglx@linutronix.de,
        siarhei.liakh@concurrent-rt.com, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com
Reply-To: bpetkov@suse.de, linux-kernel@vger.kernel.org,
          Siarhei.Liakh@concurrent-rt.com, tglx@linutronix.de,
          mingo@kernel.org, siarhei.liakh@concurrent-rt.com, hpa@zytor.com,
          luto@kernel.org
In-Reply-To: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com>
References: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86: Call fixup_exception() before notify_die() in
 math_error()
Git-Commit-ID: 3ae6295ccb7cf6d344908209701badbbbb503e40
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3ae6295ccb7cf6d344908209701badbbbb503e40
Gitweb:     https://git.kernel.org/tip/3ae6295ccb7cf6d344908209701badbbbb503e40
Author:     Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>
AuthorDate: Thu, 14 Jun 2018 19:36:07 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 11:44:56 +0200

x86: Call fixup_exception() before notify_die() in math_error()

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

---
 arch/x86/kernel/traps.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 03f3d7695dac..162a31d80ad5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -834,16 +834,18 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
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
 
