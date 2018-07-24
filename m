Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228ECECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA62620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZCAvraV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA62620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbeGXIDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:03:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40795 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbeGXIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:03:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so2190311pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lNt0s5QqmaPUumDTmDh9tuGftffvBV/eRp5isuKW8Y=;
        b=IZCAvraVKXBMSrt+LprXRPa8TzsWBujFGzK9iGYEfcaNi9ch0BExwJB2bhWlPjxxw5
         0RxjkbJ0RyPgwkU8AJzqEAb+Wilqoedt05oJtDRJAm0xODSkBfBlNNDzb6/9iqf2Xea6
         ccl7Lfh3ELIhGGhvF4npOmcNsTPh8kJ81C+HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lNt0s5QqmaPUumDTmDh9tuGftffvBV/eRp5isuKW8Y=;
        b=ojozzl+Ewb2OFLUktYjdhfBQY+IIjJaej3IwEcON8J2LTL9wiOQ9jil6l1mC7rLlrU
         qA8/2m7LlWHaRl05mqu8P5pjsJiYlFXGSX+sM4T+14RGPzao+y3fSNYl9AJ03EfxZl8W
         6E+3QUwZOfBD4fw3keX+9zFZ6bF9iIa4IOLuUROJxuHOWL5IZ5/R618+MRrNtoIMAVxb
         CyriCod5LeYhRWu0vpwrxRcAjIgcRLHEfxxVnkBeG+kNafnxv9QPVqDSp6Qn2gXIFS8g
         AZ2SvlMeMT9b2heMNBw5WpYhY9d7tVaPOpYRn0fsdsMZdWpk1SCGe9zn+GbPFX56Gy96
         Ifcg==
X-Gm-Message-State: AOUpUlGZzyIrpgvoUwDmu6PxNgPXh91E5fn2++XfwTtN4Jki7isvfNyv
        Sh7uhgA2wWW43gGxHHs539GuNw==
X-Google-Smtp-Source: AAOMgpeTka3r2VkaE8A4nOw6byWcsgyhZRfyzVMrHXe+TqVMyReY7+zdj63kRyqCRVdniZFbYXO3SQ==
X-Received: by 2002:a62:c0a:: with SMTP id u10-v6mr16375735pfi.43.1532415498607;
        Mon, 23 Jul 2018 23:58:18 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id r19-v6sm15966732pgo.68.2018.07.23.23.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:58:18 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 08/16] arm64: cpufeature: add MMFR0 helper functions
Date:   Tue, 24 Jul 2018 15:57:51 +0900
Message-Id: <20180724065759.19186-9-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those helper functions for MMFR0 register will be used later by kexec_file
loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 48 +++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..cd90b5252d6d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -486,11 +486,59 @@ static inline bool system_supports_32bit_el0(void)
 	return cpus_have_const_cap(ARM64_HAS_32BIT_EL0);
 }
 
+static inline bool system_supports_4kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN4_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN4_SUPPORTED;
+}
+
+static inline bool system_supports_64kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN64_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN64_SUPPORTED;
+}
+
+static inline bool system_supports_16kb_granule(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_TGRAN16_SHIFT);
+
+	return val == ID_AA64MMFR0_TGRAN16_SUPPORTED;
+}
+
 static inline bool system_supports_mixed_endian_el0(void)
 {
 	return id_aa64mmfr0_mixed_endian_el0(read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1));
 }
 
+static inline bool system_supports_mixed_endian(void)
+{
+	u64 mmfr0;
+	u32 val;
+
+	mmfr0 =	read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	val = cpuid_feature_extract_unsigned_field(mmfr0,
+						ID_AA64MMFR0_BIGENDEL_SHIFT);
+
+	return val == 0x1;
+}
+
 static inline bool system_supports_fpsimd(void)
 {
 	return !cpus_have_const_cap(ARM64_HAS_NO_FPSIMD);
-- 
2.18.0

