Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AD9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175112148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pV91jwgt";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="pV91jwgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1GIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:08:54 -0500
Received: from node.akkea.ca ([192.155.83.177]:59442 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbfA1GIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:08:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id B66AB4E205C;
        Mon, 28 Jan 2019 06:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655731; bh=GuTD8SqdJjaQ7GeF6fQeKCli/Z+1RZuP7gejQxTXV+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pV91jwgtHsqCRiTdNPlGoy99iDL3FDdT9cmZwEDwneJpDg8AM7Tcm/+1wOwgIpBZO
         lCWj8dgoJtwf/noANTOw3fz+U8qlaC/mjdIR3+Sr9lu0QmwVmFYhFYNikBMDEmSvoq
         pwTAevKE0NF1k0KRljTEcW8Kw+3IwIdglyM6JVCM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gw33rgbD49UY; Mon, 28 Jan 2019 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id C663B4E204E;
        Mon, 28 Jan 2019 06:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655731; bh=GuTD8SqdJjaQ7GeF6fQeKCli/Z+1RZuP7gejQxTXV+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pV91jwgtHsqCRiTdNPlGoy99iDL3FDdT9cmZwEDwneJpDg8AM7Tcm/+1wOwgIpBZO
         lCWj8dgoJtwf/noANTOw3fz+U8qlaC/mjdIR3+Sr9lu0QmwVmFYhFYNikBMDEmSvoq
         pwTAevKE0NF1k0KRljTEcW8Kw+3IwIdglyM6JVCM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v5 4/5] dmaengine: imx-sdma: add a test for imx8mq multi sdma devices
Date:   Sun, 27 Jan 2019 23:08:39 -0700
Message-Id: <20190128060840.31695-5-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128060840.31695-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.mx8mq, there are two sdma instances, and the common dma framework
will get a channel dynamically from any available sdma instance whether
it's the first sdma device or the second sdma device. Some IPs like
SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
the correct sdma device, use the node pointer to match.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c                | 6 ++++++
 include/linux/platform_data/dma-imx.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index c4db4fe6bcc9..d5f86becf59e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1918,11 +1918,16 @@ static int sdma_init(struct sdma_engine *sdma)
 static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_engine *sdma = sdmac->sdma;
 	struct imx_dma_data *data = fn_param;
 
 	if (!imx_dma_is_general_purpose(chan))
 		return false;
 
+	/* return false if it's not the right device */
+	if (sdma->dev->of_node != data->of_node)
+		return false;
+
 	sdmac->data = *data;
 	chan->private = &sdmac->data;
 
@@ -1950,6 +1955,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
 	 * be set to sdmac->event_id1.
 	 */
 	data.dma_request2 = 0;
+	data.of_node = ofdma->of_node;
 
 	return dma_request_channel(mask, sdma_filter_fn, &data);
 }
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index 7d964e787299..9daea8d42a10 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -55,6 +55,7 @@ struct imx_dma_data {
 	int dma_request2; /* secondary DMA request line */
 	enum sdma_peripheral_type peripheral_type;
 	int priority;
+	struct device_node *of_node;
 };
 
 static inline int imx_dma_is_ipu(struct dma_chan *chan)
-- 
2.17.1

