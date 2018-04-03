Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx48Wh7O8W6VX8oY0vNC/CC3+Rfa8+UDXFYnyGEDBAQvjeixcqz7QY37wIC58ip4IvmqXs5M/
ARC-Seal: i=1; a=rsa-sha256; t=1522742532; cv=none;
        d=google.com; s=arc-20160816;
        b=Txwz8y3Yog62aMUxE9/cvUrYexV7x/rMCxeFTPaUrhCflmKCqqxZAEOdJVHdGR5GPY
         ryJKVVvHXZ9SVATnstl4hPxKkVNbwhHZBaP/Egro46MFWcWA+FzFaEIxNT8SL9E8Vbq1
         6fPYFD0N8YX+dnFnpJ/tj7EGckz6XrWy2u34cWUT7HdhYFtOOQOWSONhIdF7K5wegrIt
         BBsgJfWdmup+HoHjdSDlFUsPJn39FJCRzixYyOsTk8s4dFiUDv7ZtpCmpeQ5vt++zBPi
         2SFK/Ja1w+glZW60CPC+V+sUjpI8be221jSot2A2tMsmVM94GCI8+tT5y+RqX6lw36j5
         68Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=OfihvFKJolWQ85Vtx8K3RKJkyi6SwxowHuvy5Ccuazg=;
        b=SP9uaxlLbDgvz3RbyiNbUOe+jZ6cdhacZ4uGvGC63x4Y24e3ClgPC7ViTK647PRZX3
         j7SuO+8oG15w4Odzz7NxPjKPf+46V1lDj+kkJM2XvhUw8CXVMd26zpbhremYS567XLdz
         337M/wfdhvvAYsvB7wuHQ54KY4TdxkN6H32SNj1ATlWZjKElLWXM3RWlJhclyPhOPuag
         xWLEj8XprQbUXRnGNSuMZICEzwudEe6Kf3/FuKrhwypWH5m82ikuvJK4fvYXv7P38pYi
         DeE0z2h89Ljo4wVECfkL1OIhhqtoI25dtiYaL7BjVQRxiMLCwq6B5cicbRjifVGUgWtU
         O7eA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JFV7FCcH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JFV7FCcH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JFV7FCcH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JFV7FCcH;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CA7760C65
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
Subject: [PATCH v8 2/4] arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
Date: Tue,  3 Apr 2018 13:30:44 +0530
Message-Id: <1522742446-5084-3-git-send-email-cpandya@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711273338425981?=
X-GMAIL-MSGID: =?utf-8?q?1596711273338425981?=
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
