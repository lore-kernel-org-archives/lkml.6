Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeERHeB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:34:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49848 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeERHd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:33:59 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next] net: mvpp2: Add missing VLAN tag detection
Date: Fri, 18 May 2018 09:33:39 +0200
Message-Id: <20180518073339.5353-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell PPv2 Header Parser sets some bits in the 'result_info' field in
each lookup iteration, to identify different packet attributes such as
DSA / VLAN tag, protocol infos, etc. This is used in further
classification stages in the controller.

It's the DSA tag detection entry that is in charge of detecting when there
is a single VLAN tag.

This commits adds the missing update of the result_info in this case.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 7ba7e5938c2e..47e582406bd3 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -2130,6 +2130,9 @@ static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 				mvpp2_prs_sram_ai_update(&pe, 0,
 							MVPP2_PRS_SRAM_AI_MASK);
 
+			/* Set result info bits to 'single vlan' */
+			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_SINGLE,
+						 MVPP2_PRS_RI_VLAN_MASK);
 			/* If packet is tagged continue check vid filtering */
 			mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
 		} else {
-- 
2.11.0
