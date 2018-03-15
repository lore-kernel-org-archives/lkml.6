Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtQsfJEMRV6EieJivmtRP3YYW8fvzVlS+xGFVd/275NznFkqGnJ9aVmnN3I2OmZYj65kW+p
ARC-Seal: i=1; a=rsa-sha256; t=1521117929; cv=none;
        d=google.com; s=arc-20160816;
        b=zm5S+xXtIbAs1849+tAZmBf8/CaKjrcnVr1D1XU+9T/klh4PNte+z77O84YXGyc6xn
         yamKG5IAXjrGYXM4SzqgN6PAwkOPs/+4Wp4CqoY9cmbYvtLc2ujwdhwwHFupXZnH3ZqT
         tBfmsYSLRZRjVu8VlsaEarDm9c6kBKozgcZtqeaakIf9ma9+0Uxo7nZCSKFrDtn1xvHq
         ECUspyc3yvPe/+Kn+I7eEaAijHiVYsHiiKu008AM5/rUf06CsxJWDJDSq13XlbuxcZe5
         UNHa/lJX4jSAJryjsV3Q5CtgcVX+XEyMBuUeS+FppYlAlF4L1yoBVkebh9VUHDsMJkvi
         us7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Co9F+KioBoatCy947UHZVmFoVPuHhrCd48Z0+KiQ+Xg=;
        b=pHjqXlfBCTApJPADkwTKtdWSSJuFlx3oZ9Iop1yEO+sbJXAruGLR8wCbtNtGmbD6cm
         bewO/nASc2tlZiUgQbksxUErtVTy118l8Jcit/VDXf8iMkeYPPK9jjyB590HsV0sXy1M
         QsCqxUvWY7BtBaCbx8wpoj8Y66CpxoWNeA8yBqoW9ImCWkd8WTRBOkw/2erQy5XHAQ7Z
         IwS5esf0ubY1dmUrlkQFXnbGmXDELsKs5QVWoYqnWiaS0ZbwjPF1mB3zMlKae+8/UIb1
         PNpz0Lhibzm0MI4lVOCJw/NOE33mWwvkuPvP9OpQTCkqdf08ZFa41WteHQbQeom1e8YT
         KpqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Kl+SxKNv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X6z9UOtm;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Kl+SxKNv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X6z9UOtm;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73F7760BFA
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
Subject: [PATCH v2 1/4] asm/tlbflush: Add flush_tlb_pgtable() for ARM64
Date: Thu, 15 Mar 2018 18:15:03 +0530
Message-Id: <1521117906-20107-2-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007754544699532?=
X-GMAIL-MSGID: =?utf-8?q?1595007754544699532?=
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
