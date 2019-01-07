Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A00C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F5D218A3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865109;
	bh=afIvtUEiXWVkaAXkV1IyZIHHwOSPtTGp3PK/kfaY9FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ekVfcLXTg2UqD7RiSI2ai5GNcxHAtBR3wTVgynJM6E0PRbByY2m67SNUCKdeQwaYn
	 /JvT78Ama1OUvaRmbo2NG8jm/gbeFeZDIUHPYnLsvalFeRFLDkRngh3HpSp7KEXKQ4
	 byHz5AlCBQ9TJWhdP4OShz7UCO8G7q83nfMTZVms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfAGMpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfAGMpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA10218A1;
        Mon,  7 Jan 2019 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865102;
        bh=afIvtUEiXWVkaAXkV1IyZIHHwOSPtTGp3PK/kfaY9FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+QkKkQNF3YlWliblz8FvdMAYzeul5mPHHHvC5LqgjRp5FXNK5/ct5vTqpB3qRoOV
         W3rCeIJwdHaE7lyduaVjm2cdNKMP0eFPxwyEJpYxiOeoM+Bm+BhBJWU5xk5qnYI3OH
         7+Z4vL9Q8f1F415l5WLIkYEdOLHX74Q4ryyEZrqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.20 136/145] KVM: arm/arm64: vgic: Cap SPIs to the VM-defined maximum
Date:   Mon,  7 Jan 2019 13:32:53 +0100
Message-Id: <20190107104455.007139255@linuxfoundation.org>
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
 


