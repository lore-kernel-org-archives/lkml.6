Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD1ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AB32077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sogBu8UQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AB32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeGQWfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbeGQWfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:35:11 -0400
Received: from ziggy.de (144.pool85-56-49.dynamic.orange.es [85.56.49.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3C720836;
        Tue, 17 Jul 2018 22:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531864831;
        bh=f4As0+HF36fFkBMzpJ+NyGBUuaoRUlfFgLzsD+BkT6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sogBu8UQbVGITpuwsqHguWyK2LeVTvm7zF75q9WLBARCK5YCmnwIIUEkKSXPSxW12
         egYaBfOrGiCiennFulCLTYGQ/3276aXR4NdHAmUL7SkALr4/TkCapoF+9E7SvF/YYa
         FRSd49+fOa8HMyQ3tHFC6Hu7alZLSmsdToWJl4iA=
From:   matthias.bgg@kernel.org
To:     laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab@kernel.org, rdunlap@infradead.org,
        pi-cheng.chen@linaro.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4--to=ulrich.hecht+renesas@gmail.com 5/5] drm: mediatek: Omit warning on probe defers
Date:   Tue, 17 Jul 2018 23:59:51 +0200
Message-Id: <20180717215951.378-6-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717215951.378-1-matthias.bgg@kernel.org>
References: <20180717215951.378-1-matthias.bgg@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

It can happen that the clock drivers wasn't probed before the
ddp driver gets invoked. The driver used to omit a warning
that the driver failed to get the clocks. Omit this error on
the defered probe path.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index bafc5c77c4fb..6b399348a2dc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 
 	ddp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddp->clk)) {
-		dev_err(dev, "Failed to get clock\n");
+		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock\n");
 		return PTR_ERR(ddp->clk);
 	}
 
-- 
2.17.1

