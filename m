Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbeCUT6B convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:58:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47612 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753058AbeCUT56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:57:58 -0400
From: Yan Markman <ymarkman@marvell.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "Stefan Chulski" <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [PATCH net-next v2] net: mvpp2: Don't use dynamic allocs for
 local variables
Thread-Topic: [PATCH net-next v2] net: mvpp2: Don't use dynamic allocs for
 local variables
Thread-Index: AQHTwSdYYs40xAXvGk+cdHBjOIB56aPbB5iw
Date: Wed, 21 Mar 2018 19:57:47 +0000
Message-ID: <b97e76e64d494912ae09efcc64d612ff@IL-EXCH01.marvell.com>
References: <20180321151400.6658-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20180321151400.6658-1-maxime.chevallier@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803210227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

Please check the TWO points:

1). The mvpp2_prs_flow_find() returns TID if found
    The TID=0 is valid FOUND value
    For Not-found use -ENOENT (just like your mvpp2_prs_vlan_find)

2). The original code always uses "mvpp2_prs_entry *pe" storage Zero-Allocated
   Please check the correctnes of new "mvpp2_prs_entry pe" without 
        memset(pe, 0, sizeof(pe));
   in all procedures where pe=kzalloc() has been replaced

Thanks
Yan Markman
Tel. 05-44732819


-----Original Message-----
From: Maxime Chevallier [mailto:maxime.chevallier@bootlin.com] 
Sent: Wednesday, March 21, 2018 5:14 PM
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Antoine Tenart <antoine.tenart@bootlin.com>; thomas.petazzoni@bootlin.com; gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Yan Markman <ymarkman@marvell.com>; mw@semihalf.com
Subject: [PATCH net-next v2] net: mvpp2: Don't use dynamic allocs for local variables

Some helper functions that search for given entries in the TCAM filter on PPv2 controller make use of dynamically alloced temporary variables, allocated with GFP_KERNEL. These functions can be called in atomic context, and dynamic alloc is not really needed in these cases anyways.

This commit gets rid of dynamic allocs and use stack allocation in the following functions, and where they're used :
 - mvpp2_prs_flow_find
 - mvpp2_prs_vlan_find
 - mvpp2_prs_double_vlan_find
 - mvpp2_prs_mac_da_range_find

For all these functions, instead of returning an temporary object representing the TCAM entry, we simply return the TCAM id that matches the requested entry.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Remove unnecessary brackets, following Antoine Tenart's review.

 drivers/net/ethernet/marvell/mvpp2.c | 289 +++++++++++++++--------------------
 1 file changed, 127 insertions(+), 162 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 9bd35f2291d6..28e33e139178 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -1913,16 +1913,11 @@ static void mvpp2_prs_sram_offset_set(struct mvpp2_prs_entry *pe,  }
 
 /* Find parser flow entry */
-static struct mvpp2_prs_entry *mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
+static int mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid;
 
-	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
-	if (!pe)
-		return NULL;
-	mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_FLOWS);
-
 	/* Go through the all entires with MVPP2_PRS_LU_FLOWS */
 	for (tid = MVPP2_PRS_TCAM_SRAM_SIZE - 1; tid >= 0; tid--) {
 		u8 bits;
@@ -1931,17 +1926,16 @@ static struct mvpp2_prs_entry *mvpp2_prs_flow_find(struct mvpp2 *priv, int flow)
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_FLOWS)
 			continue;
 
-		pe->index = tid;
-		mvpp2_prs_hw_read(priv, pe);
-		bits = mvpp2_prs_sram_ai_get(pe);
+		pe.index = tid;
+		mvpp2_prs_hw_read(priv, &pe);
+		bits = mvpp2_prs_sram_ai_get(&pe);
 
 		/* Sram store classification lookup ID in AI bits [5:0] */
 		if ((bits & MVPP2_PRS_FLOW_ID_MASK) == flow)
-			return pe;
+			return tid;
 	}
-	kfree(pe);
 
-	return NULL;
+	return -ENOENT;
 }
 
 /* Return first free tcam index, seeking from start to end */ @@ -2189,16 +2183,12 @@ static void mvpp2_prs_dsa_tag_ethertype_set(struct mvpp2 *priv, int port,  }
 
 /* Search for existing single/triple vlan entry */ -static struct mvpp2_prs_entry *mvpp2_prs_vlan_find(struct mvpp2 *priv,
-						   unsigned short tpid, int ai)
+static int mvpp2_prs_vlan_find(struct mvpp2 *priv, unsigned short tpid, 
+int ai)
 {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid;
 
-	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
-	if (!pe)
-		return NULL;
-	mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_VLAN);
+	memset(&pe, 0, sizeof(pe));
 
 	/* Go through the all entries with MVPP2_PRS_LU_VLAN */
 	for (tid = MVPP2_PE_FIRST_FREE_TID;
@@ -2210,19 +2200,19 @@ static struct mvpp2_prs_entry *mvpp2_prs_vlan_find(struct mvpp2 *priv,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		pe->index = tid;
+		pe.index = tid;
 
-		mvpp2_prs_hw_read(priv, pe);
-		match = mvpp2_prs_tcam_data_cmp(pe, 0, swab16(tpid));
+		mvpp2_prs_hw_read(priv, &pe);
+		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid));
 		if (!match)
 			continue;
 
 		/* Get vlan type */
-		ri_bits = mvpp2_prs_sram_ri_get(pe);
+		ri_bits = mvpp2_prs_sram_ri_get(&pe);
 		ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 
 		/* Get current ai value from tcam */
-		ai_bits = mvpp2_prs_tcam_ai_get(pe);
+		ai_bits = mvpp2_prs_tcam_ai_get(&pe);
 		/* Clear double vlan bit */
 		ai_bits &= ~MVPP2_PRS_DBL_VLAN_AI_BIT;
 
@@ -2231,33 +2221,30 @@ static struct mvpp2_prs_entry *mvpp2_prs_vlan_find(struct mvpp2 *priv,
 
 		if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
 		    ri_bits == MVPP2_PRS_RI_VLAN_TRIPLE)
-			return pe;
+			return tid;
 	}
-	kfree(pe);
 
-	return NULL;
+	return -ENOENT;
 }
 
 /* Add/update single/triple vlan entry */  static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			      unsigned int port_map)
 {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid_aux, tid;
 	int ret = 0;
 
-	pe = mvpp2_prs_vlan_find(priv, tpid, ai);
+	tid = mvpp2_prs_vlan_find(priv, tpid, ai);
 
-	if (!pe) {
+	if (tid < 0) {
 		/* Create new tcam entry */
 		tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_LAST_FREE_TID,
 						MVPP2_PE_FIRST_FREE_TID);
 		if (tid < 0)
 			return tid;
 
-		pe = kzalloc(sizeof(*pe), GFP_KERNEL);
-		if (!pe)
-			return -ENOMEM;
+		memset(&pe, 0, sizeof(pe));
 
 		/* Get last double vlan tid */
 		for (tid_aux = MVPP2_PE_LAST_FREE_TID; @@ -2268,49 +2255,47 @@ static int mvpp2_prs_vlan_add(struct mvpp2 *priv, unsigned short tpid, int ai,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			pe->index = tid_aux;
-			mvpp2_prs_hw_read(priv, pe);
-			ri_bits = mvpp2_prs_sram_ri_get(pe);
+			pe.index = tid_aux;
+			mvpp2_prs_hw_read(priv, &pe);
+			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			if ((ri_bits & MVPP2_PRS_RI_VLAN_MASK) ==
 			    MVPP2_PRS_RI_VLAN_DOUBLE)
 				break;
 		}
 
-		if (tid <= tid_aux) {
-			ret = -EINVAL;
-			goto free_pe;
-		}
+		if (tid <= tid_aux)
+			return -EINVAL;
 
-		memset(pe, 0, sizeof(*pe));
-		mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_VLAN);
-		pe->index = tid;
+		memset(&pe, 0, sizeof(pe));
+		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
+		pe.index = tid;
 
-		mvpp2_prs_match_etype(pe, 0, tpid);
+		mvpp2_prs_match_etype(&pe, 0, tpid);
 
 		/* VLAN tag detected, proceed with VID filtering */
-		mvpp2_prs_sram_next_lu_set(pe, MVPP2_PRS_LU_VID);
+		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VID);
 
 		/* Clear all ai bits for next iteration */
-		mvpp2_prs_sram_ai_update(pe, 0, MVPP2_PRS_SRAM_AI_MASK);
+		mvpp2_prs_sram_ai_update(&pe, 0, MVPP2_PRS_SRAM_AI_MASK);
 
 		if (ai == MVPP2_PRS_SINGLE_VLAN_AI) {
-			mvpp2_prs_sram_ri_update(pe, MVPP2_PRS_RI_VLAN_SINGLE,
+			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_SINGLE,
 						 MVPP2_PRS_RI_VLAN_MASK);
 		} else {
 			ai |= MVPP2_PRS_DBL_VLAN_AI_BIT;
-			mvpp2_prs_sram_ri_update(pe, MVPP2_PRS_RI_VLAN_TRIPLE,
+			mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_TRIPLE,
 						 MVPP2_PRS_RI_VLAN_MASK);
 		}
-		mvpp2_prs_tcam_ai_update(pe, ai, MVPP2_PRS_SRAM_AI_MASK);
+		mvpp2_prs_tcam_ai_update(&pe, ai, MVPP2_PRS_SRAM_AI_MASK);
 
-		mvpp2_prs_shadow_set(priv, pe->index, MVPP2_PRS_LU_VLAN);
+		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
+	} else {
+		mvpp2_prs_hw_read(priv, &pe);
 	}
 	/* Update ports' mask */
-	mvpp2_prs_tcam_port_map_set(pe, port_map);
+	mvpp2_prs_tcam_port_map_set(&pe, port_map);
 
-	mvpp2_prs_hw_write(priv, pe);
-free_pe:
-	kfree(pe);
+	mvpp2_prs_hw_write(priv, &pe);
 
 	return ret;
 }
@@ -2329,17 +2314,14 @@ static int mvpp2_prs_double_vlan_ai_free_get(struct mvpp2 *priv)  }
 
 /* Search for existing double vlan entry */ -static struct mvpp2_prs_entry *mvpp2_prs_double_vlan_find(struct mvpp2 *priv,
-							  unsigned short tpid1,
-							  unsigned short tpid2)
+static int mvpp2_prs_double_vlan_find(struct mvpp2 *priv, unsigned short tpid1,
+				      unsigned short tpid2)
 {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid;
 
-	pe = kzalloc(sizeof(*pe), GFP_KERNEL);
-	if (!pe)
-		return NULL;
-	mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_VLAN);
+	memset(&pe, 0, sizeof(pe));
+	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
 
 	/* Go through the all entries with MVPP2_PRS_LU_VLAN */
 	for (tid = MVPP2_PE_FIRST_FREE_TID;
@@ -2351,22 +2333,21 @@ static struct mvpp2_prs_entry *mvpp2_prs_double_vlan_find(struct mvpp2 *priv,
 		    priv->prs_shadow[tid].lu != MVPP2_PRS_LU_VLAN)
 			continue;
 
-		pe->index = tid;
-		mvpp2_prs_hw_read(priv, pe);
+		pe.index = tid;
+		mvpp2_prs_hw_read(priv, &pe);
 
-		match = mvpp2_prs_tcam_data_cmp(pe, 0, swab16(tpid1))
-			&& mvpp2_prs_tcam_data_cmp(pe, 4, swab16(tpid2));
+		match = mvpp2_prs_tcam_data_cmp(&pe, 0, swab16(tpid1)) &&
+			mvpp2_prs_tcam_data_cmp(&pe, 4, swab16(tpid2));
 
 		if (!match)
 			continue;
 
-		ri_mask = mvpp2_prs_sram_ri_get(pe) & MVPP2_PRS_RI_VLAN_MASK;
+		ri_mask = mvpp2_prs_sram_ri_get(&pe) & MVPP2_PRS_RI_VLAN_MASK;
 		if (ri_mask == MVPP2_PRS_RI_VLAN_DOUBLE)
-			return pe;
+			return tid;
 	}
-	kfree(pe);
 
-	return NULL;
+	return -ENOENT;
 }
 
 /* Add or update double vlan entry */
@@ -2374,28 +2355,24 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 				     unsigned short tpid2,
 				     unsigned int port_map)
 {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid_aux, tid, ai, ret = 0;
 
-	pe = mvpp2_prs_double_vlan_find(priv, tpid1, tpid2);
+	tid = mvpp2_prs_double_vlan_find(priv, tpid1, tpid2);
 
-	if (!pe) {
+	if (tid < 0) {
 		/* Create new tcam entry */
 		tid = mvpp2_prs_tcam_first_free(priv, MVPP2_PE_FIRST_FREE_TID,
 				MVPP2_PE_LAST_FREE_TID);
 		if (tid < 0)
 			return tid;
 
-		pe = kzalloc(sizeof(*pe), GFP_KERNEL);
-		if (!pe)
-			return -ENOMEM;
+		memset(&pe, 0, sizeof(pe));
 
 		/* Set ai value for new double vlan entry */
 		ai = mvpp2_prs_double_vlan_ai_free_get(priv);
-		if (ai < 0) {
-			ret = ai;
-			goto free_pe;
-		}
+		if (ai < 0)
+			return ai;
 
 		/* Get first single/triple vlan tid */
 		for (tid_aux = MVPP2_PE_FIRST_FREE_TID; @@ -2406,46 +2383,45 @@ static int mvpp2_prs_double_vlan_add(struct mvpp2 *priv, unsigned short tpid1,
 			    priv->prs_shadow[tid_aux].lu != MVPP2_PRS_LU_VLAN)
 				continue;
 
-			pe->index = tid_aux;
-			mvpp2_prs_hw_read(priv, pe);
-			ri_bits = mvpp2_prs_sram_ri_get(pe);
+			pe.index = tid_aux;
+			mvpp2_prs_hw_read(priv, &pe);
+			ri_bits = mvpp2_prs_sram_ri_get(&pe);
 			ri_bits &= MVPP2_PRS_RI_VLAN_MASK;
 			if (ri_bits == MVPP2_PRS_RI_VLAN_SINGLE ||
 			    ri_bits == MVPP2_PRS_RI_VLAN_TRIPLE)
 				break;
 		}
 
-		if (tid >= tid_aux) {
-			ret = -ERANGE;
-			goto free_pe;
-		}
+		if (tid >= tid_aux)
+			return -ERANGE;
 
-		memset(pe, 0, sizeof(*pe));
-		mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_VLAN);
-		pe->index = tid;
+		memset(&pe, 0, sizeof(pe));
+		mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_VLAN);
+		pe.index = tid;
 
 		priv->prs_double_vlans[ai] = true;
 
-		mvpp2_prs_match_etype(pe, 0, tpid1);
-		mvpp2_prs_match_etype(pe, 4, tpid2);
+		mvpp2_prs_match_etype(&pe, 0, tpid1);
+		mvpp2_prs_match_etype(&pe, 4, tpid2);
 
-		mvpp2_prs_sram_next_lu_set(pe, MVPP2_PRS_LU_VLAN);
+		mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_VLAN);
 		/* Shift 4 bytes - skip outer vlan tag */
-		mvpp2_prs_sram_shift_set(pe, MVPP2_VLAN_TAG_LEN,
+		mvpp2_prs_sram_shift_set(&pe, MVPP2_VLAN_TAG_LEN,
 					 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
-		mvpp2_prs_sram_ri_update(pe, MVPP2_PRS_RI_VLAN_DOUBLE,
+		mvpp2_prs_sram_ri_update(&pe, MVPP2_PRS_RI_VLAN_DOUBLE,
 					 MVPP2_PRS_RI_VLAN_MASK);
-		mvpp2_prs_sram_ai_update(pe, ai | MVPP2_PRS_DBL_VLAN_AI_BIT,
+		mvpp2_prs_sram_ai_update(&pe, ai | MVPP2_PRS_DBL_VLAN_AI_BIT,
 					 MVPP2_PRS_SRAM_AI_MASK);
 
-		mvpp2_prs_shadow_set(priv, pe->index, MVPP2_PRS_LU_VLAN);
+		mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_VLAN);
+	} else {
+		mvpp2_prs_hw_read(priv, &pe);
 	}
 
 	/* Update ports' mask */
-	mvpp2_prs_tcam_port_map_set(pe, port_map);
-	mvpp2_prs_hw_write(priv, pe);
-free_pe:
-	kfree(pe);
+	mvpp2_prs_tcam_port_map_set(&pe, port_map);
+	mvpp2_prs_hw_write(priv, &pe);
+
 	return ret;
 }
 
@@ -3528,7 +3504,7 @@ static int mvpp2_prs_vid_range_find(struct mvpp2 *priv, int pmap, u16 vid,
 		return tid;
 	}
 
-	return 0;
+	return -ENOENT;
 }
 
 /* Write parser entry for VID filtering */ @@ -3551,7 +3527,7 @@ static int mvpp2_prs_vid_entry_add(struct mvpp2_port *port, u16 vid)
 		shift = MVPP2_VLAN_TAG_LEN;
 
 	/* No such entry */
-	if (!tid) {
+	if (tid < 0) {
 		memset(&pe, 0, sizeof(pe));
 
 		/* Go through all entries from first to last in vlan range */ @@ -3604,7 +3580,7 @@ static void mvpp2_prs_vid_entry_remove(struct mvpp2_port *port, u16 vid)
 	tid = mvpp2_prs_vid_range_find(priv, (1 << port->id), vid, 0xfff);
 
 	/* No such entry */
-	if (tid)
+	if (tid < 0)
 		return;
 
 	mvpp2_prs_hw_inv(priv, tid);
@@ -3771,18 +3747,13 @@ static bool mvpp2_prs_mac_range_equals(struct mvpp2_prs_entry *pe,  }
 
 /* Find tcam entry with matched pair <MAC DA, port> */ -static struct mvpp2_prs_entry *
+static int
 mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 			    unsigned char *mask, int udf_type)  {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid;
 
-	pe = kzalloc(sizeof(*pe), GFP_ATOMIC);
-	if (!pe)
-		return NULL;
-	mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_MAC);
-
 	/* Go through the all entires with MVPP2_PRS_LU_MAC */
 	for (tid = MVPP2_PE_MAC_RANGE_START;
 	     tid <= MVPP2_PE_MAC_RANGE_END; tid++) { @@ -3793,17 +3764,16 @@ mvpp2_prs_mac_da_range_find(struct mvpp2 *priv, int pmap, const u8 *da,
 		    (priv->prs_shadow[tid].udf != udf_type))
 			continue;
 
-		pe->index = tid;
-		mvpp2_prs_hw_read(priv, pe);
-		entry_pmap = mvpp2_prs_tcam_port_map_get(pe);
+		pe.index = tid;
+		mvpp2_prs_hw_read(priv, &pe);
+		entry_pmap = mvpp2_prs_tcam_port_map_get(&pe);
 
-		if (mvpp2_prs_mac_range_equals(pe, da, mask) &&
+		if (mvpp2_prs_mac_range_equals(&pe, da, mask) &&
 		    entry_pmap == pmap)
-			return pe;
+			return tid;
 	}
-	kfree(pe);
 
-	return NULL;
+	return -ENOENT;
 }
 
 /* Update parser's mac da entry */
@@ -3813,15 +3783,15 @@ static int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da,
 	unsigned char mask[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	struct mvpp2 *priv = port->priv;
 	unsigned int pmap, len, ri;
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid;
 
 	/* Scan TCAM and see if entry with this <MAC DA, port> already exist */
-	pe = mvpp2_prs_mac_da_range_find(priv, BIT(port->id), da, mask,
-					 MVPP2_PRS_UDF_MAC_DEF);
+	tid = mvpp2_prs_mac_da_range_find(priv, BIT(port->id), da, mask,
+					  MVPP2_PRS_UDF_MAC_DEF);
 
 	/* No such entry */
-	if (!pe) {
+	if (tid < 0) {
 		if (!add)
 			return 0;
 
@@ -3833,39 +3803,39 @@ static int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da,
 		if (tid < 0)
 			return tid;
 
-		pe = kzalloc(sizeof(*pe), GFP_ATOMIC);
-		if (!pe)
-			return -ENOMEM;
-		mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_MAC);
-		pe->index = tid;
+		memset(&pe, 0, sizeof(pe));
+
+		pe.index = tid;
 
 		/* Mask all ports */
-		mvpp2_prs_tcam_port_map_set(pe, 0);
+		mvpp2_prs_tcam_port_map_set(&pe, 0);
+	} else {
+		mvpp2_prs_hw_read(priv, &pe);
 	}
 
+	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_MAC);
+
 	/* Update port mask */
-	mvpp2_prs_tcam_port_set(pe, port->id, add);
+	mvpp2_prs_tcam_port_set(&pe, port->id, add);
 
 	/* Invalidate the entry if no ports are left enabled */
-	pmap = mvpp2_prs_tcam_port_map_get(pe);
+	pmap = mvpp2_prs_tcam_port_map_get(&pe);
 	if (pmap == 0) {
-		if (add) {
-			kfree(pe);
+		if (add)
 			return -EINVAL;
-		}
-		mvpp2_prs_hw_inv(priv, pe->index);
-		priv->prs_shadow[pe->index].valid = false;
-		kfree(pe);
+
+		mvpp2_prs_hw_inv(priv, pe.index);
+		priv->prs_shadow[pe.index].valid = false;
 		return 0;
 	}
 
 	/* Continue - set next lookup */
-	mvpp2_prs_sram_next_lu_set(pe, MVPP2_PRS_LU_DSA);
+	mvpp2_prs_sram_next_lu_set(&pe, MVPP2_PRS_LU_DSA);
 
 	/* Set match on DA */
 	len = ETH_ALEN;
 	while (len--)
-		mvpp2_prs_tcam_data_byte_set(pe, len, da[len], 0xff);
+		mvpp2_prs_tcam_data_byte_set(&pe, len, da[len], 0xff);
 
 	/* Set result info bits */
 	if (is_broadcast_ether_addr(da)) {
@@ -3879,21 +3849,19 @@ static int mvpp2_prs_mac_da_accept(struct mvpp2_port *port, const u8 *da,
 			ri |= MVPP2_PRS_RI_MAC_ME_MASK;
 	}
 
-	mvpp2_prs_sram_ri_update(pe, ri, MVPP2_PRS_RI_L2_CAST_MASK |
+	mvpp2_prs_sram_ri_update(&pe, ri, MVPP2_PRS_RI_L2_CAST_MASK |
 				 MVPP2_PRS_RI_MAC_ME_MASK);
-	mvpp2_prs_shadow_ri_set(priv, pe->index, ri, MVPP2_PRS_RI_L2_CAST_MASK |
+	mvpp2_prs_shadow_ri_set(priv, pe.index, ri, MVPP2_PRS_RI_L2_CAST_MASK 
+|
 				MVPP2_PRS_RI_MAC_ME_MASK);
 
 	/* Shift to ethertype */
-	mvpp2_prs_sram_shift_set(pe, 2 * ETH_ALEN,
+	mvpp2_prs_sram_shift_set(&pe, 2 * ETH_ALEN,
 				 MVPP2_PRS_SRAM_OP_SEL_SHIFT_ADD);
 
 	/* Update shadow table and hw entry */
-	priv->prs_shadow[pe->index].udf = MVPP2_PRS_UDF_MAC_DEF;
-	mvpp2_prs_shadow_set(priv, pe->index, MVPP2_PRS_LU_MAC);
-	mvpp2_prs_hw_write(priv, pe);
-
-	kfree(pe);
+	priv->prs_shadow[pe.index].udf = MVPP2_PRS_UDF_MAC_DEF;
+	mvpp2_prs_shadow_set(priv, pe.index, MVPP2_PRS_LU_MAC);
+	mvpp2_prs_hw_write(priv, &pe);
 
 	return 0;
 }
@@ -4014,13 +3982,13 @@ static int mvpp2_prs_tag_mode_set(struct mvpp2 *priv, int port, int type)
 /* Set prs flow for the port */
 static int mvpp2_prs_def_flow(struct mvpp2_port *port)  {
-	struct mvpp2_prs_entry *pe;
+	struct mvpp2_prs_entry pe;
 	int tid;
 
-	pe = mvpp2_prs_flow_find(port->priv, port->id);
+	tid = mvpp2_prs_flow_find(port->priv, port->id);
 
 	/* Such entry not exist */
-	if (!pe) {
+	if (tid < 0) {
 		/* Go through the all entires from last to first */
 		tid = mvpp2_prs_tcam_first_free(port->priv,
 						MVPP2_PE_LAST_FREE_TID,
@@ -4028,24 +3996,21 @@ static int mvpp2_prs_def_flow(struct mvpp2_port *port)
 		if (tid < 0)
 			return tid;
 
-		pe = kzalloc(sizeof(*pe), GFP_KERNEL);
-		if (!pe)
-			return -ENOMEM;
-
-		mvpp2_prs_tcam_lu_set(pe, MVPP2_PRS_LU_FLOWS);
-		pe->index = tid;
+		pe.index = tid;
 
 		/* Set flow ID*/
-		mvpp2_prs_sram_ai_update(pe, port->id, MVPP2_PRS_FLOW_ID_MASK);
-		mvpp2_prs_sram_bits_set(pe, MVPP2_PRS_SRAM_LU_DONE_BIT, 1);
+		mvpp2_prs_sram_ai_update(&pe, port->id, MVPP2_PRS_FLOW_ID_MASK);
+		mvpp2_prs_sram_bits_set(&pe, MVPP2_PRS_SRAM_LU_DONE_BIT, 1);
 
 		/* Update shadow table */
-		mvpp2_prs_shadow_set(port->priv, pe->index, MVPP2_PRS_LU_FLOWS);
+		mvpp2_prs_shadow_set(port->priv, pe.index, MVPP2_PRS_LU_FLOWS);
+	} else {
+		mvpp2_prs_hw_read(port->priv, &pe);
 	}
 
-	mvpp2_prs_tcam_port_map_set(pe, (1 << port->id));
-	mvpp2_prs_hw_write(port->priv, pe);
-	kfree(pe);
+	mvpp2_prs_tcam_lu_set(&pe, MVPP2_PRS_LU_FLOWS);
+	mvpp2_prs_tcam_port_map_set(&pe, (1 << port->id));
+	mvpp2_prs_hw_write(port->priv, &pe);
 
 	return 0;
 }
--
2.11.0
