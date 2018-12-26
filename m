Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD58C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB6C218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhNIF4rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLZN5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:57:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36436 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbeLZN5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:57:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so7617657pgm.3;
        Wed, 26 Dec 2018 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0zjUBEQEh5snP3G1eRJuUVP/KHq6PY84nTcAiiZvhfc=;
        b=YhNIF4rpij54/O8M5W0qNvFn7nH97HGdMxzRo07LoKT8c30TD3+fEciFf8llTgMWmx
         Wh5Rg9GLgY9HIXzsg/SY0fCg/thwiNDygTT7iGnyGaGVA8DII/m86GKNds9swd5sWs57
         y8dkRzHNyCzyb8mk8ADSU8kAZ/H5+N6YTAfOniDWd6wgvOrH8M11AzydF7ceIpiUY2jq
         22uBmA7zRGlGXBxxrnr8a+DfOmcR5OGpzo1lC1a3o1aI8pl6SRDHyQeEW6D5XcUJUp2R
         A5TicuiER5LGLO/vV+LpIgexg1bRBK/Pi2lTz5TpiyC59BpFd2YarlFHsjlLldj7qjwR
         raRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0zjUBEQEh5snP3G1eRJuUVP/KHq6PY84nTcAiiZvhfc=;
        b=XxGewq8FhIDQcCBYa/aNNv9edsKaLfdRtp58RlzeR/VwvwKmMv2yhmQJBL6WtpIWBp
         /Z2bjx/ZdYp1wJE9kNSN82W35z+gHsfFdkNSoP94HVcmEO3Rji8RBY6B221jrC5chjZP
         2n9MRjS4vP1k4/xQUW5+IKq75BcCvl6uAmjEVVfWIgBJSfhIn9mAUxP4sDw9V76s+EQi
         uMTg5HGgRjISr4cOURgmu7sDXxiApGmPGEGXAfjwJ2UVeu5xLPKPeIBbG0JCr1kIUc+k
         xx3iXWPHxYW3VgcRbgllmPcKut/mCEmOrkCpMNQUhs5725ocsa1Ar1Loznf9VXhuRlQ6
         Q0NA==
X-Gm-Message-State: AA+aEWZTV5S7Owy4rKq5pqzmB/Mg7MQh53mbdlYC5JIlflAataLLW/rZ
        Dq14ng+Bhmf+RRJs/OnzAVE=
X-Google-Smtp-Source: AFSGD/VMrIwUJoniQwhGyyJ6pklzASXjYJASA3y0MVZ8UC1mAw56EYYI0dOQoBcU6ZlfNv+VvYwBHg==
X-Received: by 2002:a62:2606:: with SMTP id m6mr19836522pfm.133.1545832638761;
        Wed, 26 Dec 2018 05:57:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d13sm39293459pfd.58.2018.12.26.05.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:57:18 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: imx7d: fix refcount leak in imx7d_clocks_init()
Date:   Wed, 26 Dec 2018 08:57:16 -0500
Message-Id: <20181226135716.5972-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/imx/clk-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index adb08f64c691..12e2e85bbe1c 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -404,6 +404,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX7D_PLL_ARM_MAIN_SRC]  = imx_clk_mux("pll_arm_main_src", base + 0x60, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
 	clks[IMX7D_PLL_DRAM_MAIN_SRC] = imx_clk_mux("pll_dram_main_src", base + 0x70, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-- 
2.17.0

