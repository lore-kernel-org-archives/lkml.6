Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeCZNet (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:34:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44054 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbeCZNen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:34:43 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 1/2] net: mvpp2: Make mvpp2_prs_hw_read a parser entry init function
Date: Mon, 26 Mar 2018 15:34:22 +0200
Message-Id: <20180326133423.14779-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180326133423.14779-1-maxime.chevallier@bootlin.com>
References: <20180326133423.14779-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mvpp2_prs_hw_read function uses the 'index' field of the struct
mvpp2_prs_entry to initialize the rest of the fields. This makes it
unclear from a caller's perspective, who needs to manipulate a struct
that is not entirely initialized.

This commit makes it an init function for prs_entry, by passing it the
index as a parameter. The function now zeroes the entry, and sets the
index field before doing all other init from HW.

The function is renamed 'mvpp2_prs_init_from_hw' to make that clear.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 48 ++++++++++++++----------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index f8bc3d4a39ff..f51dcb3b09d7 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -1582,14 +1582,18 @@ static int mvpp2_prs_hw_write(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
 	return 0;
 }
 
-/* Read tcam entry from hw */
-static int mvpp2_prs_hw_read(struct mvpp2 *priv, struct mvpp2_prs_entry *pe)
+/* Initialize tcam entry from hw */
+static int mvpp2_prs_init_from_hw(struct mvpp2 *priv,
+				  struct mvpp2_prs_entry *pe, int tid)
 {
 	int i;
 
 	if (pe->index > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
 		return -EINVAL;
 
+	memset(pe, 0, sizeof(*pe));
+	pe->index = tid;
+
 	/* Write tcam index - indirect access */
 	mvpp2_write(priv, MVPP2_PRS_TCAM_IDX_REG, pe->index);
 
@@ -1931,8 +1935,7 @@ static struct mvpp2_prs_entry *mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
 			continue;
 
-		pe->index = tid;
-		mvpp2_prs_hw_read(priv, pe);
+		mvpp2_prs_init_from_hw(priv, pe, tid);
 		bits = mvpp2_prs_sram_ai_get(pe);
 
 		/* Sram store classification lookup ID in AI bits [5:0] */
@@ -1971,8 +1974,7 @@ static void mvpp2_prs_mac_drop_all_set(struct mvpp2 *priv, int port, bool add)
 
 	if (priv->prs_shadow[MVPP2_PE_DROP_ALL].valid) {
 		/* Entry exist - update port only */
-		pe.index = MVPP2_PE_DROP_ALL;
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, MVPP2_PE_DROP_ALL);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -2020,8 +2022,7 @@ static void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
 
 	/* promiscuous mode - Accept unknown unicast or multicast packets */
 	if (priv->prs_shadow[tid].valid) {
-		pe.index = tid;
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
 	} else {
 		memset(&pe, 0, sizeof(pe));
 		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
@@ -2071,8 +2072,7 @@ static void mvpp2_prs_dsa_tag_set(struct mvpp2 *priv, int port, bool add,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		pe.index = tid;
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -2140,8 +2140,7 @@ static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,
 
 	if (priv->prs_shadow[tid].valid) {
 		/* Entry exist - update port only */
-		pe.index = tid;
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
 	} else {
 		/* Entry doesn't exist - create new */
 		memset(&pe, 0, sizeof(pe));
@@ -2210,9 +2209,7 @@ static struct mvpp2_prs_entry *mvpp2_prs_vlan_find(struct mvpp2 *priv,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		pe->index = tid;
-
-		mvpp2_prs_hw_read(priv, pe);
+		mvpp2_prs_init_from_hw(priv, pe, tid);
 		match = mvpp2_prs_tcam_data_cmp(pe, 0, swab16(tpid));
 		if (!match)
 			continue;
@@ -2268,8 +2265,7 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			pe->index = tid_aux;
-			mvpp2_prs_hw_read(priv, pe);
+			mvpp2_prs_init_from_hw(priv, pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(pe);
 			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
 			    MVPP2_PRS_RI_VLAN_DOUBLE)
@@ -2351,8 +2347,7 @@ static struct mvpp2_prs_entry *mvpp2_prs_double_vlan_find(struct mvpp2 *priv,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		pe->index = tid;
-		mvpp2_prs_hw_read(priv, pe);
+		mvpp2_prs_init_from_hw(priv, pe, tid);
 
 		match = mvpp2_prs_tcam_data_cmp(pe, 0, swab16(tpid1))
 			&& mvpp2_prs_tcam_data_cmp(pe, 4, swab16(tpid2));
@@ -2406,8 +2401,7 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			pe->index = tid_aux;
-			mvpp2_prs_hw_read(priv, pe);
+			mvpp2_prs_init_from_hw(priv, pe, tid_aux);
 			ri_bits = mvpp2_prs_sram_ri_get(pe);
 			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
@@ -3513,9 +3507,7 @@ static int mvpp2_prs_vid_range_find(struct mvpp2 *priv, int pmap, u16 vid,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VID)
 			continue;
 
-		pe.index = tid;
-
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
 		mvpp2_prs_tcam_data_byte_get(&pe, 2, &byte[0], &enable[0]);
 		mvpp2_prs_tcam_data_byte_get(&pe, 3, &byte[1], &enable[1]);
 
@@ -3569,7 +3561,7 @@ static int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 		/* Mask all ports */
 		mvpp2_prs_tcam_port_map_set(&pe, 0);
 	} else {
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
 	}
 
 	/* Enable the current port */
@@ -3793,8 +3785,7 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 		    (priv->prs_shadow[tid].udf != udf_type))
 			continue;
 
-		pe->index = tid;
-		mvpp2_prs_hw_read(priv, pe);
+		mvpp2_prs_init_from_hw(priv, pe, tid);
 		entry_pmap = mvpp2_prs_tcam_port_map_get(pe);
 
 		if (mvpp2_prs_mac_range_equals(pe, da, mask) &&
@@ -3935,8 +3926,7 @@ static void mvpp2_prs_mac_del_all(struct mvpp2_port *port)
 		    (priv->prs_shadow[tid].udf != MVPP2_PRS_UDF_MAC_DEF))
 			continue;
 
-		pe.index = tid;
-		mvpp2_prs_hw_read(priv, &pe);
+		mvpp2_prs_init_from_hw(priv, &pe, tid);
 
 		pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
-- 
2.11.0
