Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1FFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C4D222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYpPZB9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfBNOvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:51:05 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:35593 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407300AbfBNOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:43 -0500
Received: by mail-qt1-f180.google.com with SMTP id p48so7119483qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zgIY4W12AifZiYGKPIJKvhZkVAc9WDHsN0M0ZqcY4Ag=;
        b=JYpPZB9yAsehQJ8kX2b9s5gS/ATc4yN+Z7ukFXwBX827q0jQldoOMgxHkkSofgTJ43
         pCxVRZRsMMX5jka9RpzcT00sHG4QvKtkKUYJIIB8WF9AAPHXRdOPMm/BVhbCwj3oxQRl
         oYiOwZQg4vGq9kNokwivpbmcc7AfCtHy1BHjWz+gjxFDM+qsWTqsu9kyD6EYmJ87Ppq7
         F08nsPalvOnqVY5Ncsvqsn33CgHh6e5/oRb+0c00vwESTAmpD9LSB8b0OfAG648lC4pg
         SEBuDxd+6Zed8aGYyQOLhNXCTlFbARJ3gmZyRGDwz/4/KrgrVtNjv841KkayKTKQSSix
         ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zgIY4W12AifZiYGKPIJKvhZkVAc9WDHsN0M0ZqcY4Ag=;
        b=PLk1uc8/7EQ3pS1asZu8tFHtJTgXoVhGgduk7EDGymGUPiVwzJxTpFOAdWZs001h0l
         8rSHCQqVCbDMv4iZ+10ywTREnoeFkMIHXg27xu71BuR7kl1Bl1aVsUhJyJTNMmrCpdjF
         pUhxLzy9WGk0jKNTwKdYhx3U9vIp6h/rITiumuH+5E2FsaY4xI7ZIZO0xBrIW38FARTc
         YlWG0xTMz8dhG78VlqFrkAJLAqz7dL3Ui6Dx0M+/0AoCfuwdh3BPbg1Pt0E6sC7kh86h
         fgSTX1x/zm53s/HzLiFfcwWHgif7xUTA+HDRg971CIoojQeSESEsM7/XHpWX4T1QAsHu
         Or4w==
X-Gm-Message-State: AHQUAuZvkqR7qsCjJa514kF247ca/gFh7KE5uWI7Dckl8XNpiznk7juc
        d1AhF6oZm5tCInya5+SJ7n3ntg==
X-Google-Smtp-Source: AHgI3IZ0UvZbDTKpgh144q3MZAuV7zh79/AGn+9KJdoBj3hITiStWAv+2M2d+N7jtyEYkvhHLc4teA==
X-Received: by 2002:aed:24d8:: with SMTP id u24mr3290346qtc.47.1550155782496;
        Thu, 14 Feb 2019 06:49:42 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:41 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 07/16] ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
Date:   Thu, 14 Feb 2019 09:49:21 -0500
Message-Id: <20190214144930.27539-8-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit afaf6838f4bc896a711180b702b388b8cfa638fc upstream.

Introduce C and asm helpers to sanitize user address, taking the
address range they target into account.

Use asm helper for existing sanitization in __copy_from_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/assembler.h | 11 +++++++++++
 arch/arm/include/asm/uaccess.h   | 26 ++++++++++++++++++++++++++
 arch/arm/lib/copy_from_user.S    |  6 +-----
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index e616f61f859d..7d727506096f 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -465,6 +465,17 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+	.macro uaccess_mask_range_ptr, addr:req, size:req, limit:req, tmp:req
+#ifdef CONFIG_CPU_SPECTRE
+	sub	\tmp, \limit, #1
+	subs	\tmp, \tmp, \addr	@ tmp = limit - 1 - addr
+	addhs	\tmp, \tmp, #1		@ if (tmp >= 0) {
+	subhss	\tmp, \tmp, \size	@ tmp = limit - (addr + size) }
+	movlo	\addr, #0		@ if (tmp < 0) addr = NULL
+	csdb
+#endif
+	.endm
+
 	.macro	uaccess_disable, tmp, isb=1
 #ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index b61acd62cffb..0f6c6b873bc5 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -129,6 +129,32 @@ static inline void set_fs(mm_segment_t fs)
 #define __inttype(x) \
 	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
 
+/*
+ * Sanitise a uaccess pointer such that it becomes NULL if addr+size
+ * is above the current addr_limit.
+ */
+#define uaccess_mask_range_ptr(ptr, size)			\
+	((__typeof__(ptr))__uaccess_mask_range_ptr(ptr, size))
+static inline void __user *__uaccess_mask_range_ptr(const void __user *ptr,
+						    size_t size)
+{
+	void __user *safe_ptr = (void __user *)ptr;
+	unsigned long tmp;
+
+	asm volatile(
+	"	sub	%1, %3, #1\n"
+	"	subs	%1, %1, %0\n"
+	"	addhs	%1, %1, #1\n"
+	"	subhss	%1, %1, %2\n"
+	"	movlo	%0, #0\n"
+	: "+r" (safe_ptr), "=&r" (tmp)
+	: "r" (size), "r" (current_thread_info()->addr_limit)
+	: "cc");
+
+	csdb();
+	return safe_ptr;
+}
+
 /*
  * Single-value transfer routines.  They automatically use the right
  * size if we just have the right pointer type.  Note that the functions
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index a826df3d3814..6709a8d33963 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -93,11 +93,7 @@ ENTRY(arm_copy_from_user)
 #ifdef CONFIG_CPU_SPECTRE
 	get_thread_info r3
 	ldr	r3, [r3, #TI_ADDR_LIMIT]
-	adds	ip, r1, r2	@ ip=addr+size
-	sub	r3, r3, #1	@ addr_limit - 1
-	cmpcc	ip, r3		@ if (addr+size > addr_limit - 1)
-	movcs	r1, #0		@ addr = NULL
-	csdb
+	uaccess_mask_range_ptr r1, r2, r3, ip
 #endif
 
 #include "copy_template.S"
-- 
2.17.1

