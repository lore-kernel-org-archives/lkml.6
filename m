Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B8FC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C63A218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeLSPLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:11:53 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:49265 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729500AbeLSPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:11:53 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 95D171CB95
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:11:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZdVngXRAe90onZdVng5XoO; Wed, 19 Dec 2018 09:11:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=48540 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZdVm-000PVb-RZ; Wed, 19 Dec 2018 09:11:51 -0600
Date:   Wed, 19 Dec 2018 09:11:49 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [WRONG] KVM: arm/arm64: vgic: fix off-by-one bug in vgic_get_irq()
Message-ID: <20181219151149.GA6524@embeddedor>
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
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZdVm-000PVb-RZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:48540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

This is wrong: commit 6022fcc0e87a0eb5e9a72b15ed70dd29ebcb7343

The above is not my original patch and it should not be tagged for stable,
as it introduces the same kind of bug I intended to fix:

array_index_nospec() can now return kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS
and this is not what you want. So, in this case the following line of code
is just fine as it is:

intid = array_index_nospec(intid, kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS); 


As the commit log says, my patch fixes:

commit 41b87599c74300027f305d7b34368ec558978ff2

not both:

commit 41b87599c74300027f305d7b34368ec558978ff2

and 

commit bea2ef803ade3359026d5d357348842bca9edcf1

If you want to apply the fix on top of bea2ef803ade3359026d5d357348842bca9edcf1
then you should apply this instead:

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index bb1a83345741..e607547c7bb0 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -103,7 +103,7 @@ struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
 {
        /* SGIs and PPIs */
        if (intid <= VGIC_MAX_PRIVATE) {
-               intid = array_index_nospec(intid, VGIC_MAX_PRIVATE);
+               intid = array_index_nospec(intid, VGIC_MAX_PRIVATE + 1);
                return &vcpu->arch.vgic_cpu.private_irqs[intid];
        }
 

The commit log should remain the same.

Thanks
--
Gustavo
