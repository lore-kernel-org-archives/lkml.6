Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A7FC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621502083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621502083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbeJBUOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33738 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeJBUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:09 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A900C2A;
        Tue,  2 Oct 2018 13:30:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brett Creeley <brett.creeley@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 200/228] ice: Set VLAN flags correctly
Date:   Tue,  2 Oct 2018 06:24:57 -0700
Message-Id: <20181002132511.414259822@linuxfoundation.org>
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

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit 5d8778d803e21f235e9bc727b5bd619f02abb88b ]

In the struct ice_aqc_vsi_props the field port_vlan_flags is an
overloaded term because it is used for both port VLANs (PVLANs) and
regular VLANs. This is an issue and is very confusing especially when
dealing with VFs because normal VLANs and port VLANs are not the same.
To fix this the field was renamed to vlan_flags and all of the #define's
labeled *_PVLAN_* were renamed to *_VLAN_* if they are not specific to
port VLANs.

Also in ice_vsi_manage_vlan_stripping, set the ICE_AQ_VSI_VLAN_MODE_ALL
bit to allow the driver to add a VLAN tag to all packets it sends.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   24 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_main.c       |   31 +++++++++++++-----------
 2 files changed, 30 insertions(+), 25 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -329,19 +329,19 @@ struct ice_aqc_vsi_props {
 	/* VLAN section */
 	__le16 pvid; /* VLANS include priority bits */
 	u8 pvlan_reserved[2];
-	u8 port_vlan_flags;
-#define ICE_AQ_VSI_PVLAN_MODE_S	0
-#define ICE_AQ_VSI_PVLAN_MODE_M	(0x3 << ICE_AQ_VSI_PVLAN_MODE_S)
-#define ICE_AQ_VSI_PVLAN_MODE_UNTAGGED	0x1
-#define ICE_AQ_VSI_PVLAN_MODE_TAGGED	0x2
-#define ICE_AQ_VSI_PVLAN_MODE_ALL	0x3
+	u8 vlan_flags;
+#define ICE_AQ_VSI_VLAN_MODE_S	0
+#define ICE_AQ_VSI_VLAN_MODE_M	(0x3 << ICE_AQ_VSI_VLAN_MODE_S)
+#define ICE_AQ_VSI_VLAN_MODE_UNTAGGED	0x1
+#define ICE_AQ_VSI_VLAN_MODE_TAGGED	0x2
+#define ICE_AQ_VSI_VLAN_MODE_ALL	0x3
 #define ICE_AQ_VSI_PVLAN_INSERT_PVID	BIT(2)
-#define ICE_AQ_VSI_PVLAN_EMOD_S	3
-#define ICE_AQ_VSI_PVLAN_EMOD_M	(0x3 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH	(0x0 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_STR_UP	(0x1 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_STR	(0x2 << ICE_AQ_VSI_PVLAN_EMOD_S)
-#define ICE_AQ_VSI_PVLAN_EMOD_NOTHING	(0x3 << ICE_AQ_VSI_PVLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_S		3
+#define ICE_AQ_VSI_VLAN_EMOD_M		(0x3 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_STR_BOTH	(0x0 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_STR_UP	(0x1 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_STR	(0x2 << ICE_AQ_VSI_VLAN_EMOD_S)
+#define ICE_AQ_VSI_VLAN_EMOD_NOTHING	(0x3 << ICE_AQ_VSI_VLAN_EMOD_S)
 	u8 pvlan_reserved2[3];
 	/* ingress egress up sections */
 	__le32 ingress_table; /* bitmap, 3 bits per up */
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1367,13 +1367,15 @@ static void ice_set_dflt_vsi_ctx(struct
 	ctxt->info.sw_flags = ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
 	/* Traffic from VSI can be sent to LAN */
 	ctxt->info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
-	/* By default bits 3 and 4 in port_vlan_flags are 0's which results in
-	 * legacy behavior (show VLAN, DEI, and UP) in descriptor. Also, allow
-	 * all packets untagged/tagged.
+
+	/* By default bits 3 and 4 in vlan_flags are 0's which results in legacy
+	 * behavior (show VLAN, DEI, and UP) in descriptor. Also, allow all
+	 * packets untagged/tagged.
 	 */
-	ctxt->info.port_vlan_flags = ((ICE_AQ_VSI_PVLAN_MODE_ALL &
-				       ICE_AQ_VSI_PVLAN_MODE_M) >>
-				      ICE_AQ_VSI_PVLAN_MODE_S);
+	ctxt->info.vlan_flags = ((ICE_AQ_VSI_VLAN_MODE_ALL &
+				  ICE_AQ_VSI_VLAN_MODE_M) >>
+				 ICE_AQ_VSI_VLAN_MODE_S);
+
 	/* Have 1:1 UP mapping for both ingress/egress tables */
 	table |= ICE_UP_TABLE_TRANSLATE(0, 0);
 	table |= ICE_UP_TABLE_TRANSLATE(1, 1);
@@ -3732,10 +3734,10 @@ static int ice_vsi_manage_vlan_insertion
 	enum ice_status status;
 
 	/* Here we are configuring the VSI to let the driver add VLAN tags by
-	 * setting port_vlan_flags to ICE_AQ_VSI_PVLAN_MODE_ALL. The actual VLAN
-	 * tag insertion happens in the Tx hot path, in ice_tx_map.
+	 * setting vlan_flags to ICE_AQ_VSI_VLAN_MODE_ALL. The actual VLAN tag
+	 * insertion happens in the Tx hot path, in ice_tx_map.
 	 */
-	ctxt.info.port_vlan_flags = ICE_AQ_VSI_PVLAN_MODE_ALL;
+	ctxt.info.vlan_flags = ICE_AQ_VSI_VLAN_MODE_ALL;
 
 	ctxt.info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 	ctxt.vsi_num = vsi->vsi_num;
@@ -3747,7 +3749,7 @@ static int ice_vsi_manage_vlan_insertion
 		return -EIO;
 	}
 
-	vsi->info.port_vlan_flags = ctxt.info.port_vlan_flags;
+	vsi->info.vlan_flags = ctxt.info.vlan_flags;
 	return 0;
 }
 
@@ -3769,12 +3771,15 @@ static int ice_vsi_manage_vlan_stripping
 	 */
 	if (ena) {
 		/* Strip VLAN tag from Rx packet and put it in the desc */
-		ctxt.info.port_vlan_flags = ICE_AQ_VSI_PVLAN_EMOD_STR_BOTH;
+		ctxt.info.vlan_flags = ICE_AQ_VSI_VLAN_EMOD_STR_BOTH;
 	} else {
 		/* Disable stripping. Leave tag in packet */
-		ctxt.info.port_vlan_flags = ICE_AQ_VSI_PVLAN_EMOD_NOTHING;
+		ctxt.info.vlan_flags = ICE_AQ_VSI_VLAN_EMOD_NOTHING;
 	}
 
+	/* Allow all packets untagged/tagged */
+	ctxt.info.vlan_flags |= ICE_AQ_VSI_VLAN_MODE_ALL;
+
 	ctxt.info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_VLAN_VALID);
 	ctxt.vsi_num = vsi->vsi_num;
 
@@ -3785,7 +3790,7 @@ static int ice_vsi_manage_vlan_stripping
 		return -EIO;
 	}
 
-	vsi->info.port_vlan_flags = ctxt.info.port_vlan_flags;
+	vsi->info.vlan_flags = ctxt.info.vlan_flags;
 	return 0;
 }
 


