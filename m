Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AABC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED51208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="swWwl5Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED51208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeK3B3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbeK3B3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F68A2145D;
        Thu, 29 Nov 2018 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501426;
        bh=E8aRAhkHmteTihl4UTv0DJMh1+MoLWdfWlgyDXtbKFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swWwl5Pd8y92GLwPHJunGHSXtk8vRlwAddw1trs7QWqAXDbijjFIIR7DvdV3XDQLQ
         J314+nKd/kSIMXEMiM3joFHMvvUFaBloWPi+frsXWfTDGIyUnWDPhf1nAqGBFrFCjE
         Jo0yjIld332tZP8d51y1igi6OKo9Bkw6t6v+0G3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Pisati <p.pisati@gmail.com>
Subject: [PATCH 4.9 85/92] lan78xx: Read MAC address from DT if present
Date:   Thu, 29 Nov 2018 15:12:54 +0100
Message-Id: <20181129140113.566351103@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Elwell <phil@raspberrypi.org>

commit 760db29bdc97b73ff60b091315ad787b1deb5cf5 upstream.

There is a standard mechanism for locating and using a MAC address from
the Device Tree. Use this facility in the lan78xx driver to support
applications without programmed EEPROM or OTP. At the same time,
regularise the handling of the different address sources.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Tested-by: Paolo Pisati <p.pisati@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/lan78xx.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -31,6 +31,7 @@
 #include <linux/mdio.h>
 #include <net/ip6_checksum.h>
 #include <linux/microchipphy.h>
+#include <linux/of_net.h>
 #include "lan78xx.h"
 
 #define DRIVER_AUTHOR	"WOOJUNG HUH <woojung.huh@microchip.com>"
@@ -1644,34 +1645,31 @@ static void lan78xx_init_mac_address(str
 	addr[5] = (addr_hi >> 8) & 0xFF;
 
 	if (!is_valid_ether_addr(addr)) {
-		/* reading mac address from EEPROM or OTP */
-		if ((lan78xx_read_eeprom(dev, EEPROM_MAC_OFFSET, ETH_ALEN,
-					 addr) == 0) ||
-		    (lan78xx_read_otp(dev, EEPROM_MAC_OFFSET, ETH_ALEN,
-				      addr) == 0)) {
-			if (is_valid_ether_addr(addr)) {
-				/* eeprom values are valid so use them */
-				netif_dbg(dev, ifup, dev->net,
-					  "MAC address read from EEPROM");
-			} else {
-				/* generate random MAC */
-				random_ether_addr(addr);
-				netif_dbg(dev, ifup, dev->net,
-					  "MAC address set to random addr");
-			}
-
-			addr_lo = addr[0] | (addr[1] << 8) |
-				  (addr[2] << 16) | (addr[3] << 24);
-			addr_hi = addr[4] | (addr[5] << 8);
-
-			ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-			ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		if (!eth_platform_get_mac_address(&dev->udev->dev, addr)) {
+			/* valid address present in Device Tree */
+			netif_dbg(dev, ifup, dev->net,
+				  "MAC address read from Device Tree");
+		} else if (((lan78xx_read_eeprom(dev, EEPROM_MAC_OFFSET,
+						 ETH_ALEN, addr) == 0) ||
+			    (lan78xx_read_otp(dev, EEPROM_MAC_OFFSET,
+					      ETH_ALEN, addr) == 0)) &&
+			   is_valid_ether_addr(addr)) {
+			/* eeprom values are valid so use them */
+			netif_dbg(dev, ifup, dev->net,
+				  "MAC address read from EEPROM");
 		} else {
 			/* generate random MAC */
 			random_ether_addr(addr);
 			netif_dbg(dev, ifup, dev->net,
 				  "MAC address set to random addr");
 		}
+
+		addr_lo = addr[0] | (addr[1] << 8) |
+			  (addr[2] << 16) | (addr[3] << 24);
+		addr_hi = addr[4] | (addr[5] << 8);
+
+		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
 	}
 
 	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);


