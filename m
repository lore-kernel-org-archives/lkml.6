Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6514EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF01217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867289;
	bh=10Dcalrs+Qt4Txyv0of0WKE8I0S+q9W7GelN7WZhdL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njCApp86Avr5/VBYxm20KWpImTs4tEX5W/tM8qiOqr3NYVX9sn9437uTwShG6dIg3
	 2FFXaS55b/e92iD6NhCmkRCPyDC/pg9oDZBGd4inNWO2vbDjlle7Gt/5O3iHCiNkPW
	 38DEa7FSLw5TeaJKnzhzFQv1imalpPsnsQWwBEpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfAGNV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbfAGMpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFAFE2183E;
        Mon,  7 Jan 2019 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865105;
        bh=10Dcalrs+Qt4Txyv0of0WKE8I0S+q9W7GelN7WZhdL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThiH/T6f/+eLNNZCei4ELtNPa++3L+DUj2cVncRUQqkCxQJ07kr4r2YU7SAp+n9iG
         yqoAluSWlsB9bFsfetgaumCPUInQLboK55JXytu0c2O/bzq4FE5BigF6yJTACA+1i2
         zob+IxGCgpomCS1byvFOlmm8ka6VJjw5HtEI7y/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.20 137/145] KVM: arm/arm64: vgic-v2: Set active_source to 0 when restoring state
Date:   Mon,  7 Jan 2019 13:32:54 +0100
Message-Id: <20190107104455.122701207@linuxfoundation.org>
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


