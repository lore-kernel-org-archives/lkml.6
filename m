Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE29C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2763C218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrTCH0zz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfADU5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:57:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41053 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfADU4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so17962210pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Vbeu6DpRnZCwP7K+9a0P9RRTER2t/Z433kGqekFBrY=;
        b=HrTCH0zz+n6La7vqDvNKqVoi9EadZuIp9wKa9nVjaa+GZpAvVbNfqnKkXY2If1wD55
         1JCUORAappLk7F/4W8yjdSB/nH7jiKjS2ewP51awR+I/LP5XTl8MveF/puXTPOWOjt9A
         7yTjkkGp35GsgZKkNL78hh3FRXWa/08398Bgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Vbeu6DpRnZCwP7K+9a0P9RRTER2t/Z433kGqekFBrY=;
        b=ofuzzs+0/+rJuL8TK75U95oOUWuUEsCVjqVehJkoffhRXdw2aoYdCA7Y9kdQeVOLM/
         bI9dcx8mO3SkiazDv4yRu5RSRrezGc/nSEci3Ns6PB1489im2Yt7T1+WpI60/QvLQK4K
         q/xjS8qP5NdZ3nl0FqPxSBoakUz/mF3tCpYm+dqwtDsGyXKgry9UMs4KMAfX6GXrMaoh
         VIoF6oPeM6uu7siH6eScDwFIKP0WTawR3bhPFfiJQTdOPykUqOANuwXQVyDY7dzuX8f3
         CGHu/EMaust+KQfGykYffGeBqldAJgtjbvE0OqWwmrZRResP0+ozK7yay3JTHPx/c1me
         Hjaw==
X-Gm-Message-State: AJcUukdYHRBhcmf8yQVmnsdACed032m+YlQlBDrnAAXrD5KjGCqwWa7E
        i9apCHYTRx6t4o+MYPx7Z5Ua4/dVW1CkWw==
X-Google-Smtp-Source: ALg8bN7jekfTkokUDuAB0tR3PpbgapZjIX70zUYb4Eon0+Mzrw5OPpJfkJmPRNyXXAePaGZwsq6ReQ==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr2835866pgi.8.1546635400454;
        Fri, 04 Jan 2019 12:56:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:39 -0800 (PST)
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
Subject: [PATCH 5/8 v2] dma: k3dma: Add support to dma_avail_chan
Date:   Fri,  4 Jan 2019 12:56:25 -0800
Message-Id: <1546635388-13795-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

dma_avail_chan as a property for k3dma, it defines available dma
channels which a non-secure mode driver can use.

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
 drivers/dma/k3dma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index b2060bf..431094b 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -111,6 +111,7 @@ struct k3_dma_dev {
 	struct dma_pool		*pool;
 	u32			dma_channels;
 	u32			dma_requests;
+	u32			dma_avail_chan;
 	unsigned int		irq;
 };
 
@@ -318,6 +319,9 @@ static void k3_dma_tasklet(unsigned long arg)
 	/* check new channel request in d->chan_pending */
 	spin_lock_irq(&d->lock);
 	for (pch = 0; pch < d->dma_channels; pch++) {
+		if (!(d->dma_avail_chan & (1<<pch)))
+			continue;
+
 		p = &d->phy[pch];
 
 		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
@@ -335,6 +339,9 @@ static void k3_dma_tasklet(unsigned long arg)
 	spin_unlock_irq(&d->lock);
 
 	for (pch = 0; pch < d->dma_channels; pch++) {
+		if (!(d->dma_avail_chan & (1<<pch)))
+			continue;
+
 		if (pch_alloc & (1 << pch)) {
 			p = &d->phy[pch];
 			c = p->vchan;
@@ -855,6 +862,13 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-channels", &d->dma_channels);
 		of_property_read_u32((&op->dev)->of_node,
 				"dma-requests", &d->dma_requests);
+		ret = of_property_read_u32((&op->dev)->of_node,
+				"dma-avail-chan", &d->dma_avail_chan);
+		if (ret) {
+			dev_warn(&op->dev,
+				 "dma-avail-chan doesn't exist, considering all as available.\n");
+			d->dma_avail_chan = (u32)~0UL;
+		}
 	}
 
 	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
@@ -886,8 +900,12 @@ static int k3_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	for (i = 0; i < d->dma_channels; i++) {
-		struct k3_dma_phy *p = &d->phy[i];
+		struct k3_dma_phy *p;
+
+		if (!(d->dma_avail_chan & (1<<i)))
+			continue;
 
+		p = &d->phy[i];
 		p->idx = i;
 		p->base = d->base + i * 0x40;
 	}
-- 
2.7.4

