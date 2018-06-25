Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFDAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844542557F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844542557F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752980AbeFYIBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:01:45 -0400
Received: from mout.perfora.net ([74.208.4.197]:37051 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752383AbeFYIBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:01:43 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LlWiH-1g8LsW3Lx1-00bKFT; Mon, 25 Jun 2018 10:01:20 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     netdev@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-usb@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] net: usb: asix: allow optionally getting mac address from device tree
Date:   Mon, 25 Jun 2018 10:01:08 +0200
Message-Id: <20180625080108.32441-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:mBelHOJuJGy25FR5K74iFAqsUeFxOA6/igAVHPv7IClje9hiKC9
 dmzMEFLQlVIElNsMSdSIq6kKindjqwID+pKbGZoc2g7TpbUocvyeYQ+0lZe+XF1lsxm86Eh
 JhP4IH8z6PqnrBjvL6/aH6QaCQWPirrbh5tCLSObXC5XXHY+uYWaj+zrj5fP7cw2JDL9ypZ
 x1ai6ZmK4TMt1HnUL5iLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J6gzLOGem30=:yLXExeUf8MXRyQUYT33e8b
 mtVa2QVEZrQolDZ4qYdTFV+9C0MfiGm27Kfb5DpghDJVMEaDkcvA6ZvgSG355wf4gCPARUDHp
 Hbeov0OKikcP+Lh67d7RyaCm7FIjL/9n+pa7fPiC5z1ZFtWXSdX90QQCKOhj9vNFMHZU/bpAj
 Rskb4N6k+td5UYeLJO/3bDCqlKXQKrX0ujZn4+LyyiJEdmX56pOTxFedUiFNs3q7SZmxEjywd
 xsdtOTN5PgUQWqZjUxKODoum4DJee1GzOucyGQhCUE7lzxUKFaEQR5N2eMKA/eQTpnXE9pWIi
 Jy2bWoVJDIkUqlVuuFVswlX4HAfQbcXoUwyxboNDVGkYXwLkYnbjO2z5OZJjDVWLGdi5kQ4xV
 bwwlU836z2UOYG3re2YrM4Vk5ruMsK1w+8JUGDIU752Dfr7mZsz/Tls/fkMin/Z0s9kM9zb46
 kw0d8nPqhbDsOhsyXRb2NEASv+DM5AfnGuY3OI8iWq8I+ZOApm++mRAUNvUzMYsAqPyyMkItH
 Et2wllfMWONsvVnw6Wh/vA+FZXb/9u+zH3UaM5XbCDwx7tEelwuJNb0HDs02dbiRuEodO0xvT
 bYFJxfwHLPbRG24VkTRTwxQPbjRxXxP3gmQyvj5+K7N4zbsHE2c6lItFrGWkxLolPrD1Pkavc
 1oy0mNniM5cCyHdmeorR/idGv9mRgE9qnG2x0P7gFcpAUb9yWFu8hzfzXOVRlifZzbjA=
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

 drivers/net/usb/asix.h         |  1 +
 drivers/net/usb/asix_devices.c | 39 ++++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/asix.h b/drivers/net/usb/asix.h
index 9a4171b90947..c8161960cef2 100644
--- a/drivers/net/usb/asix.h
+++ b/drivers/net/usb/asix.h
@@ -37,6 +37,7 @@
 #include <linux/usb/usbnet.h>
 #include <linux/slab.h>
 #include <linux/if_vlan.h>
+#include <linux/of_net.h>
 
 #define DRIVER_VERSION "22-Dec-2011"
 #define DRIVER_NAME "asix"
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 3d4f7959dabb..a88d65dfc64c 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -690,25 +690,34 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	u8 buf[ETH_ALEN], chipcode = 0;
 	u32 phyid;
 	struct asix_common_private *priv;
+	const u8 *mac_addr;
 
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
+	mac_addr = of_get_mac_address(dev->udev->dev.of_node);
+	if (mac_addr) {
+		memcpy(buf, mac_addr, ETH_ALEN);
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

