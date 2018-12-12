Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E90C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0E62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0E62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeLLUOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:14:15 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.229]:35201 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726248AbeLLUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:14:14 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id AE797674B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 14:11:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id XAr8gXC3IRPojXAr8gd2Of; Wed, 12 Dec 2018 14:11:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.70.203] (port=45282 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gXAqp-003BG9-PE; Wed, 12 Dec 2018 14:11:42 -0600
Date:   Wed, 12 Dec 2018 14:11:23 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] KVM: arm/arm64: vgic: fix off-by-one bug in vgic_get_irq()
Message-ID: <20181212201123.GA26674@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.70.203
X-Source-L: No
X-Exim-ID: 1gXAqp-003BG9-PE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.70.203]:45282
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the nospec API, it should be taken into account that:

"...if the CPU speculates past the bounds check then
 * array_index_nospec() will clamp the index within the range of [0,
 * size)."

The above is part of the header for macro array_index_nospec() in
linux/nospec.h

Now, in this particular case, if intid evaluates to exactly VGIC_MAX_SPI
or to exaclty VGIC_MAX_PRIVATE, the array_index_nospec() macro ends up
returning VGIC_MAX_SPI - 1 or VGIC_MAX_PRIVATE - 1 respectively, instead
of VGIC_MAX_SPI or VGIC_MAX_PRIVATE, which, based on the original logic:

	/* SGIs and PPIs */
	if (intid <= VGIC_MAX_PRIVATE)
 		return &vcpu->arch.vgic_cpu.private_irqs[intid];

 	/* SPIs */
	if (intid <= VGIC_MAX_SPI)
 		return &kvm->arch.vgic.spis[intid - VGIC_NR_PRIVATE_IRQS];

are valid values for intid.

Fix this by calling array_index_nospec() macro with VGIC_MAX_PRIVATE + 1
and VGIC_MAX_SPI + 1 as arguments for its parameter size.

Fixes: 41b87599c743 ("KVM: arm/arm64: vgic: fix possible spectre-v1 in vgic_get_irq()")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 virt/kvm/arm/vgic/vgic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 50e25438fb3c..5db40696055a 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -103,13 +103,13 @@ struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
 {
 	/* SGIs and PPIs */
 	if (intid <= VGIC_MAX_PRIVATE) {
-		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE);
+		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE + 1);
 		return &vcpu->arch.vgic_cpu.private_irqs[intid];
 	}
 
 	/* SPIs */
 	if (intid <= VGIC_MAX_SPI) {
-		intid = array_index_nospec(intid, VGIC_MAX_SPI);
+		intid = array_index_nospec(intid, VGIC_MAX_SPI + 1);
 		return &kvm->arch.vgic.spis[intid - VGIC_NR_PRIVATE_IRQS];
 	}
 
-- 
2.17.1

