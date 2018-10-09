Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD2C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B799D214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B799D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJJC5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:57:31 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.105]:40471 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbeJJC5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:57:30 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 29FD0301B6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 14:38:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9xq2gVsFLBcCX9xqEgojYe; Tue, 09 Oct 2018 14:38:58 -0500
X-Authority-Reason: nr=8
Received: from 57.154.24.109.rev.sfr.net ([109.24.154.57]:39204 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9xq0-001vWP-Dv; Tue, 09 Oct 2018 14:38:36 -0500
Date:   Tue, 9 Oct 2018 21:38:33 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next 1/2] net: phy: mscc: fix signedness bug in
 vsc85xx_downshift_get
Message-ID: <84a75d5e5f7717108feeda49b69b57ecbf361b9c.1539113472.git.gustavo@embeddedor.com>
References: <cover.1539113472.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539113472.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 109.24.154.57
X-Source-L: No
X-Exim-ID: 1g9xq0-001vWP-Dv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 57.154.24.109.rev.sfr.net (embeddedor) [109.24.154.57]:39204
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
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
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
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

