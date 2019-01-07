Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B860C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3B421736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867095;
	bh=O+9ExqC+ed/l6Th0jRsjtvryZ98xeRPS25VC/1l9aqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDeYm6wRVouMepyHdKTjVetxnhVktOOpgwHvMquhp2qBnkf69TrNhfPBxmnvD5MyJ
	 15gu2kCV5beFYpGwM/bVVvm46OVw0Ma6Gpm5VjnAoIilOYyQQgMiQU43qWEQtUXz+c
	 IgBKzfsKjLW7c1NUxdUEkUqW4gxDNvBuu3ojYjhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfAGM7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfAGM7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CADE206BB;
        Mon,  7 Jan 2019 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865941;
        bh=O+9ExqC+ed/l6Th0jRsjtvryZ98xeRPS25VC/1l9aqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTOm5MzR2mjQZJ3HTYbgoHJftIDzdjYYFHWc/ehSuMih82qTMyi5A8LGb8QxAnJde
         1UfVjEnPtPXXby4hQpsOIRtBlnkbrIOnVdaWxjOVkDxLbbXdLytUJ1oJTDf/jM5vJK
         Oju9gSq/mqE4myAhiLxQOvmQY1zcRbY606GifAKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.19 164/170] KVM: arm/arm64: vgic: Cap SPIs to the VM-defined maximum
Date:   Mon,  7 Jan 2019 13:33:11 +0100
Message-Id: <20190107104512.332781547@linuxfoundation.org>
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

From: Marc Zyngier <marc.zyngier@arm.com>

commit bea2ef803ade3359026d5d357348842bca9edcf1 upstream.

SPIs should be checked against the VMs specific configuration, and
not the architectural maximum.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -108,8 +108,8 @@ struct vgic_irq *vgic_get_irq(struct kvm
 	}
 
 	/* SPIs */
-	if (intid <= VGIC_MAX_SPI) {
-		intid = array_index_nospec(intid, VGIC_MAX_SPI);
+	if (intid < (kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS)) {
+		intid = array_index_nospec(intid, kvm->arch.vgic.nr_spis + VGIC_NR_PRIVATE_IRQS);
 		return &kvm->arch.vgic.spis[intid - VGIC_NR_PRIVATE_IRQS];
 	}
 


