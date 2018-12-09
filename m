Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CABCC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C24D2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C24D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeLIWIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37342 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbeLIWIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:30 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002po-9p; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003Q1-3v; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Matthew Wilcox" <willy@infradead.org>,
        "Mike Christie" <mchristi@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.543257769@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 153/328] iscsi target: fix session creation failure
 handling
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Fixes: 0957627a9960 ("iscsi-target: Fix sess allocation leak in...")
Signed-off-by: Mike Christie <mchristi@redhat.com>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/target/iscsi/iscsi_target_login.c | 35 ++++++++++++++---------
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
@@ -1201,13 +1208,13 @@ void iscsi_target_login_sess_out(struct
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

