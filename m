Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD7DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25BE206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DtSqydiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25BE206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeINTlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:41:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36668 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeINTlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:41:42 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C7A87CE;
        Fri, 14 Sep 2018 16:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536935216;
        bh=7MfsDesTjVez73NwLIuRR/scBqN5BqWU1jj1aRqEU1s=;
        h=From:To:Cc:Subject:Date:From;
        b=DtSqydizGTEE0a5ViZSj3ItuWqziSa/K8puCn0/G77hj5UvqHwo96fG7PvdMznQWg
         IG/gSPFurJ5vQlEFVa7lRgjaDAiJkmri7peMmcD74OKj/wsoCDrt0nrWh10cfnILRD
         h6LcLHsz9tmNPSq6jlgHy3QP4+151CO0RWcBCr4U=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v2 1/2] media: vsp1: Document max_width restriction on SRU
Date:   Fri, 14 Sep 2018 15:26:51 +0100
Message-Id: <20180914142652.30484-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRU is currently restricted to 256 pixels as part of the current
partition algorithm. Document that the actual capability of this
component is 288 pixels, but don't increase the implementation.

The extended partition algorithm may later choose to utilise a larger
input to support overlapping partitions which will improve the quality
of the output images.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_sru.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
index d216707f64c9..19f91eb81134 100644
--- a/drivers/media/platform/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/vsp1/vsp1_sru.c
@@ -314,6 +314,11 @@ static unsigned int sru_max_width(struct vsp1_entity *entity,
 	output = vsp1_entity_get_pad_format(&sru->entity, sru->entity.config,
 					    SRU_PAD_SOURCE);
 
+	/*
+	 * The maximum input width of the SRU is 288 input pixels, but 32
+	 * pixels are reserved to support overlapping partition windows when
+	 * scaling.
+	 */
 	if (input->width != output->width)
 		return 512;
 	else
-- 
2.17.1

