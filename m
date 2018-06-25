Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FBCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD2525599
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD2525599
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeFYIGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:06:19 -0400
Received: from mout.perfora.net ([74.208.4.196]:43299 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753258AbeFYIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:06:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MOyC9-1fUuNm2JK3-006N5r; Mon, 25 Jun 2018 10:00:54 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     netdev@vger.kernel.org
Cc:     intel-wired-lan@lists.osuosl.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] igb: allow optionally getting mac address from device tree
Date:   Mon, 25 Jun 2018 10:00:42 +0200
Message-Id: <20180625080042.32286-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:yHMleQQ93mACmRLTiNR6Ids3rrcvL4KCSMvF8l/Ba1qXBd+Gd3d
 0SVqBISm6hwQLoAhdx/3U2S7lgpgbjQcQ0zH9L5GxSVP1L6+tyUhAGXJvbWn9QUF+9zHW8p
 qzFVyen2KtJFUvt51yUYnG+F9ta2cn8DwDhO6bvK2IGAW+l9h6shGKs/G+QlE6i5mLkb1vt
 QVa6y9sAcE7k2QsC8EF5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VcAUtUs/gos=:UwB1R37SD+ZfsdzJ4R0eng
 h6DQw4ohz2N33AxE4FoAV/BlzrcxTZX4mXLhexpbbQ2uK1u61Osb3UF7quiHz8yEzLplZpn2D
 fRBEs3zeUBgjDxQwUGiC1lmcoJ2yn7HD+O3WMZaZQ0MxXdNhbsKniMZG0GV3VZDAkILbUzDHG
 WweEfHRBR5kPQ3rH0l/9GM2XsON3qlY+9IehMoE44CNvUNLMtlyBaXd333sU4j1+ia0hRxFef
 zm1xe02Y/YGdS7xdLc6yMDT88Jfs6ZYG6LBYerdp12ZwqweMhNVk/rIE+ZCgaTEG9BX53bU/B
 46GTkD/2bZZQnnhQk4ztEFvgccdwyOjgiQvAGuUVKDfmxrRWQL2w0554PdJZlvOwpvJFry5nd
 lewLbr9TTrA7g7FLOgAqEyHQwQz9caKrR5U97A4r8bNh5VmjeaG/LaQE2RxbFoHla05qDd4HQ
 SW6GruKq6rxonhqZRhf/BpuE4OA/kJoTxjhsoOdOuxC/fALxThH7tsJUdRrJ+K/tBCsE4r2IM
 r5oVcS/YzbRsUKrWnsMLN1bC8vEKbTFWj9/Fmi5hg2U6TayZWJMVRBlk09Wm35PkglAoStpfw
 gd9ryKvRUjJlWsxmmkVFWk7rARba1JV+qGUwyOt5Ga5WvUnJR9spPpIpz1RT3J6t5LGNlqLCz
 4AjlMnx444weALILYd+//q2qOqwxdTInPbUukSi3kDNmN+KBjCO17m5s9Yjx5K30LG2I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

For Embedded use where e.g. i210/i211 chips may be used without
external EEPROMs but regardless of whether or not the MAC address is
actually programmed into the iNVM the boot loader may choose to pass
the MAC address to be used via device tree. Therefore, allow for
optionally getting the MAC address from device tree data e.g. as
follows (excerpt from a TK1 based board, local-mac-address to be
filled in by boot loader):

pcie@1003000 {
	...

	/* I210 Gigabit Ethernet Controller */
	pci@2,0 {
		...
		status = "okay";
		pcie@0 {
			reg = <0 0 0 0 0>;
			local-mac-address = [00 00 00 00 00 00];
		};
	};
};

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f707709969ac..0abf3698b05c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -37,6 +37,7 @@
 #include <linux/dca.h>
 #endif
 #include <linux/i2c.h>
+#include <linux/of_net.h>
 #include "igb.h"
 
 #define MAJ 5
@@ -2931,6 +2932,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct e1000_info *ei = igb_info_tbl[ent->driver_data];
 	int err, pci_using_dac;
 	u8 part_str[E1000_PBANUM_LENGTH];
+	const void *iap;
 
 	/* Catch broken hardware that put the wrong VF device ID in
 	 * the PCIe SR-IOV capability.
@@ -3122,7 +3124,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
+	/* try to get the MAC address from device tree data */
+	iap = of_get_mac_address(pdev->dev.of_node);
+	if (iap)
+		memcpy(hw->mac.addr, iap, ETH_ALEN);
+	else if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
 		/* copy the MAC address out of the NVM */
 		if (hw->mac.ops.read_mac_addr(hw))
 			dev_err(&pdev->dev, "NVM Read Error\n");
-- 
2.14.4

