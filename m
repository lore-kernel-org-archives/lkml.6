Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25732064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25732064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbeJBUWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:22:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbeJBUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:21 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 750A09D9;
        Tue,  2 Oct 2018 13:36:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomer Tayar <Tomer.Tayar@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 82/94] qed: Wait for MCP halt and resume commands to take place
Date:   Tue,  2 Oct 2018 06:25:36 -0700
Message-Id: <20181002132506.207327269@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomer Tayar <Tomer.Tayar@cavium.com>

[ Upstream commit 76271809f49056f079e202bf6513d17b0d6dd34d ]

Successive iterations of halting and resuming the management chip (MCP)
might fail, since currently the driver doesn't wait for these operations to
actually take place.
This patch prevents the driver from moving forward before the operations
are reflected in the state register.

Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c      |   46 ++++++++++++++++++++-----
 drivers/net/ethernet/qlogic/qed/qed_reg_addr.h |    1 
 2 files changed, 39 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1230,31 +1230,61 @@ qed_mcp_send_drv_version(struct qed_hwfn
 	return rc;
 }
 
+/* A maximal 100 msec waiting time for the MCP to halt */
+#define QED_MCP_HALT_SLEEP_MS		10
+#define QED_MCP_HALT_MAX_RETRIES	10
+
 int qed_mcp_halt(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 resp = 0, param = 0;
+	u32 resp = 0, param = 0, cpu_state, cnt = 0;
 	int rc;
 
 	rc = qed_mcp_cmd(p_hwfn, p_ptt, DRV_MSG_CODE_MCP_HALT, 0, &resp,
 			 &param);
-	if (rc)
+	if (rc) {
 		DP_ERR(p_hwfn, "MCP response failure, aborting\n");
+		return rc;
+	}
 
-	return rc;
+	do {
+		msleep(QED_MCP_HALT_SLEEP_MS);
+		cpu_state = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_STATE);
+		if (cpu_state & MCP_REG_CPU_STATE_SOFT_HALTED)
+			break;
+	} while (++cnt < QED_MCP_HALT_MAX_RETRIES);
+
+	if (cnt == QED_MCP_HALT_MAX_RETRIES) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to halt the MCP [CPU_MODE = 0x%08x, CPU_STATE = 0x%08x]\n",
+			  qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE), cpu_state);
+		return -EBUSY;
+	}
+
+	return 0;
 }
 
+#define QED_MCP_RESUME_SLEEP_MS	10
+
 int qed_mcp_resume(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 value, cpu_mode;
+	u32 cpu_mode, cpu_state;
 
 	qed_wr(p_hwfn, p_ptt, MCP_REG_CPU_STATE, 0xffffffff);
 
-	value = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE);
-	value &= ~MCP_REG_CPU_MODE_SOFT_HALT;
-	qed_wr(p_hwfn, p_ptt, MCP_REG_CPU_MODE, value);
 	cpu_mode = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_MODE);
+	cpu_mode &= ~MCP_REG_CPU_MODE_SOFT_HALT;
+	qed_wr(p_hwfn, p_ptt, MCP_REG_CPU_MODE, cpu_mode);
+	msleep(QED_MCP_RESUME_SLEEP_MS);
+	cpu_state = qed_rd(p_hwfn, p_ptt, MCP_REG_CPU_STATE);
+
+	if (cpu_state & MCP_REG_CPU_STATE_SOFT_HALTED) {
+		DP_NOTICE(p_hwfn,
+			  "Failed to resume the MCP [CPU_MODE = 0x%08x, CPU_STATE = 0x%08x]\n",
+			  cpu_mode, cpu_state);
+		return -EBUSY;
+	}
 
-	return (cpu_mode & MCP_REG_CPU_MODE_SOFT_HALT) ? -EAGAIN : 0;
+	return 0;
 }
 
 int qed_mcp_set_led(struct qed_hwfn *p_hwfn,
--- a/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_reg_addr.h
@@ -510,6 +510,7 @@
 	0
 #define MCP_REG_CPU_STATE \
 	0xe05004UL
+#define MCP_REG_CPU_STATE_SOFT_HALTED	(0x1UL << 10)
 #define MCP_REG_CPU_EVENT_MASK \
 	0xe05008UL
 #define PGLUE_B_REG_PF_BAR0_SIZE \


