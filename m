Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE1C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681962145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYLhixoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681962145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeKOIrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbeKOI1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:23 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B139722520;
        Wed, 14 Nov 2018 22:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234139;
        bh=5lI+K5NSyp7s4MwR6HKE1/hXONzq412IaY/HDK6pCYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYLhixoLdxYSt7IngROGVS4+Rf6WPdCNUSGCepuzAjfDPJllcrQKeOa7xktE7eBNY
         pvuJxTdNYyFpXH+XEsxfaSsk3garcm6CytAQorZs2z+WA7tUQAtAc3bTSdUbnwo+OU
         BgUnXBBqUGLK1A7B1UpJx9i8i0EUhEA8MJzOCZlM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 48/73] of/device: Really only set bus DMA mask when appropriate
Date:   Wed, 14 Nov 2018 17:21:42 -0500
Message-Id: <20181114222207.98701-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

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

