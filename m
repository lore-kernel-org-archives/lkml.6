Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBA6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E7B206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmH1QzWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E7B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeIGMkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:40:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45813 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeIGMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:40:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so6222688pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lNt0s5QqmaPUumDTmDh9tuGftffvBV/eRp5isuKW8Y=;
        b=TmH1QzWEdjIScRitGPZDxo0kRunrfKh346dMTCHgL4WemhLrgJXrLlzBjN+nCXAuWy
         gCDKxLM8kTmf+MYRZA461r8JZjKI8C0b8KAyNi4UI++fnhOpsvPUJRFcCrtn0F4l/PIG
         ASgLni1wy+APVrPqon048Ll4ug/DU23G3WwCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lNt0s5QqmaPUumDTmDh9tuGftffvBV/eRp5isuKW8Y=;
        b=JN6rtj3FOmyBNF4GLpS2/5OGCao9ACmYmvPAZZ2txIZBea+pMq/ydFkF08jiNbT/Kj
         8QYejLQigMoln+N0stkUJ9TtkKWwc3wlIXiU8JJADUFlHelDWQSXCP6GS4ok0/Jr22Mn
         z5t9B/pbRPf7V1BdRq07odOJ1SkEMd3RQY7O9aiRPaKEoLIvK9tNc3OQNwufTc6cDdQl
         IuoetK2lRlmqCbARrc/7J4VYXrcHV7yQnTCj3e+AEfMjMaWO+qLJDf+6A2ns5oO5m1eb
         zAvYD3laidsI8VNsbKXW+0ZsyCOib2DxXhSp1udoBrZt9fFSbhJ0tW+NTZVAXGKAFG2X
         J3VA==
X-Gm-Message-State: APzg51Ag9/EswocK/Wq1vWYHXIrzNYJh4hCYJLvSNxdbh0mzfsdVL1/r
        sWbHo1sDqqcJ7iUhBo137r6/cA==
X-Google-Smtp-Source: ANB0VdYrAtp/gUvBjI51R0qykIAQ4AyDo0qnXD2cJ9g2XlC7ham5sVbvn6vedeNBgwLYArGHpqXuGw==
X-Received: by 2002:a17:902:20c6:: with SMTP id v6-v6mr6826590plg.228.1536307234715;
        Fri, 07 Sep 2018 01:00:34 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d19-v6sm12812464pgi.50.2018.09.07.01.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:00:34 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v14 08/16] arm64: cpufeature: add MMFR0 helper functions
Date:   Fri,  7 Sep 2018 17:00:32 +0900
Message-Id: <20180907080040.4967-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
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

