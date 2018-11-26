Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FDEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7108C2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoM6631T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7108C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbeKZV6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeKZV6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 156A621104;
        Mon, 26 Nov 2018 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230296;
        bh=4tlZWJ9lnQHdqKb3jbQ4rQ7HLeQTZQy+gwsC3Hkvh04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoM6631Ts4EdzJNjj6bGqsf79WMyL/N4FJqq4YgU7lmXxXy3/+xFhf7/ImdHiw6JI
         WHaESM7/AMX4gg3cvnDLTxSh1xJPf+w8RCfwEzwd2bOZONiH07LyT7rM7wOytJ6qVd
         coRAHA8VraRtoD3WGo/T3UwcvmqYCuN/SzMhwZuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/118] qed: Fix SPQ entries not returned to pool in error flows
Date:   Mon, 26 Nov 2018 11:51:17 +0100
Message-Id: <20181126105105.034274106@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fb5e7438e7a3c8966e04ccb0760170e9e06f3699 ]

qed_sp_destroy_request() API was added for SPQ users that need to
free/return the entry they acquired in their error flows.

Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c    | 11 +++++++---
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c   |  1 +
 drivers/net/ethernet/qlogic/qed/qed_l2.c      | 12 ++++++----
 drivers/net/ethernet/qlogic/qed/qed_rdma.c    |  1 +
 drivers/net/ethernet/qlogic/qed/qed_roce.c    |  1 +
 drivers/net/ethernet/qlogic/qed/qed_sp.h      | 11 ++++++++++
 .../net/ethernet/qlogic/qed/qed_sp_commands.c | 22 ++++++++++++-------
 drivers/net/ethernet/qlogic/qed/qed_sriov.c   |  1 +
 8 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
index cc1b373c0ace..46dc93d3b9b5 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_fcoe.c
@@ -147,7 +147,8 @@ qed_sp_fcoe_func_start(struct qed_hwfn *p_hwfn,
 		       "Cannot satisfy CQ amount. CQs requested %d, CQs available %d. Aborting function start\n",
 		       fcoe_pf_params->num_cqs,
 		       p_hwfn->hw_info.feat_num[QED_FCOE_CQ]);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto err;
 	}
 
 	p_data->mtu = cpu_to_le16(fcoe_pf_params->mtu);
@@ -156,14 +157,14 @@ qed_sp_fcoe_func_start(struct qed_hwfn *p_hwfn,
 
 	rc = qed_cxt_acquire_cid(p_hwfn, PROTOCOLID_FCOE, &dummy_cid);
 	if (rc)
-		return rc;
+		goto err;
 
 	cxt_info.iid = dummy_cid;
 	rc = qed_cxt_get_cid_info(p_hwfn, &cxt_info);
 	if (rc) {
 		DP_NOTICE(p_hwfn, "Cannot find context info for dummy cid=%d\n",
 			  dummy_cid);
-		return rc;
+		goto err;
 	}
 	p_cxt = cxt_info.p_cxt;
 	SET_FIELD(p_cxt->tstorm_ag_context.flags3,
@@ -240,6 +241,10 @@ qed_sp_fcoe_func_start(struct qed_hwfn *p_hwfn,
 	rc = qed_spq_post(p_hwfn, p_ent, NULL);
 
 	return rc;
+
+err:
+	qed_sp_destroy_request(p_hwfn, p_ent);
+	return rc;
 }
 
 static int
diff --git a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
index 1135387bd99d..4f8a685d1a55 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iscsi.c
@@ -200,6 +200,7 @@ qed_sp_iscsi_func_start(struct qed_hwfn *p_hwfn,
 		       "Cannot satisfy CQ amount. Queues requested %d, CQs available %d. Aborting function start\n",
 		       p_params->num_queues,
 		       p_hwfn->hw_info.feat_num[QED_ISCSI_CQ]);
+		qed_sp_destroy_request(p_hwfn, p_ent);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 82a1bd1f8a8c..67c02ea93906 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -740,8 +740,7 @@ int qed_sp_vport_update(struct qed_hwfn *p_hwfn,
 
 	rc = qed_sp_vport_update_rss(p_hwfn, p_ramrod, p_rss_params);
 	if (rc) {
-		/* Return spq entry which is taken in qed_sp_init_request()*/
-		qed_spq_return_entry(p_hwfn, p_ent);
+		qed_sp_destroy_request(p_hwfn, p_ent);
 		return rc;
 	}
 
@@ -1355,6 +1354,7 @@ qed_filter_ucast_common(struct qed_hwfn *p_hwfn,
 			DP_NOTICE(p_hwfn,
 				  "%d is not supported yet\n",
 				  p_filter_cmd->opcode);
+			qed_sp_destroy_request(p_hwfn, *pp_ent);
 			return -EINVAL;
 		}
 
@@ -2056,13 +2056,13 @@ qed_configure_rfs_ntuple_filter(struct qed_hwfn *p_hwfn,
 	} else {
 		rc = qed_fw_vport(p_hwfn, p_params->vport_id, &abs_vport_id);
 		if (rc)
-			return rc;
+			goto err;
 
 		if (p_params->qid != QED_RFS_NTUPLE_QID_RSS) {
 			rc = qed_fw_l2_queue(p_hwfn, p_params->qid,
 					     &abs_rx_q_id);
 			if (rc)
-				return rc;
+				goto err;
 
 			p_ramrod->rx_qid_valid = 1;
 			p_ramrod->rx_qid = cpu_to_le16(abs_rx_q_id);
@@ -2083,6 +2083,10 @@ qed_configure_rfs_ntuple_filter(struct qed_hwfn *p_hwfn,
 		   (u64)p_params->addr, p_params->length);
 
 	return qed_spq_post(p_hwfn, p_ent, NULL);
+
+err:
+	qed_sp_destroy_request(p_hwfn, p_ent);
+	return rc;
 }
 
 int qed_get_rxq_coalesce(struct qed_hwfn *p_hwfn,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index c71391b9c757..62113438c880 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -1514,6 +1514,7 @@ qed_rdma_register_tid(void *rdma_cxt,
 	default:
 		rc = -EINVAL;
 		DP_VERBOSE(p_hwfn, QED_MSG_RDMA, "rc = %d\n", rc);
+		qed_sp_destroy_request(p_hwfn, p_ent);
 		return rc;
 	}
 	SET_FIELD(p_ramrod->flags1,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_roce.c b/drivers/net/ethernet/qlogic/qed/qed_roce.c
index f9167d1354bb..e49fada85410 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_roce.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_roce.c
@@ -745,6 +745,7 @@ static int qed_roce_sp_destroy_qp_responder(struct qed_hwfn *p_hwfn,
 		DP_NOTICE(p_hwfn,
 			  "qed destroy responder failed: cannot allocate memory (ramrod). rc = %d\n",
 			  rc);
+		qed_sp_destroy_request(p_hwfn, p_ent);
 		return rc;
 	}
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp.h b/drivers/net/ethernet/qlogic/qed/qed_sp.h
index 04259df8a5c2..3157c0d99441 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp.h
@@ -399,6 +399,17 @@ struct qed_sp_init_data {
 	struct qed_spq_comp_cb *p_comp_data;
 };
 
+/**
+ * @brief Returns a SPQ entry to the pool / frees the entry if allocated.
+ *        Should be called on in error flows after initializing the SPQ entry
+ *        and before posting it.
+ *
+ * @param p_hwfn
+ * @param p_ent
+ */
+void qed_sp_destroy_request(struct qed_hwfn *p_hwfn,
+			    struct qed_spq_entry *p_ent);
+
 int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 			struct qed_spq_entry **pp_ent,
 			u8 cmd,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
index e86a1ea23613..888274fa208b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sp_commands.c
@@ -47,6 +47,19 @@
 #include "qed_sp.h"
 #include "qed_sriov.h"
 
+void qed_sp_destroy_request(struct qed_hwfn *p_hwfn,
+			    struct qed_spq_entry *p_ent)
+{
+	/* qed_spq_get_entry() can either get an entry from the free_pool,
+	 * or, if no entries are left, allocate a new entry and add it to
+	 * the unlimited_pending list.
+	 */
+	if (p_ent->queue == &p_hwfn->p_spq->unlimited_pending)
+		kfree(p_ent);
+	else
+		qed_spq_return_entry(p_hwfn, p_ent);
+}
+
 int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 			struct qed_spq_entry **pp_ent,
 			u8 cmd, u8 protocol, struct qed_sp_init_data *p_data)
@@ -111,14 +124,7 @@ int qed_sp_init_request(struct qed_hwfn *p_hwfn,
 	return 0;
 
 err:
-	/* qed_spq_get_entry() can either get an entry from the free_pool,
-	 * or, if no entries are left, allocate a new entry and add it to
-	 * the unlimited_pending list.
-	 */
-	if (p_ent->queue == &p_hwfn->p_spq->unlimited_pending)
-		kfree(p_ent);
-	else
-		qed_spq_return_entry(p_hwfn, p_ent);
+	qed_sp_destroy_request(p_hwfn, p_ent);
 
 	return -EINVAL;
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index 9b08a9d9e151..ca6290fa0f30 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -101,6 +101,7 @@ static int qed_sp_vf_start(struct qed_hwfn *p_hwfn, struct qed_vf_info *p_vf)
 	default:
 		DP_NOTICE(p_hwfn, "Unknown VF personality %d\n",
 			  p_hwfn->hw_info.personality);
+		qed_sp_destroy_request(p_hwfn, p_ent);
 		return -EINVAL;
 	}
 
-- 
2.17.1



