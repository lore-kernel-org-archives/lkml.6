Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFCC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8306620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079705;
	bh=6/x5wFDZavZaq5ZQsh17g8qJp4UW82s1VcttdSl5dZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JcETwa/G8/gHRCUVg26Fx/idaC+DFtJVGEbn9mVCY8mk7PwYQ6UE5B7IfX6raVhLT
	 /QVh9MR02snWlDcA8QNfnROeZvPDmyzcBaEEMcb181HcuMnX9yNxohjuN2JQVpU3oi
	 oQ3DKIym47rbWGHD7XofRlLe+j9KIskEIeJ215f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfAUOIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:08:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732014AbfAUN6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B415D2084C;
        Mon, 21 Jan 2019 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079126;
        bh=6/x5wFDZavZaq5ZQsh17g8qJp4UW82s1VcttdSl5dZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M85BG/DAqD/mrAbhzhU8WcTAFEVyy4qAT+b4LJrxgV4fSlYi1uqMBt3rJ5OPG3MSl
         +/5oSQ5ZpG3vc+OlP8nOgGt73iY/9TZ7vhSX+I+BZ1h8Qp13i1YTc7WeGpuTzEB2YQ
         M1BpEUhPCs2Q1ZteatLvmzLEgcpgWlBz5iSv7M9E=
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
Subject: [PATCH 4.19 18/99] arm64/kvm: consistently handle host HCR_EL2 flags
Date:   Mon, 21 Jan 2019 14:48:10 +0100
Message-Id: <20190121134914.607528642@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 95e3fa7ded8b..2297284e33f2 100644
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
index b0853069702f..651a06b1980f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -494,10 +494,9 @@ ENTRY(el2_setup)
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
index ca46153d7915..a1c32c1f2267 100644
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



