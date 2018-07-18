Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302FECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6F420856
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6F420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbeGRPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:12:56 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:8216 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730361AbeGRPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:12:56 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 18 Jul 2018 23:34:42 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 9BB6C790AC;
        Wed, 18 Jul 2018 23:34:42 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,370,1526310000"; 
   d="scan'208";a="285716424"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii1.idc.renesas.com with ESMTP; 18 Jul 2018 23:34:42 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Simon Horman <horms@verge.net.au>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] clk: renesas: r9a06g032: Avoid needless probe deferring
Date:   Wed, 18 Jul 2018 15:34:36 +0100
Message-Id: <1531924476-23261-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid all SoC peripheral drivers deferring their probes, both clock and
pinctrl drivers should already be probed. Since the pinctrl driver requires
a clock to access the registers, the clock driver should be probed before
the pinctrl driver.

Therefore, move the clock driver from subsys_initcall to core_initcall.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index a0b6ecd..b03d616 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -877,17 +877,18 @@ static const struct of_device_id r9a06g032_match[] = {
 	{ }
 };
 
-static struct platform_driver r9a06g032_clock_driver = {
+static struct platform_driver r9a06g032_clock_driver __refdata = {
 	.driver		= {
 		.name	= "renesas,r9a06g032-sysctrl",
 		.of_match_table = r9a06g032_match,
 	},
+	.probe = r9a06g032_clocks_probe,
 };
 
 static int __init r9a06g032_clocks_init(void)
 {
-	return platform_driver_probe(&r9a06g032_clock_driver,
-			r9a06g032_clocks_probe);
+	platform_driver_register(&r9a06g032_clock_driver);
+	return 0;
 }
 
-subsys_initcall(r9a06g032_clocks_init);
+core_initcall(r9a06g032_clocks_init);
-- 
2.7.4

