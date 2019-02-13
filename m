Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BA8C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B03021B1A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026330;
	bh=pC568Khs7wp3fktfigzKnfsfK+iGv+81cljZfMtPZrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjggHxPPhOn/KXsw9l15yyQnv3WYYhsPumOyrfopYwBmmezZRhBR5HEhL0e026qqa
	 2msEpqHKIrNb8UFyKio9JWdGa8q5miMnxvs4jjevwjAd6P1dBX8pVcB3rD6JrB9n0G
	 gjV0miunY7pkulSFzFgAjpE0mw+LGEZHXES1UtsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfBMCik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733098AbfBMCih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C43206B6;
        Wed, 13 Feb 2019 02:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025515;
        bh=pC568Khs7wp3fktfigzKnfsfK+iGv+81cljZfMtPZrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvIf9KH7LtyI5DF3lELK1XJ50ZvSPMLUklhri+ZZc4KeGit7xMaq5FLZF/EhnDeFs
         BJ57DJ0y+uQzbuRiiw+Rhv4JE1mPisXjMLupsV4TRVsN+iBLYF7wgMGHd7aHPhT6ZT
         cW2Ew+2eXXN27F6Wj055DtXkwf7ydOqiC3i66z9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/83] scsi: cxgb4i: add wait_for_completion()
Date:   Tue, 12 Feb 2019 21:36:33 -0500
Message-Id: <20190213023701.20286-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 9e8f1c79831424d30c0e3df068be7f4a244157c9 ]

In case of ->set_param() and ->bind_conn() cxgb4i driver does not wait for
cmd completion, this can create race conditions, to avoid this add
wait_for_completion().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c |  9 ++++-----
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 28 ++++++++++++++++++++--------
 drivers/scsi/cxgbi/libcxgbi.c      |  7 ++++---
 drivers/scsi/cxgbi/libcxgbi.h      |  5 +++--
 4 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
index bf07735275a4..0fc382cb977b 100644
--- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
+++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
@@ -1144,7 +1144,7 @@ static void ddp_clear_map(struct cxgbi_device *cdev, struct cxgbi_ppm *ppm,
 }
 
 static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk,
-				       unsigned int tid, int pg_idx, bool reply)
+				unsigned int tid, int pg_idx)
 {
 	struct sk_buff *skb = alloc_wr(sizeof(struct cpl_set_tcb_field), 0,
 					GFP_KERNEL);
@@ -1160,7 +1160,7 @@ static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk,
 	req = (struct cpl_set_tcb_field *)skb->head;
 	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, tid));
-	req->reply = V_NO_REPLY(reply ? 0 : 1);
+	req->reply = V_NO_REPLY(1);
 	req->cpu_idx = 0;
 	req->word = htons(31);
 	req->mask = cpu_to_be64(0xF0000000);
@@ -1177,11 +1177,10 @@ static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk,
  * @tid: connection id
  * @hcrc: header digest enabled
  * @dcrc: data digest enabled
- * @reply: request reply from h/w
  * set up the iscsi digest settings for a connection identified by tid
  */
 static int ddp_setup_conn_digest(struct cxgbi_sock *csk, unsigned int tid,
-			     int hcrc, int dcrc, int reply)
+				 int hcrc, int dcrc)
 {
 	struct sk_buff *skb = alloc_wr(sizeof(struct cpl_set_tcb_field), 0,
 					GFP_KERNEL);
@@ -1197,7 +1196,7 @@ static int ddp_setup_conn_digest(struct cxgbi_sock *csk, unsigned int tid,
 	req = (struct cpl_set_tcb_field *)skb->head;
 	req->wr.wr_hi = htonl(V_WR_OP(FW_WROPCODE_FORWARD));
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, tid));
-	req->reply = V_NO_REPLY(reply ? 0 : 1);
+	req->reply = V_NO_REPLY(1);
 	req->cpu_idx = 0;
 	req->word = htons(31);
 	req->mask = cpu_to_be64(0x0F000000);
diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 211da1d5a869..689d6c813a50 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -1517,16 +1517,22 @@ static void do_set_tcb_rpl(struct cxgbi_device *cdev, struct sk_buff *skb)
 	struct cxgbi_sock *csk;
 
 	csk = lookup_tid(t, tid);
-	if (!csk)
+	if (!csk) {
 		pr_err("can't find conn. for tid %u.\n", tid);
+		return;
+	}
 
 	log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_SOCK,
 		"csk 0x%p,%u,%lx,%u, status 0x%x.\n",
 		csk, csk->state, csk->flags, csk->tid, rpl->status);
 
-	if (rpl->status != CPL_ERR_NONE)
+	if (rpl->status != CPL_ERR_NONE) {
 		pr_err("csk 0x%p,%u, SET_TCB_RPL status %u.\n",
 			csk, tid, rpl->status);
+		csk->err = -EINVAL;
+	}
+
+	complete(&csk->cmpl);
 
 	__kfree_skb(skb);
 }
@@ -1903,7 +1909,7 @@ static int ddp_set_map(struct cxgbi_ppm *ppm, struct cxgbi_sock *csk,
 }
 
 static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk, unsigned int tid,
-				int pg_idx, bool reply)
+				int pg_idx)
 {
 	struct sk_buff *skb;
 	struct cpl_set_tcb_field *req;
@@ -1919,7 +1925,7 @@ static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk, unsigned int tid,
 	req = (struct cpl_set_tcb_field *)skb->head;
 	INIT_TP_WR(req, csk->tid);
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, csk->tid));
-	req->reply_ctrl = htons(NO_REPLY_V(reply) | QUEUENO_V(csk->rss_qid));
+	req->reply_ctrl = htons(NO_REPLY_V(0) | QUEUENO_V(csk->rss_qid));
 	req->word_cookie = htons(0);
 	req->mask = cpu_to_be64(0x3 << 8);
 	req->val = cpu_to_be64(pg_idx << 8);
@@ -1928,12 +1934,15 @@ static int ddp_setup_conn_pgidx(struct cxgbi_sock *csk, unsigned int tid,
 	log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_SOCK,
 		"csk 0x%p, tid 0x%x, pg_idx %u.\n", csk, csk->tid, pg_idx);
 
+	reinit_completion(&csk->cmpl);
 	cxgb4_ofld_send(csk->cdev->ports[csk->port_id], skb);
-	return 0;
+	wait_for_completion(&csk->cmpl);
+
+	return csk->err;
 }
 
 static int ddp_setup_conn_digest(struct cxgbi_sock *csk, unsigned int tid,
-				 int hcrc, int dcrc, int reply)
+				 int hcrc, int dcrc)
 {
 	struct sk_buff *skb;
 	struct cpl_set_tcb_field *req;
@@ -1951,7 +1960,7 @@ static int ddp_setup_conn_digest(struct cxgbi_sock *csk, unsigned int tid,
 	req = (struct cpl_set_tcb_field *)skb->head;
 	INIT_TP_WR(req, tid);
 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_SET_TCB_FIELD, tid));
-	req->reply_ctrl = htons(NO_REPLY_V(reply) | QUEUENO_V(csk->rss_qid));
+	req->reply_ctrl = htons(NO_REPLY_V(0) | QUEUENO_V(csk->rss_qid));
 	req->word_cookie = htons(0);
 	req->mask = cpu_to_be64(0x3 << 4);
 	req->val = cpu_to_be64(((hcrc ? ULP_CRC_HEADER : 0) |
@@ -1961,8 +1970,11 @@ static int ddp_setup_conn_digest(struct cxgbi_sock *csk, unsigned int tid,
 	log_debug(1 << CXGBI_DBG_TOE | 1 << CXGBI_DBG_SOCK,
 		"csk 0x%p, tid 0x%x, crc %d,%d.\n", csk, csk->tid, hcrc, dcrc);
 
+	reinit_completion(&csk->cmpl);
 	cxgb4_ofld_send(csk->cdev->ports[csk->port_id], skb);
-	return 0;
+	wait_for_completion(&csk->cmpl);
+
+	return csk->err;
 }
 
 static struct cxgbi_ppm *cdev2ppm(struct cxgbi_device *cdev)
diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 3f3af5e74a07..f2c561ca731a 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -573,6 +573,7 @@ static struct cxgbi_sock *cxgbi_sock_create(struct cxgbi_device *cdev)
 	skb_queue_head_init(&csk->receive_queue);
 	skb_queue_head_init(&csk->write_queue);
 	timer_setup(&csk->retry_timer, NULL, 0);
+	init_completion(&csk->cmpl);
 	rwlock_init(&csk->callback_lock);
 	csk->cdev = cdev;
 	csk->flags = 0;
@@ -2252,14 +2253,14 @@ int cxgbi_set_conn_param(struct iscsi_cls_conn *cls_conn,
 		if (!err && conn->hdrdgst_en)
 			err = csk->cdev->csk_ddp_setup_digest(csk, csk->tid,
 							conn->hdrdgst_en,
-							conn->datadgst_en, 0);
+							conn->datadgst_en);
 		break;
 	case ISCSI_PARAM_DATADGST_EN:
 		err = iscsi_set_param(cls_conn, param, buf, buflen);
 		if (!err && conn->datadgst_en)
 			err = csk->cdev->csk_ddp_setup_digest(csk, csk->tid,
 							conn->hdrdgst_en,
-							conn->datadgst_en, 0);
+							conn->datadgst_en);
 		break;
 	case ISCSI_PARAM_MAX_R2T:
 		return iscsi_tcp_set_max_r2t(conn, buf);
@@ -2385,7 +2386,7 @@ int cxgbi_bind_conn(struct iscsi_cls_session *cls_session,
 
 	ppm = csk->cdev->cdev2ppm(csk->cdev);
 	err = csk->cdev->csk_ddp_setup_pgidx(csk, csk->tid,
-					     ppm->tformat.pgsz_idx_dflt, 0);
+					     ppm->tformat.pgsz_idx_dflt);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/scsi/cxgbi/libcxgbi.h b/drivers/scsi/cxgbi/libcxgbi.h
index dcb190e75343..3bf7414a75e5 100644
--- a/drivers/scsi/cxgbi/libcxgbi.h
+++ b/drivers/scsi/cxgbi/libcxgbi.h
@@ -146,6 +146,7 @@ struct cxgbi_sock {
 	struct sk_buff_head receive_queue;
 	struct sk_buff_head write_queue;
 	struct timer_list retry_timer;
+	struct completion cmpl;
 	int err;
 	rwlock_t callback_lock;
 	void *user_data;
@@ -487,9 +488,9 @@ struct cxgbi_device {
 				  struct cxgbi_ppm *,
 				  struct cxgbi_task_tag_info *);
 	int (*csk_ddp_setup_digest)(struct cxgbi_sock *,
-				unsigned int, int, int, int);
+				    unsigned int, int, int);
 	int (*csk_ddp_setup_pgidx)(struct cxgbi_sock *,
-				unsigned int, int, bool);
+				   unsigned int, int);
 
 	void (*csk_release_offload_resources)(struct cxgbi_sock *);
 	int (*csk_rx_pdu_ready)(struct cxgbi_sock *, struct sk_buff *);
-- 
2.19.1

