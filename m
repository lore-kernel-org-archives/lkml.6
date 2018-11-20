Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB07C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9574206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9574206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeKUARy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:17:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbeKUARy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:17:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FACDAFE5;
        Tue, 20 Nov 2018 13:48:38 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, linux-riscv@lists.infradead.org
Subject: [PATCH] net: phy: mscc: fix locking in vsc85xx_default_config
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
        <20181008100728.24959-2-quentin.schulz@bootlin.com>
        <mvm8t1pazea.fsf@suse.de>
X-Yow:  Did you GAIN WEIGHT in th' past 5 MINUTES or am I just DREAMING of two
 BROCCOLI FLORETS lying in an empty GAS TANK?
Date:   Tue, 20 Nov 2018 14:48:37 +0100
In-Reply-To: <mvm8t1pazea.fsf@suse.de> (Andreas Schwab's message of "Mon, 19
        Nov 2018 15:57:17 +0100")
Message-ID: <mvma7m3n9l6.fsf_-_@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use locking phy_read/phy_write functions while inside
phy_select_patch/phy_restore_page region.

Fixes: 6a0bfbbe20 ("net: phy: mscc: migrate to phy_select/restore_page functions")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 drivers/net/phy/mscc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index a2e59f4f6f..a398ab9410 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -814,10 +814,10 @@ static int vsc85xx_default_config(struct phy_device *phydev)
 	if (rc < 0)
 		goto out_unlock;
 
-	reg_val = phy_read(phydev, MSCC_PHY_RGMII_CNTL);
+	reg_val = __phy_read(phydev, MSCC_PHY_RGMII_CNTL);
 	reg_val &= ~(RGMII_RX_CLK_DELAY_MASK);
 	reg_val |= (RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS);
-	phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
+	__phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
 
 out_unlock:
 	rc = phy_restore_page(phydev, rc, rc > 0 ? 0 : rc);
-- 
2.19.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
