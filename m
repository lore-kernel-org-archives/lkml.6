Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3BEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05FA208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05FA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLGRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:53:07 -0500
Received: from foss.arm.com ([217.140.101.70]:50660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLGRxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:53:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 224C315BE;
        Fri,  7 Dec 2018 09:53:06 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E696D3F5AF;
        Fri,  7 Dec 2018 09:53:05 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6AB891AE0BA4; Fri,  7 Dec 2018 17:53:27 +0000 (GMT)
Date:   Fri, 7 Dec 2018 17:53:27 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 0/5] arm64: assorted fixes for dcache_by_line_op
Message-ID: <20181207175326.GB11430@edgewater-inn.cambridge.arm.com>
References: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

Cheers for looking at this.

On Thu, Dec 06, 2018 at 04:57:34PM +0100, Ard Biesheuvel wrote:
> This fixes two issues in dcache_by_line_op: patch #4 fixes the logic
> that is applied when patching DC CVAP instructions, and patch #5 gets
> rid of some unintended undefined symbols resulting from incorrect use
> of conditional GAS directives.
> 
> Patches #1 to #3 are groundwork for #4.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> 
> Ard Biesheuvel (5):
>   arm64/alternative_cb: move callback reference into replacements
>     section
>   arm64/alternative_cb: add nr_alts parameter to callback handlers
>   arm64/alternative_cb: add support for alternative sequences
>   arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
>   arm64/mm: use string comparisons in dcache_by_line_op
> 
>  arch/arm64/include/asm/alternative.h | 54 +++++++++++---------
>  arch/arm64/include/asm/assembler.h   | 17 +++---
>  arch/arm64/include/asm/kvm_mmu.h     |  4 +-
>  arch/arm64/kernel/alternative.c      | 22 +++++---
>  arch/arm64/kernel/cpu_errata.c       | 24 ++++++---
>  arch/arm64/kvm/va_layout.c           |  8 +--
>  6 files changed, 79 insertions(+), 50 deletions(-)

Whilst I can see that this solves the problem, I do wonder whether the
additional infrastructure is really worth it. Couldn't we just do something
really simple like the diff below instead?

Will

--->8

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 953208267252..8dea015b6599 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -390,27 +390,38 @@ alternative_endif
  * 	size:		size of the region
  * 	Corrupts:	kaddr, size, tmp1, tmp2
  */
+	.macro __dcache_op_workaround_clean_cache, op, kaddr
+alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
+	dc	\op, \kaddr
+alternative_else
+	dc	civac, \kaddr
+alternative_endif
+	.endm
+
 	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
 	dcache_line_size \tmp1, \tmp2
 	add	\size, \kaddr, \size
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
 9998:
-	.if	(\op == cvau || \op == cvac)
-alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
-	dc	\op, \kaddr
-alternative_else
-	dc	civac, \kaddr
-alternative_endif
-	.elseif	(\op == cvap)
+	.ifc	\op, cvau
+	__dcache_op_workaround_clean_cache \op, \kaddr
+	.else
+	.ifc	\op, cvac
+	__dcache_op_workaround_clean_cache \op, \kaddr
+	.else
+	.ifc	\op, cvap
 alternative_if ARM64_HAS_DCPOP
 	sys 3, c7, c12, 1, \kaddr	// dc cvap
-alternative_else
-	dc	cvac, \kaddr
-alternative_endif
+	b	9996f
+alternative_else_nop_endif
+	__dcache_op_workaround_clean_cache cvac, \kaddr
+9996:
 	.else
 	dc	\op, \kaddr
 	.endif
+	.endif
+	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
 	b.lo	9998b
