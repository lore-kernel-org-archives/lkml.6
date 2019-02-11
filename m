Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E93B20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895731;
	bh=3SzWclKPZPnz2RWV8POlGw1gnVzi84FP4s+fVzn+f9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0/vurafL+TGFYo6YOTEbnH4AAzYq7q5JWC5lraGr8g87BVbNOhyhMpJ9Z9m2QuZ3q
	 tirTUttBcc79myWuD4/sw9ecHToAe0yzk1ovoUmtcnA9ol+a0HB8bdFKZJZR5TVVMT
	 9gGcHKCZvvNJ5GuCfsEV8aEtQ7n87Xmojr542Ol0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbfBKOf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbfBKOf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926902080F;
        Mon, 11 Feb 2019 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895726;
        bh=3SzWclKPZPnz2RWV8POlGw1gnVzi84FP4s+fVzn+f9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwHHWnM9nhJhtMEonOGCoIWtsiPLvtmBb2e9ILTnOau/dkoywdPOxwpD7HwJmPMG6
         GdnKaanfNMOEiqskqSKKDEjbtD/jKIpRVpapYUZxqf18t7DogNl6w+G42D17/1zQC8
         oK30ETZPtDdH4aEzO/DyEbfuBUsQHdN3TWFmwV5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Yonglong Liu <liuyonglong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 302/352] Revert "net: phy: marvell: avoid pause mode on SGMII-to-Copper for 88e151x"
Date:   Mon, 11 Feb 2019 15:18:49 +0100
Message-Id: <20190211141906.069774846@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit c14f07c6211cc01d52ed92cce1fade5071b8d197 ]

This reverts commit 6623c0fba10ef45b64ca213ad5dec926f37fa9a0.

The original diagnosis was incorrect: it appears that the NIC had
PHY polling mode enabled, which meant that it overwrote the PHYs
advertisement register during negotiation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -847,8 +847,6 @@ static int m88e1510_config_init(struct p
 
 	/* SGMII-to-Copper mode initialization */
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		u32 pause;
-
 		/* Select page 18 */
 		err = marvell_set_page(phydev, 18);
 		if (err < 0)
@@ -871,16 +869,6 @@ static int m88e1510_config_init(struct p
 		err = marvell_set_page(phydev, MII_MARVELL_COPPER_PAGE);
 		if (err < 0)
 			return err;
-
-		/* There appears to be a bug in the 88e1512 when used in
-		 * SGMII to copper mode, where the AN advertisement register
-		 * clears the pause bits each time a negotiation occurs.
-		 * This means we can never be truely sure what was advertised,
-		 * so disable Pause support.
-		 */
-		pause = SUPPORTED_Pause | SUPPORTED_Asym_Pause;
-		phydev->supported &= ~pause;
-		phydev->advertising &= ~pause;
 	}
 
 	return m88e1318_config_init(phydev);


