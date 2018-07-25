Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB87C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F6E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F6E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeGYPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:47:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729509AbeGYPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:47:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PEY0B7013058
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kes1075s3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:50 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 25 Jul 2018 15:35:48 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:35:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PEZiBO43122816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 14:35:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BEAF11C058;
        Wed, 25 Jul 2018 17:35:58 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D32F311C04A;
        Wed, 25 Jul 2018 17:35:57 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 17:35:57 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net/smc: improve delete link processing
Date:   Wed, 25 Jul 2018 16:35:33 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180725143533.7082-1-ubraun@linux.ibm.com>
References: <20180725143533.7082-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072514-0028-0000-0000-000002E01767
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072514-0029-0000-0000-0000239803EC
Message-Id: <20180725143533.7082-5-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

Send an orderly DELETE LINK request before termination of a link group,
add support for client triggered DELETE LINK processing. And send a
disorderly DELETE LINK before module is unloaded.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 net/smc/smc_core.h |  4 +++-
 net/smc/smc_llc.c  | 30 +++++++++++++++++++-----------
 net/smc/smc_llc.h  |  3 ++-
 net/smc/smc_wr.c   |  7 ++-----
 5 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 90c10ae9ae09..a46418f45ecd 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -30,6 +30,7 @@
 #define SMC_LGR_NUM_INCR		256
 #define SMC_LGR_FREE_DELAY_SERV		(600 * HZ)
 #define SMC_LGR_FREE_DELAY_CLNT		(SMC_LGR_FREE_DELAY_SERV + 10 * HZ)
+#define SMC_LGR_FREE_DELAY_FAST		(8 * HZ)
 
 static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 	.lock = __SPIN_LOCK_UNLOCKED(smc_lgr_list.lock),
@@ -51,6 +52,11 @@ static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 			 SMC_LGR_FREE_DELAY_CLNT : SMC_LGR_FREE_DELAY_SERV);
 }
 
+void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr)
+{
+	mod_delayed_work(system_wq, &lgr->free_work, SMC_LGR_FREE_DELAY_FAST);
+}
+
 /* Register connection's alert token in our lookup structure.
  * To use rbtrees we have to implement our own insert core.
  * Requires @conns_lock
@@ -133,6 +139,20 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	smc_lgr_schedule_free_work(lgr);
 }
 
+/* Send delete link, either as client to request the initiation
+ * of the DELETE LINK sequence from server; or as server to
+ * initiate the delete processing. See smc_llc_rx_delete_link().
+ */
+static int smc_link_send_delete(struct smc_link *lnk)
+{
+	if (lnk->state == SMC_LNK_ACTIVE &&
+	    !smc_llc_send_delete_link(lnk, SMC_LLC_REQ, true)) {
+		smc_llc_link_deleting(lnk);
+		return 0;
+	}
+	return -ENOTCONN;
+}
+
 static void smc_lgr_free_work(struct work_struct *work)
 {
 	struct smc_link_group *lgr = container_of(to_delayed_work(work),
@@ -153,10 +173,21 @@ static void smc_lgr_free_work(struct work_struct *work)
 	list_del_init(&lgr->list); /* remove from smc_lgr_list */
 free:
 	spin_unlock_bh(&smc_lgr_list.lock);
+
+	if (!lgr->is_smcd && !lgr->terminating)	{
+		/* try to send del link msg, on error free lgr immediately */
+		if (!smc_link_send_delete(&lgr->lnk[SMC_SINGLE_LINK])) {
+			/* reschedule in case we never receive a response */
+			smc_lgr_schedule_free_work(lgr);
+			return;
+		}
+	}
+
 	if (!delayed_work_pending(&lgr->free_work)) {
-		if (!lgr->is_smcd &&
-		    lgr->lnk[SMC_SINGLE_LINK].state != SMC_LNK_INACTIVE)
-			smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
+		struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
+
+		if (!lgr->is_smcd && lnk->state != SMC_LNK_INACTIVE)
+			smc_llc_link_inactive(lnk);
 		smc_lgr_free(lgr);
 	}
 }
@@ -984,8 +1015,14 @@ void smc_core_exit(void)
 	spin_unlock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, lg, &lgr_freeing_list, list) {
 		list_del_init(&lgr->list);
-		if (!lgr->is_smcd)
-			smc_llc_link_inactive(&lgr->lnk[SMC_SINGLE_LINK]);
+		if (!lgr->is_smcd) {
+			struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
+
+			if (lnk->state == SMC_LNK_ACTIVE)
+				smc_llc_send_delete_link(lnk, SMC_LLC_REQ,
+							 false);
+			smc_llc_link_inactive(lnk);
+		}
 		cancel_delayed_work_sync(&lgr->free_work);
 		smc_lgr_free(lgr); /* free link group */
 	}
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index a4f0cc4e0270..c156674733c9 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -34,7 +34,8 @@ enum smc_lgr_role {		/* possible roles of a link group */
 enum smc_link_state {			/* possible states of a link */
 	SMC_LNK_INACTIVE,	/* link is inactive */
 	SMC_LNK_ACTIVATING,	/* link is being activated */
-	SMC_LNK_ACTIVE		/* link is active */
+	SMC_LNK_ACTIVE,		/* link is active */
+	SMC_LNK_DELETING,	/* link is being deleted */
 };
 
 #define SMC_WR_BUF_SIZE		48	/* size of work request buffer */
@@ -265,6 +266,7 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 		    struct smc_clc_msg_local *lcl, struct smcd_dev *smcd,
 		    u64 peer_gid);
 void smcd_conn_free(struct smc_connection *conn);
+void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
 void smc_core_exit(void);
 
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index a88c01029fa6..9c916c709ca7 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -278,7 +278,7 @@ int smc_llc_send_add_link(struct smc_link *link, u8 mac[], u8 gid[],
 /* prepare a delete link message */
 static void smc_llc_prep_delete_link(struct smc_llc_msg_del_link *delllc,
 				     struct smc_link *link,
-				     enum smc_llc_reqresp reqresp)
+				     enum smc_llc_reqresp reqresp, bool orderly)
 {
 	memset(delllc, 0, sizeof(*delllc));
 	delllc->hd.common.type = SMC_LLC_DELETE_LINK;
@@ -287,13 +287,14 @@ static void smc_llc_prep_delete_link(struct smc_llc_msg_del_link *delllc,
 		delllc->hd.flags |= SMC_LLC_FLAG_RESP;
 	/* DEL_LINK_ALL because only 1 link supported */
 	delllc->hd.flags |= SMC_LLC_FLAG_DEL_LINK_ALL;
-	delllc->hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
+	if (orderly)
+		delllc->hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
 	delllc->link_num = link->link_id;
 }
 
 /* send DELETE LINK request or response */
 int smc_llc_send_delete_link(struct smc_link *link,
-			     enum smc_llc_reqresp reqresp)
+			     enum smc_llc_reqresp reqresp, bool orderly)
 {
 	struct smc_llc_msg_del_link *delllc;
 	struct smc_wr_tx_pend_priv *pend;
@@ -304,7 +305,7 @@ int smc_llc_send_delete_link(struct smc_link *link,
 	if (rc)
 		return rc;
 	delllc = (struct smc_llc_msg_del_link *)wr_buf;
-	smc_llc_prep_delete_link(delllc, link, reqresp);
+	smc_llc_prep_delete_link(delllc, link, reqresp, orderly);
 	/* send llc message */
 	rc = smc_wr_tx_send(link, pend);
 	return rc;
@@ -438,17 +439,19 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 
 	if (llc->hd.flags & SMC_LLC_FLAG_RESP) {
 		if (lgr->role == SMC_SERV)
-			smc_lgr_terminate(lgr);
+			smc_lgr_schedule_free_work_fast(lgr);
 	} else {
+		smc_lgr_forget(lgr);
+		smc_llc_link_deleting(link);
 		if (lgr->role == SMC_SERV) {
-			smc_lgr_forget(lgr);
-			smc_llc_prep_delete_link(llc, link, SMC_LLC_REQ);
-			smc_llc_send_message(link, llc, sizeof(*llc));
+			/* client asks to delete this link, send request */
+			smc_llc_prep_delete_link(llc, link, SMC_LLC_REQ, true);
 		} else {
-			smc_llc_prep_delete_link(llc, link, SMC_LLC_RESP);
-			smc_llc_send_message(link, llc, sizeof(*llc));
-			smc_lgr_terminate(lgr);
+			/* server requests to delete this link, send response */
+			smc_llc_prep_delete_link(llc, link, SMC_LLC_RESP, true);
 		}
+		smc_llc_send_message(link, llc, sizeof(*llc));
+		smc_lgr_schedule_free_work_fast(lgr);
 	}
 }
 
@@ -622,6 +625,11 @@ void smc_llc_link_active(struct smc_link *link, int testlink_time)
 	}
 }
 
+void smc_llc_link_deleting(struct smc_link *link)
+{
+	link->state = SMC_LNK_DELETING;
+}
+
 /* called in tasklet context */
 void smc_llc_link_inactive(struct smc_link *link)
 {
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 95a7f3662e59..9e2ff088e301 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -41,9 +41,10 @@ int smc_llc_send_confirm_link(struct smc_link *lnk,
 int smc_llc_send_add_link(struct smc_link *link, u8 mac[], u8 gid[],
 			  enum smc_llc_reqresp reqresp);
 int smc_llc_send_delete_link(struct smc_link *link,
-			     enum smc_llc_reqresp reqresp);
+			     enum smc_llc_reqresp reqresp, bool orderly);
 int smc_llc_link_init(struct smc_link *link);
 void smc_llc_link_active(struct smc_link *link, int testlink_time);
+void smc_llc_link_deleting(struct smc_link *link);
 void smc_llc_link_inactive(struct smc_link *link);
 void smc_llc_link_clear(struct smc_link *link);
 int smc_llc_do_confirm_rkey(struct smc_link *link,
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index b6df69756bef..f856b8402b3f 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -182,17 +182,14 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 		if (rc)
 			return rc;
 	} else {
-		struct smc_link_group *lgr;
-
-		lgr = smc_get_lgr(link);
 		rc = wait_event_timeout(
 			link->wr_tx_wait,
-			list_empty(&lgr->list) || /* lgr terminated */
+			link->state == SMC_LNK_INACTIVE ||
 			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
 			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
 		if (!rc) {
 			/* timeout - terminate connections */
-			smc_lgr_terminate(lgr);
+			smc_lgr_terminate(smc_get_lgr(link));
 			return -EPIPE;
 		}
 		if (idx == link->wr_tx_cnt)
-- 
2.16.4

