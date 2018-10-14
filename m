Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C796AC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CC32064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nApvgOja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CC32064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJOCRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 22:17:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36574 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeJOCRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 22:17:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so17362385wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EqigRQvhnex+fQx/zrTWbTViZl0aPRN7RMkT2wgei98=;
        b=nApvgOjaL+0kn1O+gPkBOkMzbB+N2af0PVOF9mI+i/RToW8axdXIjgyJW28kkx0AYw
         WANwM4Uy04k3iWaQ170IOY+h8HsLRV0gBnd7LreuBTMQIHDISwkmrwixtyvOvRn1ZQiW
         QghfH8sJ83T/tQezju8ljbLujhW1X9hZR+7HKs4O9jjS55cdUKI7yIlsDpUIXdxzF95F
         EYj1Bb5tdTpCL/1fAWabp1L2Di7v0//ggOIPBuyLEPk/weR4HHRVHrVb8vCvpF0Sc9/y
         U3+FRnrJ7DI2LOp3l6TZVzD4yw8fYw7PR6N25Pe5kxgnz8bDd2G5kYZPaqYnELLCDM6/
         LwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EqigRQvhnex+fQx/zrTWbTViZl0aPRN7RMkT2wgei98=;
        b=EL6mIpPl7d9DPU+bazpzI3GN6yUEFdQ9ObgMbgVRnrNYLlK98p/VkC6vTRqpC+xh3g
         jk7q13r9xdVu3ZMyG/FcUgojC2GuPjXpunW6s6bfpJ7PbYqoyYNG+FOvzcfGyPUWNVm4
         4cYIVOE8w6khaWfI/Pdlvh5HAHN63GjEuJ7RlL66ar6bmrmk61vQqpJ17WHXv8Pd4UWG
         Q6MZ8f0c0j9scGGODoRT+6/83ObNb5A9zeRs5p6FfVbcG/024n90sr1uDvHrs5GSoOsr
         oIvA3tL5CtXv2uzF2MvofEP2e8fLlAsSYlM6cnbShzE1OKHDO4Oal/FLNSTcKtMvK6Ua
         RWbA==
X-Gm-Message-State: ABuFfojdlC0PULoG9spsvDS6KnQiJs9XvPotv6GYQGaIdGin4eKUgLRU
        S5jdkU92tllCiP1LxZbxa4aag1/R
X-Google-Smtp-Source: ACcGV63PfYx+KWim4uGfhhqwLk9PjFLS6XdttAzcQxzt1G5bJvrCqmBuIuhApQjofoXcxoEz0HxnJg==
X-Received: by 2002:a1c:2746:: with SMTP id n67-v6mr10734556wmn.116.1539542120909;
        Sun, 14 Oct 2018 11:35:20 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id n11-v6sm9346136wra.26.2018.10.14.11.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 11:35:20 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86: Use assembly instruction mnemonics instead of .byte streams in arch_hweight.h
Date:   Sun, 14 Oct 2018 20:35:10 +0200
Message-Id: <20181014183510.18908-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the minimum required version of binutils was changed to 2.20,
which supports popcnt instruction mnemonics. The patch removes
all .byte #defines and uses real instruction mnemonics instead.

Tested by building x86_64 and i386 version of the kernel and comparing
objdump dumps of the pathced and unpatched vmlinux.o. They were the same.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/arch_hweight.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index 34a10b2d5b73..d668e411bd32 100644
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
@@ -24,7 +18,8 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", POPCNT32, X86_FEATURE_POPCNT)
+	asm (ALTERNATIVE("call __sw_hweight32",
+			 "popcntl %1, %0", X86_FEATURE_POPCNT)
 			 : "="REG_OUT (res)
 			 : REG_IN (w));
 
@@ -52,7 +47,8 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", POPCNT64, X86_FEATURE_POPCNT)
+	asm (ALTERNATIVE("call __sw_hweight64",
+			 "popcntq %1, %0", X86_FEATURE_POPCNT)
 			 : "="REG_OUT (res)
 			 : REG_IN (w));
 
-- 
2.17.2

