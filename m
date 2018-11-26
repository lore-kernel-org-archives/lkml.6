Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0570C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98065214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojNLkEmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98065214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbeKZV6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B6420645;
        Mon, 26 Nov 2018 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230269;
        bh=Q5bVq2N1bnQTLl3Jksf1IUpthKxO+AGeEe1knuxBywU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojNLkEmEppfQn1xmwQOnNFrWFe1Qm0bpUVitMJLaqikVs9MG1hIUwTL0Sdk4AmuK0
         tpjOkl+0tGO8auypDyOBcPLgW7En3cbBY2b1mSU2QOQ6b39kDxDs3kAga0/Pw7+YTJ
         0hBQVRwBMIZxfT9UjytmDrOTko5+1kieghYE5lwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robert Richter <robert.richter@cavium.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/118] of/device: Really only set bus DMA mask when appropriate
Date:   Mon, 26 Nov 2018 11:51:04 +0100
Message-Id: <20181126105104.056298681@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6778be4e520959659b27a441c06a84c9cb009085 ]

of_dma_configure() was *supposed* to be following the same logic as
acpi_dma_configure() and only setting bus_dma_mask if some range was
specified by the firmware. However, it seems that subtlety got lost in
the process of fitting it into the differently-shaped control flow, and
as a result the force_dma==true case ends up always setting the bus mask
to the 32-bit default, which is not what anyone wants.

Make sure we only touch it if the DT actually said so.

Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Tested-by: John Stultz <john.stultz@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Robert Richter <robert.richter@cavium.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5957cd4fa262..40b9051a7fce 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,9 +149,11 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
-	dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
+	/* ...but only set bus mask if we found valid dma-ranges earlier */
+	if (!ret)
+		dev->bus_dma_mask = mask;
 
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
-- 
2.17.1



