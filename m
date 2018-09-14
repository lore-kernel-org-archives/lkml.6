Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222CFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7B20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZXF/CEvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E7B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeINTln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:41:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36676 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeINTln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:41:43 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4E906B91;
        Fri, 14 Sep 2018 16:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536935216;
        bh=EmhaZQSNCJXPbO457Siv39Ut3dbpHKuL0RExoSK48sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXF/CEvTKzQtJ/wHgWzbgrlmo1AQJAHQpF0SFf/nf+81FHSBIa720pd99X5/VKuCG
         ciHyNGUC8VuKYFNZ3vYMyJTjR3KP3/5z37XTBvd2mVa4MyFq/SXYwnjFnFeM6A3xoX
         rFZScsUAATT1Q3djDp69OnH585vFQxmX/8UjgZLE=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v2 2/2] media: vsp1: Document max_width restriction on UDS
Date:   Fri, 14 Sep 2018 15:26:52 +0100
Message-Id: <20180914142652.30484-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDS is currently restricted based on a partition size of 256 pixels.
Document the actual restrictions, but don't increase the implementation.

The extended partition algorithm may later choose to utilise a larger
partition size to support overlapping partitions which will improve the
quality of the output images.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_uds.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index 75c613050151..e8340de85813 100644
--- a/drivers/media/platform/vsp1/vsp1_uds.c
+++ b/drivers/media/platform/vsp1/vsp1_uds.c
@@ -342,6 +342,14 @@ static unsigned int uds_max_width(struct vsp1_entity *entity,
 					    UDS_PAD_SOURCE);
 	hscale = output->width / input->width;
 
+	/*
+	 * The maximum width of the UDS is 304 pixels. These are input pixels
+	 * in the event of up-scaling, and output pixels in the event of
+	 * downscaling.
+	 *
+	 * To support overlapping parition windows we clamp at units of 256 and
+	 * the remaining pixels are reserved.
+	 */
 	if (hscale <= 2)
 		return 256;
 	else if (hscale <= 4)
-- 
2.17.1

