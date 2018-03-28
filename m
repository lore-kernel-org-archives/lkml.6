Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+BxupHS0Od45grEmfepJrff7Tn8KTbVHdsyXSy8/+Ot7xfE+7XWCExFCysWZ6kjhLeE514
ARC-Seal: i=1; a=rsa-sha256; t=1522234760; cv=none;
        d=google.com; s=arc-20160816;
        b=y8DZuPhmhmmjXb2cph0fDSVZARSDrVFEW/cvz2oz+87M0X0bVguiDs1TJn7dmjoxEy
         UMs7xBXSixHmcwXb2Y/51XWZnrWCohG9nxX+SrI3XIQg3SqSDWXobLfHiUC4Ypdra+MR
         U+6ATpqGZTbFqtHADUL+29m+B3nFUQyk+4ovOF1zz+wLRHxP7RiiwPD3AH/pr4acENtD
         PSukitvuwaGlCYRmGFN7zdDcRxer9opat0zC97Kd2Z90SRwPefEYtvh+MEqsf/ZwYlU8
         nF2lSOoiTqdJRo6Pj4lr5RdwzVzyXTLuKlIY8MoWLjvnNErXO8nCZrJg7SnolM3VQPTF
         +meQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=VhYPyw4Nkqe6iBRV9IccST49vWm0sIBvlGFmqhaaKlk=;
        b=P7zMughKPvusrPiNqr2AiBlWTPz57y0/rzIafomi29zZehS8ypAXnEJ0ldODuYrSdV
         qTNuJIdwAXap08m716I1Czs98lHBe7qRi9EDbTfTvV6uOZZaOH9an8ebt6VY+i6WBDw8
         dd3Ozf/9dt4Jm+P624E2ubUj0GeFhHUHTd7065ECEqws/SYVvd/Dkf8VDeFh12j7jUmL
         SkD1ltH9Wwhb2HrWidpZKQ9EWH8ZskAF2fjuNecf2ti+CyA4Albmy7xSw0sEJ0r8M1zs
         xZDBw1cjgM4dFaji7BA//0H9BfRGdycpsmF3SzsQqrdYlQrfd/4odcSxZzC16PaZhzUU
         8xpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X5opztE+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=D0J4iV3k;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X5opztE+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=D0J4iV3k;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E59360C67
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
Subject: [PATCH v6 2/4] arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
Date: Wed, 28 Mar 2018 16:28:49 +0530
Message-Id: <1522234731-27397-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
References: <1522234731-27397-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596178835954343774?=
X-GMAIL-MSGID: =?utf-8?q?1596178835954343774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add an interface to invalidate intermediate page tables
from TLB for kernel.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
From: V5->V6:
 - No change

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
