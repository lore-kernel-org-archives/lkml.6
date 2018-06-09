Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bjGSEkPzG1vfYwAAmS7hNA
	; Sat, 09 Jun 2018 15:34:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 640F2608C8; Sat,  9 Jun 2018 15:34:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ltx0AR5g"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CBAA1606FA;
	Sat,  9 Jun 2018 15:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBAA1606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbeFIPeb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932508AbeFIPeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:34:25 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD0C20856;
        Sat,  9 Jun 2018 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558465;
        bh=ZMjUgOMm3q91dnHqF3n53RymDq1RTUJlFYLvdJvdAZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ltx0AR5gGFsf410CHdzh2foYc63mf/hVkR74OColXNyIvKYYec4Sc0FqbhCqxSayY
         cQgzCz8ZnI+4qfNPToV5RY1r5vGMpr2jA8kNJDfWaXHO3dj2L4j+xE3NtMhWC23Izi
         hZgF2r4H/H0rMPVepDWYMGfUKV+9ob/AOx0CTab4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/41] enic: set DMA mask to 47 bit
Date: Sat,  9 Jun 2018 17:29:42 +0200
Message-Id: <20180609152927.003574309@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2703,11 +2703,11 @@ static int enic_probe(struct pci_dev *pd
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
@@ -2721,10 +2721,10 @@ static int enic_probe(struct pci_dev *pd
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
