Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CE66C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11F2208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11F2208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934097AbeFLRYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:24:49 -0400
Received: from www.osadl.org ([62.245.132.105]:58259 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932976AbeFLRYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:24:47 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5CHNUqM021912;
        Tue, 12 Jun 2018 19:23:31 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] media: stm32-dcmi: simplify of_node_put usage
Date:   Tue, 12 Jun 2018 19:23:16 +0200
Message-Id: <1528824196-19149-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does not fix any bug - this is just a code simplification. As
np is not used after passing it to v4l2_fwnode_endpoint_parse() its
refcount can be decremented immediately and at one location.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Issue found during code reading.

Patch was compile tested with: x86_64_defconfig, MEDIA_SUPPORT=y
MEDIA_CAMERA_SUPPORT=y, V4L_PLATFORM_DRIVERS=y, OF=y, COMPILE_TEST=y
CONFIG_VIDEO_STM32_DCMI=y
(There are a few sparse warnings - but unrelated to the lines changed)

Patch is against 4.17.0 (localversion-next is next-20180608)

 drivers/media/platform/stm32/stm32-dcmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 2e1933d..0b61042 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1696,23 +1696,20 @@ static int dcmi_probe(struct platform_device *pdev)
 	}
 
 	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(np), &ep);
+	of_node_put(np);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not parse the endpoint\n");
-		of_node_put(np);
 		return -ENODEV;
 	}
 
 	if (ep.bus_type == V4L2_MBUS_CSI2) {
 		dev_err(&pdev->dev, "CSI bus not supported\n");
-		of_node_put(np);
 		return -ENODEV;
 	}
 	dcmi->bus.flags = ep.bus.parallel.flags;
 	dcmi->bus.bus_width = ep.bus.parallel.bus_width;
 	dcmi->bus.data_shift = ep.bus.parallel.data_shift;
 
-	of_node_put(np);
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(&pdev->dev, "Could not get irq\n");
-- 
2.1.4

