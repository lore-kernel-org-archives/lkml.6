Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF060ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6360620856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfIqSY07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6360620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbeGWRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388510AbeGWRWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:22:44 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D582920854;
        Mon, 23 Jul 2018 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532362846;
        bh=+J69iIg9oArgpzWcZZEk2Qe2P7D0diw+scQrfvsgcYc=;
        h=From:To:Cc:Subject:Date:From;
        b=JfIqSY07YvaKoMui6NYR85qhkDcai4Vv8vqxWUxSpze5nU4upkCSsMGLU4kXjwF9V
         2Ca0M7FDBuTK4qXBgQY3YQ9v6x8SdVrG2R85HnFDI3hGenzn8WzDWNk6CSBJUSVsfe
         qoQmZR6ACWx+Pg34a5rTNOq3jPt+JxZPKAZhqPfw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] net: ethernet: fs-enet: Use generic CRC32 implementation
Date:   Mon, 23 Jul 2018 18:20:20 +0200
Message-Id: <20180723162020.6221-1-krzk@kernel.org>
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

Not tested on hardware.
---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index 1fc27c97e3b2..99fe2c210d0f 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/ptrace.h>
 #include <linux/errno.h>
+#include <linux/crc32.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -176,21 +177,10 @@ static void set_multicast_start(struct net_device *dev)
 static void set_multicast_one(struct net_device *dev, const u8 *mac)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
-	int temp, hash_index, i, j;
+	int temp, hash_index;
 	u32 crc, csrVal;
-	u8 byte, msb;
-
-	crc = 0xffffffff;
-	for (i = 0; i < 6; i++) {
-		byte = mac[i];
-		for (j = 0; j < 8; j++) {
-			msb = crc >> 31;
-			crc <<= 1;
-			if (msb ^ (byte & 0x1))
-				crc ^= FEC_CRC_POLY;
-			byte >>= 1;
-		}
-	}
+
+	crc = ether_crc(6, mac);
 
 	temp = (crc & 0x3f) >> 1;
 	hash_index = ((temp & 0x01) << 4) |
-- 
2.14.1

