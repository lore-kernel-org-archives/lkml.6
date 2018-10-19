Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A962D21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A962D21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeJSR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:27:21 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.36]:33398 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbeJSR1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:27:21 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 50141E6A8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 04:22:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id DQyTgnNwRtz4jDQygguYqN; Fri, 19 Oct 2018 04:22:05 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:50444 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gDQyR-000oCc-Ac; Fri, 19 Oct 2018 04:21:39 -0500
Date:   Fri, 19 Oct 2018 11:21:38 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3 2/2] phy: ocelot-serdes: fix out-of-bounds read
Message-ID: <5fd576c0aa6e5ae4a20bffc281dc1a3535afa90b.1539940387.git.gustavo@embeddedor.com>
References: <cover.1539940387.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539940387.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gDQyR-000oCc-Ac
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:50444
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
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
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Post the patch to netdev.

Changes in v2:
 - Rebase and add Quentin's Reviewed-by to commit log.

 drivers/phy/mscc/phy-ocelot-serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index b2be546..cbb49d9 100644
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
 	if (IS_ERR(ctrl->regs))
 		return PTR_ERR(ctrl->regs);
 
-	for (i = 0; i <= SERDES_MAX; i++) {
+	for (i = 0; i < SERDES_MAX; i++) {
 		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);
 		if (ret)
 			return ret;
-- 
2.7.4

