Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wAiLDc7yG1uAYAAAmS7hNA
	; Sat, 09 Jun 2018 15:33:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 738D4608C9; Sat,  9 Jun 2018 15:33:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbI4GitP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA947608B8;
	Sat,  9 Jun 2018 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA947608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeFIPdp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932726AbeFIPdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:42 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B8D208A3;
        Sat,  9 Jun 2018 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558421;
        bh=RV1H8ZuUTplTNxLkeZ5oUFWVG6tNP4t7PKyxRLsUOnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbI4GitPsfDH/C6aCIJIhptCgcOoD8/5C/MsjuMNN14Ok4VL/znUcyGYGsvx8b8vD
         NxBxf14SLkndrnwh6t2hy3t6mLgcD7lQWDtl+3JWx13rItn+WiYj6PduJMVFUhB+ha
         tY3tjLHbIbv0Wsbm5zBy8sbIj8FWML2nckTRGDSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 46/48] net: netsec: reduce DMA mask to 40 bits
Date: Sat,  9 Jun 2018 17:29:58 +0200
Message-Id: <20180609145950.902706617@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

[ Upstream commit 312564269535892cc082bc80592150cd1f5e8ec3 ]

The netsec network controller IP can drive 64 address bits for DMA, and
the DMA mask is set accordingly in the driver. However, the SynQuacer
SoC, which is the only silicon incorporating this IP at the moment,
integrates this IP in a manner that leaves address bits [63:40]
unconnected.

Up until now, this has not resulted in any problems, given that the DDR
controller doesn't decode those bits to begin with. However, recent
firmware updates for platforms incorporating this SoC allow the IOMMU
to be enabled, which does decode address bits [47:40], and allocates
top down from the IOVA space, producing DMA addresses that have bits
set that have been left unconnected.

Both the DT and ACPI (IORT) descriptions of the platform take this into
account, and only describe a DMA address space of 40 bits (using either
dma-ranges DT properties, or DMA address limits in IORT named component
nodes). However, even though our IOMMU and bus layers may take such
limitations into account by setting a narrower DMA mask when creating
the platform device, the netsec probe() entrypoint follows the common
practice of setting the DMA mask uncondionally, according to the
capabilities of the IP block itself rather than to its integration into
the chip.

It is currently unclear what the correct fix is here. We could hack around
it by only setting the DMA mask if it deviates from its default value of
DMA_BIT_MASK(32). However, this makes it impossible for the bus layer to
use DMA_BIT_MASK(32) as the bus limit, and so it appears that a more
comprehensive approach is required to take DMA limits imposed by the
SoC as a whole into account.

In the mean time, let's limit the DMA mask to 40 bits. Given that there
is currently only one SoC that incorporates this IP, this is a reasonable
approach that can be backported to -stable and buys us some time to come
up with a proper fix going forward.

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/socionext/netsec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1674,8 +1674,8 @@ static int netsec_probe(struct platform_
 	if (ret)
 		goto unreg_napi;
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
-		dev_warn(&pdev->dev, "Failed to enable 64-bit DMA\n");
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40)))
+		dev_warn(&pdev->dev, "Failed to set DMA mask\n");
 
 	ret = register_netdev(ndev);
 	if (ret) {
