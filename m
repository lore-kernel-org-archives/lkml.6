Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Bjpb6Nx2AiXMAFdLzSzCC/XHVn0dXJsPEXW3mNPjWC6YeAvRR0V7K5WAr45k8wY7+MHHd
ARC-Seal: i=1; a=rsa-sha256; t=1518708697; cv=none;
        d=google.com; s=arc-20160816;
        b=qwgUTrXi+5ks5vnW8u6ENQ4ZL3YEPg/fEhGaDSEnyN/X8LvQcaHx7DmgL7c2mrdEH6
         YN6BG22BGJHsKVCQV0AoLfC0t/4HQudrLv+cfnmm8Ntx36EdpSfiyR4TA+0qu5Yjwqhy
         hu6d0m7LNbx5GLu2xTa96cN9/Y1KlwtIyo4waY3jStjutwRyh7MEZQGGRBbqW9QsLRRt
         hxCqB3MTK58soreWVvT1Pvj2Jn/kivbK1ntJSbaAcdm3KzQ/ykPGrzZL6rqiUR/gv0RJ
         LcI6+nFieY0UDQ+gfW+/pi/WF9fHHpDTB/fq8zmzFBHy8GPcIa8mrCczDETexjMyxHyW
         gr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4kHOqRFARhpcj5YXNyqEQ4QDS5Bp8s14z1sB2ZwUT4g=;
        b=FDin3KIgdFy3lbFykoqBeQNuT7wpC57JqV3t9dFSYgDnaMymmJq0o8rIu/bfEmkdfO
         cOzXywwLZb/3rouL9uqVRJngxymHLXoN8M2XhP68WCXHvkM2MpoE/Kmfq8ALB4KE2KIw
         PuC/kiYxwPX7igse0ALRNjrL12qmY2vHsdj8r7oA0PLRQO/yEbqHV9hhJObbjw1emU2e
         6tIscVEfhkUXktJab5Mh4cYeo5QdH5V0QlazQVIgcdl3tpBoEfJ0tGkhBXTnsuxgUPQ2
         KROPfsT2l5tut6iux3UD7IJNdnfJOrKdujP3PjPiuI1YZZ1prtsKpYx5ip/SJ7mMbRos
         8I3A==
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
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 046/195] [Variant 3/Meltdown] arm64: mm: Introduce TTBR_ASID_MASK for getting at the ASID in the TTBR
Date: Thu, 15 Feb 2018 16:15:37 +0100
Message-Id: <20180215151708.038968792@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481491662420216?=
X-GMAIL-MSGID: =?utf-8?q?1592481491662420216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
