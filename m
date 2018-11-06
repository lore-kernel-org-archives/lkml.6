Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84360C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE0020862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 05:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+YCR0Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE0020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeKFOZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 09:25:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36181 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeKFOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 09:25:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id j22-v6so5539152pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 21:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sy/AQFQMaVt4C0zh+b0IOP8wDwMdYLhdTc2K4kZ/W/E=;
        b=S+YCR0NnfFkn0XSpoQbyn6N99EvfFcVtcsSNDeAqW3vUoxp81iTMd1XtpDF7USkANh
         fQM8DVG9Tye6T7w6cM1dn1glzsTnzrBFDQf+ScM5967tKT+c70ssVf0jjbR1WVrUvEUs
         CMboNPqZTUpwKgFrOPswpHOLTZL2fO2HKt2p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sy/AQFQMaVt4C0zh+b0IOP8wDwMdYLhdTc2K4kZ/W/E=;
        b=SArCUE3ThS5itLzAb36ySZjK9X2BoVz8ADkinUyDGK07vAYNvWkyjJwO7GWGMjjR9Y
         uiGOEwCyD1DIrCsKu6naowU3SFLY0/nI3sQEgL7Un4mcC6bvwJH8jK7NUavzVWWhxIkQ
         1Hl+THPnKufb9AJrociuiNIzuPkT4wsUrkiy2uWaufB1znlU9/tdpALQE6hFx19M6QU6
         aBfc56D4UNMkRC7xNC6XtIu9p1jRIvogwVLDvGRkQegX3X4r0d6hhKOsqgHXLRIWoVVa
         n7gAEIJ5gu7erGHb3FpoFUJtniBvQTvYzkfErq9H6LZwezJ8EXLEwCUCYFbud08/a2cY
         gDqw==
X-Gm-Message-State: AGRZ1gIE2CbtGV8q4KuAnxe/vz2gTTNHixZpVxDUgSp8pdTKO4HhhccZ
        sdoNJ1r7Lu8xWQlK6q5YxLP3SA==
X-Google-Smtp-Source: AJdET5cwk/YCksbb909uu3cC0k5TcdMMTZ2UgY9k6BaXQojLaPNo8OqbMpSlPi+QPNKUZWBHQRoFhQ==
X-Received: by 2002:a63:2e02:: with SMTP id u2mr2621110pgu.9.1541480525976;
        Mon, 05 Nov 2018 21:02:05 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o7-v6sm55735416pfb.23.2018.11.05.21.02.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 21:02:05 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org, eric.long@unisoc.com
Cc:     broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 2/7] dmaengine: sprd: Get transfer residue depending on the transfer direction
Date:   Tue,  6 Nov 2018 13:01:32 +0800
Message-Id: <2968b6dce6864608b97391e5b86ee3c47e3fb8e6.1541480353.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1541480353.git.baolin.wang@linaro.org>
References: <cover.1541480353.git.baolin.wang@linaro.org>
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

