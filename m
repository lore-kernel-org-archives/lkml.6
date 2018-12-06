Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A0C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30E6214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQGwIxIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30E6214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbeLFP7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:59:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35747 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLFP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:59:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so1594601wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YAJ/pSqxHadg9FAalxrP9XtBWK91iIUrnuOMWYKHTIQ=;
        b=bQGwIxIBK0/KWy1ZsHZsbFC0w94wP01OxLh+vtw1bAeRhFTgOQJAMWKaoVcaUF7cZl
         lusOfufP8vuz4RrpEz6ugIwqp3RJ182W4P7mOp69ecMwFaYMJrPN5UzI1ZK73k+sd659
         MvVrQK0ljOjwxFk4GJiWJRA/VvjgBOWLtupSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YAJ/pSqxHadg9FAalxrP9XtBWK91iIUrnuOMWYKHTIQ=;
        b=jHhcVDDX+SRXIU/Vw/LJuwEmss1ebp0RD+pgpHGUdNLg5b8iAS6fypJCVOCMFnFye6
         B/f7U0uXN2nYJtmFG+DwE1HfKlwDkCtjWmvbz7NyDv9xPHPmSBCNaRSvR4HwLpQF23fF
         g7Ihormz1DxWdPBauglbywZ4FVx3Via1b8T8lFPfC1uvAJd29zeNXgJRHIh7jle0mIHT
         R4+tcRLiJ9Suv/cbi1pJ6++rmwKfgcf2dFpPHTGVMNkPLQBQYdTmanRSQDmEz2LRj6gs
         JGiw2y9XYH8SO7M6u0Aj/xDjC6w/Pg5HFkgquizfx4Re3uQLSNNG/lTrDFiQZYVQCfQF
         zkDQ==
X-Gm-Message-State: AA+aEWbzwJf5lB0gUjJ2HOVstY2LIg2xk/b68NT037ieH1kUlWokN+a0
        FJRWAfDOkYQeoz3y5GMDZ/+dlidHjEn9/Q==
X-Google-Smtp-Source: AFSGD/Uz7FkM93KEWIIiMgqx12qgI/PGpb5Q4lkjoKBx6o5w4iOeuACny/LZxt+3lyM9PK+a8jbVSg==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr20471294wmi.101.1544111987884;
        Thu, 06 Dec 2018 07:59:47 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:59:47 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 5/5] arm64/mm: use string comparisons in dcache_by_line_op
Date:   Thu,  6 Dec 2018 16:57:39 +0100
Message-Id: <20181206155739.20229-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GAS directives that are currently being used in dcache_by_line_op
rely on assembler behavior that is not documented, and probably not
guaranteed to produce the correct behavior going forward.

Currently, we end up with some undefined symbols in cache.o:

$ nm arch/arm64/mm/cache.o
         ...
         U civac
         ...
         U cvac
         U cvap
         U cvau

This is due to the fact that the comparisons used to select the
operation type in the dcache_by_line_op macro are comparing symbols
not strings, and even though it seems that GAS is doing the right
thing here (undefined symbols by the same name are equal to each
other), it seems unwise to rely on this.

So let's switch to conditional directives that are documented as
operating on strings. Since these cannot be combined like ordinary
arithmetic expressions, invert the comparison logic.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 09c5a5452f60..df3043e76e6a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -383,21 +383,23 @@ alternative_endif
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
 9998:
-	.if	(\op == cvau || \op == cvac)
+	.ifnc	\op, civac
+	.ifnc	\op, cvap
 alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
 	dc	\op, \kaddr
 alternative_else
 	dc	civac, \kaddr
 alternative_endif
-	.elseif	(\op == cvap)
+	.else
 alternative_cb arm64_handle_dc_cvap
 	dc	civac, \kaddr
 alternative_cb_alt
 	sys	3, c7, c12, 1, \kaddr	// dc cvap
 	dc	cvac, \kaddr
 alternative_cb_end
+	.endif
 	.else
-	dc	\op, \kaddr
+	dc	civac, \kaddr
 	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
-- 
2.19.2

