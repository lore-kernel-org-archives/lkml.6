Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C77520856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C77520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbeGWMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:54:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388197AbeGWMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:54:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBmtHg023163
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kddqqa96a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:28 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 23 Jul 2018 12:53:25 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:53:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBrKVL34603026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:53:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C746F4C044;
        Mon, 23 Jul 2018 14:53:36 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 678584C050;
        Mon, 23 Jul 2018 14:53:36 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 14:53:36 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net/smc: add function to get link group from link
Date:   Mon, 23 Jul 2018 13:53:10 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072311-0020-0000-0000-000002A9E6F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-0021-0000-0000-000020F67193
Message-Id: <20180723115312.54694-4-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Raspl <raspl@linux.ibm.com>

Replace a frequently used construct with a more readable variant,
reducing the code. Also might come handy when we start to support
more than a single per link group.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_cdc.c  |  2 +-
 net/smc/smc_core.h |  5 +++++
 net/smc/smc_ib.c   |  3 +--
 net/smc/smc_llc.c  | 30 ++++++++----------------------
 net/smc/smc_wr.c   | 27 +++++----------------------
 5 files changed, 20 insertions(+), 47 deletions(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index f3a1497953ee..a7af2289cdff 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -365,7 +365,7 @@ static void smc_cdc_rx_handler(struct ib_wc *wc, void *buf)
 		return; /* invalid message */
 
 	/* lookup connection */
-	lgr = container_of(link, struct smc_link_group, lnk[SMC_SINGLE_LINK]);
+	lgr = smc_get_lgr(link);
 	read_lock_bh(&lgr->conns_lock);
 	conn = smc_lgr_find_conn(ntohl(cdc->token), lgr);
 	read_unlock_bh(&lgr->conns_lock);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 8b47e0168fc3..8807865483bb 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -266,4 +266,9 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 		    u64 peer_gid);
 void smcd_conn_free(struct smc_connection *conn);
 void smc_core_exit(void);
+
+static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
+{
+	return container_of(link, struct smc_link_group, lnk[SMC_SINGLE_LINK]);
+}
 #endif
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 36de2fd76170..4706ab7092a9 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -112,8 +112,7 @@ int smc_ib_modify_qp_reset(struct smc_link *lnk)
 
 int smc_ib_ready_link(struct smc_link *lnk)
 {
-	struct smc_link_group *lgr =
-		container_of(lnk, struct smc_link_group, lnk[0]);
+	struct smc_link_group *lgr = smc_get_lgr(lnk);
 	int rc = 0;
 
 	rc = smc_ib_modify_qp_init(lnk);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 5800a6b43d83..b7944aa1ffc3 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -186,8 +186,7 @@ int smc_llc_send_confirm_link(struct smc_link *link, u8 mac[],
 			      union ib_gid *gid,
 			      enum smc_llc_reqresp reqresp)
 {
-	struct smc_link_group *lgr = container_of(link, struct smc_link_group,
-						  lnk[SMC_SINGLE_LINK]);
+	struct smc_link_group *lgr = smc_get_lgr(link);
 	struct smc_llc_msg_confirm_link *confllc;
 	struct smc_wr_tx_pend_priv *pend;
 	struct smc_wr_buf *wr_buf;
@@ -381,11 +380,9 @@ static int smc_llc_send_message(struct smc_link *link, void *llcbuf, int llclen)
 static void smc_llc_rx_confirm_link(struct smc_link *link,
 				    struct smc_llc_msg_confirm_link *llc)
 {
-	struct smc_link_group *lgr;
+	struct smc_link_group *lgr = smc_get_lgr(link);
 	int conf_rc;
 
-	lgr = container_of(link, struct smc_link_group, lnk[SMC_SINGLE_LINK]);
-
 	/* RMBE eyecatchers are not supported */
 	if (llc->hd.flags & SMC_LLC_FLAG_NO_RMBE_EYEC)
 		conf_rc = 0;
@@ -411,8 +408,7 @@ static void smc_llc_rx_confirm_link(struct smc_link *link,
 static void smc_llc_rx_add_link(struct smc_link *link,
 				struct smc_llc_msg_add_link *llc)
 {
-	struct smc_link_group *lgr = container_of(link, struct smc_link_group,
-						  lnk[SMC_SINGLE_LINK]);
+	struct smc_link_group *lgr = smc_get_lgr(link);
 
 	if (llc->hd.flags & SMC_LLC_FLAG_RESP) {
 		if (link->state == SMC_LNK_ACTIVATING)
@@ -442,8 +438,7 @@ static void smc_llc_rx_add_link(struct smc_link *link,
 static void smc_llc_rx_delete_link(struct smc_link *link,
 				   struct smc_llc_msg_del_link *llc)
 {
-	struct smc_link_group *lgr = container_of(link, struct smc_link_group,
-						  lnk[SMC_SINGLE_LINK]);
+	struct smc_link_group *lgr = smc_get_lgr(link);
 
 	if (llc->hd.flags & SMC_LLC_FLAG_RESP) {
 		if (lgr->role == SMC_SERV)
@@ -476,17 +471,14 @@ static void smc_llc_rx_test_link(struct smc_link *link,
 static void smc_llc_rx_confirm_rkey(struct smc_link *link,
 				    struct smc_llc_msg_confirm_rkey *llc)
 {
-	struct smc_link_group *lgr;
 	int rc;
 
-	lgr = container_of(link, struct smc_link_group, lnk[SMC_SINGLE_LINK]);
-
 	if (llc->hd.flags & SMC_LLC_FLAG_RESP) {
 		link->llc_confirm_rkey_rc = llc->hd.flags &
 					    SMC_LLC_FLAG_RKEY_NEG;
 		complete(&link->llc_confirm_rkey);
 	} else {
-		rc = smc_rtoken_add(lgr,
+		rc = smc_rtoken_add(smc_get_lgr(link),
 				    llc->rtoken[0].rmb_vaddr,
 				    llc->rtoken[0].rmb_key);
 
@@ -514,18 +506,15 @@ static void smc_llc_rx_confirm_rkey_cont(struct smc_link *link,
 static void smc_llc_rx_delete_rkey(struct smc_link *link,
 				   struct smc_llc_msg_delete_rkey *llc)
 {
-	struct smc_link_group *lgr;
 	u8 err_mask = 0;
 	int i, max;
 
-	lgr = container_of(link, struct smc_link_group, lnk[SMC_SINGLE_LINK]);
-
 	if (llc->hd.flags & SMC_LLC_FLAG_RESP) {
 		/* unused as long as we don't send this type of msg */
 	} else {
 		max = min_t(u8, llc->num_rkeys, SMC_LLC_DEL_RKEY_MAX);
 		for (i = 0; i < max; i++) {
-			if (smc_rtoken_delete(lgr, llc->rkey[i]))
+			if (smc_rtoken_delete(smc_get_lgr(link), llc->rkey[i]))
 				err_mask |= 1 << (SMC_LLC_DEL_RKEY_MAX - 1 - i);
 		}
 
@@ -583,12 +572,10 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	struct smc_link *link = container_of(to_delayed_work(work),
 					     struct smc_link, llc_testlink_wrk);
 	unsigned long next_interval;
-	struct smc_link_group *lgr;
 	unsigned long expire_time;
 	u8 user_data[16] = { 0 };
 	int rc;
 
-	lgr = container_of(link, struct smc_link_group, lnk[SMC_SINGLE_LINK]);
 	if (link->state != SMC_LNK_ACTIVE)
 		return;		/* don't reschedule worker */
 	expire_time = link->wr_rx_tstamp + link->llc_testlink_time;
@@ -602,7 +589,7 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	rc = wait_for_completion_interruptible_timeout(&link->llc_testlink_resp,
 						       SMC_LLC_WAIT_TIME);
 	if (rc <= 0) {
-		smc_lgr_terminate(lgr);
+		smc_lgr_terminate(smc_get_lgr(link));
 		return;
 	}
 	next_interval = link->llc_testlink_time;
@@ -613,8 +600,7 @@ static void smc_llc_testlink_work(struct work_struct *work)
 
 int smc_llc_link_init(struct smc_link *link)
 {
-	struct smc_link_group *lgr = container_of(link, struct smc_link_group,
-						  lnk[SMC_SINGLE_LINK]);
+	struct smc_link_group *lgr = smc_get_lgr(link);
 	link->llc_wq = alloc_ordered_workqueue("llc_wq-%x:%x)", WQ_MEM_RECLAIM,
 					       *((u32 *)lgr->id),
 					       link->link_id);
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index dbd2605d1962..b6df69756bef 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -92,8 +92,6 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 	if (!test_and_clear_bit(pnd_snd_idx, link->wr_tx_mask))
 		return;
 	if (wc->status) {
-		struct smc_link_group *lgr;
-
 		for_each_set_bit(i, link->wr_tx_mask, link->wr_tx_cnt) {
 			/* clear full struct smc_wr_tx_pend including .priv */
 			memset(&link->wr_tx_pends[i], 0,
@@ -103,9 +101,7 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 			clear_bit(i, link->wr_tx_mask);
 		}
 		/* terminate connections of this link group abnormally */
-		lgr = container_of(link, struct smc_link_group,
-				   lnk[SMC_SINGLE_LINK]);
-		smc_lgr_terminate(lgr);
+		smc_lgr_terminate(smc_get_lgr(link));
 	}
 	if (pnd_snd.handler)
 		pnd_snd.handler(&pnd_snd.priv, link, wc->status);
@@ -188,8 +184,7 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 	} else {
 		struct smc_link_group *lgr;
 
-		lgr = container_of(link, struct smc_link_group,
-				   lnk[SMC_SINGLE_LINK]);
+		lgr = smc_get_lgr(link);
 		rc = wait_event_timeout(
 			link->wr_tx_wait,
 			list_empty(&lgr->list) || /* lgr terminated */
@@ -250,12 +245,8 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
 	rc = ib_post_send(link->roce_qp, &link->wr_tx_ibs[pend->idx],
 			  &failed_wr);
 	if (rc) {
-		struct smc_link_group *lgr =
-			container_of(link, struct smc_link_group,
-				     lnk[SMC_SINGLE_LINK]);
-
 		smc_wr_tx_put_slot(link, priv);
-		smc_lgr_terminate(lgr);
+		smc_lgr_terminate(smc_get_lgr(link));
 	}
 	return rc;
 }
@@ -283,11 +274,7 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 					      SMC_WR_REG_MR_WAIT_TIME);
 	if (!rc) {
 		/* timeout - terminate connections */
-		struct smc_link_group *lgr;
-
-		lgr = container_of(link, struct smc_link_group,
-				   lnk[SMC_SINGLE_LINK]);
-		smc_lgr_terminate(lgr);
+		smc_lgr_terminate(smc_get_lgr(link));
 		return -EPIPE;
 	}
 	if (rc == -ERESTARTSYS)
@@ -380,8 +367,6 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
 			smc_wr_rx_demultiplex(&wc[i]);
 			smc_wr_rx_post(link); /* refill WR RX */
 		} else {
-			struct smc_link_group *lgr;
-
 			/* handle status errors */
 			switch (wc[i].status) {
 			case IB_WC_RETRY_EXC_ERR:
@@ -390,9 +375,7 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
 				/* terminate connections of this link group
 				 * abnormally
 				 */
-				lgr = container_of(link, struct smc_link_group,
-						   lnk[SMC_SINGLE_LINK]);
-				smc_lgr_terminate(lgr);
+				smc_lgr_terminate(smc_get_lgr(link));
 				break;
 			default:
 				smc_wr_rx_post(link); /* refill WR RX */
-- 
2.16.4

