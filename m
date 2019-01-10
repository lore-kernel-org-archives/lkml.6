Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70061C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AAE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HL6eVqd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfAJRe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44116 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbfAJReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so5091371pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Acz25rUAnYOwtdV3EAKACd8ebfPIsH2pLWOoO+LfHkQ=;
        b=HL6eVqd3VAGtKA/ZqhGwc7urfTA9PFdcn3E/aLw3sh22SI6JuaZf+Uh1/+13tBxK9V
         cOpJ3YGxuk1q1H1+yU4KXo3S6zRVKketPHzEQHMzaXd8LyG1ZpaG2wgofDWOjiJ8+ipG
         Q8DSr1kPEWC26HS7YbYJUnNvAClIakTFeHkTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Acz25rUAnYOwtdV3EAKACd8ebfPIsH2pLWOoO+LfHkQ=;
        b=BfhZQRNk1uJIr2Ypf9k3hgeqhb9B91d1e2YZVEqZQBwYZa9B0TytlqLVOxrE6/zCgl
         Q/Uo6DbRp7OuoE6ZbVfID2rnWn+eZ+jf2vOG0mPWowJiMlDoLXbooq9L5B5baqGnCKGX
         j43gueLI7I9FAOXBGZcllOdFaomo0tzpTy2/uqKJaSdPrm2HVeLirMlHeImVueloZIC8
         LUnqmYfPkDg8wTw/Uszvo3sQ7zWZnlYLbbYGWbxUHFBm93nXggBGk9CmMdF5gMtz8M3n
         FJR1OwTVL0VdLJDj2mafBrXIzEjTcxvrbmo43TeWGmKfHjppSRaB1X3rCAwDRHw2ODbr
         P+dg==
X-Gm-Message-State: AJcUukdDlUYXuUNp/klAXItWSgv9DlTDamAeGkZmo61WMcXQTm/iaL6M
        jBOV6bzffV2mcOLM3CnW2GqllHLDQujt2w==
X-Google-Smtp-Source: ALg8bN5fReUPM9X00AxvG4rgs5k/K0xAWLkVnBzRFck8uyETLJK1JUIVJXlP/2orbsTSEM9dCxJDwA==
X-Received: by 2002:a63:a91a:: with SMTP id u26mr10042588pge.349.1547141663245;
        Thu, 10 Jan 2019 09:34:23 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:22 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>, dmaengine@vger.kernel.org,
        Li Yu <liyu65@hisilicon.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 5/8 v3] dma: k3dma: Add support for hisi-dma-avail-chan
Date:   Thu, 10 Jan 2019 09:34:09 -0800
Message-Id: <1547141652-8660-6-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yu <liyu65@hisilicon.com>

Add hisi-dma-avail-chan as a property for k3dma, it defines
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
---
 drivers/dma/k3dma.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index b2060bf..f4001ca 100644
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
+				"hisi-dma-avail-chan", &d->dma_avail_chan);
+		if (ret) {
+			dev_warn(&op->dev,
+				 "hisi-dma-avail-chan doesn't exist, considering all as available.\n");
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

