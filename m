Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64C9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA5A21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m/xol0We"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLRLdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:33:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39085 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeLRLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:33:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so2406031wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6G+51hXPmeJR9ykNhp8vQ9iLEEAvCO5U6f8uZ2c4pz0=;
        b=m/xol0WelzUvjOb1T7gtvzM4mgci6M70ZC8FZEHkbXqT8lEvWkJHMDQ9GOpcb19fLE
         pHJ0uhmcSgSRUac7uioa0q3x2H1FlaNGLGxjFPBlDveAupR+YQkGrckjLrEPfPPy2QPP
         xUpoBfmp8Zefpkr5jcXvQ2OD1/fv0s7LMGvZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6G+51hXPmeJR9ykNhp8vQ9iLEEAvCO5U6f8uZ2c4pz0=;
        b=hnUSaRegCTJ4t1TxfYhfV5G7VO2grHaK0V5PwZIpGzGBIxOuwugHGdpFEfRNirGqyJ
         +ia6I13RSjUHLMFjpObDtP4yqv4Rw8MLvyHVcNRsgN0U4447p1+Mv85gVQcxzzH/C3Ty
         WtXI9ElXqVLhEvr1zdq56Bhlgc2c/EfI1mwWQ4vyZkqGRKZensKCppI2IH4UHZXegkTo
         iKONIQT+GOMl1F+7LXRPjRwV0I9uBnI74vPbpHyARm6xtEQyYd2DYr9KXyhGAHgcRaxQ
         hzfdnqk3ZI06s/Vx3Rp+xJXEa+ZtAonDohnxzk8WQr5LWhgEbFiacVtyUbgUKirjhMSD
         MYJg==
X-Gm-Message-State: AA+aEWaVEDtaMQfArVtrgnsg7bqCY/IZWkylqRA1VSBM5bG11PEeOYpW
        lxxWYT0zM5C8YoqMTVctcDp9yA==
X-Google-Smtp-Source: AFSGD/VOWlFuoZVOKeDauoI8dplqjyg7Myu1NWvkW4rp7yL8UmE9dMhqeOQS6ejn/ZLTwjoTsx/0wg==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr3000248wms.70.1545132815033;
        Tue, 18 Dec 2018 03:33:35 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
        by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:33:34 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
Date:   Tue, 18 Dec 2018 17:03:17 +0530
Message-Id: <20181218113320.4856-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately A64 CSI cannot work with default CSI_SCLK rate.

A64 BSP is using 300MHz clock rate as default csi clock,
so sun6i_csi require explicit change to update CSI_SCLK
rate to 300MHZ for A64 SoC's.

So, set the clk_mod to 300MHz only for A64.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 9ff61896e4bb..91470edf7581 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 		return PTR_ERR(sdev->clk_mod);
 	}
 
+	/* A64 require 300MHz mod clock to operate properly */
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun50i-a64-csi"))
+		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
+
 	sdev->clk_ram = devm_clk_get(&pdev->dev, "ram");
 	if (IS_ERR(sdev->clk_ram)) {
 		dev_err(&pdev->dev, "Unable to acquire dram-csi clock\n");
-- 
2.18.0.321.gffc6fa0e3

