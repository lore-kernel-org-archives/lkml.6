Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F3C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730DB20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOPyOK20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730DB20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeGVNkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 09:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeGVNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 09:40:18 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1491020858;
        Sun, 22 Jul 2018 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532263424;
        bh=BhciSpmrihHJox5j8GvnwOzbNu+iNQfhxa78jBsqNiA=;
        h=From:To:Cc:Subject:Date:From;
        b=FOPyOK20PIn2TKOF/Dxp7OuIqKDkBwkIO36PfQdVeCoBiDH+mnQZ6YARz133HGdcn
         4qaNLRY4ikBK9DqTfe3BayDpMJsd9OI3z0bMihFGQWDcaZqyTSlwNwu8g1UVY88mxj
         4i72NMmpsM18lfYT9JCZhf0oeaaPmz5fKYwoukhg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] net: ethernet: freescale: Use generic CRC32 implementation
Date:   Sun, 22 Jul 2018 14:43:31 +0200
Message-Id: <20180722124331.22073-1-krzk@kernel.org>
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
 drivers/net/ethernet/freescale/fec_main.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c729665107f5..c93261ffa5e8 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2955,7 +2955,7 @@ static void set_multicast_list(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct netdev_hw_addr *ha;
-	unsigned int i, bit, data, crc, tmp;
+	unsigned int crc, tmp;
 	unsigned char hash;
 	unsigned int hash_high = 0, hash_low = 0;
 
@@ -2983,15 +2983,7 @@ static void set_multicast_list(struct net_device *ndev)
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
+		crc = crc32_le(~0, ha->addr, ndev->addr_len);
 
 		/* only upper 6 bits (FEC_HASH_BITS) are used
 		 * which point to specific bit in the hash registers
-- 
2.14.1

