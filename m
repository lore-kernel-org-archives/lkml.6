Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047FECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C065B20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C065B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeKETOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:14:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKETOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:14:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA59stYv284424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 01:54:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA59stlo284421;
        Mon, 5 Nov 2018 01:54:55 -0800
Date:   Mon, 5 Nov 2018 01:54:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Uros Bizjak <tipbot@zytor.com>
Message-ID: <tip-566b62a3676caed1f8c626e26066ff3ae3a38918@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        ubizjak@gmail.com
Reply-To: mingo@redhat.com, tglx@linutronix.de, ubizjak@gmail.com,
          hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20181014202354.21281-1-ubizjak@gmail.com>
References: <20181014202354.21281-1-ubizjak@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86: Use POPCNT mnemonics in arch_hweight.h
Git-Commit-ID: 566b62a3676caed1f8c626e26066ff3ae3a38918
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

Commit-ID:  566b62a3676caed1f8c626e26066ff3ae3a38918
Gitweb:     https://git.kernel.org/tip/566b62a3676caed1f8c626e26066ff3ae3a38918
Author:     Uros Bizjak <ubizjak@gmail.com>
AuthorDate: Sun, 14 Oct 2018 22:23:54 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 5 Nov 2018 10:42:32 +0100

x86: Use POPCNT mnemonics in arch_hweight.h

Recently, the minimum required version of binutils was changed to
2.20, which supports POPCNT instruction mnemonics.

Replace the byte-wise specification of POPCNT with those proper
mnemonics.

 [ bp: massage commit message and remove line breaks. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181014202354.21281-1-ubizjak@gmail.com
---
 arch/x86/include/asm/arch_hweight.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index 34a10b2d5b73..fc0693569f7a 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -5,15 +5,9 @@
 #include <asm/cpufeatures.h>
 
 #ifdef CONFIG_64BIT
-/* popcnt %edi, %eax */
-#define POPCNT32 ".byte 0xf3,0x0f,0xb8,0xc7"
-/* popcnt %rdi, %rax */
-#define POPCNT64 ".byte 0xf3,0x48,0x0f,0xb8,0xc7"
 #define REG_IN "D"
 #define REG_OUT "a"
 #else
-/* popcnt %eax, %eax */
-#define POPCNT32 ".byte 0xf3,0x0f,0xb8,0xc0"
 #define REG_IN "a"
 #define REG_OUT "a"
 #endif
@@ -24,7 +18,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", POPCNT32, X86_FEATURE_POPCNT)
+	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
 			 : "="REG_OUT (res)
 			 : REG_IN (w));
 
@@ -52,7 +46,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", POPCNT64, X86_FEATURE_POPCNT)
+	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
 			 : "="REG_OUT (res)
 			 : REG_IN (w));
 
