Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56A0C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABBD21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRRpCYY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABBD21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbeJKXIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJKXIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C337B20652;
        Thu, 11 Oct 2018 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272434;
        bh=hQ3NJjSPH97siJSUnp7GjGfh3dZ0GYNOFoap53N9dNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRRpCYY9+KrP6nTyH/7TBP4Jrqlr/mBBSg7MmfpVlUA/QH9BMMHCK0XqlP28QOIfT
         7TTBjyWksXfVuusC21OJHBNIXOldTuaeEtdmd2UXLvxa+L3jxhUwBYQd3eF0E1267T
         xUPzJEu148jLXI47NoaeD97JYERu19lQAvdQejmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3.18 069/120] arm64: KVM: Sanitize PSTATE.M when being set from userspace
Date:   Thu, 11 Oct 2018 17:34:10 +0200
Message-Id: <20181011152552.659039424@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 2a3f93459d689d990b3ecfbe782fec89b97d3279 upstream.

Not all execution modes are valid for a guest, and some of them
depend on what the HW actually supports. Let's verify that what
userspace provides is compatible with both the VM settings and
the HW capabilities.

Cc: <stable@vger.kernel.org>
Fixes: 0d854a60b1d7 ("arm64: KVM: enable initialization of a 32bit vcpu")
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/arm64/include/asm/kvm_emulate.h |    5 +++++
 arch/arm64/kvm/guest.c               |   10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -38,6 +38,11 @@ void kvm_inject_undefined(struct kvm_vcp
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 
+static inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
+{
+	return !(vcpu->arch.hcr_el2 & HCR_RW);
+}
+
 static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -141,17 +141,25 @@ static int set_core_reg(struct kvm_vcpu
 	}
 
 	if (off == KVM_REG_ARM_CORE_REG(regs.pstate)) {
-		u32 mode = (*(u32 *)valp) & COMPAT_PSR_MODE_MASK;
+		u64 mode = (*(u64 *)valp) & COMPAT_PSR_MODE_MASK;
 		switch (mode) {
 		case COMPAT_PSR_MODE_USR:
+			if ((read_cpuid(ID_AA64PFR0_EL1) & 0xf) != 2)
+				return -EINVAL;
+			break;
 		case COMPAT_PSR_MODE_FIQ:
 		case COMPAT_PSR_MODE_IRQ:
 		case COMPAT_PSR_MODE_SVC:
 		case COMPAT_PSR_MODE_ABT:
 		case COMPAT_PSR_MODE_UND:
+			if (!vcpu_el1_is_32bit(vcpu))
+				return -EINVAL;
+			break;
 		case PSR_MODE_EL0t:
 		case PSR_MODE_EL1t:
 		case PSR_MODE_EL1h:
+			if (vcpu_el1_is_32bit(vcpu))
+				return -EINVAL;
 			break;
 		default:
 			err = -EINVAL;


