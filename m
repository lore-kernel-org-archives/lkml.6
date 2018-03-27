Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELuv33hZy2Tg7Su95h8TlIk9GZ90OVN0mMuk2ATg7vHpBG6gRzjB+97PyrW9Js0NgyLzyRjb
ARC-Seal: i=1; a=rsa-sha256; t=1522157132; cv=none;
        d=google.com; s=arc-20160816;
        b=piJKWJMuHvViciGeEmTkwDV212lmCDv154/lkRXpRvaUAOEVt0EA76kDu/qJKkN8W/
         QjoQB2T7BHtUBN2dj+mZT3b+WSA6L3yPtgzoGZBYSPjasGwdCnTvC8EHwIRVmrtgQ+Hi
         keRGPqYIbkAlmQI82v6ZzOVAT4+rne/xvs4A8w+ZwkYpbGniJ17wMVclPoKoOnI1qZAf
         W+P/PFx9ttjLZCoQM4QxZ8j0I+KuC5fQgejXG8l4aUvEoh2s5M2e/9RXLFsBJ+VOHcmE
         U+fHPT7FFTjxuqBbY8bmeQp4wMwA3er9prkar6edwVYBVN1SD31OKBCTY1LkkwFe183P
         KEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=mIa32RXN+F3MI5pIaLSTOUhv5DvJwSXg8k8c43XFULk=;
        b=wtIJBNB9Fp52Xc4P+rV2fhjINHrs8ZsJ3ocgA19FD8uP02I7bR1JkckaqWV5BegpJW
         wa9WrAiQjncnxkStgOVpB6HfxWZ/SINwqr0jco9C4VxpECsDVZmDhgCSKSRCFV9k6rgx
         zgNZKYojOcIBNmgOwCIsLaEZBWz3XA/93aoD6R83mAb0aR2T+s8xwS+treCEIiCA0sdN
         9ia5HIbxW8yc0M/OnBPkLi1IxRYxMP+8285LbuNFzEUv21SkEbkKqFnoHrBX1gxKfTzV
         WvY31J9vLcbI0kSh9KMXx5yy8lIvgL36gE+n3rdeUGZAz2TTRgUPyBHJRqSyRRiIOo2P
         Gvbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CtjRilCh;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eOkWZUlM;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CtjRilCh;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eOkWZUlM;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1F0E60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
From: Chintan Pandya <cpandya@codeaurora.org>
To: catalin.marinas@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	toshi.kani@hpe.com
Cc: arnd@arndb.de,
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
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v5 2/4] arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
Date: Tue, 27 Mar 2018 18:54:58 +0530
Message-Id: <1522157100-16879-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
References: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596097437519818610?=
X-GMAIL-MSGID: =?utf-8?q?1596097437519818610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an interface to invalidate intermediate page tables
from TLB for kernel.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
Introduced in v5

 arch/arm64/include/asm/tlbflush.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 9e82dd7..6a4816d 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -209,6 +209,12 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	dsb(ish);
 }
 
+static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
+{
+	addr >>= 12;
+	__tlbi(vaae1is, addr);
+	dsb(ish);
+}
 #endif
 
 #endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
