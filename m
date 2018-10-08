Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6394C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C55E20644
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+ZyFAVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C55E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeJHWsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeJHWiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC759214DA;
        Mon,  8 Oct 2018 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012360;
        bh=wLeI+vNwtQr21xsh6IHMSSObsGV/0aq84JZuclNUEQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+ZyFAVvy5K8tymbytRHUconrX/vGckLBoo8m8zNBx40CvQhNRyZ2dx4JPR4Hw9ZX
         2qNJSJRH//rr/Ni4/3j1Dt1YVRXrMvJZZi2qS4PKCSBPOme/Rs1xyCDDquKaoDjIJe
         VS5v1EKDGPVVAYNbvpxyu6WH1ztmBi23pbh4Wn0U=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 35/58] qed: Do not add VLAN 0 tag to untagged frames in multi-function mode.
Date:   Mon,  8 Oct 2018 11:25:00 -0400
Message-Id: <20181008152523.70705-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 0216da9413afa546627a1b0d319dfd17fef34050 ]

In certain multi-function switch dependent modes, firmware adds vlan tag 0
to the untagged frames. This leads to double tagging for the traffic
if the dcbx is enabled, which is not the desired behavior. To avoid this,
driver needs to set "dcb_dont_add_vlan0" flag.

Fixes: cac6f691 ("qed: Add support for Unified Fabric Port")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 9 ++++++++-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index e0680ce91328..09ed0ba4225a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -190,6 +190,7 @@ qed_dcbx_dp_protocol(struct qed_hwfn *p_hwfn, struct qed_dcbx_results *p_data)
 
 static void
 qed_dcbx_set_params(struct qed_dcbx_results *p_data,
+		    struct qed_hwfn *p_hwfn,
 		    struct qed_hw_info *p_info,
 		    bool enable,
 		    u8 prio,
@@ -206,6 +207,11 @@ qed_dcbx_set_params(struct qed_dcbx_results *p_data,
 	else
 		p_data->arr[type].update = DONT_UPDATE_DCB_DSCP;
 
+	/* Do not add vlan tag 0 when DCB is enabled and port in UFP/OV mode */
+	if ((test_bit(QED_MF_8021Q_TAGGING, &p_hwfn->cdev->mf_bits) ||
+	     test_bit(QED_MF_8021AD_TAGGING, &p_hwfn->cdev->mf_bits)))
+		p_data->arr[type].dont_add_vlan0 = true;
+
 	/* QM reconf data */
 	if (p_info->personality == personality)
 		p_info->offload_tc = tc;
@@ -233,7 +239,7 @@ qed_dcbx_update_app_info(struct qed_dcbx_results *p_data,
 		personality = qed_dcbx_app_update[i].personality;
 		name = qed_dcbx_app_update[i].name;
 
-		qed_dcbx_set_params(p_data, p_info, enable,
+		qed_dcbx_set_params(p_data, p_hwfn, p_info, enable,
 				    prio, tc, type, personality);
 	}
 }
@@ -956,6 +962,7 @@ static void qed_dcbx_update_protocol_data(struct protocol_dcb_data *p_data,
 	p_data->dcb_enable_flag = p_src->arr[type].enable;
 	p_data->dcb_priority = p_src->arr[type].priority;
 	p_data->dcb_tc = p_src->arr[type].tc;
+	p_data->dcb_dont_add_vlan0 = p_src->arr[type].dont_add_vlan0;
 }
 
 /* Set pf update ramrod command params */
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
index 5feb90e049e0..d950d836858c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
@@ -55,6 +55,7 @@ struct qed_dcbx_app_data {
 	u8 update;		/* Update indication */
 	u8 priority;		/* Priority */
 	u8 tc;			/* Traffic Class */
+	bool dont_add_vlan0;	/* Do not insert a vlan tag with id 0 */
 };
 
 #define QED_DCBX_VERSION_DISABLED       0
-- 
2.17.1

