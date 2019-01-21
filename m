Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA3C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3974E21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078398;
	bh=jWIga8RehmT25iOSFC/qB/l4FU0UN2+WuRUVYwtB6eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MSoynlV30pDMFMVomD1cNGM9Cd4fZ+b5DgNQWljlSHSdrCgx/7cFy/4//VJkY3+Ag
	 2XfwPrPRiJFRk09+davKh3n94F6K82b1+jahKRl44SvPcR2dBV9CHw8hEE9FEsjMVG
	 YenKrLR5lInM3o7eztJokVMZOjpjMNWuti/NL1cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfAUNqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfAUNqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE43D20989;
        Mon, 21 Jan 2019 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078390;
        bh=jWIga8RehmT25iOSFC/qB/l4FU0UN2+WuRUVYwtB6eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CslCBgCOI/bUsMk3/SsrACMCvci9O0F98AEt1lYKUIOm2beSp8yyeGLaUvSW1JXkT
         UBaOBbcTZkdYrRlci4X3Sc72jFx6p3hrX6pcVyl1dj5uFCmEawj7yi2OPoii5HUQpJ
         3Hxa5zhuxoX0A2v3dGNVf3hqRxB36J4BeXjJzZ5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 015/111] arm64/kvm: consistently handle host HCR_EL2 flags
Date:   Mon, 21 Jan 2019 14:42:09 +0100
Message-Id: <20190121122457.382354635@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

[ Upstream commit 4eaed6aa2c628101246bcabc91b203bfac1193f8 ]

In KVM we define the configuration of HCR_EL2 for a VHE HOST in
HCR_HOST_VHE_FLAGS, but we don't have a similar definition for the
non-VHE host flags, and open-code HCR_RW. Further, in head.S we
open-code the flags for VHE and non-VHE configurations.

In future, we're going to want to configure more flags for the host, so
lets add a HCR_HOST_NVHE_FLAGS defintion, and consistently use both
HCR_HOST_VHE_FLAGS and HCR_HOST_NVHE_FLAGS in the kvm code and head.S.

We now use mov_q to generate the HCR_EL2 value, as we use when
configuring other registers in head.S.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 1 +
 arch/arm64/kernel/head.S         | 5 ++---
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 2dafd936d84d..7b914c6fb855 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -87,6 +87,7 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..b207a2ce4bc6 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -496,10 +496,9 @@ ENTRY(el2_setup)
 #endif
 
 	/* Hyp configuration. */
-	mov	x0, #HCR_RW			// 64-bit EL1
+	mov_q	x0, HCR_HOST_NVHE_FLAGS
 	cbz	x2, set_hcr
-	orr	x0, x0, #HCR_TGE		// Enable Host Extensions
-	orr	x0, x0, #HCR_E2H
+	mov_q	x0, HCR_HOST_VHE_FLAGS
 set_hcr:
 	msr	hcr_el2, x0
 	isb
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 7cc175c88a37..f6e02cc4d856 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -157,7 +157,7 @@ static void __hyp_text __deactivate_traps_nvhe(void)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	write_sysreg(HCR_RW, hcr_el2);
+	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 }
 
-- 
2.19.1



