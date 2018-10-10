Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C82C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861AF2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861AF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeJKBmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:42:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34156 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbeJKBmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:42:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9658C207B4; Wed, 10 Oct 2018 20:19:16 +0200 (CEST)
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 64AB7206A1;
        Wed, 10 Oct 2018 20:19:06 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v2] clk: mvebu: armada-37xx-tbg: Switch to clk_get and balance it in probe
Date:   Wed, 10 Oct 2018 20:18:38 +0200
Message-Id: <20181010181838.26923-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parent clock is get only to have its name, and then the clock is no
more used, so we can safely free it using clk_put. Furthermore as between
the successful devm_clk_get() and the devm_clk_put() call we don't exit
the probe function in error so I can use non managed version of clk_get()
and clk_put().

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
Changelog:
v1 -> v2

 - Use the non managed version of clk_get() and clk_put() (suggested
   by Stephen Boyd)
 - Modify the title and the commit log to reflect this change

drivers/clk/mvebu/armada-37xx-tbg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index 71f30149e80e..ee272d4d8c24 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -96,12 +96,13 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	hw_tbg_data->num = NUM_TBG;
 	platform_set_drvdata(pdev, hw_tbg_data);
 
-	parent = devm_clk_get(dev, NULL);
+	parent = clk_get(dev, NULL);
 	if (IS_ERR(parent)) {
 		dev_err(dev, "Could get the clock parent\n");
 		return -EINVAL;
 	}
 	parent_name = __clk_get_name(parent);
+	clk_put(parent);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, res);
-- 
2.19.1

