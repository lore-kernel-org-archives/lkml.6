Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE15C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C442147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfA2VEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:04:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbfA2VEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:04:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TL4Zwq2097139
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 13:04:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TL4Z5x2097136;
        Tue, 29 Jan 2019 13:04:35 -0800
Date:   Tue, 29 Jan 2019 13:04:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-5ccd35287edae4107475a141a477a6a4ecbe1cab@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        colin.king@canonical.com, dave.hansen@linux.intel.com,
        bp@alien8.de, luto@kernel.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
          colin.king@canonical.com, luto@kernel.org, bp@alien8.de,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20181222191116.21831-1-colin.king@canonical.com>
References: <20181222191116.21831-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fault: Fix sign-extend unintended sign
 extension
Git-Commit-ID: 5ccd35287edae4107475a141a477a6a4ecbe1cab
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

Commit-ID:  5ccd35287edae4107475a141a477a6a4ecbe1cab
Gitweb:     https://git.kernel.org/tip/5ccd35287edae4107475a141a477a6a4ecbe1cab
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Sat, 22 Dec 2018 19:11:16 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 21:58:59 +0100

x86/fault: Fix sign-extend unintended sign extension

show_ldttss() shifts desc.base2 by 24 bit, but base2 is 8 bits of a
bitfield in a u16.

Due to the really great idea of integer promotion in C99 base2 is promoted
to an int, because that's the standard defined behaviour when all values
which can be represented by base2 fit into an int.

Now if bit 7 is set in desc.base2 the result of the shift left by 24 makes
the resulting integer negative and the following conversion to unsigned
long legitmately sign extends first causing the upper bits 32 bits to be
set in the result.

Fix this by casting desc.base2 to unsigned long before the shift.

Detected by CoverityScan, CID#1475635 ("Unintended sign extension")

[ tglx: Reworded the changelog a bit as I actually had to lookup
  	the standard (again) to decode the original one. ]

Fixes: a1a371c468f7 ("x86/fault: Decode page fault OOPSes better")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20181222191116.21831-1-colin.king@canonical.com

---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad33233..9d5c75f02295 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -595,7 +595,7 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		return;
 	}
 
-	addr = desc.base0 | (desc.base1 << 16) | (desc.base2 << 24);
+	addr = desc.base0 | (desc.base1 << 16) | ((unsigned long)desc.base2 << 24);
 #ifdef CONFIG_X86_64
 	addr |= ((u64)desc.base3 << 32);
 #endif
