Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07461205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd27wgfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07461205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeH2W0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:26:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39041 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeH2W0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:26:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so2651729pff.6;
        Wed, 29 Aug 2018 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7FzF/u9VzIPAca/cGSLZ78ky8I3exCpYK+DzMjQX5JY=;
        b=Zd27wgfoKOaaNx8D0GbyPRrta3X+dVe1Ohp0UreSik1Pl7cGejnxxeSxQwz4H0+avi
         Th3P83yXPbwSeervFp8/qheNBZN+3g0atHX2Nci0EOP3J4t1wk0AFNugBmOizRFFHTY3
         TObHOO/+FHjmCQhanyJqfqbvmuijQg48gnzp69q4YbmPYPT94ZzTH//a9UFiHX4B/rxK
         zsYdmEKordYGpI47TFG9zf3Pk6rvOUJxDHsx0h3vlgTe8KjIlPc18KK49uzCBw0xU9KS
         IVYfj7jhW4SZBvoi98hlwR5ek+rztYd5F7xGa3uWXW6DyQQP9kfFR184XrNAO6LU9kEB
         ZbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7FzF/u9VzIPAca/cGSLZ78ky8I3exCpYK+DzMjQX5JY=;
        b=ttVDbi+gm5pM6wtiFzMfMSbwoHAgUeshk6G7w6KaZbFcOjLlb7lAe4wVmLfVnDFt9f
         wL3MgdRt2YrgH+pSNpgrIxyaWL7eiEMqaFie1L4hNOhbGtPsLotYGLhaTExYhWVlU6CM
         z2Ezn9qRO+kAE8+Xj+NIODZHjo26mK2MmCZaa0lxRBs7TrlCFz0szfgkCYRquywTMaYb
         IIp66baluCK6UBXjaDDnrkbIrIWRzWf7nSpHyk85HcLW29Zosyj1Z/S1uwj10W5DAfD6
         eRYN3O69HLZhtVG0c1n13G88LIGNu2ZrjLaleBt9MPVd7fabozdg/oEEstNKXU3tIgBR
         jwDA==
X-Gm-Message-State: APzg51DaLyqvB+wKB1Q9NH631ybfITu8sXD9emf29rZnrqwCpA6YpgbG
        9iJgv2I06oLLaLO336jFw5ZGDTZR
X-Google-Smtp-Source: ANB0VdbPWQEgyUyND2afGBS7XICq+yHfIDTjyrPo1OmZja1Ly/T0Tmt5y+Q0EbdQrwdx1NYmzhsd/A==
X-Received: by 2002:a63:df04:: with SMTP id u4-v6mr6759760pgg.434.1535567282678;
        Wed, 29 Aug 2018 11:28:02 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id w131-v6sm3697666pfd.152.2018.08.29.11.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 11:28:02 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH net v2] net: bcmgenet: use MAC link status for fixed phy
Date:   Wed, 29 Aug 2018 11:27:49 -0700
Message-Id: <1535567269-12534-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the fixed PHY with GENET (e.g. MOCA) the PHY link
status can be determined from the internal link status captured
by the MAC. This allows the PHY state machine to use the correct
link state with the fixed PHY even if MAC link event interrupts
are missed when the net device is opened.

Fixes: 8d88c6ebb34c ("net: bcmgenet: enable MoCA link state change detection")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
v2: increased "Fixes" sha1 to 12 digits

 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  3 +++
 drivers/net/ethernet/broadcom/genet/bcmmii.c   | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index b773bc07edf7..14b49612aa86 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -186,6 +186,9 @@ struct bcmgenet_mib_counters {
 #define UMAC_MAC1			0x010
 #define UMAC_MAX_FRAME_LEN		0x014
 
+#define UMAC_MODE			0x44
+#define  MODE_LINK_STATUS		(1 << 5)
+
 #define UMAC_EEE_CTRL			0x064
 #define  EN_LPI_RX_PAUSE		(1 << 0)
 #define  EN_LPI_TX_PFC			(1 << 1)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 5333274a283c..4241ae928d4a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -115,8 +115,14 @@ void bcmgenet_mii_setup(struct net_device *dev)
 static int bcmgenet_fixed_phy_link_update(struct net_device *dev,
 					  struct fixed_phy_status *status)
 {
-	if (dev && dev->phydev && status)
-		status->link = dev->phydev->link;
+	struct bcmgenet_priv *priv;
+	u32 reg;
+
+	if (dev && dev->phydev && status) {
+		priv = netdev_priv(dev);
+		reg = bcmgenet_umac_readl(priv, UMAC_MODE);
+		status->link = !!(reg & MODE_LINK_STATUS);
+	}
 
 	return 0;
 }
-- 
2.7.4

