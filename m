Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZpNqwoAWha8/VlFKiMeLnBzGGG0LCibUyMCm338HXJCcp/3vqdIZkWt8xf9ZrsL9SeXqqUI
ARC-Seal: i=1; a=rsa-sha256; t=1525074137; cv=none;
        d=google.com; s=arc-20160816;
        b=pBN13L1hyF0gE7fZITJBFvUvPEJmiUrLCkfbTuhPPvtP6hu+p41hNnZSY2Sw3tcLhr
         QSYNh7OxpTghgCPltDa2xCQsgO+dqjm58t1Q7HLLRKOWdZZPpgdTX9TnI5c7oRiMpSvJ
         7pItT2wu0UWBTkhpz8+G7wy6BPUVCRLxs6mCw5nFez2kGGq26Me/juEfZdcEdhQPAVsU
         S6elPgpVZ9tVYcZOhKknZBi/7g/EToxX6PU2f3niYo5Fpm2azDSUEqomAS9y8O+JSm+L
         ZbXhONgGlqDqITtgyYLRD7OKSsQt0KPVM2mpHbCvXU+lzyn0k+FF8Ww98dZ+cQYI5CPk
         TsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Z1LksQdv5FEEr8eHpQHg9zvuqR0xq0tGWsMs4XBvbS8=;
        b=BEsYAyly6GsEpp1fObjrMG6eKMs9Doq/wy4cjB/an9/+oBXNWUHmp+7FhS3DjtsEWe
         Zsuhm1+sZF+LxH/JDc4sFRCw0nYiRZqRGgH4hkeJK8orEzGFW4u63NIiR4Dm3jaiJy+F
         zc0b9TEWeFloJjfOPTTuszDTb30m5f3h8HBqh8drudFFGqVovoDlo7K53VA/mH/cpm2F
         3Frk7PGI0eDbjmf5OqAh0Vk/GoRYVfCu3T0gAkFpo58oohe833mLuu8K/Ux6NZ1Oqhzs
         fHSibfYeuGAGNtyh0U8+u0OVGk0Uvsow7tTNXpkLa166IiuJpMZnf5azNJjifPWp+MH3
         z5FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ku79jfWn;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZwS5BkKV;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ku79jfWn;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZwS5BkKV;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5694460F5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Philip Elcan <pelcan@codeaurora.org>,
	James Morse <james.morse@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v9 2/4] arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
Date: Mon, 30 Apr 2018 13:11:32 +0530
Message-Id: <1525074094-25839-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599156139163198462?=
X-GMAIL-MSGID: =?utf-8?q?1599156139163198462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an interface to invalidate intermediate page tables
from TLB for kernel.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 arch/arm64/include/asm/tlbflush.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index dfc61d7..a4a1901 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -218,6 +218,13 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	dsb(ish);
 }
 
+static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
+{
+	unsigned long addr = __TLBI_VADDR(kaddr, 0);
+
+	__tlbi(vaae1is, addr);
+	dsb(ish);
+}
 #endif
 
 #endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
