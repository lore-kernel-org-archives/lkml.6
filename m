Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC6EC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F1E21924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="su6N+hDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388023AbeLUQCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:02:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387900AbeLUQCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:02:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so5766498wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDOhg70hFYOwseCBHyxAEd0RE2ixDZurR5a6abXMMmM=;
        b=su6N+hDKVAiNS5Jd6Z/sNgQPv6iyvC3hN2KRF7OOWM2CwwEs91Vj9dgAps9xVxc/4w
         QbcwQ7hGyQeizNHXM84Hc8y1knKW/tcgNaE3ZKM57o8XG0h4+mzfwK4JPnMutPLm4nBr
         ufMJP7PhF/VGKbY/Qfz69pV5mzjdV/ppemgr8C9c0NOGdGg5/SpD6FcQT+iQkGBRNLq4
         6bb6I7xzvDHiY7xoSuuhHqes1Bg/KI1lhMijFkvilm9BcmyeMk76AKAOu6w+tQuryDZN
         HU59twCQWCJA7Y2mEcmEGXcNLCwkP3Y3CX2PNrEahxvyFGskfsM1ZSC6M9bymqdufCId
         K3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDOhg70hFYOwseCBHyxAEd0RE2ixDZurR5a6abXMMmM=;
        b=jpl+c//bU/wHdearG6t1+oXF8poLDmR7R1ro/CoGiL0bYCK+YxsN8SC8xFoXPA5AY+
         +yNt/nagNSXSyA7jhZBIKsE0OVRltl+GwzvCKHNSOyRIIZvEc3ycLZfZ2q/kfKspamXg
         L89bysqsCQLnaKp4vfx3vNiT+wiKRbLm9EXEbwr4lXzEamDRykApy2/+fZVRUgCumDF/
         pvyH/80x75mM7zE+loYQ/C/LkU0HNGBT4cG6rwrzb1lvxEAPrkk7pF9moQlbbtw3b8VO
         2YSFNaJFZMMckt4vbL4Tlu+vE/Ey7rrKshgtQVJIfx5SNx/jrl0zQ3D6Fh1sWvejWssc
         P/Dg==
X-Gm-Message-State: AA+aEWa3M5jwE9AkWrcxg7pWE4rGsB2LKK4F22PjML/fyvfGqgkAGrB0
        wrIN0+xluwcZ6sQsnuM7r1WE+Q==
X-Google-Smtp-Source: ALg8bN4chblCMfZezJ4NOJzu7yuQDWL120ghh9NaRoNpwN2pTUp9Mh15rexywcQDtXlMIvGEymFG6g==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr3487436wmb.93.1545408170446;
        Fri, 21 Dec 2018 08:02:50 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y138sm13044021wmc.16.2018.12.21.08.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:02:49 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] clk: meson: clean-up clock registration
Date:   Fri, 21 Dec 2018 17:02:36 +0100
Message-Id: <20181221160239.26265-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221160239.26265-1-jbrunet@baylibre.com>
References: <20181221160239.26265-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Order, ids and size  between the table of regmap clocks and the onecell
data table could be different.

Set regmap pointer in all the regmap clocks before starting the
registration using the onecell data, to make sure we don't
get into an incoherent situation.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson-aoclk.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index f965845917e3..258c8d259ea1 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -65,15 +65,20 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Populate regmap and register all clks
-	 */
-	for (clkid = 0; clkid < data->num_clks; clkid++) {
+	/* Populate regmap */
+	for (clkid = 0; clkid < data->num_clks; clkid++)
 		data->clks[clkid]->map = regmap;
 
+	/* Register all clks */
+	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
+		if (!data->hw_data->hws[clkid])
+			continue;
+
 		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
-		if (ret)
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
 			return ret;
+		}
 	}
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-- 
2.19.2

