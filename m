Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9EBC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F8021470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbzK9Lhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F8021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeJKXGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DC820652;
        Thu, 11 Oct 2018 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272329;
        bh=3rp2QlXgwc5vLryRMopIfjesRtEA7fYhoQH6qUIen6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbzK9LhdkfJEO5b3hr/gel9d49Vd4r8UHXqpnsFlcF8xYuT90cTpKmpxGhFykYqCw
         jcufoe0OkNvU+HALCTazgm/hfXaUS+9q3b7RnVABdW+pBaSHo33sFycRXB+kuugc8k
         5WN8uHFCPa4T7FXvOjHUyDY8WxCIiUAA3+oi+b9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3.18 063/120] arm64: KVM: Tighten guest core register access from userspace
Date:   Thu, 11 Oct 2018 17:34:04 +0200
Message-Id: <20181011152552.394412670@linuxfoundation.org>
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

From: Dave Martin <Dave.Martin@arm.com>

commit d26c25a9d19b5976b319af528886f89cf455692d upstream.

We currently allow userspace to access the core register file
in about any possible way, including straddling multiple
registers and doing unaligned accesses.

This is not the expected use of the ABI, and nobody is actually
using it that way. Let's tighten it by explicitly checking
the size and alignment for each field of the register file.

Cc: <stable@vger.kernel.org>
Fixes: 2f4a07c5f9fe ("arm64: KVM: guest one-reg interface")
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
[maz: rewrote Dave's initial patch to be more easily backported]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kvm/guest.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -46,6 +46,45 @@ static u64 core_reg_offset_from_id(u64 i
 	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
 }
 
+static int validate_core_offset(const struct kvm_one_reg *reg)
+{
+	u64 off = core_reg_offset_from_id(reg->id);
+	int size;
+
+	switch (off) {
+	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
+	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
+	case KVM_REG_ARM_CORE_REG(regs.sp):
+	case KVM_REG_ARM_CORE_REG(regs.pc):
+	case KVM_REG_ARM_CORE_REG(regs.pstate):
+	case KVM_REG_ARM_CORE_REG(sp_el1):
+	case KVM_REG_ARM_CORE_REG(elr_el1):
+	case KVM_REG_ARM_CORE_REG(spsr[0]) ...
+	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
+		size = sizeof(__u64);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
+	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
+		size = sizeof(__uint128_t);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
+		size = sizeof(__u32);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (KVM_REG_SIZE(reg->id) == size &&
+	    IS_ALIGNED(off, size / sizeof(__u32)))
+		return 0;
+
+	return -EINVAL;
+}
+
 static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 {
 	/*
@@ -65,6 +104,9 @@ static int get_core_reg(struct kvm_vcpu
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
 		return -ENOENT;
 
+	if (validate_core_offset(reg))
+		return -EINVAL;
+
 	if (copy_to_user(uaddr, ((u32 *)regs) + off, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 
@@ -87,6 +129,9 @@ static int set_core_reg(struct kvm_vcpu
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >= nr_regs)
 		return -ENOENT;
 
+	if (validate_core_offset(reg))
+		return -EINVAL;
+
 	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
 		return -EINVAL;
 


