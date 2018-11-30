Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DBEC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6735720868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6735720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeLACm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:42:28 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57818 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbeLACm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:42:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA78D20CFA; Fri, 30 Nov 2018 16:32:43 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id BBC4C20CFB;
        Fri, 30 Nov 2018 16:32:26 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 4/4] clk: mvebu: armada-37xx-xtal: fill the device entry when registering the clock
Date:   Fri, 30 Nov 2018 16:32:14 +0100
Message-Id: <20181130153214.9058-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130153214.9058-1-miquel.raynal@bootlin.com>
References: <20181130153214.9058-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far the clk_hw_register_fixed_factor() call was not providing any
device structure. While doing so is harmless for regular use, the
missing device structure may be a problem for suspend to RAM support.

Since, device links have been added to clocks, links created during
probe will enforce the suspend/resume orders. When the device is
missing during the registration, no link can be established, hence the
order between parent and child clocks are not enforced.

Adding the device structure here will create a link between the XTAL
clock (this one) and the four TBG clocks that are derived from it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-xtal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
index e9e306d4e9af..0e74bcd83d1a 100644
--- a/drivers/clk/mvebu/armada-37xx-xtal.c
+++ b/drivers/clk/mvebu/armada-37xx-xtal.c
@@ -57,7 +57,8 @@ static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
 		rate = 25000000;
 
 	of_property_read_string_index(np, "clock-output-names", 0, &xtal_name);
-	xtal_hw = clk_hw_register_fixed_rate(NULL, xtal_name, NULL, 0, rate);
+	xtal_hw = clk_hw_register_fixed_rate(&pdev->dev, xtal_name, NULL, 0,
+					     rate);
 	if (IS_ERR(xtal_hw))
 		return PTR_ERR(xtal_hw);
 	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, xtal_hw);
-- 
2.19.1

