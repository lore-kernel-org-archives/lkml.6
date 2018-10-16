Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3490204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3490204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJQB05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:26:57 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.182]:47679 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbeJQB04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:26:56 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id CE96C313CB9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:35:26 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id CTFRg68aNaSeyCTFYgQw8E; Tue, 16 Oct 2018 12:35:26 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:46070 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gCTFQ-000vXD-Ru; Tue, 16 Oct 2018 12:35:12 -0500
Date:   Tue, 16 Oct 2018 19:35:11 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next v3 1/2] net: phy: mscc: fix signedness bug in
 vsc85xx_downshift_get
Message-ID: <454db44c56f4981a56c02f87de80f860e142545a.1539710647.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gCTFQ-000vXD-Ru
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:46070
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the error handling for the call to function
phy_read_paged() doesn't work because *reg_val* is of
type u16 (16 bits, unsigned), which makes it impossible
for it to hold a value less than 0.

Fix this by changing the type of variable *reg_val* to int.

Addresses-Coverity-ID: 1473970 ("Unsigned compared against 0")
Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page functions")
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v3:
 - Post patch to netdev.

Changes in v2:
 - Add Quentin's Reviewed-by to the commit log.

 drivers/net/phy/mscc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index bffe077..bff56c3 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -522,7 +522,7 @@ static int vsc85xx_mdix_set(struct phy_device *phydev, u8 mdix)
 
 static int vsc85xx_downshift_get(struct phy_device *phydev, u8 *count)
 {
-	u16 reg_val;
+	int reg_val;
 
 	reg_val = phy_read_paged(phydev, MSCC_PHY_PAGE_EXTENDED,
 				 MSCC_PHY_ACTIPHY_CNTL);
-- 
2.7.4

