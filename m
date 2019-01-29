Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C354020857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762195;
	bh=Iww4BYsRB2NAzdd4B0KXVbi0JLKuAhzlYQS4eF5RfDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bnaHINMdfvIXg/yxxZb9/ookn/AOJn/L9qlUolkLbCwT9on5eJ3jqCztQUiAtCngV
	 jDqcgPCCO5JU5HghiMuJp/Qsfxnj5JPoRmtSLLqFZTyjQm0gENFWpaf2SgV6uOHxho
	 S+u7WDCIzgf/ZQKt3UtWVCMH1cX4eb8j4fw6SFaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfA2LnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfA2LnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A4320857;
        Tue, 29 Jan 2019 11:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762191;
        bh=Iww4BYsRB2NAzdd4B0KXVbi0JLKuAhzlYQS4eF5RfDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9mf2LtdMpnY0Uf/bUrLKgZCFKjW1fmCvR7fNuadokATop+T3oyczQSAPnMeW78VX
         pLtZhheBQSY/ROwcQ6R0hFQnBxZ8cYtUsdlvl/3JzEIXHDLDsLCh/FwWF9enaoq02/
         hch7Uv9ofTJseR1FRIUp4GgIsOv5zsDIbgin7+q0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 004/103] net: phy: marvell: Errata for mv88e6390 internal PHYs
Date:   Tue, 29 Jan 2019 12:34:41 +0100
Message-Id: <20190129113159.808287257@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 8cbcdc1a51999ca81db2956608b917aacd28d837 ]

The VOD can be out of spec, unless some magic value is poked into an
undocumented register in an undocumented page.

Fixes: e4cf8a38fc0d ("net: phy: Marvell: Add mv88e6390 internal PHY")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c |   35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1063,6 +1063,39 @@ static int m88e1145_config_init(struct p
 	return 0;
 }
 
+/* The VOD can be out of specification on link up. Poke an
+ * undocumented register, in an undocumented page, with a magic value
+ * to fix this.
+ */
+static int m88e6390_errata(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_write(phydev, MII_BMCR,
+			BMCR_ANENABLE | BMCR_SPEED1000 | BMCR_FULLDPLX);
+	if (err)
+		return err;
+
+	usleep_range(300, 400);
+
+	err = phy_write_paged(phydev, 0xf8, 0x08, 0x36);
+	if (err)
+		return err;
+
+	return genphy_soft_reset(phydev);
+}
+
+static int m88e6390_config_aneg(struct phy_device *phydev)
+{
+	int err;
+
+	err = m88e6390_errata(phydev);
+	if (err)
+		return err;
+
+	return m88e1510_config_aneg(phydev);
+}
+
 /**
  * fiber_lpa_to_ethtool_lpa_t
  * @lpa: value of the MII_LPA register for fiber link
@@ -2313,7 +2346,7 @@ static struct phy_driver marvell_drivers
 		.flags = PHY_HAS_INTERRUPT,
 		.probe = m88e6390_probe,
 		.config_init = &marvell_config_init,
-		.config_aneg = &m88e1510_config_aneg,
+		.config_aneg = &m88e6390_config_aneg,
 		.read_status = &marvell_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
 		.config_intr = &marvell_config_intr,


