Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224dHPqzWLWW2GNm19v14i6W29C1zIAjjUo/yMMRhqGHcCDYJlE+1Jw4mUeX+DRfYziALrUF
ARC-Seal: i=1; a=rsa-sha256; t=1518709219; cv=none;
        d=google.com; s=arc-20160816;
        b=bc55JmUDFlI3E4OUN2WuUwUbKHm9BM9Sr2GwDLcAzXGekApq74NQuMMggHSNxzsE1u
         zw+Rphd2lisrafIhVG3CBli/1+5D6qiqiWxzC4QUwyMAC/q/Qd3X6FeaLfiKEIBd9ZUw
         PLR8Wzzo85nOR8D+fcwIRsr2/jeu2UGcpuh1K1ubZgOlOl3E4DBfR28oSvbCPJNaDtF0
         2/jR4wyXfITzRYo/r9rbjz4kcJl/5fhNW+rjdF35W+zGNdtVinoaq1U2h5/ed3HAgEgQ
         qewKvd7rIRiCBWUqVIsS0mUUHHrQz+iyvL0Nu6ZWQQuZ1ZC1kzlA5lyC58Lp5BPzA3k8
         4Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=C827VtmxOL28cRzTC+/FfZzCxAArgFD75qYXfKyecGM=;
        b=VA6ssTnFoeY5q9uvVXe2ZQK4M3d39I0HyaudHdY5EEq6DfSoWQRWt+fV4CC57bu+XU
         mXYHtJT4sZDp2NO1k8DOM8KAgYnBK0pc7tStWYT2/baVi8s3qHudRWqaJXYkPBcbaV4G
         V0aibYcTse8nhbgJrL/lthB5i5im6VJmzQnnH/YBEmHsgWoZ/8vujLKS7yTf3uVLFgVT
         okixGRmbqX1pNLeR7F1RUN5crJHoe5a8cRiZ1O93QsxalEEwQHbPJGDP8owxrzVykLet
         TFUc+iKGiJCaDJpyCUn8aEbTDMNkuivJTpdEFXnPDQSQRa5OGdCY0pLLipL8syRTL4R6
         Igvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 038/202] [Variant 3/Meltdown] arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR
Date: Thu, 15 Feb 2018 16:15:38 +0100
Message-Id: <20180215151715.075650355@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481491662420216?=
X-GMAIL-MSGID: =?utf-8?q?1592482038839219931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit b519538dfefc upstream.

There are now a handful of open-coded masks to extract the ASID from a
TTBR value, so introduce a TTBR_ASID_MASK and use that instead.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/asm-uaccess.h |    3 ++-
 arch/arm64/include/asm/mmu.h         |    1 +
 arch/arm64/include/asm/uaccess.h     |    4 ++--
 arch/arm64/kernel/entry.S            |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -4,6 +4,7 @@
 
 #include <asm/alternative.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/mmu.h>
 #include <asm/sysreg.h>
 #include <asm/assembler.h>
 
@@ -17,7 +18,7 @@
 	msr	ttbr0_el1, \tmp1		// set reserved TTBR0_EL1
 	isb
 	sub	\tmp1, \tmp1, #SWAPPER_DIR_SIZE
-	bic	\tmp1, \tmp1, #(0xffff << 48)
+	bic	\tmp1, \tmp1, #TTBR_ASID_MASK
 	msr	ttbr1_el1, \tmp1		// set reserved ASID
 	isb
 	.endm
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,6 +18,7 @@
 
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
 #define USER_ASID_FLAG	(UL(1) << 48)
+#define TTBR_ASID_MASK	(UL(0xffff) << 48)
 
 #ifndef __ASSEMBLY__
 
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -112,7 +112,7 @@ static inline void __uaccess_ttbr0_disab
 	write_sysreg(ttbr + SWAPPER_DIR_SIZE, ttbr0_el1);
 	isb();
 	/* Set reserved ASID */
-	ttbr &= ~(0xffffUL << 48);
+	ttbr &= ~TTBR_ASID_MASK;
 	write_sysreg(ttbr, ttbr1_el1);
 	isb();
 }
@@ -131,7 +131,7 @@ static inline void __uaccess_ttbr0_enabl
 
 	/* Restore active ASID */
 	ttbr1 = read_sysreg(ttbr1_el1);
-	ttbr1 |= ttbr0 & (0xffffUL << 48);
+	ttbr1 |= ttbr0 & TTBR_ASID_MASK;
 	write_sysreg(ttbr1, ttbr1_el1);
 	isb();
 
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -205,7 +205,7 @@ alternative_else_nop_endif
 
 	.if	\el != 0
 	mrs	x21, ttbr1_el1
-	tst	x21, #0xffff << 48		// Check for the reserved ASID
+	tst	x21, #TTBR_ASID_MASK		// Check for the reserved ASID
 	orr	x23, x23, #PSR_PAN_BIT		// Set the emulated PAN in the saved SPSR
 	b.eq	1f				// TTBR0 access already disabled
 	and	x23, x23, #~PSR_PAN_BIT		// Clear the emulated PAN in the saved SPSR
