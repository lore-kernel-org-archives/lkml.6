Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6639127C48
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMPW7D5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6639127C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936784AbeF2SwQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:52:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41913 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933642AbeF2SwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:52:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so4875677ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aaqiWv1/qM0jeo9g5G5zoYmz4WxV8FEaeF/KEXgwrnM=;
        b=GMPW7D5Orlz5hOw7cItD8WFSlSjiRuz16vQr8C8tGuXaHftEqKCLK62/3oQVzTNiBX
         LMRuZqBVTTG4OfORdMgwRhCc0Skjc2/DkMAGB8nsNR3QleZinrxqM0JyvbP7PmLGheWM
         QQVnTratLAMxwCfMq/BAla3CWTBesiAZorYXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aaqiWv1/qM0jeo9g5G5zoYmz4WxV8FEaeF/KEXgwrnM=;
        b=BFjtG2fpl0Xv4YEDSNLj7Mp9F9iAHE4NKoGncWP7EzbvbauVrXOIG+piH6OtFGlLUr
         9IyfKU0Fn9OK/oTB0YQxB9NcPDBIA5xpGqiakGVS5n+57pMxkvI9uasTCUeXQZMah9ds
         UAPCZ1eeIdjsOCm1mECpOihIVE+zz3xbViM7aiZpzfdsZUpqFXpq9vrT3+26gSSkwr7t
         +7fpw78FCLcmn0ejychgLfIowqVfZdiKRBebg2VimBXsL8B+VTyOj+ipATkfQ3U8cQSe
         i4JiuMnsY2QTUEP/rn/xTz30LgXkS9LcDvEp8S5K7qz1AZi3cgcmARWX7+aqgMrIhG8Q
         gmMA==
X-Gm-Message-State: APt69E1yQ1onZJLcxa16DSdIrNpdl91IJz3/10YfWkyENkbyEGBeHPi3
        YHL/nIdsqVL4J4J1fjTC+lOZjg==
X-Google-Smtp-Source: ADUXVKLstvMIpXPul2FnflAqX9KGyqaRk9hJ1wCY2a60uof/V62V1LGGpj8kwuUcjOXGRpiQrccjcQ==
X-Received: by 2002:a17:902:46e:: with SMTP id 101-v6mr16310439ple.39.1530298334511;
        Fri, 29 Jun 2018 11:52:14 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g75-v6sm17617027pfg.145.2018.06.29.11.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:52:13 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:52:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bus: imx-weim: Remove VLA usage
Message-ID: <20180629185212.GA37517@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
switches to using a maximum size and adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/bus/imx-weim.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 3d56ebcda720..6a94aa6a22c2 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -45,6 +45,8 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
 	.cs_stride	= 0x18,
 };
 
+#define MAX_CS_REGS_COUNT	6
+
 static const struct of_device_id weim_id_table[] = {
 	/* i.MX1/21 */
 	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
@@ -112,9 +114,12 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
 static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype)
 {
-	u32 cs_idx, value[devtype->cs_regs_count];
+	u32 cs_idx, value[MAX_CS_REGS_COUNT];
 	int i, ret;
 
+	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
+		return -EINVAL;
+
 	/* get the CS index from this child node's "reg" property. */
 	ret = of_property_read_u32(np, "reg", &cs_idx);
 	if (ret)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
