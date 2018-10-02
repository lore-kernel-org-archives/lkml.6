Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDA6C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF5A206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF5A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeJBUOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbeJBUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:45 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 385DEBF0;
        Tue,  2 Oct 2018 13:31:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martyna Szapar <martyna.szapar@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 207/228] i40e: Fix for Tx timeouts when interface is brought up if DCB is enabled
Date:   Tue,  2 Oct 2018 06:25:04 -0700
Message-Id: <20181002132511.789312673@linuxfoundation.org>
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

From: Martyna Szapar <martyna.szapar@intel.com>

[ Upstream commit fa38e30ac73fbb01d7e5d0fd1b12d412fa3ac3ee ]

If interface is connected to switch port configured for DCB there are
TX timeouts when bringing up interface. Problem started appearing after
adding in i40e driver code mqprio hardware offload mode. In function
i40e_vsi_configure_bw_alloc was added resetting BW rate which should
be executing when mqprio qdisc is removed but was also when there was
no mqprio qdisc added and DCB was enabled. In this patch was added
additional check for DCB flag so now when DCB is enabled the correct
DCB configs from before mqprio patch are restored.

Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5121,15 +5121,17 @@ static int i40e_vsi_configure_bw_alloc(s
 				       u8 *bw_share)
 {
 	struct i40e_aqc_configure_vsi_tc_bw_data bw_data;
+	struct i40e_pf *pf = vsi->back;
 	i40e_status ret;
 	int i;
 
-	if (vsi->back->flags & I40E_FLAG_TC_MQPRIO)
+	/* There is no need to reset BW when mqprio mode is on.  */
+	if (pf->flags & I40E_FLAG_TC_MQPRIO)
 		return 0;
-	if (!vsi->mqprio_qopt.qopt.hw) {
+	if (!vsi->mqprio_qopt.qopt.hw && !(pf->flags & I40E_FLAG_DCB_ENABLED)) {
 		ret = i40e_set_bw_limit(vsi, vsi->seid, 0);
 		if (ret)
-			dev_info(&vsi->back->pdev->dev,
+			dev_info(&pf->pdev->dev,
 				 "Failed to reset tx rate for vsi->seid %u\n",
 				 vsi->seid);
 		return ret;
@@ -5138,12 +5140,11 @@ static int i40e_vsi_configure_bw_alloc(s
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++)
 		bw_data.tc_bw_credits[i] = bw_share[i];
 
-	ret = i40e_aq_config_vsi_tc_bw(&vsi->back->hw, vsi->seid, &bw_data,
-				       NULL);
+	ret = i40e_aq_config_vsi_tc_bw(&pf->hw, vsi->seid, &bw_data, NULL);
 	if (ret) {
-		dev_info(&vsi->back->pdev->dev,
+		dev_info(&pf->pdev->dev,
 			 "AQ command Config VSI BW allocation per TC failed = %d\n",
-			 vsi->back->hw.aq.asq_last_status);
+			 pf->hw.aq.asq_last_status);
 		return -EINVAL;
 	}
 


