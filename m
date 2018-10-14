Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC7C71123
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A65620843
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 09:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A65620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJNQ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 12:58:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeJNQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 12:58:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9E9HmrV3117084
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 14 Oct 2018 02:17:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9E9HjpB3117081;
        Sun, 14 Oct 2018 02:17:45 -0700
Date:   Sun, 14 Oct 2018 02:17:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nathan Chancellor <tipbot@zytor.com>
Message-ID: <tip-53c13ba8ed39e89f21a0b98f4c8a241bb44e483d@git.kernel.org>
Cc:     mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        natechancellor@gmail.com, tglx@linutronix.de,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, ndesaulniers@google.com,
          linux-kernel@vger.kernel.org, natechancellor@gmail.com,
          hpa@zytor.com, bp@alien8.de, mingo@kernel.org
In-Reply-To: <20181013005311.28617-1-natechancellor@gmail.com>
References: <20181013005311.28617-1-natechancellor@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/time: Correct the attribute on jiffies'
 definition
Git-Commit-ID: 53c13ba8ed39e89f21a0b98f4c8a241bb44e483d
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

Commit-ID:  53c13ba8ed39e89f21a0b98f4c8a241bb44e483d
Gitweb:     https://git.kernel.org/tip/53c13ba8ed39e89f21a0b98f4c8a241bb44e483d
Author:     Nathan Chancellor <natechancellor@gmail.com>
AuthorDate: Fri, 12 Oct 2018 17:53:12 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 14 Oct 2018 11:11:23 +0200

x86/time: Correct the attribute on jiffies' definition

Clang warns that the declaration of jiffies in include/linux/jiffies.h
doesn't match the definition in arch/x86/time/kernel.c:

arch/x86/kernel/time.c:29:42: warning: section does not match previous declaration [-Wsection]
__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
                                         ^
./include/linux/cache.h:49:4: note: expanded from macro '__cacheline_aligned'
                 __section__(".data..cacheline_aligned")))
                 ^
./include/linux/jiffies.h:81:31: note: previous attribute is here
extern unsigned long volatile __cacheline_aligned_in_smp __jiffy_arch_data jiffies;
                              ^
./arch/x86/include/asm/cache.h:20:2: note: expanded from macro '__cacheline_aligned_in_smp'
        __page_aligned_data
        ^
./include/linux/linkage.h:39:29: note: expanded from macro '__page_aligned_data'
#define __page_aligned_data     __section(.data..page_aligned) __aligned(PAGE_SIZE)
                                ^
./include/linux/compiler_attributes.h:233:56: note: expanded from macro '__section'
#define __section(S)                    __attribute__((__section__(#S)))
                                                       ^
1 warning generated.

The declaration was changed in commit 7c30f352c852 ("jiffies.h: declare
jiffies and jiffies_64 with ____cacheline_aligned_in_smp") but wasn't
updated here. Make them match so Clang no longer warns.

Fixes: 7c30f352c852 ("jiffies.h: declare jiffies and jiffies_64 with ____cacheline_aligned_in_smp")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181013005311.28617-1-natechancellor@gmail.com

---
 arch/x86/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index be01328eb755..fddaefc51fb6 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -25,7 +25,7 @@
 #include <asm/time.h>
 
 #ifdef CONFIG_X86_64
-__visible volatile unsigned long jiffies __cacheline_aligned = INITIAL_JIFFIES;
+__visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 #endif
 
 unsigned long profile_pc(struct pt_regs *regs)
