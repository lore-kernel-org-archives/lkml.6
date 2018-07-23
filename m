Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URG_BIZ,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35674ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE13D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE13D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeGWMyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:54:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388147AbeGWMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:54:17 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6NBoreM028083
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:26 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kdb590cgf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:53:25 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 23 Jul 2018 12:53:23 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Jul 2018 12:53:21 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6NBrJUL42729510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jul 2018 11:53:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58C914C040;
        Mon, 23 Jul 2018 14:53:35 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEF394C04A;
        Mon, 23 Jul 2018 14:53:34 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 Jul 2018 14:53:34 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net/smc: eliminate cursor read and write calls
Date:   Mon, 23 Jul 2018 13:53:09 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180723115312.54694-1-ubraun@linux.ibm.com>
References: <20180723115312.54694-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072311-0016-0000-0000-000001EA2DDA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072311-0017-0000-0000-0000323F0314
Message-Id: <20180723115312.54694-3-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-23_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807230139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Raspl <raspl@linux.ibm.com>

The functions to read and write cursors are exclusively used to copy
cursors. Therefore switch to a respective function instead.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  |  8 ++------
 net/smc/smc_cdc.c | 33 ++++++++++++---------------------
 net/smc/smc_cdc.h | 43 +++++++++++++++----------------------------
 net/smc/smc_rx.c  | 15 ++++-----------
 net/smc/smc_tx.c  | 46 +++++++++++++---------------------------------
 net/smc/smc_tx.h  |  4 ++--
 6 files changed, 48 insertions(+), 101 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 143b2220c0c8..7fc810ec31c5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1755,12 +1755,8 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
 		    smc->sk.sk_state == SMC_CLOSED) {
 			answ = 0;
 		} else {
-			smc_curs_write(&cons,
-			       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-				       conn);
-			smc_curs_write(&urg,
-				       smc_curs_read(&conn->urg_curs, conn),
-				       conn);
+			smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
+			smc_curs_copy(&urg, &conn->urg_curs, conn);
 			answ = smc_curs_diff(conn->rmb_desc->len,
 					     &cons, &urg) == 1;
 		}
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 621d8cca570b..f3a1497953ee 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -34,14 +34,15 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 			       enum ib_wc_status wc_status)
 {
 	struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend *)pnd_snd;
+	struct smc_connection *conn = cdcpend->conn;
 	struct smc_sock *smc;
 	int diff;
 
-	if (!cdcpend->conn)
+	if (!conn)
 		/* already dismissed */
 		return;
 
-	smc = container_of(cdcpend->conn, struct smc_sock, conn);
+	smc = container_of(conn, struct smc_sock, conn);
 	bh_lock_sock(&smc->sk);
 	if (!wc_status) {
 		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
@@ -52,9 +53,7 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 		atomic_add(diff, &cdcpend->conn->sndbuf_space);
 		/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 		smp_mb__after_atomic();
-		smc_curs_write(&cdcpend->conn->tx_curs_fin,
-			       smc_curs_read(&cdcpend->cursor, cdcpend->conn),
-			       cdcpend->conn);
+		smc_curs_copy(&conn->tx_curs_fin, &cdcpend->cursor, conn);
 	}
 	smc_tx_sndbuf_nonfull(smc);
 	bh_unlock_sock(&smc->sk);
@@ -110,9 +109,8 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 			    &conn->local_tx_ctrl, conn);
 	rc = smc_wr_tx_send(link, (struct smc_wr_tx_pend_priv *)pend);
 	if (!rc)
-		smc_curs_write(&conn->rx_curs_confirmed,
-			       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-			       conn);
+		smc_curs_copy(&conn->rx_curs_confirmed,
+			      &conn->local_tx_ctrl.cons, conn);
 
 	return rc;
 }
@@ -194,8 +192,8 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
 	rc = smcd_tx_ism_write(conn, &cdc, sizeof(cdc), 0, 1);
 	if (rc)
 		return rc;
-	smc_curs_write(&conn->rx_curs_confirmed,
-		       smc_curs_read(&conn->local_tx_ctrl.cons, conn), conn);
+	smc_curs_copy(&conn->rx_curs_confirmed, &conn->local_tx_ctrl.cons,
+		      conn);
 	/* Calculate transmitted data and increment free send buffer space */
 	diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
 			     &conn->tx_curs_sent);
@@ -204,8 +202,7 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
 	atomic_add(diff, &conn->sndbuf_space);
 	/* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
 	smp_mb__after_atomic();
-	smc_curs_write(&conn->tx_curs_fin,
-		       smc_curs_read(&conn->tx_curs_sent, conn), conn);
+	smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
 
 	smc_tx_sndbuf_nonfull(smc);
 	return rc;
@@ -225,9 +222,7 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
 	char *base;
 
 	/* new data included urgent business */
-	smc_curs_write(&conn->urg_curs,
-		       smc_curs_read(&conn->local_rx_ctrl.prod, conn),
-		       conn);
+	smc_curs_copy(&conn->urg_curs, &conn->local_rx_ctrl.prod, conn);
 	conn->urg_state = SMC_URG_VALID;
 	if (!sock_flag(&smc->sk, SOCK_URGINLINE))
 		/* we'll skip the urgent byte, so don't account for it */
@@ -247,12 +242,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	struct smc_connection *conn = &smc->conn;
 	int diff_cons, diff_prod;
 
-	smc_curs_write(&prod_old,
-		       smc_curs_read(&conn->local_rx_ctrl.prod, conn),
-		       conn);
-	smc_curs_write(&cons_old,
-		       smc_curs_read(&conn->local_rx_ctrl.cons, conn),
-		       conn);
+	smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
+	smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
 	smc_cdc_msg_to_host(&conn->local_rx_ctrl, cdc, conn);
 
 	diff_cons = smc_curs_diff(conn->peer_rmbe_size, &cons_old,
diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
index 8fbce4fee3e4..934df4473a7c 100644
--- a/net/smc/smc_cdc.h
+++ b/net/smc/smc_cdc.h
@@ -104,47 +104,34 @@ static inline u64 smc_curs_read(union smc_host_cursor *curs,
 #endif
 }
 
-static inline u64 smc_curs_read_net(union smc_cdc_cursor *curs,
-				    struct smc_connection *conn)
-{
-#ifndef KERNEL_HAS_ATOMIC64
-	unsigned long flags;
-	u64 ret;
-
-	spin_lock_irqsave(&conn->acurs_lock, flags);
-	ret = curs->acurs;
-	spin_unlock_irqrestore(&conn->acurs_lock, flags);
-	return ret;
-#else
-	return atomic64_read(&curs->acurs);
-#endif
-}
-
-static inline void smc_curs_write(union smc_host_cursor *curs, u64 val,
-				  struct smc_connection *conn)
+/* Copy cursor src into tgt */
+static inline void smc_curs_copy(union smc_host_cursor *tgt,
+				 union smc_host_cursor *src,
+				 struct smc_connection *conn)
 {
 #ifndef KERNEL_HAS_ATOMIC64
 	unsigned long flags;
 
 	spin_lock_irqsave(&conn->acurs_lock, flags);
-	curs->acurs = val;
+	tgt->acurs = src->acurs;
 	spin_unlock_irqrestore(&conn->acurs_lock, flags);
 #else
-	atomic64_set(&curs->acurs, val);
+	atomic64_set(&tgt->acurs, atomic64_read(&src->acurs));
 #endif
 }
 
-static inline void smc_curs_write_net(union smc_cdc_cursor *curs, u64 val,
-				      struct smc_connection *conn)
+static inline void smc_curs_copy_net(union smc_cdc_cursor *tgt,
+				     union smc_cdc_cursor *src,
+				     struct smc_connection *conn)
 {
 #ifndef KERNEL_HAS_ATOMIC64
 	unsigned long flags;
 
 	spin_lock_irqsave(&conn->acurs_lock, flags);
-	curs->acurs = val;
+	tgt->acurs = src->acurs;
 	spin_unlock_irqrestore(&conn->acurs_lock, flags);
 #else
-	atomic64_set(&curs->acurs, val);
+	atomic64_set(&tgt->acurs, atomic64_read(&src->acurs));
 #endif
 }
 
@@ -179,7 +166,7 @@ static inline void smc_host_cursor_to_cdc(union smc_cdc_cursor *peer,
 {
 	union smc_host_cursor temp;
 
-	smc_curs_write(&temp, smc_curs_read(local, conn), conn);
+	smc_curs_copy(&temp, local, conn);
 	peer->count = htonl(temp.count);
 	peer->wrap = htons(temp.wrap);
 	/* peer->reserved = htons(0); must be ensured by caller */
@@ -206,8 +193,8 @@ static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
 	union smc_host_cursor temp, old;
 	union smc_cdc_cursor net;
 
-	smc_curs_write(&old, smc_curs_read(local, conn), conn);
-	smc_curs_write_net(&net, smc_curs_read_net(peer, conn), conn);
+	smc_curs_copy(&old, local, conn);
+	smc_curs_copy_net(&net, peer, conn);
 	temp.count = ntohl(net.count);
 	temp.wrap = ntohs(net.wrap);
 	if ((old.wrap > temp.wrap) && temp.wrap)
@@ -215,7 +202,7 @@ static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
 	if ((old.wrap == temp.wrap) &&
 	    (old.count > temp.count))
 		return;
-	smc_curs_write(local, smc_curs_read(&temp, conn), conn);
+	smc_curs_copy(local, &temp, conn);
 }
 
 static inline void smcr_cdc_msg_to_host(struct smc_host_cdc_msg *local,
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index b329803c8339..c99c987097b1 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -82,8 +82,7 @@ static int smc_rx_update_consumer(struct smc_sock *smc,
 		}
 	}
 
-	smc_curs_write(&conn->local_tx_ctrl.cons, smc_curs_read(&cons, conn),
-		       conn);
+	smc_curs_copy(&conn->local_tx_ctrl.cons, &cons, conn);
 
 	/* send consumer cursor update if required */
 	/* similar to advertising new TCP rcv_wnd if required */
@@ -97,8 +96,7 @@ static void smc_rx_update_cons(struct smc_sock *smc, size_t len)
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor cons;
 
-	smc_curs_write(&cons, smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-		       conn);
+	smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
 	smc_rx_update_consumer(smc, cons, len);
 }
 
@@ -245,10 +243,7 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 			if (!(flags & MSG_TRUNC))
 				rc = memcpy_to_msg(msg, &conn->urg_rx_byte, 1);
 			len = 1;
-			smc_curs_write(&cons,
-				       smc_curs_read(&conn->local_tx_ctrl.cons,
-						     conn),
-				       conn);
+			smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
 			if (smc_curs_diff(conn->rmb_desc->len, &cons,
 					  &conn->urg_curs) > 1)
 				conn->urg_rx_skip_pend = true;
@@ -370,9 +365,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			continue;
 		}
 
-		smc_curs_write(&cons,
-			       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-			       conn);
+		smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
 		/* subsequent splice() calls pick up where previous left */
 		if (splbytes)
 			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 142bcb134dd6..2f5e324e54b9 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -181,9 +181,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		copylen = min_t(size_t, send_remaining, writespace);
 		/* determine start of sndbuf */
 		sndbuf_base = conn->sndbuf_desc->cpu_addr;
-		smc_curs_write(&prep,
-			       smc_curs_read(&conn->tx_curs_prep, conn),
-			       conn);
+		smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
 		tx_cnt_prep = prep.count;
 		/* determine chunks where to write into sndbuf */
 		/* either unwrapped case, or 1st chunk of wrapped case */
@@ -214,9 +212,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		smc_sndbuf_sync_sg_for_device(conn);
 		/* update cursors */
 		smc_curs_add(conn->sndbuf_desc->len, &prep, copylen);
-		smc_curs_write(&conn->tx_curs_prep,
-			       smc_curs_read(&prep, conn),
-			       conn);
+		smc_curs_copy(&conn->tx_curs_prep, &prep, conn);
 		/* increased in send tasklet smc_cdc_tx_handler() */
 		smp_mb__before_atomic();
 		atomic_sub(copylen, &conn->sndbuf_space);
@@ -417,8 +413,8 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 	int rc;
 
 	/* source: sndbuf */
-	smc_curs_write(&sent, smc_curs_read(&conn->tx_curs_sent, conn), conn);
-	smc_curs_write(&prep, smc_curs_read(&conn->tx_curs_prep, conn), conn);
+	smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
+	smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
 	/* cf. wmem_alloc - (snd_max - snd_una) */
 	to_send = smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
 	if (to_send <= 0)
@@ -429,12 +425,8 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 	rmbespace = atomic_read(&conn->peer_rmbe_space);
 	if (rmbespace <= 0)
 		return 0;
-	smc_curs_write(&prod,
-		       smc_curs_read(&conn->local_tx_ctrl.prod, conn),
-		       conn);
-	smc_curs_write(&cons,
-		       smc_curs_read(&conn->local_rx_ctrl.cons, conn),
-		       conn);
+	smc_curs_copy(&prod, &conn->local_tx_ctrl.prod, conn);
+	smc_curs_copy(&cons, &conn->local_rx_ctrl.cons, conn);
 
 	/* if usable snd_wnd closes ask peer to advertise once it opens again */
 	pflags = &conn->local_tx_ctrl.prod_flags;
@@ -481,14 +473,9 @@ static int smc_tx_rdma_writes(struct smc_connection *conn)
 		pflags->urg_data_present = 1;
 	smc_tx_advance_cursors(conn, &prod, &sent, len);
 	/* update connection's cursors with advanced local cursors */
-	smc_curs_write(&conn->local_tx_ctrl.prod,
-		       smc_curs_read(&prod, conn),
-		       conn);
+	smc_curs_copy(&conn->local_tx_ctrl.prod, &prod, conn);
 							/* dst: peer RMBE */
-	smc_curs_write(&conn->tx_curs_sent,
-		       smc_curs_read(&sent, conn),
-		       conn);
-							/* src: local sndbuf */
+	smc_curs_copy(&conn->tx_curs_sent, &sent, conn);/* src: local sndbuf */
 
 	return 0;
 }
@@ -606,17 +593,11 @@ void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 	int sender_free = conn->rmb_desc->len;
 	int to_confirm;
 
-	smc_curs_write(&cons,
-		       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-		       conn);
-	smc_curs_write(&cfed,
-		       smc_curs_read(&conn->rx_curs_confirmed, conn),
-		       conn);
+	smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
+	smc_curs_copy(&cfed, &conn->rx_curs_confirmed, conn);
 	to_confirm = smc_curs_diff(conn->rmb_desc->len, &cfed, &cons);
 	if (to_confirm > conn->rmbe_update_limit) {
-		smc_curs_write(&prod,
-			       smc_curs_read(&conn->local_rx_ctrl.prod, conn),
-			       conn);
+		smc_curs_copy(&prod, &conn->local_rx_ctrl.prod, conn);
 		sender_free = conn->rmb_desc->len -
 			      smc_curs_diff(conn->rmb_desc->len, &prod, &cfed);
 	}
@@ -632,9 +613,8 @@ void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 					      SMC_TX_WORK_DELAY);
 			return;
 		}
-		smc_curs_write(&conn->rx_curs_confirmed,
-			       smc_curs_read(&conn->local_tx_ctrl.cons, conn),
-			       conn);
+		smc_curs_copy(&conn->rx_curs_confirmed,
+			      &conn->local_tx_ctrl.cons, conn);
 		conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
 	}
 	if (conn->local_rx_ctrl.prod_flags.write_blocked &&
diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
index b22bdc5694c4..07e6ad76224a 100644
--- a/net/smc/smc_tx.h
+++ b/net/smc/smc_tx.h
@@ -22,8 +22,8 @@ static inline int smc_tx_prepared_sends(struct smc_connection *conn)
 {
 	union smc_host_cursor sent, prep;
 
-	smc_curs_write(&sent, smc_curs_read(&conn->tx_curs_sent, conn), conn);
-	smc_curs_write(&prep, smc_curs_read(&conn->tx_curs_prep, conn), conn);
+	smc_curs_copy(&sent, &conn->tx_curs_sent, conn);
+	smc_curs_copy(&prep, &conn->tx_curs_prep, conn);
 	return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
 }
 
-- 
2.16.4

