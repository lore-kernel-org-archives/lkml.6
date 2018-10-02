Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F065C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E156206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E156206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeJBUNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbeJBUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:29 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6894BF0;
        Tue,  2 Oct 2018 13:30:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 174/228] qed: Prevent a possible deadlock during driver load and unload
Date:   Tue,  2 Oct 2018 06:24:31 -0700
Message-Id: <20181002132510.393357305@linuxfoundation.org>
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

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit eaa50fc59e5841910987e90b0438b2643041f508 ]

The MFW manages an internal lock to prevent concurrent hardware
(de)initialization of different PFs.
This, together with the busy-waiting for the MFW's responses for commands,
might lead to a deadlock during concurrent load or unload of PFs.
This patch adds the option to sleep within the busy-waiting, and uses it
for the (un)load requests (which are not sent from an interrupt context) to
prevent the possible deadlock.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c |   43 +++++++++++++++++++++---------
 drivers/net/ethernet/qlogic/qed/qed_mcp.h |   21 +++++++++-----
 2 files changed, 44 insertions(+), 20 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -48,7 +48,7 @@
 #include "qed_reg_addr.h"
 #include "qed_sriov.h"
 
-#define CHIP_MCP_RESP_ITER_US 10
+#define QED_MCP_RESP_ITER_US	10
 
 #define QED_DRV_MB_MAX_RETRIES	(500 * 1000)	/* Account for 5 sec */
 #define QED_MCP_RESET_RETRIES	(50 * 1000)	/* Account for 500 msec */
@@ -317,7 +317,7 @@ static void qed_mcp_reread_offsets(struc
 
 int qed_mcp_reset(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 org_mcp_reset_seq, seq, delay = CHIP_MCP_RESP_ITER_US, cnt = 0;
+	u32 org_mcp_reset_seq, seq, delay = QED_MCP_RESP_ITER_US, cnt = 0;
 	int rc = 0;
 
 	/* Ensure that only a single thread is accessing the mailbox */
@@ -449,10 +449,10 @@ static int
 _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
 		       struct qed_mcp_mb_params *p_mb_params,
-		       u32 max_retries, u32 delay)
+		       u32 max_retries, u32 usecs)
 {
+	u32 cnt = 0, msecs = DIV_ROUND_UP(usecs, 1000);
 	struct qed_mcp_cmd_elem *p_cmd_elem;
-	u32 cnt = 0;
 	u16 seq_num;
 	int rc = 0;
 
@@ -475,7 +475,11 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *
 			goto err;
 
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
-		udelay(delay);
+
+		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
+			msleep(msecs);
+		else
+			udelay(usecs);
 	} while (++cnt < max_retries);
 
 	if (cnt >= max_retries) {
@@ -504,7 +508,11 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *
 		 * The spinlock stays locked until the list element is removed.
 		 */
 
-		udelay(delay);
+		if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP))
+			msleep(msecs);
+		else
+			udelay(usecs);
+
 		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
 
 		if (p_cmd_elem->b_is_completed)
@@ -539,7 +547,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *
 		   "MFW mailbox: response 0x%08x param 0x%08x [after %d.%03d ms]\n",
 		   p_mb_params->mcp_resp,
 		   p_mb_params->mcp_param,
-		   (cnt * delay) / 1000, (cnt * delay) % 1000);
+		   (cnt * usecs) / 1000, (cnt * usecs) % 1000);
 
 	/* Clear the sequence number from the MFW response */
 	p_mb_params->mcp_resp &= FW_MSG_CODE_MASK;
@@ -557,7 +565,7 @@ static int qed_mcp_cmd_and_union(struct
 {
 	size_t union_data_size = sizeof(union drv_union_data);
 	u32 max_retries = QED_DRV_MB_MAX_RETRIES;
-	u32 delay = CHIP_MCP_RESP_ITER_US;
+	u32 usecs = QED_MCP_RESP_ITER_US;
 
 	/* MCP not initialized */
 	if (!qed_mcp_is_init(p_hwfn)) {
@@ -574,8 +582,13 @@ static int qed_mcp_cmd_and_union(struct
 		return -EINVAL;
 	}
 
+	if (QED_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP)) {
+		max_retries = DIV_ROUND_UP(max_retries, 1000);
+		usecs *= 1000;
+	}
+
 	return _qed_mcp_cmd_and_union(p_hwfn, p_ptt, p_mb_params, max_retries,
-				      delay);
+				      usecs);
 }
 
 int qed_mcp_cmd(struct qed_hwfn *p_hwfn,
@@ -792,6 +805,7 @@ __qed_mcp_load_req(struct qed_hwfn *p_hw
 	mb_params.data_src_size = sizeof(load_req);
 	mb_params.p_data_dst = &load_rsp;
 	mb_params.data_dst_size = sizeof(load_rsp);
+	mb_params.flags = QED_MB_FLAG_CAN_SLEEP;
 
 	DP_VERBOSE(p_hwfn, QED_MSG_SP,
 		   "Load Request: param 0x%08x [init_hw %d, drv_type %d, hsi_ver %d, pda 0x%04x]\n",
@@ -1013,7 +1027,8 @@ int qed_mcp_load_req(struct qed_hwfn *p_
 
 int qed_mcp_unload_req(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 wol_param, mcp_resp, mcp_param;
+	struct qed_mcp_mb_params mb_params;
+	u32 wol_param;
 
 	switch (p_hwfn->cdev->wol_config) {
 	case QED_OV_WOL_DISABLED:
@@ -1031,8 +1046,12 @@ int qed_mcp_unload_req(struct qed_hwfn *
 		wol_param = DRV_MB_PARAM_UNLOAD_WOL_MCP;
 	}
 
-	return qed_mcp_cmd(p_hwfn, p_ptt, DRV_MSG_CODE_UNLOAD_REQ, wol_param,
-			   &mcp_resp, &mcp_param);
+	memset(&mb_params, 0, sizeof(mb_params));
+	mb_params.cmd = DRV_MSG_CODE_UNLOAD_REQ;
+	mb_params.param = wol_param;
+	mb_params.flags = QED_MB_FLAG_CAN_SLEEP;
+
+	return qed_mcp_cmd_and_union(p_hwfn, p_ptt, &mb_params);
 }
 
 int qed_mcp_unload_done(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -660,14 +660,19 @@ struct qed_mcp_info {
 };
 
 struct qed_mcp_mb_params {
-	u32			cmd;
-	u32			param;
-	void			*p_data_src;
-	u8			data_src_size;
-	void			*p_data_dst;
-	u8			data_dst_size;
-	u32			mcp_resp;
-	u32			mcp_param;
+	u32 cmd;
+	u32 param;
+	void *p_data_src;
+	void *p_data_dst;
+	u8 data_src_size;
+	u8 data_dst_size;
+	u32 mcp_resp;
+	u32 mcp_param;
+	u32 flags;
+#define QED_MB_FLAG_CAN_SLEEP	(0x1 << 0)
+#define QED_MB_FLAGS_IS_SET(params, flag) \
+	({ typeof(params) __params = (params); \
+	   (__params && (__params->flags & QED_MB_FLAG_ ## flag)); })
 };
 
 struct qed_drv_tlv_hdr {


