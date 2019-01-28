Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52B121736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wb+JVtYh";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="wb+JVtYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1GI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:08:56 -0500
Received: from node.akkea.ca ([192.155.83.177]:59460 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfA1GIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:08:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 72BFE4E204D;
        Mon, 28 Jan 2019 06:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655732; bh=aJyv2Anmq+fMmh2Gi9/xrGD4eRTLdWMOQTdSRYOpd8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wb+JVtYh3oZyNQa4t16L6fvOlK1dtxqZTyQKc8MZnCu4Kg4LWaWRuBYdasChj/oAa
         j9AG1IgC9MMv016EOWBL6LMJDp97cw4ukLlRNQRnmlQSa8U/BFbEHhaRz+qhORVl9l
         Pn3UNS6oRzKXArGRJaHsIB+Z9IzCbwNSU2WIkQMs=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h5e4iN8c030o; Mon, 28 Jan 2019 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 868DD4E204B;
        Mon, 28 Jan 2019 06:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548655732; bh=aJyv2Anmq+fMmh2Gi9/xrGD4eRTLdWMOQTdSRYOpd8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wb+JVtYh3oZyNQa4t16L6fvOlK1dtxqZTyQKc8MZnCu4Kg4LWaWRuBYdasChj/oAa
         j9AG1IgC9MMv016EOWBL6LMJDp97cw4ukLlRNQRnmlQSa8U/BFbEHhaRz+qhORVl9l
         Pn3UNS6oRzKXArGRJaHsIB+Z9IzCbwNSU2WIkQMs=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v5 5/5] dmaengine: imx-sdma: fix consistent dma test failures
Date:   Sun, 27 Jan 2019 23:08:40 -0700
Message-Id: <20190128060840.31695-6-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128060840.31695-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190128060840.31695-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without the copy being aligned sdma1 fails ~10% of the time

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d5f86becf59e..88910ec09568 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2118,6 +2118,7 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_dma_memcpy = sdma_prep_memcpy;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
 	sdma->dma_device.dev->dma_parms = &sdma->dma_parms;
+	sdma->dma_device.copy_align = 2;
 	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
 
 	platform_set_drvdata(pdev, sdma);
-- 
2.17.1

