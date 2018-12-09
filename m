Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1102DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52E220672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52E220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLIWEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35846 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeLIVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:31 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72u-0002im-0s; Sun, 09 Dec 2018 21:55:28 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003dP-4M; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Christoffer Dall" <christoffer.dall@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Will Deacon" <will.deacon@arm.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.634299428@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 283/328] arm64: KVM: Tighten guest core register
 access from userspace
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Martin <Dave.Martin@arm.com>

commit d26c25a9d19b5976b319af528886f89cf455692d upstream.

We currently allow userspace to access the core register file
in about any possible way, including straddling multiple
registers and doing unaligned accesses.

This is not the expected use of the ABI, and nobody is actually
using it that way. Let's tighten it by explicitly checking
the size and alignment for each field of the register file.

Fixes: 2f4a07c5f9fe ("arm64: KVM: guest one-reg interface")
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
[maz: rewrote Dave's initial patch to be more easily backported]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kvm/guest.c | 45 ++++++++++++++++++++++++++++++++++++++++++
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
 

