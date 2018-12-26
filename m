Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3904C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A277D218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GNmZUn9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeLZQpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:45:16 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38981 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeLZQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:45:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so9583008qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a/LUwAP4xu+zNakjYJJ48vD4f9YrE1P+QIINyrItNIo=;
        b=GNmZUn9K6Tn2ODocJgkuyy3A7xgsDN0hL4FWSQLm3kh8j6g4isGWpG8o93hWu4pigN
         u0Gg8w5h3DBG2DLFiiKh8KGIGUzjNI0EmCf4h/43KOF0FXXNBMMP9gQpZNglJ+let7P7
         8h22Skam697IhbSbUnwIUNGVP3GW/Q6xe4zJZQpLVKhRL8rwn+m+vGU1sbDx7SON17ro
         Y3tMCC/6zNvLK3OJvStI4DSD/4wJr2R9nSP7eLVlUAw6nbbzrlW4QrMOMxfk79RFF1rU
         YPTwgAplTcLDg/WN065zarbvVwKKjiM7/iwde0SzAU3EONCFmWlU2CpDTl2K25Ue52Uq
         VqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/LUwAP4xu+zNakjYJJ48vD4f9YrE1P+QIINyrItNIo=;
        b=ZPD9ev+KgQTFz3qjtbIGvdUjCS+/pPWfRQOBPgnk73+1Q9qqa2DTOVhcrUsCXIUP8d
         maD4aAVxYk5DjZApaSWgtjIcJDoAwM3Lt2skf0gurm58N7NLh0Xsa+V0iJMoO2aLlChK
         u0s2g7eLtJ+GmxEQZ9O/BF6EqEXWlv+IrWl8Ba9VPIV9/SjUitVYjP7vysKa71jBqfME
         NRWnHmmdALxq/ffMSNmiRbkXEZX1TPsMF+Rg26UGENvqZjc00yU+ZRv2GvkZ23tV1B6y
         XtFYhiW4gKxM7s6tHkphyjsRPVscwvNo7U5nMmZ594QeAYR1VosVGuitcCPtoSvF/7bG
         eHew==
X-Gm-Message-State: AJcUukdXuNRopO/POMiUl8lB/Mnmfpw9hLqwuYfP2fu7VHzNRPhhoqom
        WeG3LmuRkh9fr1V+88P3T3e5GQ==
X-Google-Smtp-Source: ALg8bN4qDJrXi30Gm/7gnRxTo2mkmliB5xWpXzK1jd9T94cUilZmTTKyrqwSwz39ZYtoAFTRG4GcUA==
X-Received: by 2002:a37:7b01:: with SMTP id w1mr18816380qkc.122.1545842714264;
        Wed, 26 Dec 2018 08:45:14 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 08:45:13 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v3 2/3] arm64: vdso: Use ARCH_TIMER_NBITS to calculate mask
Date:   Wed, 26 Dec 2018 11:45:08 -0500
Message-Id: <20181226164509.22916-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226164509.22916-1-pasha.tatashin@soleen.com>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_clock_shifted_nsec macro in vdso/gettimeofday.S has another place
where the size of clocksource precision is hardcoded. Use
ARCH_TIMER_NBITS to generate mask value.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/asm-offsets.c       | 1 +
 arch/arm64/kernel/vdso/gettimeofday.S | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 65b8afc84466..32e1b935dd6c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -107,6 +107,7 @@ int main(void)
   DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
   DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
   DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
+  DEFINE(CLOCKSOURCE_MASK,	CLOCKSOURCE_MASK(ARCH_TIMER_NBITS));
   BLANK();
   DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
   DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..5a7580d0118e 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -69,8 +69,7 @@ x_tmp		.req	x8
 	mrs	x_tmp, cntvct_el0
 	/* Calculate cycle delta and convert to ns. */
 	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
+	mov     x_tmp, #CLOCKSOURCE_MASK
 	and	\res, x_tmp, \res
 	mul	\res, \res, \mult
 	.endm
-- 
2.20.1

