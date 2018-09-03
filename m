Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59339C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1184F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1184F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeICVzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeICVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5CADD18;
        Mon,  3 Sep 2018 17:33:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.18 033/123] KVM: arm/arm64: Fix potential loss of ptimer interrupts
Date:   Mon,  3 Sep 2018 18:56:17 +0200
Message-Id: <20180903165720.883684870@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <christoffer.dall@arm.com>

commit 7afc4ddbf299a13aaf28406783d141a34c6b4f5a upstream.

kvm_timer_update_state() is called when changing the phys timer
configuration registers, either via vcpu reset, as a result of a trap
from the guest, or when userspace programs the registers.

phys_timer_emulate() is in turn called by kvm_timer_update_state() to
either cancel an existing software timer, or program a new software
timer, to emulate the behavior of a real phys timer, based on the change
in configuration registers.

Unfortunately, the interaction between these two functions left a small
race; if the conceptual emulated phys timer should actually fire, but
the soft timer hasn't executed its callback yet, we cancel the timer in
phys_timer_emulate without injecting an irq.  This only happens if the
check in kvm_timer_update_state is called before the timer should fire,
which is relatively unlikely, but possible.

The solution is to update the state of the phys timer after calling
phys_timer_emulate, which will pick up the pending timer state and
update the interrupt value.

Note that this leaves the opportunity of raising the interrupt twice,
once in the just-programmed soft timer, and once in
kvm_timer_update_state.  Since this always happens synchronously with
the VCPU execution, there is no harm in this, and the guest ever only
sees a single timer interrupt.

Cc: Stable <stable@vger.kernel.org> # 4.15+
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arch_timer.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -295,9 +295,9 @@ static void phys_timer_emulate(struct kv
 	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	/*
-	 * If the timer can fire now we have just raised the IRQ line and we
-	 * don't need to have a soft timer scheduled for the future.  If the
-	 * timer cannot fire at all, then we also don't need a soft timer.
+	 * If the timer can fire now, we don't need to have a soft timer
+	 * scheduled for the future.  If the timer cannot fire at all,
+	 * then we also don't need a soft timer.
 	 */
 	if (kvm_timer_should_fire(ptimer) || !kvm_timer_irq_can_fire(ptimer)) {
 		soft_timer_cancel(&timer->phys_timer, NULL);
@@ -332,10 +332,10 @@ static void kvm_timer_update_state(struc
 	level = kvm_timer_should_fire(vtimer);
 	kvm_timer_update_irq(vcpu, level, vtimer);
 
+	phys_timer_emulate(vcpu);
+
 	if (kvm_timer_should_fire(ptimer) != ptimer->irq.level)
 		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
-
-	phys_timer_emulate(vcpu);
 }
 
 static void vtimer_save_state(struct kvm_vcpu *vcpu)


