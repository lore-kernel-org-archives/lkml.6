Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELsJAkP8oXTrCdf7InVkMDY0fsRaTA3079TCbjGxKhpI7aeVugTmSFkLPMz8TQaQ4WRFuQmi
ARC-Seal: i=1; a=rsa-sha256; t=1521017326; cv=none;
        d=google.com; s=arc-20160816;
        b=EGaL92k+gV+LQVEf+B8x9Mjv/Nxv/k8f17QtrCeOi+0k//0o2Ytrwu+4QdbzZY+jHT
         MErID3teLCQh23AKeaBn+50KpMdzHK2tbTgYn0beaq43r4Vt848iKR+DQrE15Fp0YmsF
         ijDGrSCRaJL3psCbbXel4TYtyPl/ldLhOdXS/+wincIDBa+OOYSz2Ez7S9sytFxslnXE
         5fY5CV81dh+9AVhTxpNvI9wvV4X7UGqRj+TwTJK83H1DgDyyL7ypze1JA/fVEcTvCUK1
         WvQrXWNZmaYg8QmiMtUvnZ16l1ddIhM5gi/K/WQM/D1rZnTsA0Lu+ikU8Yk28ELCE6GR
         8lAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Co9F+KioBoatCy947UHZVmFoVPuHhrCd48Z0+KiQ+Xg=;
        b=km9LMiVNOA+l+B2Hf3/DPXusahqC619lnAkomRvCJboUeKBlTMp8Pyf0pEu+dGLGim
         Ol6ZJGMVwnIatVFIknmJ1xuvbH1t7ivUuT8r2yebvPGglvQMAtzJeVCwEAIGhsXmj6dy
         A2CfR8LTVZoDBmaXdyuOKdEORWx9a9LxVG8SRGFuMF8yhe8Gr/LkBvDUw4UluKPNav93
         D6tOS4tW77f+qDfNsDk/OznVV+30/Fp7qYVh8PycEUohIIQS5hHOUcYJQBy6VMveX/zn
         X/28SVRXTQ7jqMLx1P7uEcyABkAthYzQxtGCdtM8v/xX9ualSm2eBk5K6OOlduuCRkKj
         b0cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q12wn2ga;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q12wn2ga;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q12wn2ga;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Q12wn2ga;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A9C960867
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	arnd@arndb.de
Cc: mark.rutland@arm.com,
	ard.biesheuvel@linaro.org,
	marc.zyngier@arm.com,
	james.morse@arm.com,
	kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	toshi.kani@hpe.com,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v1 1/4] asm/tlbflush: Add flush_tlb_pgtable() for ARM64
Date: Wed, 14 Mar 2018 14:18:22 +0530
Message-Id: <1521017305-28518-2-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902263763060667?=
X-GMAIL-MSGID: =?utf-8?q?1594902263763060667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ARM64 MMU implements invalidation of TLB for
intermediate page tables for perticular VA. This
may or may not be available for other arch. So,
provide this API hook only for ARM64, for now.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/include/asm/tlbflush.h | 5 +++++
 include/asm-generic/tlb.h         | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 9e82dd7..5f656f0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -209,6 +209,11 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	dsb(ish);
 }
 
+static inline void flush_tlb_pgtable(struct mm_struct *mm,
+				       unsigned long uaddr)
+{
+	__flush_tlb_pgtable(mm, uaddr);
+}
 #endif
 
 #endif
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index faddde4..7832c0a 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -295,4 +295,10 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
 #define tlb_migrate_finish(mm) do {} while (0)
 
+#ifndef CONFIG_ARM64
+static inline void flush_tlb_pgtable(struct mm_struct *mm,
+					unsigned long uaddr)
+{
+}
+#endif
 #endif /* _ASM_GENERIC__TLB_H */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
