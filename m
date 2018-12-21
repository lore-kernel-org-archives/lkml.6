Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3986C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6788621908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFRLZWj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbeLUJqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:46:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36304 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeLUJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:46:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so3463984lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rZpt6IZJExB+1DUmVUcp0qlAQJqjtaoSfZntRDcDJUk=;
        b=ZFRLZWj3jysGlW8tRcnKahfc7Hn9I/Q/3aY1xlR6XRRvH2M620GzqtmSuVOKQ8Hj9m
         FQuxO9RKLXFKE0edPbzw7DuqhYHBS3kcaMj9z795CREqe28DSSVASXW08ktQLDvCSIq0
         5rfbCeipeqiZ6j1QEGeMNgC9TiqSwBmhG9gJ+YwYC37Gkqr8t/G1gg1pNbRHtHWS0gou
         ChB/gJCsmw+nhgiuh12gqtooIlTYdJgWDSYe9qvx4ZDpjEU8bmZUEuxavO5dB26jr2SG
         kyZ16UGaeiOvBjvMwKI4Cev34enYc390T9wUuj3CgN7fPSqLeZinVdw3/1EomWm9281E
         UYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rZpt6IZJExB+1DUmVUcp0qlAQJqjtaoSfZntRDcDJUk=;
        b=TuZ5T0lEo6T3VV9LPExaWrGD9Lmnb8SZCLL3ydfEpGSz8xG820arN/EofQ4CmKo51Z
         Vbd5r/B0rRIaVVPcNn3+T7VSNoYAqpfEVUDRBXwd0XRvoNysIbPZrfSyIw3pAmx4REh4
         faHbzkk/P4VeZwhQvekPuFuNgAsEN7Epytn1Q3yDnE1H66EOyxl4q8VSccik6dvx0hhv
         OBvFG5JfK70dPwMnEV2CMK91gnQ0ZJTDDLLUD6Eqp9JJByRIBnOgv5qJwjW0d2gydN34
         P72kCZ3eJzmxKKQy5Pkv7PPLNRYU+AC1r4Fpp3VmWKITYpiVSreTv2HXxkR5TEzayoR4
         LMVA==
X-Gm-Message-State: AA+aEWZgm4UYRj9tj1K4LLyq30j9jTND5xUPRxSFvd1dlqHZLLKLW8l7
        ktm6k5cypwEdVTIMEHzDm3rPaXB5
X-Google-Smtp-Source: AFSGD/UUOeYUsa9qdSv8VLQbNlu50V7Kzy4KnMfVtEf6yGU2DGlmk270Ahd78hCvRxwVkWgmGgZvWg==
X-Received: by 2002:a19:9904:: with SMTP id b4mr927334lfe.95.1545385565244;
        Fri, 21 Dec 2018 01:46:05 -0800 (PST)
Received: from maxim-H61M-D2-B3.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id k21-v6sm4430909ljc.15.2018.12.21.01.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 01:46:04 -0800 (PST)
From:   Max Uvarov <muvarov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
        Max Uvarov <muvarov@gmail.com>
Subject: [PATCH] usbnet: smsc95xx: allow to down ethernet link
Date:   Fri, 21 Dec 2018 12:45:53 +0300
Message-Id: <20181221094553.13137-1-muvarov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allow ifconfig ethX to down ethernet link. Ethernet
part of chip is switched to power down more and on
ifconfig up driver does soft reset and restores it's
state.

Signed-off-by: Max Uvarov <muvarov@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 34 +++++++++++++++++++++++++++++++++-
 drivers/net/usb/smsc95xx.h |  5 +++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 41e283f3eeb9..e72b038cfb79 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1142,9 +1142,41 @@ static int smsc95xx_reset(struct usbnet *dev)
 	return 0;
 }
 
+static int smsc95xx_lan_power_down(struct net_device *net)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct mii_if_info *mii = &dev->mii;
+	int ret;
+
+	ret = smsc95xx_mdio_read_nopm(net, mii->phy_id, SMSC95XX_PHY_BASIC);
+	if (ret < 0)
+		return ret;
+	ret &= ~SMSC95XX_PHY_BASIC_BIT_AUTONEG; /* disable autoneg */
+	smsc95xx_mdio_write_nopm(net, mii->phy_id, SMSC95XX_PHY_BASIC, ret);
+
+	ret = smsc95xx_mdio_read_nopm(net, mii->phy_id, SMSC95XX_PHY_BASIC);
+	if (ret < 0)
+		return ret;
+	ret |= SMSC95XX_PHY_BASIC_BIT_POWER_DOWN; /* enable power down */
+	smsc95xx_mdio_write_nopm(net, mii->phy_id, SMSC95XX_PHY_BASIC, ret);
+
+	return 0;
+}
+
+static int smsc95xx_stop(struct net_device *net)
+{
+	int ret;
+
+	ret = smsc95xx_lan_power_down(net);
+	if (ret)
+		netdev_err(net, "err switch to power down mode\n");
+
+	return usbnet_stop(net);
+}
+
 static const struct net_device_ops smsc95xx_netdev_ops = {
 	.ndo_open		= usbnet_open,
-	.ndo_stop		= usbnet_stop,
+	.ndo_stop		= smsc95xx_stop,
 	.ndo_start_xmit		= usbnet_start_xmit,
 	.ndo_tx_timeout		= usbnet_tx_timeout,
 	.ndo_change_mtu		= usbnet_change_mtu,
diff --git a/drivers/net/usb/smsc95xx.h b/drivers/net/usb/smsc95xx.h
index 526faa0c44e6..547e8053feba 100644
--- a/drivers/net/usb/smsc95xx.h
+++ b/drivers/net/usb/smsc95xx.h
@@ -47,6 +47,11 @@
 #define RX_STS_DB_			(0x00000004)	/* Dribbling */
 #define RX_STS_CRC_			(0x00000002)	/* CRC Error */
 
+/* Basic Control Register */
+#define SMSC95XX_PHY_BASIC		  (0x0)
+#define SMSC95XX_PHY_BASIC_BIT_AUTONEG	  BIT(12)
+#define SMSC95XX_PHY_BASIC_BIT_POWER_DOWN BIT(11)
+
 /* SCSRs */
 #define ID_REV				(0x00)
 #define ID_REV_CHIP_ID_MASK_		(0xFFFF0000)
-- 
2.17.1

