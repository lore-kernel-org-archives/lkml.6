Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F96C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1195E2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692851;
	bh=F94zqeT9EReT6TR2XWPDHPvFwDySPNmZN6oFjLmP03M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZKRptn8PkYjP3XZudhVpaSivEKt6xb0eDTf8/HVW8Moy7aHOw/65NYfB3TyGrYTR
	 AkeC1/ZPwZZ/3oNEOto4lhlScCxThyWRcYWDvzuiiCv3ROycXJ7lNDu1CK1ApoQmU5
	 qWn+h3V3YvjbVP+m/idUez2VwCQU8drn9liQtVX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfA1Q13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390406AbfA1Q1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:27:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB0102147A;
        Mon, 28 Jan 2019 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692844;
        bh=F94zqeT9EReT6TR2XWPDHPvFwDySPNmZN6oFjLmP03M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MzYdjsKYaum9c/yC9Y5C/UPz8ZEWMm1lZGIxDAlJCvLuxSseLxNr2HToDc+Pw06b0
         p0Z/8V0xYDwepUclwGrdwIqBmPJ5M8YlCL2auUvmpZcYV4KcwO6BvXosvlQGyjwXrB
         qZ/oc+nmQTDjSjQ0hjLEOt6OsT0rvjFs28r4gDnM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 3.18 35/61] arm64: KVM: Skip MMIO insn after emulation
Date:   Mon, 28 Jan 2019 11:25:57 -0500
Message-Id: <20190128162623.59854-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 0d640732dbebed0f10f18526de21652931f0b2f2 ]

When we emulate an MMIO instruction, we advance the CPU state within
decode_hsr(), before emulating the instruction effects.

Having this logic in decode_hsr() is opaque, and advancing the state
before emulation is problematic. It gets in the way of applying
consistent single-step logic, and it prevents us from being able to fail
an MMIO instruction with a synchronous exception.

Clean this up by only advancing the CPU state *after* the effects of the
instruction are emulated.

Cc: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kvm/mmio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 4cb5a93182e9..c215bb4423ac 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -118,6 +118,12 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		*vcpu_reg(vcpu, vcpu->arch.mmio_decode.rt) = data;
 	}
 
+	/*
+	 * The MMIO instruction is emulated and should not be re-executed
+	 * in the guest.
+	 */
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+
 	return 0;
 }
 
@@ -154,11 +160,6 @@ static int decode_hsr(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	vcpu->arch.mmio_decode.sign_extend = sign_extend;
 	vcpu->arch.mmio_decode.rt = rt;
 
-	/*
-	 * The MMIO instruction is emulated and should not be re-executed
-	 * in the guest.
-	 */
-	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 0;
 }
 
-- 
2.19.1

