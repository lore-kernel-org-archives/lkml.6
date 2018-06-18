Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0572C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2155208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2155208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936838AbeFRKOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:14:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbeFRIQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:16:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB08CC50;
        Mon, 18 Jun 2018 08:16:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 036/279] KVM: arm/arm64: vgic: Kick new VCPU on interrupt migration
Date:   Mon, 18 Jun 2018 10:10:21 +0200
Message-Id: <20180618080610.305984616@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit bf9a41377d14f565764022470e14aae72559589a ]

When vgic_prune_ap_list() finds an interrupt that needs to be migrated
to a new VCPU, we should notify this VCPU of the pending interrupt,
since it requires immediate action.
Kick this VCPU once we have added the new IRQ to the list, but only
after dropping the locks.

Reported-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/arm/vgic/vgic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -599,6 +599,7 @@ retry:
 
 	list_for_each_entry_safe(irq, tmp, &vgic_cpu->ap_list_head, ap_list) {
 		struct kvm_vcpu *target_vcpu, *vcpuA, *vcpuB;
+		bool target_vcpu_needs_kick = false;
 
 		spin_lock(&irq->irq_lock);
 
@@ -669,11 +670,18 @@ retry:
 			list_del(&irq->ap_list);
 			irq->vcpu = target_vcpu;
 			list_add_tail(&irq->ap_list, &new_cpu->ap_list_head);
+			target_vcpu_needs_kick = true;
 		}
 
 		spin_unlock(&irq->irq_lock);
 		spin_unlock(&vcpuB->arch.vgic_cpu.ap_list_lock);
 		spin_unlock_irqrestore(&vcpuA->arch.vgic_cpu.ap_list_lock, flags);
+
+		if (target_vcpu_needs_kick) {
+			kvm_make_request(KVM_REQ_IRQ_PENDING, target_vcpu);
+			kvm_vcpu_kick(target_vcpu);
+		}
+
 		goto retry;
 	}
 


