Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF95C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA75214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cikb10eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA75214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeLFP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:59:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeLFP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:59:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so970406wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBf2ddABzNmUATNTkk2NnIWCCRz0jpWPHKnmmJ2ur1E=;
        b=cikb10eScMgEpPy7mtJP4RXIN8T1QZq9WVgYZi95AR+i7To5iS+heCKoRM9014xRYT
         Ur1lV8CjLtLPaiHFc7wRUaDcfjjrmA9TvhtO503Qjkft00Bz8qad0RgXK+dBAKCNrjXj
         FchhmDN30ABh9EurnN30vGYzRdHREgSGwqJ1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBf2ddABzNmUATNTkk2NnIWCCRz0jpWPHKnmmJ2ur1E=;
        b=oruKmnO+eKiKzFTrrQg1A2P22rrb0TqGdFJQwprfDyAKCW4wZxbD+8X6SDxOPpVB4S
         rApT61DQa5CvAdGrsucXNtOuZS7qnRNyXEt2xqOk4sD5cjRIzbyk9XCpu7Sg2tcDcI0x
         DUAR7+GuvvdA1sp4phEtOI59p96Qq5zoFT+QJJJN/xvTQV5Cu6O93YUfvtHr2/QQ6T+X
         9G1rl2iOhcot+QV6BWn0AEDksXmPd6ghQebvpRyFQ5I6hG+hyP+ckCOAgZ1VOedGVkTg
         Upp2lETQKTJ9PwkIgCaxBuvLI08Sy5x9nkqmKWn3GFLneOWwov6f39w16qvzPnQ0/SsS
         zrNQ==
X-Gm-Message-State: AA+aEWYsR9llxRGitWQBUmxajL3/shxnnMk1Pul2dY5WrdTymVIJ7bff
        I/7OwM2WoRbinJ/LFj/oSj/Ly/4YG3PJ8w==
X-Google-Smtp-Source: AFSGD/VhyKKwFtrwEwbxdn3T97eS4TuHFuszki85hwbAkAZOws3n+QUG/oNY3bRdVyJabPsG+BScbg==
X-Received: by 2002:adf:b201:: with SMTP id u1mr25976578wra.165.1544111985333;
        Thu, 06 Dec 2018 07:59:45 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:59:44 -0800 (PST)
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
Subject: [PATCH 3/5] arm64/alternative_cb: add support for alternative sequences
Date:   Thu,  6 Dec 2018 16:57:37 +0100
Message-Id: <20181206155739.20229-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permit callback type alternatives to carry a sequence of alternative
instructions, and leave it up to the callback handler to decide how
to use them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/alternative.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 987c1514183a..6b7726ee6b0a 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -156,7 +156,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.popsection
 	.pushsection .altinstr_replacement, "ax"
 663:	.word	\cb - .
-664:	.popsection
+	.popsection
 661:
 .endm
 
@@ -185,10 +185,21 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
 	.org	. - (662b-661b) + (664b-663b)
 .endm
 
+.macro alternative_cb_alt
+	.set .Lasm_alt_mode, 1
+	.pushsection .altinstr_replacement, "ax"
+	.org	663b + AARCH64_INSN_SIZE
+.endm
+
 /*
  * Callback-based alternative epilogue
  */
 .macro alternative_cb_end
+	.if .Lasm_alt_mode==0
+	.pushsection .altinstr_replacement, "ax"
+	.org	663b + AARCH64_INSN_SIZE
+	.endif
+664:	.popsection
 662:
 .endm
 
-- 
2.19.2

