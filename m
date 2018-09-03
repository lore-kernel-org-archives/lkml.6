Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA459C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0C20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE0C20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeICVXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:23:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbeICVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:23:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17A52CEE;
        Mon,  3 Sep 2018 17:02:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 4.4 79/80] iscsi target: fix session creation failure handling
Date:   Mon,  3 Sep 2018 18:49:57 +0200
Message-Id: <20180903164937.305035745@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164934.171677301@linuxfoundation.org>
References: <20180903164934.171677301@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <mchristi@redhat.com>

commit 26abc916a898d34c5ad159315a2f683def3c5555 upstream.

The problem is that iscsi_login_zero_tsih_s1 sets conn->sess early in
iscsi_login_set_conn_values. If the function fails later like when we
alloc the idr it does kfree(sess) and leaves the conn->sess pointer set.
iscsi_login_zero_tsih_s1 then returns -Exyz and we then call
iscsi_target_login_sess_out and access the freed memory.

This patch has iscsi_login_zero_tsih_s1 either completely setup the
session or completely tear it down, so later in
iscsi_target_login_sess_out we can just check for it being set to the
connection.

Cc: stable@vger.kernel.org
Fixes: 0957627a9960 ("iscsi-target: Fix sess allocation leak in...")
Signed-off-by: Mike Christie <mchristi@redhat.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_login.c |   35 ++++++++++++++++++------------
 1 file changed, 21 insertions(+), 14 deletions(-)

--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -323,8 +323,7 @@ static int iscsi_login_zero_tsih_s1(
 		pr_err("idr_alloc() for sess_idr failed\n");
 		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
-		kfree(sess);
-		return -ENOMEM;
+		goto free_sess;
 	}
 
 	sess->creation_time = get_jiffies_64();
@@ -340,20 +339,28 @@ static int iscsi_login_zero_tsih_s1(
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
 		pr_err("Unable to allocate memory for"
 				" struct iscsi_sess_ops.\n");
-		kfree(sess);
-		return -ENOMEM;
+		goto remove_idr;
 	}
 
 	sess->se_sess = transport_init_session(TARGET_PROT_NORMAL);
 	if (IS_ERR(sess->se_sess)) {
 		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
-		kfree(sess->sess_ops);
-		kfree(sess);
-		return -ENOMEM;
+		goto free_ops;
 	}
 
 	return 0;
+
+free_ops:
+	kfree(sess->sess_ops);
+remove_idr:
+	spin_lock_bh(&sess_idr_lock);
+	idr_remove(&sess_idr, sess->session_index);
+	spin_unlock_bh(&sess_idr_lock);
+free_sess:
+	kfree(sess);
+	conn->sess = NULL;
+	return -ENOMEM;
 }
 
 static int iscsi_login_zero_tsih_s2(
@@ -1142,13 +1149,13 @@ void iscsi_target_login_sess_out(struct
 				   ISCSI_LOGIN_STATUS_INIT_ERR);
 	if (!zero_tsih || !conn->sess)
 		goto old_sess_out;
-	if (conn->sess->se_sess)
-		transport_free_session(conn->sess->se_sess);
-	if (conn->sess->session_index != 0) {
-		spin_lock_bh(&sess_idr_lock);
-		idr_remove(&sess_idr, conn->sess->session_index);
-		spin_unlock_bh(&sess_idr_lock);
-	}
+
+	transport_free_session(conn->sess->se_sess);
+
+	spin_lock_bh(&sess_idr_lock);
+	idr_remove(&sess_idr, conn->sess->session_index);
+	spin_unlock_bh(&sess_idr_lock);
+
 	kfree(conn->sess->sess_ops);
 	kfree(conn->sess);
 	conn->sess = NULL;


