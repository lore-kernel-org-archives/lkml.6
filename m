Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B394C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1002E2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866772;
	bh=pe4GpTP5sLXuJjlVIz5ZrazuBCmLykzGckE0cmqtLmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PaE4UrvupiVYfq9ZuUzvJOYoWJTZgJnVIr7KGxbcfdmGD6c9l954xzT9DT7Yb0Ieb
	 ij8VQ8l+wp0GO2aarfZH8rs0jYyD4xXQYqlVAdfFTcFOeAlGqesELhl0jrUvGRHyBm
	 VAYPaoQ5Qw3RuzRzzSNGU2JT4i0J7LSJsYCRt2Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfAGNEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731184AbfAGNEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D4F206BB;
        Mon,  7 Jan 2019 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866248;
        bh=pe4GpTP5sLXuJjlVIz5ZrazuBCmLykzGckE0cmqtLmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGEAqGVPcnlKx/HP5kZ+r+9tCyTIUTsxOguYEyJdRsLraCF4j4Jbwt/6pcLuomSKt
         BCeZzTs725CSFsVJ9draKjBIWg0BbQgRHvrKVqo+6703u/0cZLaj3PUjaJR1jGmqvS
         EiFx49z97p7wub4eNQ3QZ11HsJr/FdMLeuXIXIZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 097/101] arm/arm64: KVM: vgic: Force VM halt when changing the active state of GICv3 PPIs/SGIs
Date:   Mon,  7 Jan 2019 13:33:25 +0100
Message-Id: <20190107105338.080964363@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 107352a24900fb458152b92a4e72fbdc83fd5510 upstream.

We currently only halt the guest when a vCPU messes with the active
state of an SPI. This is perfectly fine for GICv2, but isn't enough
for GICv3, where all vCPUs can access the state of any other vCPU.

Let's broaden the condition to include any GICv3 interrupt that
has an active state (i.e. all but LPIs).

Cc: stable@vger.kernel.org
Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-mmio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -241,14 +241,16 @@ static void vgic_mmio_change_active(stru
  */
 static void vgic_change_active_prepare(struct kvm_vcpu *vcpu, u32 intid)
 {
-	if (intid > VGIC_NR_PRIVATE_IRQS)
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 ||
+	    intid > VGIC_NR_PRIVATE_IRQS)
 		kvm_arm_halt_guest(vcpu->kvm);
 }
 
 /* See vgic_change_active_prepare */
 static void vgic_change_active_finish(struct kvm_vcpu *vcpu, u32 intid)
 {
-	if (intid > VGIC_NR_PRIVATE_IRQS)
+	if (vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3 ||
+	    intid > VGIC_NR_PRIVATE_IRQS)
 		kvm_arm_resume_guest(vcpu->kvm);
 }
 


