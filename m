Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9602CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAA9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAA9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJQB3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:29:07 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.36]:47472 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727152AbeJQB3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:29:06 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B6F9A4BDC2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:37:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id CTHkgeUzLkBj6CTHkgj46j; Tue, 16 Oct 2018 12:37:36 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:46092 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCTHj-000wzM-RI; Tue, 16 Oct 2018 12:37:35 -0500
Date:   Tue, 16 Oct 2018 19:37:35 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next v3 2/2] net: phy: mscc: fix memory leak in
 vsc8574_config_pre_init
Message-ID: <b8c30607a81a8e5d872a3a82cbb37b97af8670d9.1539710647.git.gustavo@embeddedor.com>
References: <cover.1539710647.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539710647.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gCTHj-000wzM-RI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:46092
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for *fw* were successfully allocated,
release them before return.

Addresses-Coverity-ID: 1473968 ("Resource leak")
Fixes: 00d70d8e0e78 ("net: phy: mscc: add support for VSC8574 PHY")
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Add Quentin's Reviewed-by to the commit log.
 - Post patch to netdev.

Changes in v2:
 - Jump to out label so all functions in the driver exit with the PHY
   set to access the standard page. Thanks to Quentin Schulz for
   pointing this out.

 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index bff56c3..a2e59f4 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1292,7 +1292,7 @@ static int vsc8574_config_pre_init(struct phy_device *phydev)
 				dev_err(dev,
 					"%s: failed to assert reset of micro\n",
 					__func__);
-				return ret;
+				goto out;
 			}
 		}
 	} else {
-- 
2.7.4

