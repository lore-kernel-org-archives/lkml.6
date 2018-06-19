Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE13C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2859A2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7GNC/TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030488AbeFST2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:28:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46563 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967238AbeFST1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:27:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id v13-v6so768577wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vXkMZMdtqXwQabFANthjvHFgEKPyu0gVz46zl6OeIVE=;
        b=i7GNC/THtkqIFgVKnHdxUVIbmlKJIQy7v3p4BwEj1erCZvwTmWIa+/hKBzYZjD56Xu
         vMlyj27HMPXKIPMNFtnWvldICGi16v2J1M9Azc3oD69HaghjPgbPIKjvcmISiImH0rnq
         ++UP/h6sU4C+UubeUp2yZaTEL9W4nKhSquTcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vXkMZMdtqXwQabFANthjvHFgEKPyu0gVz46zl6OeIVE=;
        b=gQ3r1qy/ea1v5/P2TWVwN42LifKdBtnh8cyySSQPeJ3DSRKWktlmrkS1SBqYMTmYmT
         U9azr7hNee4hsBJNhrEL34ybrumJaf3IqCxSC/+t/faES/PlrW4MFrdp9UeN4ypeUX94
         E6M/XFEN2/ta60IHgXtF3mMBxTXa7vXypcBfv+6LYXvrqltssfPqXPVUvqtBe0rECmhP
         87Pgt6Iez9xM42SUJNNM/i6F+HpxhKZ63SUDyny3wPEDt2IOuoov4fDxMcWyu9O5Rm21
         sOP4zHRL9g1PpNGZSTbuYnX1rNggSFQd8hK3wPkS9i6TPdKxhhNM94j7r/lZxqYgXbRk
         4cug==
X-Gm-Message-State: APt69E0axfwloUWAtuBFhrctDww70tmVw6XzJ6jebJy+ot+USEx7QhS3
        xoyn3l6KWEUG+lZl3PFC9f+VJg==
X-Google-Smtp-Source: ADUXVKJKV+gJwOTs4fGYuHpPN3yjYMiNZER6ZjBPGf9SRdEeq1x5pe1rQY+fgb87l6jZVuSXVbagsA==
X-Received: by 2002:adf:88ca:: with SMTP id g10-v6mr14060672wrg.62.1529436467570;
        Tue, 19 Jun 2018 12:27:47 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:a06d:5653:4fd5:13a])
        by smtp.gmail.com with ESMTPSA id c53-v6sm982601wrg.12.2018.06.19.12.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:27:46 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, linux@roeck-us.net, mark.rutland@arm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] ARM: assembler: prevent ADR from setting the Thumb bit twice
Date:   Tue, 19 Jun 2018 21:26:33 +0200
Message-Id: <20180619192633.21846-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To work around recent issues where ADR references to Thumb function
symbols may or may not have the Thumb bit set already when they are
resolved by GAS, reference the symbol indirectly via a local symbol
typed as 'function', and emit the reference in a way that prevents
the assembler from resolving it directly. Instead, it will be fixed
up by the linker, which behaves consistently and according to spec
when it comes to relocations of symbols with function annotation
targetting wide ADR instructions.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/assembler.h | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 6ae42ad29518..ee2d4eb26318 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,13 +195,33 @@
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-	adr\c	\rd, \sym + 1
+	__badr	\c, \rd, \sym
 #else
 	adr\c	\rd, \sym
 #endif
 	.endm
 	.endr
 
+	/*
+	 * GAS's behavior with respect to setting the Thumb bit on addresses
+	 * of locally defined symbols taken using adr instructions is
+	 * inconsistent, and so we are better off letting the linker handle
+	 * it instead. So emit the reference as a relocation, and force a
+	 * wide encoding so that we can support both forward and backward
+	 * references, and avoid the R_ARM_THM_PC8 relocation that operates
+	 * on the narrow encoding, which is documented as not taking the
+	 * Thumb bit into account. (IHI 0044E ELF for the ARM Architecture)
+	 *
+	 * Note that this needs to be a separate macro or \@ does not work
+	 * correctly.
+	 */
+	.macro		__badr, c, rd, sym
+	.set		.Lsym\@, \sym
+	.type		.Lsym\@, %function
+	.reloc		., R_ARM_THM_ALU_PREL_11_0, .Lsym\@
+	adr\c\().w	\rd, .
+	.endm
+
 /*
  * Get current thread_info.
  */
-- 
2.17.1

