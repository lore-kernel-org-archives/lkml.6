Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2FDDBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB077208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAMm2vGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB077208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934651AbeFLRFZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934074AbeFLQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4348208B7;
        Tue, 12 Jun 2018 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822027;
        bh=UbBOfp6IRf7+bymItA6YGRZHbK4AsadistpEYPxHa0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NAMm2vGjHlqSeCROKAARfhBTX/iYClGAdr72BnvH9xPLmBrI+z1IxsNM5rIbnOAD2
         dmzMGJnTzmQTTz+TZghLbZfNKaY8YCsxFgvBvnBpAMQD3MRwC/+briZ9DSCIcNhpMv
         QB24MQEojTcc6aBiax9KK++8ZE7uIBY+dQOgV8rc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 10/31] enic: set DMA mask to 47 bit
Date:   Tue, 12 Jun 2018 18:46:13 +0200
Message-Id: <20180612164621.197259901@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2541,11 +2541,11 @@ static int enic_probe(struct pci_dev *pd
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
@@ -2559,10 +2559,10 @@ static int enic_probe(struct pci_dev *pd
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


