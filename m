Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4CAC1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019EF208C2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoWET/cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019EF208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935103AbeFLQw4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935055AbeFLQwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:52:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF229208BA;
        Tue, 12 Jun 2018 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822364;
        bh=avp+9hWZlz1nx00jnBhnWOQsnGhE/qh8DC/EkZ/pErQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoWET/cPvMz9Xvus6zxp/FQyASYw99kRsYhgYqP1naKlydf2Xv1t6NzGHWwbIQGjw
         uB6HyauPA9qYkE1+IaTQgDnm62p0Nvr1Ihr0qGBJgyRaguTnBSKg8uyYRYRojetZhK
         2umLKiJr2kNwLQev03Vc+8wGkxCmrr+nn60IHKEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 11/24] enic: set DMA mask to 47 bit
Date:   Tue, 12 Jun 2018 18:51:55 +0200
Message-Id: <20180612164817.129520725@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit 322eaa06d55ebc1402a4a8d140945cff536638b4 ]

In commit 624dbf55a359b ("driver/net: enic: Try DMA 64 first, then
failover to DMA") DMA mask was changed from 40 bits to 64 bits.
Hardware actually supports only 47 bits.

Fixes: 624dbf55a359b ("driver/net: enic: Try DMA 64 first, then failover to DMA")
Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2543,11 +2543,11 @@ static int enic_probe(struct pci_dev *pd
 	pci_set_master(pdev);
 
 	/* Query PCI controller on system for DMA addressing
-	 * limitation for the device.  Try 64-bit first, and
+	 * limitation for the device.  Try 47-bit first, and
 	 * fail to 32-bit.
 	 */
 
-	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(47));
 	if (err) {
 		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 		if (err) {
@@ -2561,10 +2561,10 @@ static int enic_probe(struct pci_dev *pd
 			goto err_out_release_regions;
 		}
 	} else {
-		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(47));
 		if (err) {
 			dev_err(dev, "Unable to obtain %u-bit DMA "
-				"for consistent allocations, aborting\n", 64);
+				"for consistent allocations, aborting\n", 47);
 			goto err_out_release_regions;
 		}
 		using_dac = 1;


