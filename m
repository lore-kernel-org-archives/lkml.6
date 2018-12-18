Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB212C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CD721841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Dyp9G4/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeLRLdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:33:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46093 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLRLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:33:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so15489595wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 03:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tp2qTP6b0v5Vb54Ya9denLrSJ0P23sY7OEhQ5x0BuQw=;
        b=Dyp9G4/ekeYXIOjOjpiWgVd9vebimJb9fRIf1Xc3jcoJabiZtusXwthfSgo4oTLy+u
         X/LwvbVkkRx7XUDOUKqkbUANBdGpW00sWSJNIbT51PuJrYH/FHbgWIffTh815hutWXnt
         dtdOmBUs/595yPrQbizgIqEF5OeH7PeoYHPDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tp2qTP6b0v5Vb54Ya9denLrSJ0P23sY7OEhQ5x0BuQw=;
        b=kciMslYeB/X5hrc9NYW48n4262NdrSPbx9q0h4VuYKHFOTKkhuRx0WLX8cY+Kjk0u4
         yI2fpjr/ESHxq1XOQIjZvDM7HZQtyK+YAmM4tNGP/bEVidpS0gTXEr+1KKH4N3Jq/xkQ
         IOXFz37l5nDn9OgjE9dhvgduoWQumk0FNTtjbq5ln63gKr1bOLOGbBrPphlhg5M6MuFW
         m/4dQH92G1Gbo1YVIN3/47pk9NCdH42uWD/7Db3yNHE9blyndZ67sstBMqF6ZUr4Y6lS
         WMgi9Ee6SC8VK4AfR0g0MdZaMc+WogWm7hBa9xQsKraUeQewIZgl1DrTHX/tE+tfe+ik
         xsRg==
X-Gm-Message-State: AA+aEWakj2b3E3d02c3auPS6+ot9LDzG3ofwf19/2+sQaNgDPK7RgtU3
        SkTdW1olPaeFrLrc5UgXLTyabg==
X-Google-Smtp-Source: AFSGD/UBnj2Lpi4jkn0o6yWcZcSfQE5ucR9VFQkE9SDOdqSMiaik7KRdoJ3yAEltcutn/NWo0vNsTw==
X-Received: by 2002:adf:e149:: with SMTP id f9mr15577466wri.42.1545132812924;
        Tue, 18 Dec 2018 03:33:32 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host230-181-static.228-95-b.business.telecomitalia.it. [95.228.181.230])
        by smtp.gmail.com with ESMTPSA id h2sm4276184wrv.87.2018.12.18.03.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 03:33:32 -0800 (PST)
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
Subject: [PATCH v4 2/6] media: sun6i: Add A64 compatible support
Date:   Tue, 18 Dec 2018 17:03:16 +0530
Message-Id: <20181218113320.4856-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner A64 CSI.

A64 CSI has similar features as like in H3, but the CSI_SCLK
need to update it to 300MHz than default clock rate.

A64 BSP is also operating same rate as default csi clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index ee882b66a5ea..9ff61896e4bb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -895,6 +895,7 @@ static const struct of_device_id sun6i_csi_of_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-csi", },
 	{ .compatible = "allwinner,sun8i-h3-csi", },
 	{ .compatible = "allwinner,sun8i-v3s-csi", },
+	{ .compatible = "allwinner,sun50i-a64-csi", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sun6i_csi_of_match);
-- 
2.18.0.321.gffc6fa0e3

