Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCC620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbeGYPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:47:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729507AbeGYPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:47:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PEY2Oh121496
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ketx2gmyr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 25 Jul 2018 15:35:47 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:35:44 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PEZgSS38666408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 14:35:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C71CE11C054;
        Wed, 25 Jul 2018 17:35:56 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D0A611C04A;
        Wed, 25 Jul 2018 17:35:56 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 17:35:56 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net/smc: provide fallback reason code
Date:   Wed, 25 Jul 2018 16:35:32 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180725143533.7082-1-ubraun@linux.ibm.com>
References: <20180725143533.7082-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072514-0028-0000-0000-000002E01765
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072514-0029-0000-0000-0000239803EB
Message-Id: <20180725143533.7082-4-ubraun@linux.ibm.com>
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

Remember the fallback reason code and the peer diagnosis code for
smc sockets, and provide them in smc_diag.c to the netlink interface.
And add more detailed reason codes.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 include/uapi/linux/smc_diag.h |  6 +++++
 net/smc/af_smc.c              | 52 +++++++++++++++++++++++++------------------
 net/smc/smc.h                 |  2 ++
 net/smc/smc_clc.c             |  6 ++++-
 net/smc/smc_clc.h             | 18 ++++++++++-----
 net/smc/smc_diag.c            |  6 +++++
 6 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 48ae3ee22b2d..ac9e8c96d9bd 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -43,6 +43,7 @@ enum {
 	SMC_DIAG_LGRINFO,
 	SMC_DIAG_SHUTDOWN,
 	SMC_DIAG_DMBINFO,
+	SMC_DIAG_FALLBACK,
 	__SMC_DIAG_MAX,
 };
 
@@ -92,6 +93,11 @@ struct smc_diag_lgrinfo {
 	__u8				role;
 };
 
+struct smc_diag_fallback {
+	__u32 reason;
+	__u32 peer_diagnosis;
+};
+
 struct smcd_diag_dmbinfo {		/* SMC-D Socket internals */
 	__u32 linkid;			/* Link identifier */
 	__u64 peer_gid;			/* Peer GID */
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index b81797103260..fce7e4751151 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -344,17 +344,17 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 
 	rc = smc_ib_modify_qp_rts(link);
 	if (rc)
-		return SMC_CLC_DECL_INTERR;
+		return SMC_CLC_DECL_ERR_RDYLNK;
 
 	smc_wr_remember_qp_attr(link);
 
 	if (smc_reg_rmb(link, smc->conn.rmb_desc, false))
-		return SMC_CLC_DECL_INTERR;
+		return SMC_CLC_DECL_ERR_REGRMB;
 
 	/* send CONFIRM LINK response over RoCE fabric */
 	rc = smc_llc_send_confirm_link(link, SMC_LLC_RESP);
 	if (rc < 0)
-		return SMC_CLC_DECL_TCL;
+		return SMC_CLC_DECL_TIMEOUT_CL;
 
 	/* receive ADD LINK request from server over RoCE fabric */
 	rest = wait_for_completion_interruptible_timeout(&link->llc_add,
@@ -372,7 +372,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 				   link->smcibdev->mac[link->ibport - 1],
 				   link->gid, SMC_LLC_RESP);
 	if (rc < 0)
-		return SMC_CLC_DECL_TCL;
+		return SMC_CLC_DECL_TIMEOUT_AL;
 
 	smc_llc_link_active(link, net->ipv4.sysctl_tcp_keepalive_time);
 
@@ -424,9 +424,10 @@ static void smc_link_save_peer_info(struct smc_link *link,
 }
 
 /* fall back during connect */
-static int smc_connect_fallback(struct smc_sock *smc)
+static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
 {
 	smc->use_fallback = true;
+	smc->fallback_rsn = reason_code;
 	smc_copy_sock_settings_to_clc(smc);
 	if (smc->sk.sk_state == SMC_INIT)
 		smc->sk.sk_state = SMC_ACTIVE;
@@ -443,7 +444,7 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code)
 			sock_put(&smc->sk); /* passive closing */
 		return reason_code;
 	}
-	if (reason_code != SMC_CLC_DECL_REPLY) {
+	if (reason_code != SMC_CLC_DECL_PEERDECL) {
 		rc = smc_clc_send_decline(smc, reason_code);
 		if (rc < 0) {
 			if (smc->sk.sk_state == SMC_INIT)
@@ -451,7 +452,7 @@ static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code)
 			return rc;
 		}
 	}
-	return smc_connect_fallback(smc);
+	return smc_connect_fallback(smc, reason_code);
 }
 
 /* abort connecting */
@@ -568,7 +569,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 		smc_link_save_peer_info(link, aclc);
 
 	if (smc_rmb_rtoken_handling(&smc->conn, aclc))
-		return smc_connect_abort(smc, SMC_CLC_DECL_INTERR,
+		return smc_connect_abort(smc, SMC_CLC_DECL_ERR_RTOK,
 					 local_contact);
 
 	smc_close_init(smc);
@@ -576,12 +577,12 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	if (local_contact == SMC_FIRST_CONTACT) {
 		if (smc_ib_ready_link(link))
-			return smc_connect_abort(smc, SMC_CLC_DECL_INTERR,
+			return smc_connect_abort(smc, SMC_CLC_DECL_ERR_RDYLNK,
 						 local_contact);
 	} else {
 		if (!smc->conn.rmb_desc->reused &&
 		    smc_reg_rmb(link, smc->conn.rmb_desc, true))
-			return smc_connect_abort(smc, SMC_CLC_DECL_INTERR,
+			return smc_connect_abort(smc, SMC_CLC_DECL_ERR_REGRMB,
 						 local_contact);
 	}
 	smc_rmb_sync_sg_for_device(&smc->conn);
@@ -659,11 +660,11 @@ static int __smc_connect(struct smc_sock *smc)
 	sock_hold(&smc->sk); /* sock put in passive closing */
 
 	if (smc->use_fallback)
-		return smc_connect_fallback(smc);
+		return smc_connect_fallback(smc, smc->fallback_rsn);
 
 	/* if peer has not signalled SMC-capability, fall back */
 	if (!tcp_sk(smc->clcsock->sk)->syn_smc)
-		return smc_connect_fallback(smc);
+		return smc_connect_fallback(smc, SMC_CLC_DECL_PEERNOSMC);
 
 	/* IPSec connections opt out of SMC-R optimizations */
 	if (using_ipsec(smc))
@@ -693,7 +694,7 @@ static int __smc_connect(struct smc_sock *smc)
 
 	/* if neither ISM nor RDMA are supported, fallback */
 	if (!rdma_supported && !ism_supported)
-		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_CNFERR);
+		return smc_connect_decline_fallback(smc, SMC_CLC_DECL_NOSMCDEV);
 
 	/* perform CLC handshake */
 	rc = smc_connect_clc(smc, smc_type, &aclc, ibdev, ibport, gid, ismdev);
@@ -708,7 +709,7 @@ static int __smc_connect(struct smc_sock *smc)
 	else if (ism_supported && aclc.hdr.path == SMC_TYPE_D)
 		rc = smc_connect_ism(smc, &aclc, ismdev);
 	else
-		rc = SMC_CLC_DECL_CNFERR;
+		rc = SMC_CLC_DECL_MODEUNSUPP;
 	if (rc) {
 		smc_connect_ism_vlan_cleanup(smc, ism_supported, ismdev, vlan);
 		return smc_connect_decline_fallback(smc, rc);
@@ -946,12 +947,12 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 	link = &lgr->lnk[SMC_SINGLE_LINK];
 
 	if (smc_reg_rmb(link, smc->conn.rmb_desc, false))
-		return SMC_CLC_DECL_INTERR;
+		return SMC_CLC_DECL_ERR_REGRMB;
 
 	/* send CONFIRM LINK request to client over the RoCE fabric */
 	rc = smc_llc_send_confirm_link(link, SMC_LLC_REQ);
 	if (rc < 0)
-		return SMC_CLC_DECL_TCL;
+		return SMC_CLC_DECL_TIMEOUT_CL;
 
 	/* receive CONFIRM LINK response from client over the RoCE fabric */
 	rest = wait_for_completion_interruptible_timeout(
@@ -973,7 +974,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 				   link->smcibdev->mac[link->ibport - 1],
 				   link->gid, SMC_LLC_REQ);
 	if (rc < 0)
-		return SMC_CLC_DECL_TCL;
+		return SMC_CLC_DECL_TIMEOUT_AL;
 
 	/* receive ADD LINK response from client over the RoCE fabric */
 	rest = wait_for_completion_interruptible_timeout(&link->llc_add_resp,
@@ -1048,7 +1049,8 @@ static void smc_listen_decline(struct smc_sock *new_smc, int reason_code,
 	}
 	smc_conn_free(&new_smc->conn);
 	new_smc->use_fallback = true;
-	if (reason_code && reason_code != SMC_CLC_DECL_REPLY) {
+	new_smc->fallback_rsn = reason_code;
+	if (reason_code && reason_code != SMC_CLC_DECL_PEERDECL) {
 		if (smc_clc_send_decline(new_smc, reason_code) < 0) {
 			smc_listen_out_err(new_smc);
 			return;
@@ -1139,7 +1141,7 @@ static int smc_listen_rdma_reg(struct smc_sock *new_smc, int local_contact)
 	if (local_contact != SMC_FIRST_CONTACT) {
 		if (!new_smc->conn.rmb_desc->reused) {
 			if (smc_reg_rmb(link, new_smc->conn.rmb_desc, true))
-				return SMC_CLC_DECL_INTERR;
+				return SMC_CLC_DECL_ERR_REGRMB;
 		}
 	}
 	smc_rmb_sync_sg_for_device(&new_smc->conn);
@@ -1159,13 +1161,13 @@ static void smc_listen_rdma_finish(struct smc_sock *new_smc,
 		smc_link_save_peer_info(link, cclc);
 
 	if (smc_rmb_rtoken_handling(&new_smc->conn, cclc)) {
-		reason_code = SMC_CLC_DECL_INTERR;
+		reason_code = SMC_CLC_DECL_ERR_RTOK;
 		goto decline;
 	}
 
 	if (local_contact == SMC_FIRST_CONTACT) {
 		if (smc_ib_ready_link(link)) {
-			reason_code = SMC_CLC_DECL_INTERR;
+			reason_code = SMC_CLC_DECL_ERR_RDYLNK;
 			goto decline;
 		}
 		/* QP confirmation over RoCE fabric */
@@ -1206,6 +1208,7 @@ static void smc_listen_work(struct work_struct *work)
 	/* check if peer is smc capable */
 	if (!tcp_sk(newclcsock->sk)->syn_smc) {
 		new_smc->use_fallback = true;
+		new_smc->fallback_rsn = SMC_CLC_DECL_PEERNOSMC;
 		smc_listen_out_connected(new_smc);
 		return;
 	}
@@ -1250,7 +1253,8 @@ static void smc_listen_work(struct work_struct *work)
 	     smc_listen_rdma_reg(new_smc, local_contact))) {
 		/* SMC not supported, decline */
 		mutex_unlock(&smc_create_lgr_pending);
-		smc_listen_decline(new_smc, SMC_CLC_DECL_CNFERR, local_contact);
+		smc_listen_decline(new_smc, SMC_CLC_DECL_MODEUNSUPP,
+				   local_contact);
 		return;
 	}
 
@@ -1297,6 +1301,7 @@ static void smc_tcp_listen_work(struct work_struct *work)
 
 		new_smc->listen_smc = lsmc;
 		new_smc->use_fallback = lsmc->use_fallback;
+		new_smc->fallback_rsn = lsmc->fallback_rsn;
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
@@ -1451,6 +1456,7 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (msg->msg_flags & MSG_FASTOPEN) {
 		if (sk->sk_state == SMC_INIT) {
 			smc->use_fallback = true;
+			smc->fallback_rsn = SMC_CLC_DECL_OPTUNSUPP;
 		} else {
 			rc = -EINVAL;
 			goto out;
@@ -1648,6 +1654,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		/* option not supported by SMC */
 		if (sk->sk_state == SMC_INIT) {
 			smc->use_fallback = true;
+			smc->fallback_rsn = SMC_CLC_DECL_OPTUNSUPP;
 		} else {
 			if (!smc->use_fallback)
 				rc = -EINVAL;
@@ -1885,6 +1892,7 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 	/* create internal TCP socket for CLC handshake and fallback */
 	smc = smc_sk(sk);
 	smc->use_fallback = false; /* assume rdma capability first */
+	smc->fallback_rsn = 0;
 	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
 			      &smc->clcsock);
 	if (rc) {
diff --git a/net/smc/smc.h b/net/smc/smc.h
index be20acd7b5ab..08786ace6010 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -208,6 +208,8 @@ struct smc_sock {				/* smc sock container */
 	struct list_head	accept_q;	/* sockets to be accepted */
 	spinlock_t		accept_q_lock;	/* protects accept_q */
 	bool			use_fallback;	/* fallback to tcp */
+	int			fallback_rsn;	/* reason for fallback */
+	u32			peer_diagnosis; /* decline reason from peer */
 	int			sockopt_defer_accept;
 						/* sockopt TCP_DEFER_ACCEPT
 						 * value
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 78d74938a9d9..83aba9ade060 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -334,7 +334,11 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		goto out;
 	}
 	if (clcm->type == SMC_CLC_DECLINE) {
-		reason_code = SMC_CLC_DECL_REPLY;
+		struct smc_clc_msg_decline *dclc;
+
+		dclc = (struct smc_clc_msg_decline *)clcm;
+		reason_code = SMC_CLC_DECL_PEERDECL;
+		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
 		if (((struct smc_clc_msg_decline *)buf)->hdr.flag) {
 			smc->conn.lgr->sync_err = 1;
 			smc_lgr_terminate(smc->conn.lgr);
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 6bdc63352d6a..18da89b681c2 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -28,15 +28,21 @@
 #define SMC_TYPE_B		3		/* SMC-R and SMC-D	      */
 #define CLC_WAIT_TIME		(6 * HZ)	/* max. wait time on clcsock  */
 #define SMC_CLC_DECL_MEM	0x01010000  /* insufficient memory resources  */
-#define SMC_CLC_DECL_TIMEOUT	0x02000000  /* timeout                        */
+#define SMC_CLC_DECL_TIMEOUT_CL	0x02010000  /* timeout w4 QP confirm link     */
+#define SMC_CLC_DECL_TIMEOUT_AL	0x02020000  /* timeout w4 QP add link	      */
 #define SMC_CLC_DECL_CNFERR	0x03000000  /* configuration error            */
-#define SMC_CLC_DECL_IPSEC	0x03030000  /* IPsec usage                    */
+#define SMC_CLC_DECL_PEERNOSMC	0x03010000  /* peer did not indicate SMC      */
+#define SMC_CLC_DECL_IPSEC	0x03020000  /* IPsec usage		      */
+#define SMC_CLC_DECL_NOSMCDEV	0x03030000  /* no SMC device found	      */
+#define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
+#define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
+#define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
 #define SMC_CLC_DECL_SYNCERR	0x04000000  /* synchronization error          */
-#define SMC_CLC_DECL_REPLY	0x06000000  /* reply to a received decline    */
+#define SMC_CLC_DECL_PEERDECL	0x05000000  /* peer declined during handshake */
 #define SMC_CLC_DECL_INTERR	0x99990000  /* internal error                 */
-#define SMC_CLC_DECL_TCL	0x02040000  /* timeout w4 QP confirm          */
-#define SMC_CLC_DECL_SEND	0x07000000  /* sending problem                */
-#define SMC_CLC_DECL_RMBE_EC	0x08000000  /* peer has eyecatcher in RMBE    */
+#define SMC_CLC_DECL_ERR_RTOK	0x99990001  /*	 rtoken handling failed       */
+#define SMC_CLC_DECL_ERR_RDYLNK	0x99990002  /*	 ib ready link failed	      */
+#define SMC_CLC_DECL_ERR_REGRMB	0x99990003  /*	 reg rmb failed		      */
 
 struct smc_clc_msg_hdr {	/* header1 of clc messages */
 	u8 eyecatcher[4];	/* eye catcher */
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index a3cf7313a2d3..dbf64a93d68a 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -79,6 +79,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 			   struct nlattr *bc)
 {
 	struct smc_sock *smc = smc_sk(sk);
+	struct smc_diag_fallback fallback;
 	struct user_namespace *user_ns;
 	struct smc_diag_msg *r;
 	struct nlmsghdr *nlh;
@@ -101,6 +102,11 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	if (smc_diag_msg_attrs_fill(sk, skb, r, user_ns))
 		goto errout;
 
+	fallback.reason = smc->fallback_rsn;
+	fallback.peer_diagnosis = smc->peer_diagnosis;
+	if (nla_put(skb, SMC_DIAG_FALLBACK, sizeof(fallback), &fallback) < 0)
+		goto errout;
+
 	if ((req->diag_ext & (1 << (SMC_DIAG_CONNINFO - 1))) &&
 	    smc->conn.alert_token_local) {
 		struct smc_connection *conn = &smc->conn;
-- 
2.16.4

