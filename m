Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E22C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FBB20663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358748;
	bh=/EWCgWSjTn/Ss7NZaIIKPldGBBjbsncShtDYnEpS+yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqX56cG95Z09MsnzIp0q32Td2UVz3GxvCjN5m0a/LP1JzdsmyRq+qr65X0If5REnd
	 e7L+0BILXWNBg0rRDNsY28/eR5QiyvX6s9DpWS0k57j+4KAIEB5sykkdpEn47FHSzJ
	 i/MbYtSIci2Y+eqSKDaEvYHmGFbEr8Yv/9Dlbugg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfAXTjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732958AbfAXTjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:39:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BBD218D0;
        Thu, 24 Jan 2019 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358743;
        bh=/EWCgWSjTn/Ss7NZaIIKPldGBBjbsncShtDYnEpS+yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XG3FRLRI5r1oma9eDkNs7DX72kCoRmr4VXWBX5R+lkNy0Hb2ltCeBV5sjLko5/eXI
         ll2BJ3GfyjiwB1nPBlFDEqjY+V229eJJBAkjzAWkmYM10ggMyyY9isI1vtmLSCmRP/
         yjqP1P1Oo/jATYcuQOnHfXMMihIvT7GYOLeoofFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 011/127] octeontx2-af: Fix a resource leak in an error handling path in cgx_probe()
Date:   Thu, 24 Jan 2019 20:19:17 +0100
Message-Id: <20190124190212.611485311@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 1492623e837fe7ca6296f7f5411328307e242771 ]

If an error occurs after the call to 'pci_alloc_irq_vectors()', we must
call 'pci_free_irq_vectors()' in order to avoid a	resource leak.

The same sequence is already in place in the corresponding 'cgx_remove()'
function.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -668,7 +668,7 @@ static int cgx_probe(struct pci_dev *pde
 	if (!cgx->reg_base) {
 		dev_err(dev, "CGX: Cannot map CSR memory space, aborting\n");
 		err = -ENOMEM;
-		goto err_release_regions;
+		goto err_free_irq_vectors;
 	}
 
 	nvec = CGX_NVEC;
@@ -693,6 +693,8 @@ static int cgx_probe(struct pci_dev *pde
 err_release_lmac:
 	cgx_lmac_exit(cgx);
 	list_del(&cgx->cgx_list);
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
 err_release_regions:
 	pci_release_regions(pdev);
 err_disable_device:


