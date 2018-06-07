Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YBFxGtVBGVuJdAAAmS7hNA
	; Thu, 07 Jun 2018 14:31:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 027696089E; Thu,  7 Jun 2018 14:31:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72D65602FC;
	Thu,  7 Jun 2018 14:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72D65602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933821AbeFGObs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:31:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40255 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933620AbeFGObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:31:42 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbh-0005Zm-7U; Thu, 07 Jun 2018 15:09:41 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb5-0002z4-L4; Thu, 07 Jun 2018 15:09:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marc Zyngier" <marc.zyngier@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.986419228@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 195/410] arm: KVM: Fix SMCCC handling of
 unimplemented SMC/HVC calls
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 20e8175d246e9f9deb377f2784b3e7dfb2ad3e86 upstream.

KVM doesn't follow the SMCCC when it comes to unimplemented calls,
and inject an UNDEF instead of returning an error. Since firmware
calls are now used for security mitigation, they are becoming more
common, and the undef is counter productive.

Instead, let's follow the SMCCC which states that -1 must be returned
to the caller when getting an unknown function number.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[bwh: Backported to 3.16: Use vcpu_reg() instead of vcpu_set_reg()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/kvm/handle_exit.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -45,7 +45,7 @@ static int handle_hvc(struct kvm_vcpu *v
 
 	ret = kvm_psci_call(vcpu);
 	if (ret < 0) {
-		kvm_inject_undefined(vcpu);
+		*vcpu_reg(vcpu, 0) = ~0UL;
 		return 1;
 	}
 
@@ -54,7 +54,16 @@ static int handle_hvc(struct kvm_vcpu *v
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	kvm_inject_undefined(vcpu);
+	/*
+	 * "If an SMC instruction executed at Non-secure EL1 is
+	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
+	 * Trap exception, not a Secure Monitor Call exception [...]"
+	 *
+	 * We need to advance the PC after the trap, as it would
+	 * otherwise return to the same address...
+	 */
+	*vcpu_reg(vcpu, 0) = ~0UL;
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 1;
 }
 
