Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6D3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0567D222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403873AbfBMLQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:16:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfBMLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:16:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1DBFxiW237706
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 03:15:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1DBFwop237703;
        Wed, 13 Feb 2019 03:15:58 -0800
Date:   Wed, 13 Feb 2019 03:15:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-10970e1b4be9c74fce8ab6e3c34a7d718f063f2c@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, robsonde@gmail.com, bp@suse.de, matz@suse.de,
        stable@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: matz@suse.de, torvalds@linux-foundation.org,
          stable@vger.kernel.org, bp@suse.de, robsonde@gmail.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190202005512.3144-1-robsonde@gmail.com>
References: <20190202005512.3144-1-robsonde@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/a.out: Clear the dump structure initially
Git-Commit-ID: 10970e1b4be9c74fce8ab6e3c34a7d718f063f2c
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

Commit-ID:  10970e1b4be9c74fce8ab6e3c34a7d718f063f2c
Gitweb:     https://git.kernel.org/tip/10970e1b4be9c74fce8ab6e3c34a7d718f063f2c
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 12 Feb 2019 14:28:03 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 13 Feb 2019 12:10:51 +0100

x86/a.out: Clear the dump structure initially

dump_thread32() in aout_core_dump() does not clear the user32 structure
allocated on the stack as the first thing on function entry.

As a result, the dump.u_comm, dump.u_ar0 and dump.signal which get
assigned before the clearing, get overwritten.

Rename that function to fill_dump() to make it clear what it does and
call it first thing.

This was caught while staring at a patch by Derek Robson
<robsonde@gmail.com>.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Derek Robson <robsonde@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Matz <matz@suse.de>
Cc: x86@kernel.org
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190202005512.3144-1-robsonde@gmail.com
---
 arch/x86/ia32/ia32_aout.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
index f65b78d32f5e..7dbbe9ffda17 100644
--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -51,7 +51,7 @@ static unsigned long get_dr(int n)
 /*
  * fill in the user structure for a core dump..
  */
-static void dump_thread32(struct pt_regs *regs, struct user32 *dump)
+static void fill_dump(struct pt_regs *regs, struct user32 *dump)
 {
 	u32 fs, gs;
 	memset(dump, 0, sizeof(*dump));
@@ -157,10 +157,12 @@ static int aout_core_dump(struct coredump_params *cprm)
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
+
+	fill_dump(cprm->regs, &dump);
+
 	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
 	dump.u_ar0 = offsetof(struct user32, regs);
 	dump.signal = cprm->siginfo->si_signo;
-	dump_thread32(cprm->regs, &dump);
 
 	/*
 	 * If the size of the dump file exceeds the rlimit, then see
