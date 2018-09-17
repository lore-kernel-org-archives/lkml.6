Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083D22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083D22146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeIREhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:08 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EC86C49;
        Mon, 17 Sep 2018 23:07:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <dave.martin@arm.com>,
        Alexander Graf <agraf@suse.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 4.18 021/158] arm64: KVM: Only force FPEXC32_EL2.EN if trapping FPSIMD
Date:   Tue, 18 Sep 2018 00:40:51 +0200
Message-Id: <20180917211711.837550715@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 7d14919c0d475a795c0127631ac8ecb2b0f31831 upstream.

If trapping FPSIMD in the context of an AArch32 guest, it is critical
to set FPEXC32_EL2.EN to 1 so that the trapping is taken to EL2 and
not EL1.

Conversely, it is just as critical *not* to set FPEXC32_EL2.EN to 1
if we're not going to trap FPSIMD, as we then corrupt the existing
VFP state.

Moving the call to __activate_traps_fpsimd32 to the point where we
know for sure that we are going to trap ensures that we don't set that
bit spuriously.

Fixes: e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to reduce guest/host thrashing")
Cc: stable@vger.kernel.org # v4.18
Cc: Dave Martin <dave.martin@arm.com>
Reported-by: Alexander Graf <agraf@suse.de>
Tested-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kvm/hyp/switch.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -98,8 +98,10 @@ static void activate_traps_vhe(struct kv
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
 	val &= ~CPACR_EL1_ZEN;
-	if (!update_fp_enabled(vcpu))
+	if (!update_fp_enabled(vcpu)) {
 		val &= ~CPACR_EL1_FPEN;
+		__activate_traps_fpsimd32(vcpu);
+	}
 
 	write_sysreg(val, cpacr_el1);
 
@@ -114,8 +116,10 @@ static void __hyp_text __activate_traps_
 
 	val = CPTR_EL2_DEFAULT;
 	val |= CPTR_EL2_TTA | CPTR_EL2_TZ;
-	if (!update_fp_enabled(vcpu))
+	if (!update_fp_enabled(vcpu)) {
 		val |= CPTR_EL2_TFP;
+		__activate_traps_fpsimd32(vcpu);
+	}
 
 	write_sysreg(val, cptr_el2);
 }
@@ -129,7 +133,6 @@ static void __hyp_text __activate_traps(
 	if (cpus_have_const_cap(ARM64_HAS_RAS_EXTN) && (hcr & HCR_VSE))
 		write_sysreg_s(vcpu->arch.vsesr_el2, SYS_VSESR_EL2);
 
-	__activate_traps_fpsimd32(vcpu);
 	if (has_vhe())
 		activate_traps_vhe(vcpu);
 	else


