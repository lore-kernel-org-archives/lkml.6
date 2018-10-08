Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D470C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670A52085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670A52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJIBUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:20:14 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.234]:18970 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbeJIBUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:20:14 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C90A2B79A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 13:07:18 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9Zvfg5k57BcCX9ZvugOtty; Mon, 08 Oct 2018 13:07:18 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:47794 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9Zvf-003zBm-5P; Mon, 08 Oct 2018 13:06:51 -0500
Date:   Mon, 8 Oct 2018 20:06:49 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <20181008180649.GA9152@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g9Zvf-003zBm-5P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:47794
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is an out-of-bounds read on array ctrl->phys,
once variable i reaches the maximum array size of SERDES_MAX
in the for loop.

Fix this by changing the condition in the for loop from
i <= SERDES_MAX to i < SERDES_MAX.

Addresses-Coverity-ID: 1473966 ("Out-of-bounds read")
Addresses-Coverity-ID: 1473959 ("Out-of-bounds read")
Fixes: 51f6b410fc22 ("phy: add driver for Microsemi Ocelot SerDes muxing")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/phy/mscc/phy-ocelot-serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index 8936abd..c4eee3a 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -206,7 +206,7 @@ static struct phy *serdes_simple_xlate(struct device *dev,
 	port = args->args[0];
 	idx = args->args[1];
 
-	for (i = 0; i <= SERDES_MAX; i++) {
+	for (i = 0; i < SERDES_MAX; i++) {
 		struct serdes_macro *macro = phy_get_drvdata(ctrl->phys[i]);
 
 		if (idx != macro->idx)
@@ -260,7 +260,7 @@ static int serdes_probe(struct platform_device *pdev)
 	if (!ctrl->regs)
 		return -ENODEV;
 
-	for (i = 0; i <= SERDES_MAX; i++) {
+	for (i = 0; i < SERDES_MAX; i++) {
 		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);
 		if (ret)
 			return ret;
-- 
2.7.4

