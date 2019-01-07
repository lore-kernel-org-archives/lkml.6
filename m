Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67B921736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865949;
	bh=5WmGrLw4Gjys7Y4cyfcoEcfMzrkyIJHFrA3ibV9q/Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqy3AaCGWaOa2/pFam/C0xtvxsYcTQbpwGw+gA+4LO/nKKcE3CY3KhzOmSnUy0Qmr
	 xvSRqLhsjUS2h7cRTfNxbvR8jkc7P21KHjm7SQhqqdqDs9VJZVf5oEeJOPlETpSCmD
	 RdYRW81Cs/cC0VzCnSRIa8Cdch5X/YCO5GTtClCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfAGM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbfAGM7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2E9206BB;
        Mon,  7 Jan 2019 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865945;
        bh=5WmGrLw4Gjys7Y4cyfcoEcfMzrkyIJHFrA3ibV9q/Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbR6+XergcDXC0pLAkD4PX7tt3IeKx+fk9Gsqa9z+Dy6r1fn1avuKBRSJkXPCf/JR
         OgdWpwBg/Zz3H9oJgHv8yuFBVKt4tElRyW2IS+i/J78XhfQ07VINnjdi1dUcJVGQnI
         19vvWsg7TijxAlmK52+Xr1Db7Ne5pFjnDsbEObRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 165/170] KVM: arm/arm64: vgic-v2: Set active_source to 0 when restoring state
Date:   Mon,  7 Jan 2019 13:33:12 +0100
Message-Id: <20190107104512.456281545@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <christoffer.dall@arm.com>

commit 60c3ab30d8c2ff3a52606df03f05af2aae07dc6b upstream.

When restoring the active state from userspace, we don't know which CPU
was the source for the active state, and this is not architecturally
exposed in any of the register state.

Set the active_source to 0 in this case.  In the future, we can expand
on this and exposse the information as additional information to
userspace for GICv2 if anyone cares.

Cc: stable@vger.kernel.org
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-mmio.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -317,11 +317,26 @@ static void vgic_mmio_change_active(stru
 		vgic_hw_irq_change_active(vcpu, irq, active, !requester_vcpu);
 	} else {
 		u32 model = vcpu->kvm->arch.vgic.vgic_model;
+		u8 active_source;
 
 		irq->active = active;
+
+		/*
+		 * The GICv2 architecture indicates that the source CPUID for
+		 * an SGI should be provided during an EOI which implies that
+		 * the active state is stored somewhere, but at the same time
+		 * this state is not architecturally exposed anywhere and we
+		 * have no way of knowing the right source.
+		 *
+		 * This may lead to a VCPU not being able to receive
+		 * additional instances of a particular SGI after migration
+		 * for a GICv2 VM on some GIC implementations.  Oh well.
+		 */
+		active_source = (requester_vcpu) ? requester_vcpu->vcpu_id : 0;
+
 		if (model == KVM_DEV_TYPE_ARM_VGIC_V2 &&
 		    active && vgic_irq_is_sgi(irq->intid))
-			irq->active_source = requester_vcpu->vcpu_id;
+			irq->active_source = active_source;
 	}
 
 	if (irq->active)


