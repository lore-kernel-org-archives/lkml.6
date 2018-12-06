Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBA0C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A19214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTafQJUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A19214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLFQAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:00:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLFP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:59:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so1473206wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wpw2u+vd9657tht5bV1UNpmFvYbIAJm69uSezSpG9Ao=;
        b=fTafQJUWvloms3Jzq3/B4I3D4zX2ANxFQwunJyp5pR6sv3hRU4IVk1JpJ8FsIJKO2K
         QPb0bek0z0OHe6JFTaM5W+uS1oa2eopKgztXOzHIeeHhHXr+FgYIO/sXMi+vx5VCaGAP
         NGf1CTJ4GtXAbZq9WswRDOtXlym28H4oKCc+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wpw2u+vd9657tht5bV1UNpmFvYbIAJm69uSezSpG9Ao=;
        b=X6GWvh+AIMwbwC47X7ZSdKhhDpspRBRPswPzDkG2zmE2Efd/u5ksQ8WoLs35VrOXnT
         9t00tcJQYXpTtujF/qotWRiFUM3Nr0u0h797dcdvkbcPqgsfNoW8FDscI888T4ckhUob
         lq6TFgi3Vy4kSjPB3TttAmho9mtwQ5ruQg2w0KiJtEWVUQ8J8RJxUJJSdS818m94Ubxe
         up1mDxUbp0HgFo+pZdbxQRhWLkDoS+3zcHv/CATLcg/Ene4iBZeRC/OR9opG4U40cTUZ
         /sES8mN35HUYFMIDjxutBJqQiAPLk6RtdLedoU4EHA1sBgwGKGpal3zy0BD1ct5rffkC
         0YzA==
X-Gm-Message-State: AA+aEWZsjTAhFMIXIMtt4eJ7D/3NpTaZwhzhE0SLWMucHwNjfVc8FiSh
        gij9B+h7yMt8bQWZncOzA63cOjkLWNS2bA==
X-Google-Smtp-Source: AFSGD/U/8K3Ee5ipPIKObnWbkqdw/St+p8KIU4KkxWhfa07dAZiz2aSbUVr8PaxfUg7CVH26FPBSOw==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr20445248wma.68.1544111986633;
        Thu, 06 Dec 2018 07:59:46 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:59:45 -0800 (PST)
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
Subject: [PATCH 4/5] arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
Date:   Thu,  6 Dec 2018 16:57:38 +0100
Message-Id: <20181206155739.20229-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the enhanced alternative_cb implementation to reimplement the code
patching logic for DC CVAP instructions so that we don't fall back to
DV CVAC instructions on systems that require those to be upgraded to
DC CIVAC to work around silicon errata. At the same time, we don't want
to use DV CIVAC needlessly, since doing so may adversely affect
performance.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/assembler.h |  9 +++++----
 arch/arm64/kernel/cpu_errata.c     | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..09c5a5452f60 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -390,11 +390,12 @@ alternative_else
 	dc	civac, \kaddr
 alternative_endif
 	.elseif	(\op == cvap)
-alternative_if ARM64_HAS_DCPOP
-	sys 3, c7, c12, 1, \kaddr	// dc cvap
-alternative_else
+alternative_cb arm64_handle_dc_cvap
+	dc	civac, \kaddr
+alternative_cb_alt
+	sys	3, c7, c12, 1, \kaddr	// dc cvap
 	dc	cvac, \kaddr
-alternative_endif
+alternative_cb_end
 	.else
 	dc	\op, \kaddr
 	.endif
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c5489b4612c5..a63e362da307 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -755,3 +755,17 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 	}
 };
+
+asmlinkage void __init arm64_handle_dc_cvap(struct alt_instr *alt,
+					    __le32 *origptr, __le32 *updptr,
+					    int nr_inst, int nr_alts)
+{
+	struct alt_instr_cb *alt_insn = offset_to_ptr(&alt->alt_offset);
+
+	BUG_ON(nr_inst != 1 || nr_alts != 2);
+
+	if (cpus_have_cap(ARM64_HAS_DCPOP))
+		updptr[0] = alt_insn->insn[0];
+	else if (!cpus_have_cap(ARM64_WORKAROUND_CLEAN_CACHE))
+		updptr[0] = alt_insn->insn[1];
+}
-- 
2.19.2

