Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18678C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3A120841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IUVd+Agp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3A120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbeHaSsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:48:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44524 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbeHaSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:48:41 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B48841AA2;
        Fri, 31 Aug 2018 16:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535726451;
        bh=2bSgBlD5BczKXo2QNEk9M3an9MenpcPj9DQhEYcxIfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUVd+AgpRGZWPPaqcOOeaKkM1eMGMFlWRP74LguOV8wNm3sm2UJkrUbBRz6B15WsR
         JJ3oPVglObKQTIjOevfW3hi1m/HQN7pMR7JkBMWJ6WKuaCDr+LYZUp3di/2FQKbHO8
         /BXkMs2LK6+nK0iLzRGqs873gkHoD9A5n8PQF6xQ=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 4/6] media: vsp1: Document max_width restriction on SRU
Date:   Fri, 31 Aug 2018 15:40:42 +0100
Message-Id: <20180831144044.31713-5-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRU is currently restricted to 256 pixels as part of the current
partition algorithm. Document that the actual capability of this
component is 288 pixels, but don't increase the implementation.

The extended partition algorithm may later choose to utilise a larger
input to support overlapping partitions.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_sru.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/vsp1/vsp1_sru.c
index f277700e5cc2..2a40e09b9aa7 100644
--- a/drivers/media/platform/vsp1/vsp1_sru.c
+++ b/drivers/media/platform/vsp1/vsp1_sru.c
@@ -314,6 +314,10 @@ static unsigned int sru_max_width(struct vsp1_entity *entity,
 	output = vsp1_entity_get_pad_format(&sru->entity, sru->entity.config,
 					    SRU_PAD_SOURCE);
 
+	/*
+	 * The maximum width of the SRU is 288 input pixels, but to support the
+	 * partition algorithm, this is currently kept at 256.
+	 */
 	if (input->width != output->width)
 		return 512;
 	else
-- 
2.17.1

