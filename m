Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF17BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995CC2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeTiLmJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995CC2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLFP7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:59:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37061 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFP7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:59:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so1009842wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgSG9gChmYBffNKXbMNH/SpVS1I5j9iEUF32P6VsSNQ=;
        b=OeTiLmJb/vMVFqlou6bQKq9apgP2LUcCUWVMJEAQrfWdHhvbmur7qW30Qg1tVQ7d2L
         M8nEaUPwwxyHVyla64j+Pb81s2Trsf3uZB0cnLc2jPytOGg2K6MvthrZl/eUs3awgRtz
         BHW8jdTyEdBkCxpo+LKBm4JJ2hhbcz726b/kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgSG9gChmYBffNKXbMNH/SpVS1I5j9iEUF32P6VsSNQ=;
        b=irg4subCwWwBzsIARl0IKzVbOAP+EW61vOtcWRyc6OGx16a7Fn4iY0zE8ufRnEDkiR
         H356cHTBjEiN40At/qduB8fzYTX4UuNOFypHFPQQOYTJKmvG73KLq3sgB/5x8IZgM+jn
         PuZB8fxqKXhdrrFjlClNnWbeEoeiRtsKulcZBCotk4ZApDUOGo7820JrWunya7COtI3D
         N5dBM/z4v4uedP0Db9gHH1RlkVIL22HI7+Y49YoxttyKUhOkHS8wagbQqdTYpiManMP1
         iAojqGq+WaariDMwCoekd+WB55z4u4xSQnUS4KAFEMiPeNgCekrc4IWUAtBk62EKWBQA
         0tlw==
X-Gm-Message-State: AA+aEWbQOlBol7EdrgphqJY1cbE5C5rS9IrblGT8QGBotTtwuwHrfe7Q
        O7wXbJi/wLaXXC8SKrA2YwKlgGjItb836g==
X-Google-Smtp-Source: AFSGD/VvKaAmAdJzJ+BUHas/Zq2Nbfy6LLOGmMa9lkWO0VLQKH4qjf5s5cxXOfmJws8qo28Il2s7jA==
X-Received: by 2002:adf:8342:: with SMTP id 60mr24344596wrd.212.1544111984136;
        Thu, 06 Dec 2018 07:59:44 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:59:43 -0800 (PST)
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
Subject: [PATCH 2/5] arm64/alternative_cb: add nr_alts parameter to callback handlers
Date:   Thu,  6 Dec 2018 16:57:36 +0100
Message-Id: <20181206155739.20229-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callback handlers for alternative patching will shortly be able to
access a set of alternative instructions provided at assembly time.
So update the callback handler prototypes so we can pass this number.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/alternative.h |  4 ++--
 arch/arm64/include/asm/kvm_mmu.h     |  4 ++--
 arch/arm64/kernel/alternative.c      | 11 +++++++----
 arch/arm64/kernel/cpu_errata.c       | 10 ++++------
 arch/arm64/kvm/va_layout.c           |  8 ++++----
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 77da798e888b..987c1514183a 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -29,8 +29,8 @@ struct alt_instr_cb {
 	__le32 insn[];		/* sequence of alternative instructions */
 };
 
-typedef void (*alternative_cb_t)(struct alt_instr *alt,
-				 __le32 *origptr, __le32 *updptr, int nr_inst);
+typedef void (*alternative_cb_t)(struct alt_instr *alt, __le32 *origptr,
+				 __le32 *updptr, int nr_inst, int nr_alts);
 
 void __init apply_alternatives_all(void);
 
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 658657367f2f..5e32e314b9f0 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -100,8 +100,8 @@ alternative_cb_end
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 
-void kvm_update_va_mask(struct alt_instr *alt,
-			__le32 *origptr, __le32 *updptr, int nr_inst);
+void kvm_update_va_mask(struct alt_instr *alt, __le32 *origptr,
+			__le32 *updptr, int nr_insti, int nr_alts);
 
 static inline unsigned long __kern_hyp_va(unsigned long v)
 {
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index a49930843784..f55afa0bbaa4 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -107,8 +107,8 @@ static u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr, __le32 *altinsnp
 	return insn;
 }
 
-static void patch_alternative(struct alt_instr *alt,
-			      __le32 *origptr, __le32 *updptr, int nr_inst)
+static void patch_alternative(struct alt_instr *alt, __le32 *origptr,
+			      __le32 *updptr, int nr_inst, int nr_alts)
 {
 	__le32 *replptr;
 	int i;
@@ -154,7 +154,7 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 	struct alt_instr_cb *alt_cb_insn;
 
 	for (alt = region->begin; alt < region->end; alt++) {
-		int nr_inst;
+		int nr_inst, nr_alts;
 
 		/* Use ARM64_CB_PATCH as an unconditional patch */
 		if (alt->cpufeature < ARM64_CB_PATCH &&
@@ -174,12 +174,15 @@ static void __apply_alternatives(void *alt_region, bool is_module)
 
 		if (alt->cpufeature < ARM64_CB_PATCH) {
 			alt_cb = patch_alternative;
+			nr_alts = alt->alt_len / AARCH64_INSN_SIZE;
 		} else {
 			alt_cb_insn = ALT_REPL_PTR(alt);
 			alt_cb = offset_to_ptr(&alt_cb_insn->cb_offset);
+			nr_alts = (alt->alt_len - sizeof(*alt_cb_insn)) / AARCH64_INSN_SIZE;
+
 		}
 
-		alt_cb(alt, origptr, updptr, nr_inst);
+		alt_cb(alt, origptr, updptr, nr_inst, nr_alts);
 
 		if (!is_module) {
 			clean_dcache_range_nopatch((u64)origptr,
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6ad715d67df8..c5489b4612c5 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -305,9 +305,8 @@ static int __init ssbd_cfg(char *buf)
 }
 early_param("ssbd", ssbd_cfg);
 
-void __init arm64_update_smccc_conduit(struct alt_instr *alt,
-				       __le32 *origptr, __le32 *updptr,
-				       int nr_inst)
+void __init arm64_update_smccc_conduit(struct alt_instr *alt, __le32 *origptr,
+				       __le32 *updptr, int nr_inst, int nr_alts)
 {
 	u32 insn;
 
@@ -327,9 +326,8 @@ void __init arm64_update_smccc_conduit(struct alt_instr *alt,
 	*updptr = cpu_to_le32(insn);
 }
 
-void __init arm64_enable_wa2_handling(struct alt_instr *alt,
-				      __le32 *origptr, __le32 *updptr,
-				      int nr_inst)
+void __init arm64_enable_wa2_handling(struct alt_instr *alt, __le32 *origptr,
+				      __le32 *updptr, int nr_inst, int nr_alts)
 {
 	BUG_ON(nr_inst != 1);
 	/*
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index c712a7376bc1..db7ba73e306a 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -114,8 +114,8 @@ static u32 compute_instruction(int n, u32 rd, u32 rn)
 	return insn;
 }
 
-void __init kvm_update_va_mask(struct alt_instr *alt,
-			       __le32 *origptr, __le32 *updptr, int nr_inst)
+void __init kvm_update_va_mask(struct alt_instr *alt, __le32 *origptr,
+			       __le32 *updptr, int nr_inst, int nr_alts)
 {
 	int i;
 
@@ -154,8 +154,8 @@ void __init kvm_update_va_mask(struct alt_instr *alt,
 void *__kvm_bp_vect_base;
 int __kvm_harden_el2_vector_slot;
 
-void kvm_patch_vector_branch(struct alt_instr *alt,
-			     __le32 *origptr, __le32 *updptr, int nr_inst)
+void kvm_patch_vector_branch(struct alt_instr *alt, __le32 *origptr,
+			     __le32 *updptr, int nr_inst, int nr_alts)
 {
 	u64 addr;
 	u32 insn;
-- 
2.19.2

