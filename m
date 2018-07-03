Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDACC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825ED20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825ED20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeGCPHX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:07:23 -0400
Received: from mout.perfora.net ([74.208.4.197]:38023 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932410AbeGCPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:07:07 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lyk9B-1gECBF2Mi7-0169A7; Tue, 03 Jul 2018 17:06:55 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     netdev@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-usb@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2] net: usb: asix: allow optionally getting mac address from device tree
Date:   Tue,  3 Jul 2018 17:06:49 +0200
Message-Id: <20180703150649.30030-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:bgbCL+SCEUaQUIDUdKfiBC+iRosUOs3WijT7DE8DN3ASuijtxRy
 KxTSqYoLSEI184QanVhV292qhtFUxkRNPsZGVcNoo4pPVEYG5KLqfMBum5K6nHpaENbppHY
 YRlmDlc1kcFJEqI1oaUErhocTLBd1DHhA08qaLJYINXqO+ryoELEtHjTHtTRRZjyqzDONB9
 JZOceNZedJvG8lXseK2IA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d6OC1ASxGNU=:JlPMUGR69Rr+ou29NkURuv
 2pAGBmsAhg0YHie904jHfA/EguICL0Y8wFMRKpUqMyV8TuPP4F5MkjLMocHPRmGkbiDIOMwdH
 lGd0yScdYXGfmn2DREwXANuVdcqubEmiRQISRAn4bs1yOxw7S8h9bcYv73cZeTltXF9wuYRof
 DJ+8op9rixf+lV765bqZJILAbvx6KU/DSk47hmkgvmXh1TnQt23I7hpLz11uMExLy1FWH9ufN
 idq5LsBAKlOEMrrNfml8m8CKrmdeUrX5nyuYmnBSTVsiisYNOVqIAJcnQxYCN1kcCDeXsQxLl
 9Xl0YLq3dfVnMV1an+OGrBtAij02/PyOq0AhN98AoDQ0HCGhmXwPwEa7WkVOXXqFvJGMw4pyg
 m5cAb1ryOJSk8N9E3GNA7QVZ3p/NZDKOle3FkuJ5mPDjg1BD1H07RktiKDE3yBO7hXnVaHxNZ
 1hOv7wfvG0lp1nixsKTaEZbjW8RN/sPYqb4GucSbSMLM9jkSc3REI+SA06jpvTIfGwsxGpAFx
 NHcOPP+Sjuw7qLd5nK2u+HV6Ys48Ve64PkNEJpFvAod3qZgtpA4cHT+pa28B9HPU1IqxjQKor
 aLHq2y+ISBrPcwj1ECLQf1ZuYEGSe5Kb7qvQpZgfrLd+gzpbqhU6UG1xaCejCd+iGlPCe0SQT
 5qPmU3kttWs3EzmZXrpWmKRJ/279XNhqYkF+8/sC6ZaacOOfnMA6kngjLlPpJ4FMOhLA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

For Embedded use where e.g. AX88772B chips may be used without external
EEPROMs the boot loader may choose to pass the MAC address to be used
via device tree. Therefore, allow for optionally getting the MAC
address from device tree data e.g. as follows (excerpt from a T30 based
board, local-mac-address to be filled in by boot loader):

/* EHCI instance 1: USB2_DP/N -> AX88772B */
usb@7d004000 {
	status = "okay";
	#address-cells = <1>;
	#size-cells = <0>;
	asix@1 {
		reg = <1>;
		local-mac-address = [00 00 00 00 00 00];
	};
};

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Use eth_platform_get_mac_address() as suggested by Andrew.

 drivers/net/usb/asix_devices.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 3d4f7959dabb..8f41c6bda8e5 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -691,24 +691,32 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	u32 phyid;
 	struct asix_common_private *priv;
 
-	usbnet_get_endpoints(dev,intf);
+	usbnet_get_endpoints(dev, intf);
 
-	/* Get the MAC address */
-	if (dev->driver_info->data & FLAG_EEPROM_MAC) {
-		for (i = 0; i < (ETH_ALEN >> 1); i++) {
-			ret = asix_read_cmd(dev, AX_CMD_READ_EEPROM, 0x04 + i,
-					    0, 2, buf + i * 2, 0);
-			if (ret < 0)
-				break;
-		}
+	/* Maybe the boot loader passed the MAC address via device tree */
+	if (!eth_platform_get_mac_address(&dev->udev->dev, buf)) {
+		netif_dbg(dev, ifup, dev->net,
+			  "MAC address read from device tree");
 	} else {
-		ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID,
-				0, 0, ETH_ALEN, buf, 0);
-	}
+		/* Try getting the MAC address from EEPROM */
+		if (dev->driver_info->data & FLAG_EEPROM_MAC) {
+			for (i = 0; i < (ETH_ALEN >> 1); i++) {
+				ret = asix_read_cmd(dev, AX_CMD_READ_EEPROM,
+						    0x04 + i, 0, 2, buf + i * 2,
+						    0);
+				if (ret < 0)
+					break;
+			}
+		} else {
+			ret = asix_read_cmd(dev, AX_CMD_READ_NODE_ID,
+					    0, 0, ETH_ALEN, buf, 0);
+		}
 
-	if (ret < 0) {
-		netdev_dbg(dev->net, "Failed to read MAC address: %d\n", ret);
-		return ret;
+		if (ret < 0) {
+			netdev_dbg(dev->net, "Failed to read MAC address: %d\n",
+				   ret);
+			return ret;
+		}
 	}
 
 	asix_set_netdev_dev_addr(dev, buf);
-- 
2.14.4

