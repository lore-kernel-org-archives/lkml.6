Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FD2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359DE20843
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="edGM6VuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359DE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeHaSso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:48:44 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44534 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeHaSsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:48:42 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C9F81AA9;
        Fri, 31 Aug 2018 16:40:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535726451;
        bh=UGBLCimnQAziXokWCQkuQUoE0LzCXqg+DstUlEdNYz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edGM6VuSvXmysK88dpiID8+BpiLvy2paQ9rLjyZkN7MExtu9rUV31CQ6T9UAPfMlb
         PS4SAUYdaxpL9KlNMWfOEv50llLkh4Eh4pdeXnkDPT2BNC12ONkeqBlL4VEEY2Ul8u
         1MFQOUVLnWuCKHfilai4qKSi5XLCUtEQhf/4/UaY=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 5/6] media: vsp1: Document max_width restriction on UDS
Date:   Fri, 31 Aug 2018 15:40:43 +0100
Message-Id: <20180831144044.31713-6-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDS is currently restricted based on a partition size of 256 pixels.
Document the actual restrictions, but don't increase the implementation.

The extended partition algorithm may later choose to utilise a larger
partition size to support overlapping partitions.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_uds.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/vsp1/vsp1_uds.c
index c20c84b54936..7c11651db5d4 100644
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
+	 * To support the current parition algorithm, we clamp at units of 256.
+	 */
+
 	if (hscale <= 2)
 		return 256;
 	else if (hscale <= 4)
-- 
2.17.1

