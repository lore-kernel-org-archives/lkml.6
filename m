Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4372C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC5F20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC5F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeICVz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47856 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:57 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FD56D16;
        Mon,  3 Sep 2018 17:34:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.18 034/123] KVM: arm/arm64: Fix lost IRQs from emulated physcial timer when blocked
Date:   Mon,  3 Sep 2018 18:56:18 +0200
Message-Id: <20180903165720.922186161@linuxfoundation.org>
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

commit 245715cbe83ca934af5d20e078fd85175c62995e upstream.

When the VCPU is blocked (for example from WFI) we don't inject the
physical timer interrupt if it should fire while the CPU is blocked, but
instead we just wake up the VCPU and expect kvm_timer_vcpu_load to take
care of injecting the interrupt.

Unfortunately, kvm_timer_vcpu_load() doesn't actually do that, it only
has support to schedule a soft timer if the emulated phys timer is
expected to fire in the future.

Follow the same pattern as kvm_timer_update_state() and update the irq
state after potentially scheduling a soft timer.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Cc: Stable <stable@vger.kernel.org> # 4.15+
Fixes: bbdd52cfcba29 ("KVM: arm/arm64: Avoid phys timer emulation in vcpu entry/exit")
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arch_timer.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -487,6 +487,7 @@ void kvm_timer_vcpu_load(struct kvm_vcpu
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	struct arch_timer_context *vtimer = vcpu_vtimer(vcpu);
+	struct arch_timer_context *ptimer = vcpu_ptimer(vcpu);
 
 	if (unlikely(!timer->enabled))
 		return;
@@ -502,6 +503,10 @@ void kvm_timer_vcpu_load(struct kvm_vcpu
 
 	/* Set the background timer for the physical timer emulation. */
 	phys_timer_emulate(vcpu);
+
+	/* If the timer fired while we weren't running, inject it now */
+	if (kvm_timer_should_fire(ptimer) != ptimer->irq.level)
+		kvm_timer_update_irq(vcpu, !ptimer->irq.level, ptimer);
 }
 
 bool kvm_timer_should_notify_user(struct kvm_vcpu *vcpu)


