Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99626C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5448A21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkNlkVhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5448A21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeK2RCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbeK2RCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:00 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F365A21104;
        Thu, 29 Nov 2018 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471069;
        bh=y59yG2GwRCX+jw5ueSyKkxjEepKMJGvHGzB9haD8qec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkNlkVhk/BGV3gFljE5UR9mOwvQGKUvlUt1SGF7r3J0OR6ZcXzlg/guDOcG18rVkU
         LJ7ErI0WHTG0Mj7iXamG+BjI2dVuC7mqUMOmCyXBA2d9d4w6EsN4g+I6bo2ICCEEyA
         7WEiw5w1eiduuRtCKRp5Ft5YN+FWvqh+xDhMaIZ8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@cavium.com>,
        Denis Bolotin <denis.bolotin@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 20/68] qed: Fix rdma_info structure allocation
Date:   Thu, 29 Nov 2018 00:55:11 -0500
Message-Id: <20181129055559.159228-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@cavium.com>

[ Upstream commit 291d57f67d2449737d1e370ab5b9a583818eaa0c ]

Certain flows need to access the rdma-info structure, for example dcbx
update flows. In some cases there can be a race between the allocation or
deallocation of the structure which was done in roce start / roce stop and
an asynchrounous dcbx event that tries to access the structure.
For this reason, we move the allocation of the rdma_info structure to be
similar to the iscsi/fcoe info structures which are allocated during device
setup.
We add a new field of "active" to the struct to define whether roce has
already been started or not, and this is checked instead of whether the
pointer to the info structure.

Fixes: 51ff17251c9c ("qed: Add support for RoCE hw init")
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c  | 15 +++++--
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 50 +++++++++++++---------
 drivers/net/ethernet/qlogic/qed/qed_rdma.h |  5 +++
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 97f073fd3725..9d2d18c32162 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -179,6 +179,10 @@ void qed_resc_free(struct qed_dev *cdev)
 			qed_iscsi_free(p_hwfn);
 			qed_ooo_free(p_hwfn);
 		}
+
+		if (QED_IS_RDMA_PERSONALITY(p_hwfn))
+			qed_rdma_info_free(p_hwfn);
+
 		qed_iov_free(p_hwfn);
 		qed_l2_free(p_hwfn);
 		qed_dmae_info_free(p_hwfn);
@@ -1074,6 +1078,12 @@ int qed_resc_alloc(struct qed_dev *cdev)
 				goto alloc_err;
 		}
 
+		if (QED_IS_RDMA_PERSONALITY(p_hwfn)) {
+			rc = qed_rdma_info_alloc(p_hwfn);
+			if (rc)
+				goto alloc_err;
+		}
+
 		/* DMA info initialization */
 		rc = qed_dmae_info_alloc(p_hwfn);
 		if (rc)
@@ -2091,11 +2101,8 @@ int qed_hw_start_fastpath(struct qed_hwfn *p_hwfn)
 	if (!p_ptt)
 		return -EAGAIN;
 
-	/* If roce info is allocated it means roce is initialized and should
-	 * be enabled in searcher.
-	 */
 	if (p_hwfn->p_rdma_info &&
-	    p_hwfn->b_rdma_enabled_in_prs)
+	    p_hwfn->p_rdma_info->active && p_hwfn->b_rdma_enabled_in_prs)
 		qed_wr(p_hwfn, p_ptt, p_hwfn->rdma_prs_search_reg, 0x1);
 
 	/* Re-open incoming traffic */
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 62113438c880..7873d6dfd91f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -140,22 +140,34 @@ static u32 qed_rdma_get_sb_id(void *p_hwfn, u32 rel_sb_id)
 	return FEAT_NUM((struct qed_hwfn *)p_hwfn, QED_PF_L2_QUE) + rel_sb_id;
 }
 
-static int qed_rdma_alloc(struct qed_hwfn *p_hwfn,
-			  struct qed_ptt *p_ptt,
-			  struct qed_rdma_start_in_params *params)
+int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn)
 {
 	struct qed_rdma_info *p_rdma_info;
-	u32 num_cons, num_tasks;
-	int rc = -ENOMEM;
 
-	DP_VERBOSE(p_hwfn, QED_MSG_RDMA, "Allocating RDMA\n");
-
-	/* Allocate a struct with current pf rdma info */
 	p_rdma_info = kzalloc(sizeof(*p_rdma_info), GFP_KERNEL);
 	if (!p_rdma_info)
-		return rc;
+		return -ENOMEM;
+
+	spin_lock_init(&p_rdma_info->lock);
 
 	p_hwfn->p_rdma_info = p_rdma_info;
+	return 0;
+}
+
+void qed_rdma_info_free(struct qed_hwfn *p_hwfn)
+{
+	kfree(p_hwfn->p_rdma_info);
+	p_hwfn->p_rdma_info = NULL;
+}
+
+static int qed_rdma_alloc(struct qed_hwfn *p_hwfn)
+{
+	struct qed_rdma_info *p_rdma_info = p_hwfn->p_rdma_info;
+	u32 num_cons, num_tasks;
+	int rc = -ENOMEM;
+
+	DP_VERBOSE(p_hwfn, QED_MSG_RDMA, "Allocating RDMA\n");
+
 	if (QED_IS_IWARP_PERSONALITY(p_hwfn))
 		p_rdma_info->proto = PROTOCOLID_IWARP;
 	else
@@ -183,7 +195,7 @@ static int qed_rdma_alloc(struct qed_hwfn *p_hwfn,
 	/* Allocate a struct with device params and fill it */
 	p_rdma_info->dev = kzalloc(sizeof(*p_rdma_info->dev), GFP_KERNEL);
 	if (!p_rdma_info->dev)
-		goto free_rdma_info;
+		return rc;
 
 	/* Allocate a struct with port params and fill it */
 	p_rdma_info->port = kzalloc(sizeof(*p_rdma_info->port), GFP_KERNEL);
@@ -298,8 +310,6 @@ static int qed_rdma_alloc(struct qed_hwfn *p_hwfn,
 	kfree(p_rdma_info->port);
 free_rdma_dev:
 	kfree(p_rdma_info->dev);
-free_rdma_info:
-	kfree(p_rdma_info);
 
 	return rc;
 }
@@ -370,8 +380,6 @@ static void qed_rdma_resc_free(struct qed_hwfn *p_hwfn)
 
 	kfree(p_rdma_info->port);
 	kfree(p_rdma_info->dev);
-
-	kfree(p_rdma_info);
 }
 
 static void qed_rdma_free_tid(void *rdma_cxt, u32 itid)
@@ -679,8 +687,6 @@ static int qed_rdma_setup(struct qed_hwfn *p_hwfn,
 
 	DP_VERBOSE(p_hwfn, QED_MSG_RDMA, "RDMA setup\n");
 
-	spin_lock_init(&p_hwfn->p_rdma_info->lock);
-
 	qed_rdma_init_devinfo(p_hwfn, params);
 	qed_rdma_init_port(p_hwfn);
 	qed_rdma_init_events(p_hwfn, params);
@@ -727,7 +733,7 @@ static int qed_rdma_stop(void *rdma_cxt)
 	/* Disable RoCE search */
 	qed_wr(p_hwfn, p_ptt, p_hwfn->rdma_prs_search_reg, 0);
 	p_hwfn->b_rdma_enabled_in_prs = false;
-
+	p_hwfn->p_rdma_info->active = 0;
 	qed_wr(p_hwfn, p_ptt, PRS_REG_ROCE_DEST_QP_MAX_PF, 0);
 
 	ll2_ethertype_en = qed_rd(p_hwfn, p_ptt, PRS_REG_LIGHT_L2_ETHERTYPE_EN);
@@ -1236,7 +1242,8 @@ qed_rdma_create_qp(void *rdma_cxt,
 	u8 max_stats_queues;
 	int rc;
 
-	if (!rdma_cxt || !in_params || !out_params || !p_hwfn->p_rdma_info) {
+	if (!rdma_cxt || !in_params || !out_params ||
+	    !p_hwfn->p_rdma_info->active) {
 		DP_ERR(p_hwfn->cdev,
 		       "qed roce create qp failed due to NULL entry (rdma_cxt=%p, in=%p, out=%p, roce_info=?\n",
 		       rdma_cxt, in_params, out_params);
@@ -1802,8 +1809,8 @@ bool qed_rdma_allocated_qps(struct qed_hwfn *p_hwfn)
 {
 	bool result;
 
-	/* if rdma info has not been allocated, naturally there are no qps */
-	if (!p_hwfn->p_rdma_info)
+	/* if rdma wasn't activated yet, naturally there are no qps */
+	if (!p_hwfn->p_rdma_info->active)
 		return false;
 
 	spin_lock_bh(&p_hwfn->p_rdma_info->lock);
@@ -1849,7 +1856,7 @@ static int qed_rdma_start(void *rdma_cxt,
 	if (!p_ptt)
 		goto err;
 
-	rc = qed_rdma_alloc(p_hwfn, p_ptt, params);
+	rc = qed_rdma_alloc(p_hwfn);
 	if (rc)
 		goto err1;
 
@@ -1858,6 +1865,7 @@ static int qed_rdma_start(void *rdma_cxt,
 		goto err2;
 
 	qed_ptt_release(p_hwfn, p_ptt);
+	p_hwfn->p_rdma_info->active = 1;
 
 	return rc;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.h b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
index 6f722ee8ee94..50d609c0e108 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.h
@@ -102,6 +102,7 @@ struct qed_rdma_info {
 	u16 max_queue_zones;
 	enum protocol_type proto;
 	struct qed_iwarp_info iwarp;
+	u8 active:1;
 };
 
 struct qed_rdma_qp {
@@ -176,10 +177,14 @@ struct qed_rdma_qp {
 #if IS_ENABLED(CONFIG_QED_RDMA)
 void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
 void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt);
+int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn);
+void qed_rdma_info_free(struct qed_hwfn *p_hwfn);
 #else
 static inline void qed_rdma_dpm_conf(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt) {}
 static inline void qed_rdma_dpm_bar(struct qed_hwfn *p_hwfn,
 				    struct qed_ptt *p_ptt) {}
+static inline int qed_rdma_info_alloc(struct qed_hwfn *p_hwfn) {return -EINVAL}
+static inline void qed_rdma_info_free(struct qed_hwfn *p_hwfn) {}
 #endif
 
 int
-- 
2.17.1

