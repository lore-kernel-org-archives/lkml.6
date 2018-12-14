Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F90C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114B820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790862;
	bh=wKHoiP8BdQjGccr8WSX0D277E50G4KTCVqpfMqqK/90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hixi4h+PknHTvP0NNSw5CxbVFCv9xPmWu0ZBq7G+LOgnLRI+dyD2P6Jig8aBAxCcB
	 AnMYJN2uCxH1Jz6C7ysmkZPQvHy1EiWMJgMRKLajKmFLnw9EmNO3ciTPgXc3d4SoEg
	 kYfSdzw0dJGUCd5Unh5cZn9PH/s+IPZZ2SCV6lwg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 114B820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeLNMID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbeLNMH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6962147D;
        Fri, 14 Dec 2018 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789278;
        bh=wKHoiP8BdQjGccr8WSX0D277E50G4KTCVqpfMqqK/90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/5J1TawmY0k/tjZDREL+F3sO4kjvOT25ugqBijiR2MVgUMOt4b+C8lI+31YgcICW
         hGb2UYAAeJxyLHubrKvm2heE4EYJCSJNSgDOnldvv7/cX0jjep8KhH96rqo6Qea9zl
         NQd0NXSWujMW3vmRomn5F1xKQeYNG8Wjz6kYRLO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/89] net: phy: dont allow __set_phy_supported to add unsupported modes
Date:   Fri, 14 Dec 2018 12:59:21 +0100
Message-Id: <20181214115730.081766744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy_device.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1703,20 +1703,17 @@ EXPORT_SYMBOL(genphy_loopback);
 
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


