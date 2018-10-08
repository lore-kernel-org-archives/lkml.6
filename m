Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24521502
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwurOQXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D24521502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJHWiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeJHWiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D90012075E;
        Mon,  8 Oct 2018 15:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012359;
        bh=kcGU+jBFSSQSgN2MACNzmTHjv3YqU2D0GMbrRiKLCRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwurOQXjccludyk6tyuvbsBatGPpAPCjCZN5voB7WiOgyYKocFKRMPth+hukZxw6P
         kKoeiyRP/dv48YDJCUTBia96f19ALGv6OtiZkZwvYPkqgOf2m3j3iqqFEMXZ5CWI0r
         OR+BRzkn3yz5uZuJtPZSN9UwSjGVomAhhaqYHevM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 34/58] qed: Fix populating the invalid stag value in multi function mode.
Date:   Mon,  8 Oct 2018 11:24:59 -0400
Message-Id: <20181008152523.70705-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 50fdf60181b01b7383b85d4b9acbb842263d96a2 ]

In multi-function mode, driver receives the stag value (outer vlan)
for a PF from management FW (MFW). If the stag value is negotiated prior to
the driver load, then the stag is not notified to the driver and hence
driver will have the invalid stag value.
The fix is to request the MFW for STAG value during the driver load time.

Fixes: cac6f691 ("qed: Add support for Unified Fabric Port")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 15 ++++++++++++++-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h |  4 ++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index e5249b4741d0..194f4dbe57d3 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -1636,7 +1636,7 @@ static int qed_vf_start(struct qed_hwfn *p_hwfn,
 int qed_hw_init(struct qed_dev *cdev, struct qed_hw_init_params *p_params)
 {
 	struct qed_load_req_params load_req_params;
-	u32 load_code, param, drv_mb_param;
+	u32 load_code, resp, param, drv_mb_param;
 	bool b_default_mtu = true;
 	struct qed_hwfn *p_hwfn;
 	int rc = 0, mfw_rc, i;
@@ -1782,6 +1782,19 @@ int qed_hw_init(struct qed_dev *cdev, struct qed_hw_init_params *p_params)
 
 	if (IS_PF(cdev)) {
 		p_hwfn = QED_LEADING_HWFN(cdev);
+
+		/* Get pre-negotiated values for stag, bandwidth etc. */
+		DP_VERBOSE(p_hwfn,
+			   QED_MSG_SPQ,
+			   "Sending GET_OEM_UPDATES command to trigger stag/bandwidth attention handling\n");
+		drv_mb_param = 1 << DRV_MB_PARAM_DUMMY_OEM_UPDATES_OFFSET;
+		rc = qed_mcp_cmd(p_hwfn, p_hwfn->p_main_ptt,
+				 DRV_MSG_CODE_GET_OEM_UPDATES,
+				 drv_mb_param, &resp, &param);
+		if (rc)
+			DP_NOTICE(p_hwfn,
+				  "Failed to send GET_OEM_UPDATES attention request\n");
+
 		drv_mb_param = STORM_FW_VERSION;
 		rc = qed_mcp_cmd(p_hwfn, p_hwfn->p_main_ptt,
 				 DRV_MSG_CODE_OV_UPDATE_STORM_FW_VER,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index bee10c1781fb..baa8a795c551 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -12414,6 +12414,7 @@ struct public_drv_mb {
 #define DRV_MSG_SET_RESOURCE_VALUE_MSG		0x35000000
 #define DRV_MSG_CODE_OV_UPDATE_WOL              0x38000000
 #define DRV_MSG_CODE_OV_UPDATE_ESWITCH_MODE     0x39000000
+#define DRV_MSG_CODE_GET_OEM_UPDATES            0x41000000
 
 #define DRV_MSG_CODE_BW_UPDATE_ACK		0x32000000
 #define DRV_MSG_CODE_NIG_DRAIN			0x30000000
@@ -12539,6 +12540,9 @@ struct public_drv_mb {
 #define DRV_MB_PARAM_ESWITCH_MODE_VEB	0x1
 #define DRV_MB_PARAM_ESWITCH_MODE_VEPA	0x2
 
+#define DRV_MB_PARAM_DUMMY_OEM_UPDATES_MASK	0x1
+#define DRV_MB_PARAM_DUMMY_OEM_UPDATES_OFFSET	0
+
 #define DRV_MB_PARAM_SET_LED_MODE_OPER		0x0
 #define DRV_MB_PARAM_SET_LED_MODE_ON		0x1
 #define DRV_MB_PARAM_SET_LED_MODE_OFF		0x2
-- 
2.17.1

