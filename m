Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98615ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4389620856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJl73yox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4389620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeGWRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388147AbeGWRVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:21:38 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EB520854;
        Mon, 23 Jul 2018 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532362780;
        bh=++73e+sSzjo7qeQlua05HTEcILo5aExz1Xt4anunSM4=;
        h=From:To:Cc:Subject:Date:From;
        b=SJl73yox57mwF/PVi70vGQUTck1hMMEnJcxm8LBcQ4Fefwz+myJjWT0npst1ZcLcz
         HKtdznZllfQhwvkXFkG3/iPurinMgt8y8MVE38vNr7lxhpeJQRyOW5suc7Rqw3yLaB
         qu/dPZ1QML3wgdP+NsiRQPUoHRtMvCYF3aE+4YeI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] net: ethernet: freescale: Use generic CRC32 implementation
Date:   Mon, 23 Jul 2018 18:19:14 +0200
Message-Id: <20180723161914.6101-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic kernel CRC32 implementation because it:
1. Should be faster (uses lookup tables),
2. Removes duplicated CRC generation code,
3. Uses well-proven algorithm instead of coding it one more time.

Suggested-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Use ether_crc_le (suggested by David)

Changes since v1:
1. Fix missing header inclusion.
---
 drivers/net/ethernet/freescale/fec_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c729665107f5..98ad34192255 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -48,6 +48,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
+#include <linux/crc32.h>
 #include <linux/platform_device.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
@@ -2955,7 +2956,7 @@ static void set_multicast_list(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct netdev_hw_addr *ha;
-	unsigned int i, bit, data, crc, tmp;
+	unsigned int crc, tmp;
 	unsigned char hash;
 	unsigned int hash_high = 0, hash_low = 0;
 
@@ -2983,15 +2984,7 @@ static void set_multicast_list(struct net_device *ndev)
 	/* Add the addresses in hash register */
 	netdev_for_each_mc_addr(ha, ndev) {
 		/* calculate crc32 value of mac address */
-		crc = 0xffffffff;
-
-		for (i = 0; i < ndev->addr_len; i++) {
-			data = ha->addr[i];
-			for (bit = 0; bit < 8; bit++, data >>= 1) {
-				crc = (crc >> 1) ^
-				(((crc ^ data) & 1) ? CRC32_POLY : 0);
-			}
-		}
+		crc = ether_crc_le(ndev->addr_len, ha->addr);
 
 		/* only upper 6 bits (FEC_HASH_BITS) are used
 		 * which point to specific bit in the hash registers
-- 
2.14.1

