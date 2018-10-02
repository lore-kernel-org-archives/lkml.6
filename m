Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E38C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0EA2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0EA2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeJBUSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbeJBUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:09 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 85762B2F;
        Tue,  2 Oct 2018 13:34:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 116/137] qed: Avoid sending mailbox commands when MFW is not responsive
Date:   Tue,  2 Oct 2018 06:25:17 -0700
Message-Id: <20181002132506.640005083@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit b310974e041913231b6e3d5d475d4df55c312301 ]

Keep sending mailbox commands to the MFW when it is not responsive ends up
with a redundant amount of timeout expiries.
This patch prints the MCP status on the first command which is not
responded, and blocks the following commands.
Since the (un)load request commands might be not responded due to other
PFs, the patch also adds the option to skip the blocking upon a failure.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c      |   52 ++++++++++++++++++++++++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h      |    6 ++
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h |    1 
 3 files changed, 56 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -319,6 +319,12 @@ int qed_mcp_reset(struct qed_hwfn *p_hwf
 	u32 org_mcp_reset_seq, seq, delay = QED_MCP_RESP_ITER_US, cnt = 0;
 	int rc = 0;
 
+	if (p_hwfn->mcp_info->b_block_cmd) {
+		DP_NOTICE(p_hwfn,
+			  "The MFW is not responsive. Avoid sending MCP_RESET mailbox command.\n");
+		return -EBUSY;
+	}
+
 	/* Ensure that only a single thread is accessing the mailbox */
 	spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
 
@@ -444,6 +450,33 @@ static void __qed_mcp_cmd_and_union(stru
 		   (p_mb_params->cmd | seq_num), p_mb_params->param);
 }
 
+static void qed_mcp_cmd_set_blocking(struct qed_hwfn *p_hwfn, bool block_cmd)
+{
+	p_hwfn->mcp_info->b_block_cmd = block_cmd;
+
+	DP_INFO(p_hwfn, "%s sending of mailbox commands to the MFW\n",
+		block_cmd ? "Block" : "Unblock");
+}
+
+static void qed_mcp_print_cpu_info(struct qed_hwfn *p_hwfn,
+				   struct qed_ptt *p_ptt)
+{
+	u32 cpu_mode, cpu_state, cpu_pc_0, cpu_pc_1, cpu_pc_2;
+	u32 delay = QED_MCP_RESP_ITER_US;
+
+	cpu_mode = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE);
+	cpu_state = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_STATE);
+	cpu_pc_0 = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_PROGRAM_COUNTER);
+	udelay(delay);
+	cpu_pc_1 = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_PROGRAM_COUNTER);
+	udelay(delay);
+	cpu_pc_2 = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_PROGRAM_COUNTER);
+
+	DP_NOTICE(p_hwfn,
+		  "MCP CPU info: mode 0x%08x, state 0x%08x, pc {0x%08x, 0x%08x, 0x%08x}\n",
+		  cpu_mode, cpu_state, cpu_pc_0, cpu_pc_1, cpu_pc_2);
+}
+
 static int
 _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		       struct qed_ptt *p_ptt,
@@ -530,11 +563,15 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *
 		DP_NOTICE(p_hwfn,
 			  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
 			  p_mb_params->cmd, p_mb_params->param);
+		qed_mcp_print_cpu_info(p_hwfn, p_ptt);
 
 		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
 		qed_mcp_cmd_del_elem(p_hwfn, p_cmd_elem);
 		spin_unlock_bh(&p_hwfn->mcp_info->cmd_lock);
 
+		if (!QED_MB_FLAGS_IS_SET(p_mb_params, AVOID_BLOCK))
+			qed_mcp_cmd_set_blocking(p_hwfn, true);
+
 		return -EAGAIN;
 	}
 
@@ -572,6 +609,13 @@ static int qed_mcp_cmd_and_union(struct
 		return -EBUSY;
 	}
 
+	if (p_hwfn->mcp_info->b_block_cmd) {
+		DP_NOTICE(p_hwfn,
+			  "The MFW is not responsive. Avoid sending mailbox command 0x%08x [param 0x%08x].\n",
+			  p_mb_params->cmd, p_mb_params->param);
+		return -EBUSY;
+	}
+
 	if (p_mb_params->data_src_size > union_data_size ||
 	    p_mb_params->data_dst_size > union_data_size) {
 		DP_ERR(p_hwfn,
@@ -776,7 +820,7 @@ __qed_mcp_load_req(struct qed_hwfn *p_hw
 	mb_params.data_src_size = sizeof(load_req);
 	mb_params.p_data_dst = &load_rsp;
 	mb_params.data_dst_size = sizeof(load_rsp);
-	mb_params.flags = QED_MB_FLAG_CAN_SLEEP;
+	mb_params.flags = QED_MB_FLAG_CAN_SLEEP | QED_MB_FLAG_AVOID_BLOCK;
 
 	DP_VERBOSE(p_hwfn, QED_MSG_SP,
 		   "Load Request: param 0x%08x [init_hw %d, drv_type %d, hsi_ver %d, pda 0x%04x]\n",
@@ -1020,7 +1064,7 @@ int qed_mcp_unload_req(struct qed_hwfn *
 	memset(&mb_params, 0, sizeof(mb_params));
 	mb_params.cmd = DRV_MSG_CODE_UNLOAD_REQ;
 	mb_params.param = wol_param;
-	mb_params.flags = QED_MB_FLAG_CAN_SLEEP;
+	mb_params.flags = QED_MB_FLAG_CAN_SLEEP | QED_MB_FLAG_AVOID_BLOCK;
 
 	return qed_mcp_cmd_and_union(p_hwfn, p_ptt, &mb_params);
 }
@@ -2047,6 +2091,8 @@ int qed_mcp_halt(struct qed_hwfn *p_hwfn
 		return -EBUSY;
 	}
 
+	qed_mcp_cmd_set_blocking(p_hwfn, true);
+
 	return 0;
 }
 
@@ -2071,6 +2117,8 @@ int qed_mcp_resume(struct qed_hwfn *p_hw
 		return -EBUSY;
 	}
 
+	qed_mcp_cmd_set_blocking(p_hwfn, false);
+
 	return 0;
 }
 
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -540,11 +540,14 @@ struct qed_mcp_info {
 	 */
 	spinlock_t				cmd_lock;
 
+	/* Flag to indicate whether sending a MFW mailbox command is blocked */
+	bool					b_block_cmd;
+
 	/* Spinlock used for syncing SW link-changes and link-changes
 	 * originating from attention context.
 	 */
 	spinlock_t				link_lock;
-	bool					block_mb_sending;
+
 	u32					public_base;
 	u32					drv_mb_addr;
 	u32					mfw_mb_addr;
@@ -575,6 +578,7 @@ struct qed_mcp_mb_params {
 	u32 mcp_param;
 	u32 flags;
 #define QED_MB_FLAG_CAN_SLEEP	(0x1 << 0)
+#define QED_MB_FLAG_AVOID_BLOCK	(0x1 << 1)
 #define QED_MB_FLAGS_IS_SET(params, flag) \
 	({ typeof(params) __params = (params); \
 	   (__params && (__params->flags & QED_MB_FLAG_ ## flag)); })
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -557,6 +557,7 @@
 #define MCP_REG_CPU_STATE_SOFT_HALTED	(0x1UL << 10)
 #define MCP_REG_CPU_EVENT_MASK \
 	0xe05008UL
+#define MCP_REG_CPU_PROGRAM_COUNTER	0xe0501cUL
 #define PGLUE_B_REG_PF_BAR0_SIZE \
 	0x2aae60UL
 #define PGLUE_B_REG_PF_BAR1_SIZE \


