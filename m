Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2FE20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2FE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbeGWNoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:44:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388242AbeGWNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:43:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 414AE40B;
        Mon, 23 Jul 2018 12:42:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 012/107] net: phy: fix flag masking in __set_phy_supported
Date:   Mon, 23 Jul 2018 14:41:06 +0200
Message-Id: <20180723122413.454617395@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit df8ed346d4a806a6eef2db5924285e839604b3f9 ]

Currently also the pause flags are removed from phydev->supported because
they're not included in PHY_DEFAULT_FEATURES. I don't think this is
intended, especially when considering that this function can be called
via phy_set_max_speed() anywhere in a driver. Change the masking to mask
out only the values we're going to change. In addition remove the
misleading comment, job of this small function is just to adjust the
supported and advertised speeds.

Fixes: f3a6bd393c2c ("phylib: Add phy_set_max_speed helper")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1265,11 +1265,8 @@ static int gen10g_resume(struct phy_devi
 
 static int __set_phy_supported(struct phy_device *phydev, u32 max_speed)
 {
-	/* The default values for phydev->supported are provided by the PHY
-	 * driver "features" member, we want to reset to sane defaults first
-	 * before supporting higher speeds.
-	 */
-	phydev->supported &= PHY_DEFAULT_FEATURES;
+	phydev->supported &= ~(PHY_1000BT_FEATURES | PHY_100BT_FEATURES |
+			       PHY_10BT_FEATURES);
 
 	switch (max_speed) {
 	default:


