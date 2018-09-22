Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDE5C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2FA21532
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2FA21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeIVPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:51:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeIVPvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:51:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8M9vrKu2281087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 Sep 2018 02:57:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8M9vqPE2281084;
        Sat, 22 Sep 2018 02:57:52 -0700
Date:   Sat, 22 Sep 2018 02:57:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matthew Whitehead <tipbot@zytor.com>
Message-ID: <tip-03b099bdcdf7125d4a63dc9ddeefdd454e05123d@git.kernel.org>
Cc:     qianyue.zj@alibaba-inc.com, mingo@kernel.org, tglx@linutronix.de,
        luto@amacapital.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bp@suse.de, pombredanne@nexb.com,
        peterz@infradead.org, tedheadster@gmail.com
Reply-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
          tedheadster@gmail.com, pombredanne@nexb.com,
          peterz@infradead.org, bp@suse.de, hpa@zytor.com,
          qianyue.zj@alibaba-inc.com, mingo@kernel.org,
          luto@amacapital.net, tglx@linutronix.de
In-Reply-To: <20180921212041.13096-2-tedheadster@gmail.com>
References: <20180921212041.13096-2-tedheadster@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU: Use correct macros for Cyrix calls
Git-Commit-ID: 03b099bdcdf7125d4a63dc9ddeefdd454e05123d
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

Commit-ID:  03b099bdcdf7125d4a63dc9ddeefdd454e05123d
Gitweb:     https://git.kernel.org/tip/03b099bdcdf7125d4a63dc9ddeefdd454e05123d
Author:     Matthew Whitehead <tedheadster@gmail.com>
AuthorDate: Fri, 21 Sep 2018 17:20:40 -0400
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 22 Sep 2018 11:46:56 +0200

x86/CPU: Use correct macros for Cyrix calls

There are comments in processor-cyrix.h advising you to _not_ make calls
using the deprecated macros in this style:

  setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);

This is because it expands the macro into a non-functioning calling
sequence. The calling order must be:

  outb(CX86_CCR2, 0x22);
  inb(0x23);

From the comments:

 * When using the old macros a line like
 *   setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
 * gets expanded to:
 *  do {
 *    outb((CX86_CCR2), 0x22);
 *    outb((({
 *        outb((CX86_CCR2), 0x22);
 *        inb(0x23);
 *    }) | 0x88), 0x23);
 *  } while (0);

The new macros fix this problem, so use them instead.

Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180921212041.13096-2-tedheadster@gmail.com
---
 arch/x86/kernel/cpu/cyrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 8949b7ae6d92..d12226f60168 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -437,7 +437,7 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 			/* enable MAPEN  */
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);
 			/* enable cpuid  */
-			setCx86_old(CX86_CCR4, getCx86_old(CX86_CCR4) | 0x80);
+			setCx86(CX86_CCR4, getCx86(CX86_CCR4) | 0x80);
 			/* disable MAPEN */
 			setCx86(CX86_CCR3, ccr3);
 			local_irq_restore(flags);
