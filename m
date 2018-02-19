Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753061AbeBSPib (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:38:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeBSPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:38:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C9C760240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
From: Shanker Donthineni <shankerd@codeaurora.org>
To: Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Cc: Vikram Sethi <vikrams@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH] KVM: arm/arm64: No need to zero CNTVOFF in kvm_timer_vcpu_put() for VHE
Date: Mon, 19 Feb 2018 09:38:07 -0600
Message-Id: <1519054687-14405-1-git-send-email-shankerd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AArch64/AArch32, the virtual counter uses a fixed virtual offset
of zero in the following situations as per ARMv8 specifications:

1) HCR_EL2.E2H is 1, and CNTVCT_EL0/CNTVCT are read from EL2.
2) HCR_EL2.{E2H, TGE} is {1, 1}, and either:
   — CNTVCT_EL0 is read from Non-secure EL0 or EL2.
   — CNTVCT is read from Non-secure EL0.

So, no need to zero CNTVOFF_EL2/CNTVOFF for VHE case.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 virt/kvm/arm/arch_timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 70268c0..86eca324 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -541,9 +541,11 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
 	 * The kernel may decide to run userspace after calling vcpu_put, so
 	 * we reset cntvoff to 0 to ensure a consistent read between user
 	 * accesses to the virtual counter and kernel access to the physical
-	 * counter.
+	 * counter of non-VHE case. For VHE, the virtual counter uses a fixed
+	 * virtual offset of zero, so no need to zero CNTVOFF_EL2 register.
 	 */
-	set_cntvoff(0);
+	if (!has_vhe())
+		set_cntvoff(0);
 }
 
 /*
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
