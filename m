Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C6AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B05821736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865953;
	bh=6i+p/ggQR+S3Jx5EkMVK0shEZkUdHfX5bVBNv/VJ88I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q27NGjyLuR/BtYS+5dvUinI1xKHeIFWjrkKnB0VenJwO1JghM4/6zt4PPP5I+hY+z
	 CDekLQBiQnRwkfR40CjsVHhC7wcaTEb/GVGrEGIA/beAJ6wZF9/Hv8EMlsD/Gt/93+
	 7Z72b6y7RlpPW/O9H6Yq2DOhim+ummPYrZanXGB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfAGM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbfAGM7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9381E206BB;
        Mon,  7 Jan 2019 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865948;
        bh=6i+p/ggQR+S3Jx5EkMVK0shEZkUdHfX5bVBNv/VJ88I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kln4LSgFX2wOUdwp9rn05rgcnvkTvdNnGJc31OZ7Nxo12lQsK4Lw1Yg4h6up5JdRV
         b7OOtIbmGQzIqSoZ3S/8+7dMhxVk9ms1rSNIGZ4teqA5Vwjc1OlChu93k+HOqYC4vv
         dlpDk8XXrmLVs96J8DMg0ytqmZ5vmyxGt2OPlsmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 166/170] KVM: arm/arm64: vgic: Fix off-by-one bug in vgic_get_irq()
Date:   Mon,  7 Jan 2019 13:33:13 +0100
Message-Id: <20190107104512.582721066@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit c23b2e6fc4ca346018618266bcabd335c0a8a49e upstream.

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
[dropped the SPI part which was fixed separately]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -103,7 +103,7 @@ struct vgic_irq *vgic_get_irq(struct kvm
 {
 	/* SGIs and PPIs */
 	if (intid <= VGIC_MAX_PRIVATE) {
-		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE);
+		intid = array_index_nospec(intid, VGIC_MAX_PRIVATE + 1);
 		return &vcpu->arch.vgic_cpu.private_irqs[intid];
 	}
 


