Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6573AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AD821736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867294;
	bh=u7b4o1jaLgPIippnEODpgri1oaBiu1Td8rTnkp8dvHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qvIFbKO8rePdirTe2ztW7OWJz5Na6PkZHQ/d1xkB79QmyjH+eCs56JyDN4aSdMMw
	 3aDIBXNWnebkpH7+iFmun1D4Po+Jghp/c8CZJRJ8fPLPaZgG8w4Oajb+bXxt40hzfK
	 WvjkClIxgORKhqfag9QCjLyA8wurvCfaj9P3X58k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAGMpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfAGMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31C782183E;
        Mon,  7 Jan 2019 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865099;
        bh=u7b4o1jaLgPIippnEODpgri1oaBiu1Td8rTnkp8dvHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXAoVocvDeLbDnN43BgE8tkMJjLqE4j7mZJuG0hV4KchLgIqD+4dKAWRS21r0VDVV
         FbRLhVPnRO6Vawo/V0HA0bnbUkU+3hho3Eby8XLEhtkkKwPj9XIbADPlv8O23fI9oo
         CMRqZj8BpRxXtydZg80SQqikQLsvJJBmiDQBl8cQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.20 135/145] KVM: arm/arm64: vgic: Do not cond_resched_lock() with IRQs disabled
Date:   Mon,  7 Jan 2019 13:32:52 +0100
Message-Id: <20190107104454.882943697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Julien Thierry <julien.thierry@arm.com>

commit 2e2f6c3c0b08eed3fcf7de3c7684c940451bdeb1 upstream.

To change the active state of an MMIO, halt is requested for all vcpus of
the affected guest before modifying the IRQ state. This is done by calling
cond_resched_lock() in vgic_mmio_change_active(). However interrupts are
disabled at this point and we cannot reschedule a vcpu.

We actually don't need any of this, as kvm_arm_halt_guest ensures that
all the other vcpus are out of the guest. Let's just drop that useless
code.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-mmio.c |   21 ---------------------
 1 file changed, 21 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -313,27 +313,6 @@ static void vgic_mmio_change_active(stru
 
 	spin_lock_irqsave(&irq->irq_lock, flags);
 
-	/*
-	 * If this virtual IRQ was written into a list register, we
-	 * have to make sure the CPU that runs the VCPU thread has
-	 * synced back the LR state to the struct vgic_irq.
-	 *
-	 * As long as the conditions below are true, we know the VCPU thread
-	 * may be on its way back from the guest (we kicked the VCPU thread in
-	 * vgic_change_active_prepare)  and still has to sync back this IRQ,
-	 * so we release and re-acquire the spin_lock to let the other thread
-	 * sync back the IRQ.
-	 *
-	 * When accessing VGIC state from user space, requester_vcpu is
-	 * NULL, which is fine, because we guarantee that no VCPUs are running
-	 * when accessing VGIC state from user space so irq->vcpu->cpu is
-	 * always -1.
-	 */
-	while (irq->vcpu && /* IRQ may have state in an LR somewhere */
-	       irq->vcpu != requester_vcpu && /* Current thread is not the VCPU thread */
-	       irq->vcpu->cpu != -1) /* VCPU thread is running */
-		cond_resched_lock(&irq->irq_lock);
-
 	if (irq->hw) {
 		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
 	} else {


