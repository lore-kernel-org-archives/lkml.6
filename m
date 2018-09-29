Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC41C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B341C206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 05:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkhC3ycx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B341C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeI2MRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:17:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34331 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeI2MRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:17:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so5687662pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 22:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sy/AQFQMaVt4C0zh+b0IOP8wDwMdYLhdTc2K4kZ/W/E=;
        b=ZkhC3ycxpJc5Fbohpuuz/zGXQ4Lg5WaCwHn4bHPoSg9nAEJ4BLLLxDNL3mgbp45CDA
         hG43S+7ghflX3AsBUKVTsEb8rQlc0Ca8dAvxi0G6+arKBMtT/7gjUddGLZOygut7Z9Kc
         KTZvD8bUAlkWMdGPY06KOAbZ1npPXRk3ssn38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sy/AQFQMaVt4C0zh+b0IOP8wDwMdYLhdTc2K4kZ/W/E=;
        b=rhnMeXdpv0CK8qNMJ/nv/nB3k4RualhYyUyZyEjBWfRMAOlC1f+r/6ulVTQh7h505/
         YQ7UJ42megelIHZkG8/FgWNpg9GOOCgNCKJ2lG2vUyoD0PERimUo2XR9wEGpSxbKFbLb
         LpcctlKMqzEtCqZk6JrWcTGN6+YfYushzl1ALfTwjil7F7sajHTKP4kRHEblXNeP/c2T
         eLnyf3ME6vxk6p1W8yz27d9DsCBk6KPp/AY7u78GFyBpsxoAFClFDG+UXl1XBfFl2iq8
         N5q1DBwkdeQNMgryy9VDZlQTqKu6+pymw+w7dGCUh62qZchDKUpgN9CugQ82xrHgU+n5
         pbNQ==
X-Gm-Message-State: ABuFfohsPvLZobImsIc4T44/rWc04kb5UHm9lrLxZRI0vhvh5GhcgSLa
        wfRlqyO3QbSZIzkYmSYYIC0gCg==
X-Google-Smtp-Source: ACcGV61H2D7d5k5Fc0OMSlKEzKUBkYWrjRVkBZk07K+oMTolCSBlzqEtxXZFqnm9aUcmE00wgRgyHg==
X-Received: by 2002:a65:4103:: with SMTP id w3-v6mr1605709pgp.284.1538200205296;
        Fri, 28 Sep 2018 22:50:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i80-v6sm11118049pfi.87.2018.09.28.22.50.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 22:50:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org,
        eric.long@spreadtrum.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dmaengine: sprd: Get transfer residue depending on the transfer direction
Date:   Sat, 29 Sep 2018 13:49:00 +0800
Message-Id: <fabe5b03c8c3de84bc9fec10de8f20c2fd85441c.1538199697.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1538199697.git.baolin.wang@linaro.org>
References: <cover.1538199697.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Long <eric.long@spreadtrum.com>

Add one field to save the transfer direction for struct sprd_dma_desc,
which is used to get correct transfer residue depending on the transfer
direction.

[Baolin Wang adds one field to present the transfer direction]
Signed-off-by: Eric Long <eric.long@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index c226dc93..4f3587b 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -159,6 +159,7 @@ struct sprd_dma_chn_hw {
 struct sprd_dma_desc {
 	struct virt_dma_desc	vd;
 	struct sprd_dma_chn_hw	chn_hw;
+	enum dma_transfer_direction dir;
 };
 
 /* dma channel description */
@@ -331,6 +332,17 @@ static void sprd_dma_stop_and_disable(struct sprd_dma_chn *schan)
 	sprd_dma_disable_chn(schan);
 }
 
+static unsigned long sprd_dma_get_src_addr(struct sprd_dma_chn *schan)
+{
+	unsigned long addr, addr_high;
+
+	addr = readl(schan->chn_base + SPRD_DMA_CHN_SRC_ADDR);
+	addr_high = readl(schan->chn_base + SPRD_DMA_CHN_WARP_PTR) &
+		    SPRD_DMA_HIGH_ADDR_MASK;
+
+	return addr | (addr_high << SPRD_DMA_HIGH_ADDR_OFFSET);
+}
+
 static unsigned long sprd_dma_get_dst_addr(struct sprd_dma_chn *schan)
 {
 	unsigned long addr, addr_high;
@@ -534,7 +546,12 @@ static enum dma_status sprd_dma_tx_status(struct dma_chan *chan,
 		else
 			pos = 0;
 	} else if (schan->cur_desc && schan->cur_desc->vd.tx.cookie == cookie) {
-		pos = sprd_dma_get_dst_addr(schan);
+		struct sprd_dma_desc *sdesc = to_sprd_dma_desc(vd);
+
+		if (sdesc->dir == DMA_DEV_TO_MEM)
+			pos = sprd_dma_get_dst_addr(schan);
+		else
+			pos = sprd_dma_get_src_addr(schan);
 	} else {
 		pos = 0;
 	}
@@ -804,6 +821,8 @@ static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
 	if (!sdesc)
 		return NULL;
 
+	sdesc->dir = dir;
+
 	for_each_sg(sgl, sg, sglen, i) {
 		len = sg_dma_len(sg);
 
-- 
1.7.9.5

