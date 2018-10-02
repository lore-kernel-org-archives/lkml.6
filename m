Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191D0C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9102064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9102064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeJBUpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:45:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbeJBUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:22 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C93D7B2F;
        Tue,  2 Oct 2018 13:29:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 172/228] qed: Wait for ready indication before rereading the shmem
Date:   Tue,  2 Oct 2018 06:24:29 -0700
Message-Id: <20181002132510.289135971@linuxfoundation.org>
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

[ Upstream commit f00d25f3154b676fcea4502a25b94bd7f142ca74 ]

The MFW might be reset and re-update its shared memory.
Upon the detection of such a reset the driver rereads this memory, but it
has to wait till the data is valid.
This patch adds the missing wait for a data ready indication.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c |   50 ++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -183,18 +183,57 @@ int qed_mcp_free(struct qed_hwfn *p_hwfn
 	return 0;
 }
 
+/* Maximum of 1 sec to wait for the SHMEM ready indication */
+#define QED_MCP_SHMEM_RDY_MAX_RETRIES	20
+#define QED_MCP_SHMEM_RDY_ITER_MS	50
+
 static int qed_load_mcp_offsets(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
 	struct qed_mcp_info *p_info = p_hwfn->mcp_info;
+	u8 cnt = QED_MCP_SHMEM_RDY_MAX_RETRIES;
+	u8 msec = QED_MCP_SHMEM_RDY_ITER_MS;
 	u32 drv_mb_offsize, mfw_mb_offsize;
 	u32 mcp_pf_id = MCP_PF_ID(p_hwfn);
 
 	p_info->public_base = qed_rd(p_hwfn, p_ptt, MISC_REG_SHARED_MEM_ADDR);
-	if (!p_info->public_base)
-		return 0;
+	if (!p_info->public_base) {
+		DP_NOTICE(p_hwfn,
+			  "The address of the MCP scratch-pad is not configured\n");
+		return -EINVAL;
+	}
 
 	p_info->public_base |= GRCBASE_MCP;
 
+	/* Get the MFW MB address and number of supported messages */
+	mfw_mb_offsize = qed_rd(p_hwfn, p_ptt,
+				SECTION_OFFSIZE_ADDR(p_info->public_base,
+						     PUBLIC_MFW_MB));
+	p_info->mfw_mb_addr = SECTION_ADDR(mfw_mb_offsize, mcp_pf_id);
+	p_info->mfw_mb_length = (u16)qed_rd(p_hwfn, p_ptt,
+					    p_info->mfw_mb_addr +
+					    offsetof(struct public_mfw_mb,
+						     sup_msgs));
+
+	/* The driver can notify that there was an MCP reset, and might read the
+	 * SHMEM values before the MFW has completed initializing them.
+	 * To avoid this, the "sup_msgs" field in the MFW mailbox is used as a
+	 * data ready indication.
+	 */
+	while (!p_info->mfw_mb_length && --cnt) {
+		msleep(msec);
+		p_info->mfw_mb_length =
+			(u16)qed_rd(p_hwfn, p_ptt,
+				    p_info->mfw_mb_addr +
+				    offsetof(struct public_mfw_mb, sup_msgs));
+	}
+
+	if (!cnt) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to get the SHMEM ready notification after %d msec\n",
+			  QED_MCP_SHMEM_RDY_MAX_RETRIES * msec);
+		return -EBUSY;
+	}
+
 	/* Calculate the driver and MFW mailbox address */
 	drv_mb_offsize = qed_rd(p_hwfn, p_ptt,
 				SECTION_OFFSIZE_ADDR(p_info->public_base,
@@ -204,13 +243,6 @@ static int qed_load_mcp_offsets(struct q
 		   "drv_mb_offsiz = 0x%x, drv_mb_addr = 0x%x mcp_pf_id = 0x%x\n",
 		   drv_mb_offsize, p_info->drv_mb_addr, mcp_pf_id);
 
-	/* Set the MFW MB address */
-	mfw_mb_offsize = qed_rd(p_hwfn, p_ptt,
-				SECTION_OFFSIZE_ADDR(p_info->public_base,
-						     PUBLIC_MFW_MB));
-	p_info->mfw_mb_addr = SECTION_ADDR(mfw_mb_offsize, mcp_pf_id);
-	p_info->mfw_mb_length =	(u16)qed_rd(p_hwfn, p_ptt, p_info->mfw_mb_addr);
-
 	/* Get the current driver mailbox sequence before sending
 	 * the first command
 	 */


