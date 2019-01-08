Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F55DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47627206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977151;
	bh=sg8He88PYAFMzsl8nQ+RbaFInaliXaS0CIBbp/TGEto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LQrJQchGPPgeasyovoR5R9pfzNy2VapozcPR3cRqke2dretYoS4XATxM9PPwE8XHT
	 bussZMIx0x8cyueYyNQUJwbYSr3GgWgtk3lt8qNDQ0uA6Kje3YQS0isewvEc4SxH0M
	 0l+mfszUopWFneA1gKXCsEMq8SReBpYfewC+ZS9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfAHTwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:52:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbfAHTbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:31:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E832120645;
        Tue,  8 Jan 2019 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975874;
        bh=sg8He88PYAFMzsl8nQ+RbaFInaliXaS0CIBbp/TGEto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkpdUr+wSgSaMhiME1LkgaljNYRd7Qhd09nqAhEiKkFE0hK+07p8WA2AweG1uFA2D
         LjZ2dp1ewjWo94Bg8jSeuXR/HUl3/jsMdAJo5U+gL9PWbuK1g8NWahB/9W2oeWiMyT
         fQmGP8QZdjHjDiUUrd5ltpAnZBo2M+R0NPrUUVsE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 51/97] arm64: Fix minor issues with the dcache_by_line_op macro
Date:   Tue,  8 Jan 2019 14:29:00 -0500
Message-Id: <20190108192949.122407-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

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
index 0bcc98dbba56..f90f5d83b228 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -378,27 +378,33 @@ alternative_endif
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

