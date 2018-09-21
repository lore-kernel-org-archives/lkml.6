Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF96AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9C21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfLx+7Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB9C21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeIVEVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:21:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42623 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVEVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:21:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so6559405pff.9;
        Fri, 21 Sep 2018 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H9cNT0Tp13nJ+GUwoMH9aBG19QPMRXS/35BiURGEFTU=;
        b=BfLx+7WdhRRX2TwqZjzPThcXyk4lbFc48g0oSGe0t/vWtidjeLMX0edTs4pTlk9yc7
         xoC8MN3moONBcg955jhIb+n31cBPFUjtYrn+Y13TXPe7ZQ26VJ75zK2xXyv4QswWp2NC
         92nmg5tTTkHZVG1qQA7fzrtsfPlQj+IqX2OF2JQBF2hxrs5lmXzCL0PW6oA24DrZoxwl
         XoHSb51tXreg6H7KWhq+l10O7hM7BepQ+ZBOapwlZY57e1vYH7mJrXUwxlxy1+BcYIEt
         BdyJwU8DuS6NjIZC6h8WtuVpj0+XEXsYgoaY09+2aqXWt7SIt61GKLzBmnH9WOrnAn42
         2cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H9cNT0Tp13nJ+GUwoMH9aBG19QPMRXS/35BiURGEFTU=;
        b=Xm1JoikkXMIQ/QA1gUAkUC7MwoX4gFXqF2Wo75I1ctP3n3Y4FO3ZybXRy1QZkcH5bW
         MlHZ1kHnXE0CbVRN9jMLazxaz6umnuh3Et6UDhhuYIUX8lGccWkY5uYgEiYjp0uO/QNS
         iKp6Fd3F2NPYQ6ichcuO6INfLsQaj4WEbelRi4ffrViy7zKy5XwCSLjXwSZbRfLVTsI8
         LQAWuF6HiQeuEXx6p1/C/KLiF6Lwps2piVUa02n/sGzZdzE75gliJ5H85gqNAsHCZYRn
         9Awi+lql9V9k8xFIBrhiAw2JxUkeJkgEmSDXY6MDIszRFp/EaOvxfJtcz7cdIgUPA0n0
         fG0Q==
X-Gm-Message-State: APzg51C/2F15f4/6H9T1eVLVVh9z2NtdD2eGN1KMM18GDCzLHgk7FMW3
        cd5Y2OKLmgEcQirINsygQjOrDKk/
X-Google-Smtp-Source: ANB0Vdb/ZeMoxm8x/7uEP0hUzQSyQKqMXo8XeWqXzM0UgkHpw+obWNBPojl0rKH+o2U7J/DAbhq0Yw==
X-Received: by 2002:a62:464f:: with SMTP id t76-v6mr48398507pfa.118.1537569009397;
        Fri, 21 Sep 2018 15:30:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n83-v6sm60042676pfk.19.2018.09.21.15.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:30:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     rmk+kernel@armlinux.org.uk,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Don't assign autonegotiation enabled
Date:   Fri, 21 Sep 2018 15:30:05 -0700
Message-Id: <20180921223005.24969-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHYLINK takes care of filing the right information into
state->an_enabled, get rid of the read from the SerDes's BMCR register.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_serdes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index b45c55e0b8b4..629bf14128a2 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -100,15 +100,13 @@ int b53_serdes_link_state(struct b53_device *dev, int port,
 			  struct phylink_link_state *state)
 {
 	u8 lane = b53_serdes_map_lane(dev, port);
-	u16 dig, bmcr, bmsr;
+	u16 dig, bmsr;
 
 	if (lane == B53_INVALID_LANE)
 		return 1;
 
 	dig = b53_serdes_read(dev, lane, B53_SERDES_DIGITAL_STATUS,
 			      SERDES_DIGITAL_BLK);
-	bmcr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMCR),
-			       SERDES_MII_BLK);
 	bmsr = b53_serdes_read(dev, lane, B53_SERDES_MII_REG(MII_BMSR),
 			       SERDES_MII_BLK);
 
@@ -129,7 +127,6 @@ int b53_serdes_link_state(struct b53_device *dev, int port,
 	}
 
 	state->duplex = dig & DUPLEX_STATUS ? DUPLEX_FULL : DUPLEX_HALF;
-	state->an_enabled = !!(bmcr & BMCR_ANENABLE);
 	state->an_complete = !!(bmsr & BMSR_ANEGCOMPLETE);
 	state->link = !!(dig & LINK_STATUS);
 	if (dig & PAUSE_RESOLUTION_RX_SIDE)
-- 
2.17.1

