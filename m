Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE10C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D375A2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D375A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeJBUOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbeJBUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:04 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16CD0C4E;
        Tue,  2 Oct 2018 13:30:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 195/228] ice: Fix multiple static analyser warnings
Date:   Tue,  2 Oct 2018 06:24:52 -0700
Message-Id: <20181002132511.190851690@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit 4381147df9098706caa5cf9fda37e53b2fe4871f ]

This patch fixes the following smatch errors:

1) Fix "odd binop '0x0 & 0xc'" when performing the bitwise-and with a
   constant value of zero (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG).
   Remove a similar bitwise-and with 0 in ice_add_marker_act() and use the
   right mask ICE_LG_ACT_GENERIC_OFFSET_M in the expression.

2) Fix a similar issue "odd binop '0x0 & 0x1800' in ice_req_irq_msix_misc.

3) Fix "odd binop '0x380000 & 0x7fff8'" in ice_add_marker_act(). Also, use
   a new define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX instead of magic
   number '7'.

4) Fix warn: odd binop '0x0 & 0x18' in ice_set_dflt_vsi_ctx() by removing
   unnecessary logic to explicitly unset bits 3 and 4 in port_vlan_bits.
   These bits are unset already by the memset on ctxt->info.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |    1 
 drivers/net/ethernet/intel/ice/ice_common.c     |   25 +++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_main.c       |   19 +++++++-----------
 drivers/net/ethernet/intel/ice/ice_switch.c     |    4 +--
 4 files changed, 25 insertions(+), 24 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -594,6 +594,7 @@ struct ice_sw_rule_lg_act {
 #define ICE_LG_ACT_GENERIC_OFFSET_M	(0x7 << ICE_LG_ACT_GENERIC_OFFSET_S)
 #define ICE_LG_ACT_GENERIC_PRIORITY_S	22
 #define ICE_LG_ACT_GENERIC_PRIORITY_M	(0x7 << ICE_LG_ACT_GENERIC_PRIORITY_S)
+#define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX	7
 
 	/* Action = 7 - Set Stat count */
 #define ICE_LG_ACT_STAT_COUNT		0x7
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1619,20 +1619,23 @@ __ice_aq_get_set_rss_lut(struct ice_hw *
 	}
 
 	/* LUT size is only valid for Global and PF table types */
-	if (lut_size == ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128) {
-		flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG <<
-			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-	} else if (lut_size == ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512) {
+	switch (lut_size) {
+	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128:
+		break;
+	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512:
 		flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_512_FLAG <<
 			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
 			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-	} else if ((lut_size == ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K) &&
-		   (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF)) {
-		flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG <<
-			  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
-			 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
-	} else {
+		break;
+	case ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K:
+		if (lut_type == ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF) {
+			flags |= (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K_FLAG <<
+				  ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_S) &
+				 ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_M;
+			break;
+		}
+		/* fall-through */
+	default:
 		status = ICE_ERR_PARAM;
 		goto ice_aq_get_set_rss_lut_exit;
 	}
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1352,14 +1352,13 @@ static void ice_set_dflt_vsi_ctx(struct
 	ctxt->info.sw_flags = ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 	/* Traffic from VSI can be sent to LAN */
 	ctxt->info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
-	/* Allow all packets untagged/tagged */
+	/* By default bits 3 and 4 in port_vlan_flags are 0's which results in
+	 * legacy behavior (show VLAN, DEI, and UP) in descriptor. Also, allow
+	 * all packets untagged/tagged.
+	 */
 	ctxt->info.port_vlan_flags = ((ICE_AQ_VSI_PVLAN_MODE_ALL &
 				       ICE_AQ_VSI_PVLAN_MODE_M) >>
 				      ICE_AQ_VSI_PVLAN_MODE_S);
-	/* Show VLAN/UP from packets in Rx descriptors */
-	ctxt->info.port_vlan_flags |= ((ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH &
-					ICE_AQ_VSI_PVLAN_EMOD_M) >>
-				       ICE_AQ_VSI_PVLAN_EMOD_S);
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |= ICE_UP_TABLE_TRANSLATE(0, 0);
 	table |= ICE_UP_TABLE_TRANSLATE(1, 1);
@@ -2058,15 +2057,13 @@ static int ice_req_irq_msix_misc(struct
 skip_req_irq:
 	ice_ena_misc_vector(pf);
 
-	val = (pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
-	      (ICE_RX_ITR & PFINT_OICR_CTL_ITR_INDX_M) |
-	      PFINT_OICR_CTL_CAUSE_ENA_M;
+	val = ((pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
+	       PFINT_OICR_CTL_CAUSE_ENA_M);
 	wr32(hw, PFINT_OICR_CTL, val);
 
 	/* This enables Admin queue Interrupt causes */
-	val = (pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
-	      (ICE_RX_ITR & PFINT_FW_CTL_ITR_INDX_M) |
-	      PFINT_FW_CTL_CAUSE_ENA_M;
+	val = ((pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
+	       PFINT_FW_CTL_CAUSE_ENA_M);
 	wr32(hw, PFINT_FW_CTL, val);
 
 	itr_gran = hw->itr_gran_200;
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -645,14 +645,14 @@ ice_add_marker_act(struct ice_hw *hw, st
 	act |= (1 << ICE_LG_ACT_GENERIC_VALUE_S) & ICE_LG_ACT_GENERIC_VALUE_M;
 	lg_act->pdata.lg_act.act[1] = cpu_to_le32(act);
 
-	act = (7 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
+	act = (ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX <<
+	       ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_OFFSET_M;
 
 	/* Third action Marker value */
 	act |= ICE_LG_ACT_GENERIC;
 	act |= (sw_marker << ICE_LG_ACT_GENERIC_VALUE_S) &
 		ICE_LG_ACT_GENERIC_VALUE_M;
 
-	act |= (0 << ICE_LG_ACT_GENERIC_OFFSET_S) & ICE_LG_ACT_GENERIC_VALUE_M;
 	lg_act->pdata.lg_act.act[2] = cpu_to_le32(act);
 
 	/* call the fill switch rule to fill the lookup tx rx structure */


