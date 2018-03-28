Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+BclQwp4kLQ3HN32kijyVquloGv7jj22Tgp2JjPG1qCvdQhWdKb86GdPHYkupvHZPaA7gs
ARC-Seal: i=1; a=rsa-sha256; t=1522240312; cv=none;
        d=google.com; s=arc-20160816;
        b=zfcK1i0KTPTzeo00yOJd059tpexI3U53VbTKFR1gUo0MMnXtuO+23ZnenOkyAaRQ+Q
         GCDVe5Y6BZnauYUpEAQ+KgveAvKB1v970Zf1Wyu/47d0T/hbR6Cdc7pmbtfM5nKNlHG0
         ey/pLZ9G9Db5XL1M42cfYw10RqkOv9GDhV8x0EAFSdGuq4CfG7B2HAXSY0F30hx73lpf
         guwg4I62d+5Q/7dj70ei6bgdSxvdQmgPuGbcPEOKYA6zO9ITOQnq1YU1SeH/ptBAcypF
         MbMIi0qMMkIjH2NQAy/69kpLQxkEITaZ7Fqed0fd4xVUeNgUKviYDwgopszXcE+8OgOk
         Yj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OfihvFKJolWQ85Vtx8K3RKJkyi6SwxowHuvy5Ccuazg=;
        b=dXkQYvBpE1NZrtVnHVGkRXiBhJON3mGZ1eWY7gFnRDBGE8XfUNvevcu/jsztq2WC10
         Y8Mc8ODC9gkmgbgeNniF/B45up1+KqcuSj3Egh01th9n8bAB6BeEJZe9tclk93xjWXG/
         0nCJ+IHoB9RjyOcqcjr2CDTQCLIEOMt3WFe30sYDP1d4nTc2QAmOfpJAmoCS6dM5zyXH
         38hwA6vQbYsUzhdQZN9u9z3gmf7k08nr0p8BQe3YZqgIt7REZxFRI/5DTMTbMpSI/hPr
         qhwhkdMFgF5KdNy+sz8rjvh6mHtyOvrU5f12CdwVa5yaAXtj/e1gn9oeY7z6pXcIDO0M
         QQbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LM9FjIPJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LM9FjIPJ;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LM9FjIPJ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LM9FjIPJ;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A382260C67
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
Subject: [PATCH v7 2/4] arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
Date: Wed, 28 Mar 2018 18:01:20 +0530
Message-Id: <1522240282-12104-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
References: <1522240282-12104-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178835954343774?=
X-GMAIL-MSGID: =?utf-8?q?1596184658260289758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an interface to invalidate intermediate page tables
from TLB for kernel.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
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
