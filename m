Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EF9C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B2F20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B2F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJIFgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:36:32 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:21503 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbeJIFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:36:32 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 23C811C374
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 17:22:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9dvBg0Asr8YaU9dvBgS4kb; Mon, 08 Oct 2018 17:22:38 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:53286 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9dvA-00276x-K6; Mon, 08 Oct 2018 17:22:36 -0500
Date:   Tue, 9 Oct 2018 00:22:33 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/2] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <30c1dcb4a8d3707238fcf0a996b9e0bf0a4a7bbc.1539036280.git.gustavo@embeddedor.com>
References: <cover.1539036280.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539036280.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g9dvA-00276x-K6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:53286
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
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

