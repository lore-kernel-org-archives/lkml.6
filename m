Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0BAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BA218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gB0ZszgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfAXUYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:39 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36599 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfAXUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:37 -0500
Received: by mail-pg1-f169.google.com with SMTP id n2so3165806pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B0f8amiCLjyli23I/W3zmD+C1Sb7tBAJSig2UQnjOwY=;
        b=gB0ZszgYj5x8jhbNMvIZcXlWOR1JWYlYbwLDXLU4cskG8A97BO+WzW5FZ7LelxxtIR
         /p9ppRHWPpPWeC7jJJchOrVJqwJeE5+0SNOZHKWFIhtk9f3n3LxW8P0LvcwdNZRXaKgo
         lzFu6Rf+aPTnZtMhPUudVyz8KKbzuabo5P2GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B0f8amiCLjyli23I/W3zmD+C1Sb7tBAJSig2UQnjOwY=;
        b=MFKSjqeKR8P3UcuK1fZGNkhUdvSV+BtvTJ33yc09qeug1NwxlpMPb9x3sEqYuc2p/y
         qsVBb6QWMP3y0PPgWnLVACrQCspdiEr6/KZMc4ouRpLlTJlN9u3Q7kyfhd1qlVbw7j1Z
         1MLau/AvDGeXo992gAkH0m2QJgL3e1F+9dT06Ij5ZzznqZ5gIVfgY8gEqfIw6XXYxrdG
         HINDHHPQiJXgal2wHGVoaMoFVJhZaDMqbI0H8l2CwjDD0fM4EaJUrfSxc0VywaGqFQRM
         Lb4h7FN5f7mT6fxpeZMCVs3PVol1KKjwFLjgszIirWQIyuxUTYHbR/Y26Da7IJS9JiHh
         Up2A==
X-Gm-Message-State: AJcUuke3k3jGcissAxZLADxvjx8Scjye6/b+mynAl26j1Qi6wQ4D6BLl
        tpTZcymz9+t2cI5pQdK2f14G058fY7OXTg==
X-Google-Smtp-Source: ALg8bN4Dwb3JzI5lW/2vt0Yp5oNUZHY8h6sdUI1wJTzstKxnpgqTE9glCXrxX130Sm4sTN55K9ANxw==
X-Received: by 2002:a62:de06:: with SMTP id h6mr8198941pfg.158.1548361476070;
        Thu, 24 Jan 2019 12:24:36 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:35 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>, dmaengine@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 5/8 v5] dma: k3dma: Add support for dma-channel-mask
Date:   Thu, 24 Jan 2019 12:24:20 -0800
Message-Id: <1548361463-28372-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Add dma-channel-mask as a property for k3dma, it defines
available dma channels which a non-secure mode driver can use.

One sample usage of this is in Hi3660 SoC. DMA channel 0 is
reserved to lpm3, which is a coprocessor for power management. So
as a result, any request in kernel (which runs on main processor
and in non-secure mode) should start from at least channel 1.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Guodong Xu <guodong.xu@linaro.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Li Yu <liyu65@hisilicon.com>
[jstultz: Reworked to use a channel mask]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Rename to hisi-dma-avail-chan
v4: Rename to dma-channel-mask
v5: Use BIT(i) instead of (1<<i)
---
 drivers/dma/k3dma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index e415c85..294ec64 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -111,6 +111,7 @@ struct k3_dma_dev {
 	struct dma_pool		*pool;
 	u32			dma_channels;
 	u32			dma_requests;
+	u32			dma_channel_mask;
 	unsigned int		irq;
 };
 
@@ -319,6 +320,9 @@ static void k3_dma_tasklet(unsigned long arg)
 	/* check new channel request in d->chan_pending */
 	spin_lock_irq(&d->lock);
 	for (pch = 0; pch < d->dma_channels; pch++) {
+		if (!(d->dma_channel_mask & (1<<pch)))
+			continue;
+
 		p = &d->phy[pch];
 
 		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
@@ -336,6 +340,9 @@ static void k3_dma_tasklet(unsigned long arg)
 	spin_unlock_irq(&d->lock);
 
 	for (pch = 0; pch < d->dma_channels; pch++) {
+		if (!(d->dma_channel_mask & (1<<pch)))
+			continue;
+
 		if (pch_alloc & (1 << pch)) {
 			p = &d->phy[pch];
 			c = p->vchan;
@@ -856,6 +863,13 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-channels", &d->dma_channels);
 		of_property_read_u32((&op->dev)->of_node,
 				"dma-requests", &d->dma_requests);
+		ret = of_property_read_u32((&op->dev)->of_node,
+				"dma-channel-mask", &d->dma_channel_mask);
+		if (ret) {
+			dev_warn(&op->dev,
+				 "dma-channel-mask doesn't exist, considering all as available.\n");
+			d->dma_channel_mask = (u32)~0UL;
+		}
 	}
 
 	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
@@ -887,8 +901,12 @@ static int k3_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	for (i = 0; i < d->dma_channels; i++) {
-		struct k3_dma_phy *p = &d->phy[i];
+		struct k3_dma_phy *p;
+
+		if (!(d->dma_channel_mask & BIT(i)))
+			continue;
 
+		p = &d->phy[i];
 		p->idx = i;
 		p->base = d->base + i * 0x40;
 	}
-- 
2.7.4

