Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D5D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfBSQvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:51:19 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43993 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfBSQvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:51:19 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9462E1C000F;
        Tue, 19 Feb 2019 16:51:16 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Date:   Tue, 19 Feb 2019 17:51:14 +0100
Message-Id: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nck() looks at the last id in an array and unfortunately,
at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
number of peripheral clocks is 1 instead of a maximum of 31.

Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/at91sam9x5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 2fe225a697df..d37e7ed9eb90 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -144,8 +144,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		return;
 
 	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
-					   nck(at91sam9x5_systemck),
-					   nck(at91sam9x35_periphck), 0);
+					   nck(at91sam9x5_systemck), 31, 0);
 	if (!at91sam9x5_pmc)
 		return;
 
-- 
2.20.1

