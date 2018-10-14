Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4619C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E4020659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwwz2JKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E4020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeJOEGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 00:06:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeJOEGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 00:06:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so17629492wmt.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L37uplPqEMhWZ/f84YCge4YKakRsY/JsUJTcR/39LA0=;
        b=bwwz2JKuepSvZItpYV0GVfIxSmtb8L+4+A0Y4hehYT026HM1xgrErCUD7cPQWGqXPA
         T8BNuCoEaAZePAL4oWn93EnNfbX1B0sfkQzwmtlHfBvCYhWWgARPOw+PYr48jty/9fMn
         1Vgcb3MSu7kY20nA8yekTGQHAX4XdCaPgcx/so+27xv6JKELgm0oXbP4z627iGnpY1gX
         kxuzfrAnwkfOQ1MZ0p+6HL2mvFN5QSLAO+9Yct1MkU8muVIhTpROpAzaqu+L+GbM4cSS
         O5jzPMXFdAZEOhEqP2yWUXpa3uXc6hjMd1zjqRXb2BsA1Ib8qqrdzJspT0ZJxGmWQCy4
         cmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L37uplPqEMhWZ/f84YCge4YKakRsY/JsUJTcR/39LA0=;
        b=AXBLW3AD2fVkXzh7/d+ZEAn4GI95jZSBi3TY2JqIFCAonksP+rEdZBAxrB1BCSsPDj
         akm4c+ycAFrzAEicHnv1mNgrPkqj3MFtJ+RN0t39sJFuBxiNdAuycTmleuD5n4MjCdcs
         2kXtmWt93H1l75odw/9Pv/x9pe4aw91JnUJcWzVsjPzMuUAMkpxs26Aj36wwx7bogLkF
         +TVg1S3WA803Pdc4oYUp3zEPIYPPW5GEYQthMViH5ebC3FS/gR0zAghiVAeE+UXCENUa
         r3vH43e/ousBS6M4XjQFfdXXbq9jyjPgqm5X42BW2KMQ/02mbC57rtn8/VQMoNumNllf
         boOQ==
X-Gm-Message-State: ABuFfog0/O3MnUYJTmvTtjyX5ZjjOdjbZLYOQ1diuOc4ZNraCIM3gH59
        W81Kdw1MVJ2Ouki9aPxc/mmRyFZe
X-Google-Smtp-Source: ACcGV615Y3QzYcla2ZCWBjWxz0G0kk3OXbwS/BnV2ZN5+N8iBnjWy+XEB8mJGR1x5roROmKc4j3Q3A==
X-Received: by 2002:a1c:ca04:: with SMTP id a4-v6mr10430384wmg.83.1539548641404;
        Sun, 14 Oct 2018 13:24:01 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id y64-v6sm6199236wmg.28.2018.10.14.13.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 13:24:00 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH v2] x86: Use assembly instruction mnemonics instead of .byte streams in arch_hweight.h
Date:   Sun, 14 Oct 2018 22:23:54 +0200
Message-Id: <20181014202354.21281-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the minimum required version of binutils was changed to 2.20,
which supports popcnt instruction mnemonics. The patch removes
corresponding #defines that implement popcnt instructions using target-dependant
.byte streams and uses unified instruction mnemonics instead.

Tested by building x86_64 and i386 version of the kernel and comparing
objdump dumps of the pathced and unpatched vmlinux.o. They were the same.

v2: Update commit message to emphasize removal of #defines.

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

