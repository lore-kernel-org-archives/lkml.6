Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A64EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA49208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn6/3+Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA49208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH0OtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:49:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43018 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeH0OtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:49:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so7846336edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oTakMaiOebK5l3wbEWRh64Nq6kIU7IgNvjz7uyzmuwA=;
        b=jn6/3+OxOGwmvIFxTYpbSRgKOXuI7apBvxHgX8ipNy0TVAvz0eTHh9MNMGRwB1OqX8
         NvbEfc+1acMAk5iURWGZcozMcVtoROK/kWS2espfMemsS29uZUKNyazEBOz7dNjguZ++
         GGD6rxwtYc3tkLWMlwLOHIzaKnzHsHg1fqYAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oTakMaiOebK5l3wbEWRh64Nq6kIU7IgNvjz7uyzmuwA=;
        b=WPzWFUh78+dB88msEtzQ0AJPA2u5TrZzsnVWVR8B5J1jGbZ9EBZ9r8MSWrNRFzt3E1
         BYUCUwhZ8YCEJ/tVPWOwxflWYRYqF6KlGZ7HZDu8UK7EvJMse1cvfIpcqoWNzKRkBk+5
         RGXLHUFwpHerqRls+/ah97V44r5LbWeXa4dSQdygtSvPz/0axnG04Y+MByGRgv9LFkmb
         i3LWCCDAU+/i0P5cBafjdGcJJgmHPyZ/lMc0cHIz1XMs3m62YWNGr5lYtfAVyb9kPGzW
         RuV4kiHnbF6GEoKkr1ODkC1dvBNramlxz61bbUg2QT1C/gTxm0HhTZVid5VpCWnsu62z
         qZsw==
X-Gm-Message-State: APzg51AffRDsVxobjTp2//YFgNcmcDf0Ra9jkePvvud2nfhs09LMJKMm
        78vxHGPe8BGdUOA4rXmgkB3P3eZdKD4JfyQm
X-Google-Smtp-Source: ANB0VdaNlQQXTe7ZyRNSXz0CpEdAuQ5F2duo21GJzpkBAaoE+YIUDLAZpmGV2G67TlEncXfO5EsZOg==
X-Received: by 2002:a50:93a6:: with SMTP id o35-v6mr16577539eda.300.1535367782373;
        Mon, 27 Aug 2018 04:03:02 -0700 (PDT)
Received: from rev02.home ([2a02:a212:9283:9800:24b9:e2d6:9acc:50dd])
        by smtp.gmail.com with ESMTPSA id r2-v6sm3114344eda.89.2018.08.27.04.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:03:01 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        herbert@gondor.apana.org.au, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/4] arm64: cpufeature: add feature for CRC32 instructions
Date:   Mon, 27 Aug 2018 13:02:43 +0200
Message-Id: <20180827110245.14812-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a CRC32 feature bit and wire it up to the CPU id register so we
will be able to use alternatives patching for CRC32 operations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cpucaps.h | 3 ++-
 arch/arm64/kernel/cpufeature.c   | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ae1f70450fb2..9932aca9704b 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -51,7 +51,8 @@
 #define ARM64_SSBD				30
 #define ARM64_MISMATCHED_CACHE_TYPE		31
 #define ARM64_HAS_STAGE2_FWB			32
+#define ARM64_HAS_CRC32				33
 
-#define ARM64_NCAPS				33
+#define ARM64_NCAPS				34
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e238b7932096..7626b80128f5 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1222,6 +1222,15 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_hw_dbm,
 	},
 #endif
+	{
+		.desc = "CRC32 instructions",
+		.capability = ARM64_HAS_CRC32,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR0_EL1,
+		.field_pos = ID_AA64ISAR0_CRC32_SHIFT,
+		.min_field_value = 1,
+	},
 	{},
 };
 
-- 
2.18.0

