Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1DCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E786218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900942;
	bh=lq8DUiO64Rn3NBnOg15utBUG/ufJFv25QCwtFF/ogRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZ9xHy7XxP7iVD+Bf02iouLjW0JDe7UFy1RJc4XmJk+VNMYzmnzKWlmlzKEcKptwV
	 nIQiDI8ghMOq83imvpk3w3GKkPcHdf4xsxG0lp+fuW56hwsQj3PDJ8eRqr8L9Fv3+Y
	 Ox4BGyGC6IBTatEUSOQSJq2Ta9A/1GDAGH+Navp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfBKQCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:02:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbfBKOaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D970E2075C;
        Mon, 11 Feb 2019 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895418;
        bh=lq8DUiO64Rn3NBnOg15utBUG/ufJFv25QCwtFF/ogRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTzv+aPp5l3aZg/XKnDkhci9HcM0frLmtzZDS61I5iYUN6r5aVfecusxHPg56ni4L
         e9XyMMZE92vk0GzLJq19TMzZRaLCcFfixA195uFkVbo12BaHTRqQsjBfgAKeTe63CS
         9bNeop8dKtQhB4pdAeIHCIBMCyH6sYIB4Nrz+ri4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 198/352] arm64: KVM: Skip MMIO insn after emulation
Date:   Mon, 11 Feb 2019 15:17:05 +0100
Message-Id: <20190211141859.743131514@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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
 virt/kvm/arm/mmio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
index dac7ceb1a677..08443a15e6be 100644
--- a/virt/kvm/arm/mmio.c
+++ b/virt/kvm/arm/mmio.c
@@ -117,6 +117,12 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		vcpu_set_reg(vcpu, vcpu->arch.mmio_decode.rt, data);
 	}
 
+	/*
+	 * The MMIO instruction is emulated and should not be re-executed
+	 * in the guest.
+	 */
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+
 	return 0;
 }
 
@@ -144,11 +150,6 @@ static int decode_hsr(struct kvm_vcpu *vcpu, bool *is_write, int *len)
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



