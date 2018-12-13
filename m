Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E673C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF99F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675558;
	bh=obCAhtDZPNOAQLzCuHx1YxeLKtW4GZW0eSf2JlEqtU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dtmz8K4bamNVc3g259RwFoQHOhXPatAPYP8SMWm5sOx8fguOiklvtPMQNousGjbmY
	 Yot36MRiCCTjJUB+z3jWZgyZZHD+3fSLENFuEWZyogHsup2vezQRNQQzR2sMckBWm0
	 IlH5Eg9ZTAl0iHmeBa7YknyANMUn+nKEer/qkh68=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF99F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeLMEch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:32:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeLMEce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453AD20672;
        Thu, 13 Dec 2018 04:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675553;
        bh=obCAhtDZPNOAQLzCuHx1YxeLKtW4GZW0eSf2JlEqtU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5hgVWtlb4jMnzQ/8I1CGtPJNNiscbmBa5xPJDNe/keYUG7xMo4A9TrK/boDCLQf0
         /QPHDvvcJsTRPXe72LW/W1yKFXnWHNbyhMl0co4c82t62mT22V8UtmqqLFkyFXnKwi
         3pbI9MTJLAstUq3tJSA/HWZDQMxRfNmxEvCOD5Xg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 19/34] net: phy: don't allow __set_phy_supported to add unsupported modes
Date:   Wed, 12 Dec 2018 23:31:45 -0500
Message-Id: <20181213043200.76295-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit d2a36971ef595069b7a600d1144c2e0881a930a1 ]

Currently __set_phy_supported allows to add modes w/o checking whether
the PHY supports them. This is wrong, it should never add modes but
only remove modes we don't want to support.

The commit marked as fixed didn't do anything wrong, it just copied
existing functionality to the helper which is being fixed now.

Fixes: f3a6bd393c2c ("phylib: Add phy_set_max_speed helper")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy_device.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b131e555d3c2..f04be9e8980f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1579,20 +1579,17 @@ static int gen10g_resume(struct phy_device *phydev)
 
 static int __set_phy_supported(struct phy_device *phydev, u32 max_speed)
 {
-	phydev->supported &= ~(PHY_1000BT_FEATURES | PHY_100BT_FEATURES |
-			       PHY_10BT_FEATURES);
-
 	switch (max_speed) {
-	default:
-		return -ENOTSUPP;
-	case SPEED_1000:
-		phydev->supported |= PHY_1000BT_FEATURES;
+	case SPEED_10:
+		phydev->supported &= ~PHY_100BT_FEATURES;
 		/* fall through */
 	case SPEED_100:
-		phydev->supported |= PHY_100BT_FEATURES;
-		/* fall through */
-	case SPEED_10:
-		phydev->supported |= PHY_10BT_FEATURES;
+		phydev->supported &= ~PHY_1000BT_FEATURES;
+		break;
+	case SPEED_1000:
+		break;
+	default:
+		return -ENOTSUPP;
 	}
 
 	return 0;
-- 
2.19.1

