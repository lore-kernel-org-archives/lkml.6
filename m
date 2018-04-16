Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeDPIH4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:07:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45816 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753384AbeDPIHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:07:55 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net] net: mvpp2: Fix TCAM filter reserved range
Date: Mon, 16 Apr 2018 10:07:23 +0200
Message-Id: <20180416080723.15593-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell's PPv2 controller has a Packet Header parser, which uses a
fixed-size TCAM array of filter entries.

The mvpp2 driver reserves some ranges among the 256 TCAM entries to
perform MAC and VID filtering. The rest of the TCAM ids are freely usable
for other features, such as IPv4 proto matching.

This commit fixes the MVPP2_PE_LAST_FREE_TID define that sets the end of
the "free range", which included the MAC range. This could therefore allow
some other features to use entries dedicated to MAC filtering,
lowering the number of unicast/multicast addresses that could be allowed
before switching to promiscuous mode.

Fixes: 10fea26ce2aa ("net: mvpp2: Add support for unicast filtering")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 54a038943c06..9deb79b6dcc8 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -663,7 +663,7 @@ enum mvpp2_tag_type {
 #define MVPP2_PE_VID_FILT_RANGE_END     (MVPP2_PRS_TCAM_SRAM_SIZE - 31)
 #define MVPP2_PE_VID_FILT_RANGE_START   (MVPP2_PE_VID_FILT_RANGE_END - \
 					 MVPP2_PRS_VLAN_FILT_RANGE_SIZE + 1)
-#define MVPP2_PE_LAST_FREE_TID          (MVPP2_PE_VID_FILT_RANGE_START - 1)
+#define MVPP2_PE_LAST_FREE_TID          (MVPP2_PE_MAC_RANGE_START - 1)
 #define MVPP2_PE_IP6_EXT_PROTO_UN	(MVPP2_PRS_TCAM_SRAM_SIZE - 30)
 #define MVPP2_PE_IP6_ADDR_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 29)
 #define MVPP2_PE_IP4_ADDR_UN		(MVPP2_PRS_TCAM_SRAM_SIZE - 28)
-- 
2.11.0
