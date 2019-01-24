Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE673C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F361218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358920;
	bh=mFo8k6uNPilubPRW7Tv4K1psNiY7oGR+H9EaGvdHh08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0JQb47k9JWCepAMIAcW4br143OaZxu02eTarxo63yDKLLtgVJ9vpjaLpCDDsoPYx
	 yjUbcv1Lp5YD976n03I9l6CHTmWBz8A7f1H+t9efg3cR48dh/ZvwsxqrsZ+vCqQD9W
	 K0PfdzmnwEigFKs56AZBsb8z1AdeJyrH6Li036Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbfAXTl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387689AbfAXTl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:41:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017B8218D9;
        Thu, 24 Jan 2019 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358915;
        bh=mFo8k6uNPilubPRW7Tv4K1psNiY7oGR+H9EaGvdHh08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1fiympOhjOAK73b382GbG+UZWKGE9ZqyfPJBVxAp2jvbu3+el0ztezomZNqdeHLF
         v6F+4BH2fiCSqkKz6dzVhYTbN0wkvktjSUmhjnbSsTB36+KCtRDreLqnjqn+VyOtFf
         IfQP98oPmWbrwhk2yC9Bmc6dcqQdSTLN0xTb/kBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 070/127] arm64: Fix minor issues with the dcache_by_line_op macro
Date:   Thu, 24 Jan 2019 20:20:16 +0100
Message-Id: <20190124190215.160444577@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 33309ecda0070506c49182530abe7728850ebe78 ]

The dcache_by_line_op macro suffers from a couple of small problems:

First, the GAS directives that are currently being used rely on
assembler behavior that is not documented, and probably not guaranteed
to produce the correct behavior going forward. As a result, we end up
with some undefined symbols in cache.o:

$ nm arch/arm64/mm/cache.o
         ...
         U civac
         ...
         U cvac
         U cvap
         U cvau

This is due to the fact that the comparisons used to select the
operation type in the dcache_by_line_op macro are comparing symbols
not strings, and even though it seems that GAS is doing the right
thing here (undefined symbols by the same name are equal to each
other), it seems unwise to rely on this.

Second, when patching in a DC CVAP instruction on CPUs that support it,
the fallback path consists of a DC CVAU instruction which may be
affected by CPU errata that require ARM64_WORKAROUND_CLEAN_CACHE.

Solve these issues by unrolling the various maintenance routines and
using the conditional directives that are documented as operating on
strings. To avoid the complexity of nested alternatives, we move the
DC CVAP patching to __clean_dcache_area_pop, falling back to a branch
to __clean_dcache_area_poc if DCPOP is not supported by the CPU.

Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/assembler.h | 30 ++++++++++++++++++------------
 arch/arm64/mm/cache.S              |  3 +++
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6142402c2eb4..08b216c200c9 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -377,27 +377,33 @@ alternative_endif
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
-alternative_if ARM64_HAS_DCPOP
-	sys 3, c7, c12, 1, \kaddr	// dc cvap
-alternative_else
-	dc	cvac, \kaddr
-alternative_endif
+	.ifc	\op, cvau
+	__dcache_op_workaround_clean_cache \op, \kaddr
+	.else
+	.ifc	\op, cvac
+	__dcache_op_workaround_clean_cache \op, \kaddr
+	.else
+	.ifc	\op, cvap
+	sys	3, c7, c12, 1, \kaddr	// dc cvap
 	.else
 	dc	\op, \kaddr
 	.endif
+	.endif
+	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
 	b.lo	9998b
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 0c22ede52f90..a194fd0e837f 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -212,6 +212,9 @@ ENDPROC(__dma_clean_area)
  *	- size    - size in question
  */
 ENTRY(__clean_dcache_area_pop)
+	alternative_if_not ARM64_HAS_DCPOP
+	b	__clean_dcache_area_poc
+	alternative_else_nop_endif
 	dcache_by_line_op cvap, sy, x0, x1, x2, x3
 	ret
 ENDPIPROC(__clean_dcache_area_pop)
-- 
2.19.1



