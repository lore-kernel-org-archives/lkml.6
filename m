Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C3CC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CFD20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080030;
	bh=D5ypL21+mfZqIUz5EehpdkZL3KWBWvy0iSnjDDP1rKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aJxqudfOy+wdzXvQYunHYmBmLdT5hMUovL1Lfpx6RJw4zvb/oySdJAZQqxteBH/2
	 KXaOZVPTtTpiOiI/VDPlUa9kCazWCgxuHNSaXXuPPPhhY6sJmjdJD6b+9p6lxH4OVj
	 K4OtQg6d/K9f2iTOr2q1EAMfFLt8R9Hjr8wOs3lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfAUNw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731152AbfAUNww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:52:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C2D20879;
        Mon, 21 Jan 2019 13:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078771;
        bh=D5ypL21+mfZqIUz5EehpdkZL3KWBWvy0iSnjDDP1rKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3JnfbSZGzvnxL/m0JQf1MSv60U7DhWeunHOJIMmdNX+JT2p9ZC6CyVOPQcymIOXL
         TCv+ymlj/apzYDHcz5TVRHm4EHgzqlcfa71TVWiCL5y+ilx0STvzlMty7ETRRICBsC
         FHlkW++juI7rQ2q+PNhNKxNOhS8J9H5OIV4NyKp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 11/59] arm64/kvm: consistently handle host HCR_EL2 flags
Date:   Mon, 21 Jan 2019 14:43:36 +0100
Message-Id: <20190121122457.760297173@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Backport of upstream commit 4eaed6aa2c628101246bcabc91b203bfac1193f8 ]

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
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Signed-off-by: Will Deacon <will.deacon@arm.com>
[kristina: backport to 4.14.y: adjust context]
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 1 +
 arch/arm64/kernel/head.S         | 5 ++---
 arch/arm64/kvm/hyp/switch.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 73cc4309fe01..9b25a1e2d583 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -82,6 +82,7 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
 #define HCR_INT_OVERRIDE   (HCR_FMO | HCR_IMO)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 261f3f88364c..ec393275ba04 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -414,10 +414,9 @@ CPU_LE(	bic	x0, x0, #(1 << 25)	)	// Clear the EE bit for EL2
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
index b2f1992c6234..44845996b554 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -127,7 +127,7 @@ static void __hyp_text __deactivate_traps_nvhe(void)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	write_sysreg(HCR_RW, hcr_el2);
+	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 }
 
-- 
2.19.1



