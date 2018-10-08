Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F46C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B09021479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVAfokm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B09021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbeJICDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732127AbeJICDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A09204FD;
        Mon,  8 Oct 2018 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024637;
        bh=o4Zgv1FYtY/1FyaQDuIOTmf3XwnYrGL6gHhy3SAZyK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVAfokm0YYwYNUKo3BicTzCsSH2Dic3Dvdl5LpXLLW1lXUTztvlVEjRlVyOCSddtY
         BgbLgfXgq8eHD51LxAO/vif9mwyha34WLCJISTpPOe48jnrPn4xrPvwBu98ELOm3yi
         tuahIJfCPj5WyNWV7PP0jqBCBXR3XXiVp1x9nhu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 087/168] scsi: iscsi: target: Fix conn_ops double free
Date:   Mon,  8 Oct 2018 20:31:07 +0200
Message-Id: <20181008175623.367757938@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 05a86e78ea9823ec25b3515db078dd8a76fc263c ]

If iscsi_login_init_conn fails it can free conn_ops.
__iscsi_target_login_thread will then call iscsi_target_login_sess_out
which will also free it.

This fixes the problem by organizing conn allocation/setup into parts that
are needed through the life of the conn and parts that are only needed for
the login. The free functions then release what was allocated in the alloc
functions.

With this patch we have:

iscsit_alloc_conn/iscsit_free_conn - allocs/frees the conn we need for the
entire life of the conn.

iscsi_login_init_conn/iscsi_target_nego_release - allocs/frees the parts
of the conn that are only needed during login.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/iscsi/iscsi_target.c       |    9 -
 drivers/target/iscsi/iscsi_target_login.c |  141 +++++++++++++++---------------
 drivers/target/iscsi/iscsi_target_login.h |    2 
 3 files changed, 77 insertions(+), 75 deletions(-)

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4211,22 +4211,15 @@ int iscsit_close_connection(
 		crypto_free_ahash(tfm);
 	}
 
-	free_cpumask_var(conn->conn_cpumask);
-
-	kfree(conn->conn_ops);
-	conn->conn_ops = NULL;
-
 	if (conn->sock)
 		sock_release(conn->sock);
 
 	if (conn->conn_transport->iscsit_free_conn)
 		conn->conn_transport->iscsit_free_conn(conn);
 
-	iscsit_put_transport(conn->conn_transport);
-
 	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
 	conn->conn_state = TARG_CONN_STATE_FREE;
-	kfree(conn);
+	iscsit_free_conn(conn);
 
 	spin_lock_bh(&sess->conn_lock);
 	atomic_dec(&sess->nconn);
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -67,45 +67,10 @@ static struct iscsi_login *iscsi_login_i
 		goto out_req_buf;
 	}
 
-	conn->conn_ops = kzalloc(sizeof(struct iscsi_conn_ops), GFP_KERNEL);
-	if (!conn->conn_ops) {
-		pr_err("Unable to allocate memory for"
-			" struct iscsi_conn_ops.\n");
-		goto out_rsp_buf;
-	}
-
-	init_waitqueue_head(&conn->queues_wq);
-	INIT_LIST_HEAD(&conn->conn_list);
-	INIT_LIST_HEAD(&conn->conn_cmd_list);
-	INIT_LIST_HEAD(&conn->immed_queue_list);
-	INIT_LIST_HEAD(&conn->response_queue_list);
-	init_completion(&conn->conn_post_wait_comp);
-	init_completion(&conn->conn_wait_comp);
-	init_completion(&conn->conn_wait_rcfr_comp);
-	init_completion(&conn->conn_waiting_on_uc_comp);
-	init_completion(&conn->conn_logout_comp);
-	init_completion(&conn->rx_half_close_comp);
-	init_completion(&conn->tx_half_close_comp);
-	init_completion(&conn->rx_login_comp);
-	spin_lock_init(&conn->cmd_lock);
-	spin_lock_init(&conn->conn_usage_lock);
-	spin_lock_init(&conn->immed_queue_lock);
-	spin_lock_init(&conn->nopin_timer_lock);
-	spin_lock_init(&conn->response_queue_lock);
-	spin_lock_init(&conn->state_lock);
-
-	if (!zalloc_cpumask_var(&conn->conn_cpumask, GFP_KERNEL)) {
-		pr_err("Unable to allocate conn->conn_cpumask\n");
-		goto out_conn_ops;
-	}
 	conn->conn_login = login;
 
 	return login;
 
-out_conn_ops:
-	kfree(conn->conn_ops);
-out_rsp_buf:
-	kfree(login->rsp_buf);
 out_req_buf:
 	kfree(login->req_buf);
 out_login:
@@ -1155,6 +1120,75 @@ iscsit_conn_set_transport(struct iscsi_c
 	return 0;
 }
 
+static struct iscsi_conn *iscsit_alloc_conn(struct iscsi_np *np)
+{
+	struct iscsi_conn *conn;
+
+	conn = kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	if (!conn) {
+		pr_err("Could not allocate memory for new connection\n");
+		return NULL;
+	}
+	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
+	conn->conn_state = TARG_CONN_STATE_FREE;
+
+	init_waitqueue_head(&conn->queues_wq);
+	INIT_LIST_HEAD(&conn->conn_list);
+	INIT_LIST_HEAD(&conn->conn_cmd_list);
+	INIT_LIST_HEAD(&conn->immed_queue_list);
+	INIT_LIST_HEAD(&conn->response_queue_list);
+	init_completion(&conn->conn_post_wait_comp);
+	init_completion(&conn->conn_wait_comp);
+	init_completion(&conn->conn_wait_rcfr_comp);
+	init_completion(&conn->conn_waiting_on_uc_comp);
+	init_completion(&conn->conn_logout_comp);
+	init_completion(&conn->rx_half_close_comp);
+	init_completion(&conn->tx_half_close_comp);
+	init_completion(&conn->rx_login_comp);
+	spin_lock_init(&conn->cmd_lock);
+	spin_lock_init(&conn->conn_usage_lock);
+	spin_lock_init(&conn->immed_queue_lock);
+	spin_lock_init(&conn->nopin_timer_lock);
+	spin_lock_init(&conn->response_queue_lock);
+	spin_lock_init(&conn->state_lock);
+
+	timer_setup(&conn->nopin_response_timer,
+		    iscsit_handle_nopin_response_timeout, 0);
+	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
+
+	if (iscsit_conn_set_transport(conn, np->np_transport) < 0)
+		goto free_conn;
+
+	conn->conn_ops = kzalloc(sizeof(struct iscsi_conn_ops), GFP_KERNEL);
+	if (!conn->conn_ops) {
+		pr_err("Unable to allocate memory for struct iscsi_conn_ops.\n");
+		goto put_transport;
+	}
+
+	if (!zalloc_cpumask_var(&conn->conn_cpumask, GFP_KERNEL)) {
+		pr_err("Unable to allocate conn->conn_cpumask\n");
+		goto free_mask;
+	}
+
+	return conn;
+
+free_mask:
+	free_cpumask_var(conn->conn_cpumask);
+put_transport:
+	iscsit_put_transport(conn->conn_transport);
+free_conn:
+	kfree(conn);
+	return NULL;
+}
+
+void iscsit_free_conn(struct iscsi_conn *conn)
+{
+	free_cpumask_var(conn->conn_cpumask);
+	kfree(conn->conn_ops);
+	iscsit_put_transport(conn->conn_transport);
+	kfree(conn);
+}
+
 void iscsi_target_login_sess_out(struct iscsi_conn *conn,
 		struct iscsi_np *np, bool zero_tsih, bool new_sess)
 {
@@ -1208,10 +1242,6 @@ old_sess_out:
 		crypto_free_ahash(tfm);
 	}
 
-	free_cpumask_var(conn->conn_cpumask);
-
-	kfree(conn->conn_ops);
-
 	if (conn->param_list) {
 		iscsi_release_param_list(conn->param_list);
 		conn->param_list = NULL;
@@ -1229,8 +1259,7 @@ old_sess_out:
 	if (conn->conn_transport->iscsit_free_conn)
 		conn->conn_transport->iscsit_free_conn(conn);
 
-	iscsit_put_transport(conn->conn_transport);
-	kfree(conn);
+	iscsit_free_conn(conn);
 }
 
 static int __iscsi_target_login_thread(struct iscsi_np *np)
@@ -1260,31 +1289,16 @@ static int __iscsi_target_login_thread(s
 	}
 	spin_unlock_bh(&np->np_thread_lock);
 
-	conn = kzalloc(sizeof(struct iscsi_conn), GFP_KERNEL);
+	conn = iscsit_alloc_conn(np);
 	if (!conn) {
-		pr_err("Could not allocate memory for"
-			" new connection\n");
 		/* Get another socket */
 		return 1;
 	}
-	pr_debug("Moving to TARG_CONN_STATE_FREE.\n");
-	conn->conn_state = TARG_CONN_STATE_FREE;
-
-	timer_setup(&conn->nopin_response_timer,
-		    iscsit_handle_nopin_response_timeout, 0);
-	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
-
-	if (iscsit_conn_set_transport(conn, np->np_transport) < 0) {
-		kfree(conn);
-		return 1;
-	}
 
 	rc = np->np_transport->iscsit_accept_np(np, conn);
 	if (rc == -ENOSYS) {
 		complete(&np->np_restart_comp);
-		iscsit_put_transport(conn->conn_transport);
-		kfree(conn);
-		conn = NULL;
+		iscsit_free_conn(conn);
 		goto exit;
 	} else if (rc < 0) {
 		spin_lock_bh(&np->np_thread_lock);
@@ -1292,17 +1306,13 @@ static int __iscsi_target_login_thread(s
 			np->np_thread_state = ISCSI_NP_THREAD_ACTIVE;
 			spin_unlock_bh(&np->np_thread_lock);
 			complete(&np->np_restart_comp);
-			iscsit_put_transport(conn->conn_transport);
-			kfree(conn);
-			conn = NULL;
+			iscsit_free_conn(conn);
 			/* Get another socket */
 			return 1;
 		}
 		spin_unlock_bh(&np->np_thread_lock);
-		iscsit_put_transport(conn->conn_transport);
-		kfree(conn);
-		conn = NULL;
-		goto out;
+		iscsit_free_conn(conn);
+		return 1;
 	}
 	/*
 	 * Perform the remaining iSCSI connection initialization items..
@@ -1452,7 +1462,6 @@ old_sess_out:
 		tpg_np = NULL;
 	}
 
-out:
 	return 1;
 
 exit:
--- a/drivers/target/iscsi/iscsi_target_login.h
+++ b/drivers/target/iscsi/iscsi_target_login.h
@@ -19,7 +19,7 @@ extern int iscsi_target_setup_login_sock
 extern int iscsit_accept_np(struct iscsi_np *, struct iscsi_conn *);
 extern int iscsit_get_login_rx(struct iscsi_conn *, struct iscsi_login *);
 extern int iscsit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, u32);
-extern void iscsit_free_conn(struct iscsi_np *, struct iscsi_conn *);
+extern void iscsit_free_conn(struct iscsi_conn *);
 extern int iscsit_start_kthreads(struct iscsi_conn *);
 extern void iscsi_post_login_handler(struct iscsi_np *, struct iscsi_conn *, u8);
 extern void iscsi_target_login_sess_out(struct iscsi_conn *, struct iscsi_np *,


