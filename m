Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6FDC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7531D2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079125;
	bh=QFFMolJ+NWaG/RDlKxDhyUelDAGwAR0RY0xG9wzTEHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYUn4Avb84pKmGt2/UO238U60TlrXRaszdBn32fpp5JJ2QkfKZpu0NnLLPk+WBdP8
	 TB6J1Tj9PHlhyA8h/mudSX/5grBEDh6zedkL1GQ1mgGm0AoAEofDiFJcZZwruobGxq
	 MIHar1s0yGyhIPX50X/0YGu2XLggHCkC40Lq64RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfAUN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbfAUN6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9392084C;
        Mon, 21 Jan 2019 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079120;
        bh=QFFMolJ+NWaG/RDlKxDhyUelDAGwAR0RY0xG9wzTEHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCAIdsvXKkszwtKDLM5NtoJnbw976n6sZQRqnS0MvGzVViw+16p20GYbYgRv4sJoi
         ga1WABpe0ivWy5zhkSs1tpqjNAfuQfqAVPdSHjk7FJea7jP9Za2rzJipQFHVVmOF/6
         nkUAtlRVbIXJhhOLUaTsKy8CNbnZC5/6cZMoJDbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 16/99] scsi: target: iscsi: cxgbit: fix csk leak
Date:   Mon, 21 Jan 2019 14:48:08 +0100
Message-Id: <20190121134914.534395149@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 801df68d617e3cb831f531c99fa6003620e6b343 ]

csk leak can happen if a new TCP connection gets established after
cxgbit_accept_np() returns, to fix this leak free remaining csk in
cxgbit_free_np().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 8de16016b6de..71888b979ab5 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -598,9 +598,12 @@ static void cxgbit_free_cdev_np(struct cxgbit_np *cnp)
 	mutex_unlock(&cdev_list_lock);
 }
 
+static void __cxgbit_free_conn(struct cxgbit_sock *csk);
+
 void cxgbit_free_np(struct iscsi_np *np)
 {
 	struct cxgbit_np *cnp = np->np_context;
+	struct cxgbit_sock *csk, *tmp;
 
 	cnp->com.state = CSK_STATE_DEAD;
 	if (cnp->com.cdev)
@@ -608,6 +611,13 @@ void cxgbit_free_np(struct iscsi_np *np)
 	else
 		cxgbit_free_all_np(cnp);
 
+	spin_lock_bh(&cnp->np_accept_lock);
+	list_for_each_entry_safe(csk, tmp, &cnp->np_accept_list, accept_node) {
+		list_del_init(&csk->accept_node);
+		__cxgbit_free_conn(csk);
+	}
+	spin_unlock_bh(&cnp->np_accept_lock);
+
 	np->np_context = NULL;
 	cxgbit_put_cnp(cnp);
 }
@@ -705,9 +715,9 @@ void cxgbit_abort_conn(struct cxgbit_sock *csk)
 			      csk->tid, 600, __func__);
 }
 
-void cxgbit_free_conn(struct iscsi_conn *conn)
+static void __cxgbit_free_conn(struct cxgbit_sock *csk)
 {
-	struct cxgbit_sock *csk = conn->context;
+	struct iscsi_conn *conn = csk->conn;
 	bool release = false;
 
 	pr_debug("%s: state %d\n",
@@ -716,7 +726,7 @@ void cxgbit_free_conn(struct iscsi_conn *conn)
 	spin_lock_bh(&csk->lock);
 	switch (csk->com.state) {
 	case CSK_STATE_ESTABLISHED:
-		if (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT) {
+		if (conn && (conn->conn_state == TARG_CONN_STATE_IN_LOGOUT)) {
 			csk->com.state = CSK_STATE_CLOSING;
 			cxgbit_send_halfclose(csk);
 		} else {
@@ -741,6 +751,11 @@ void cxgbit_free_conn(struct iscsi_conn *conn)
 		cxgbit_put_csk(csk);
 }
 
+void cxgbit_free_conn(struct iscsi_conn *conn)
+{
+	__cxgbit_free_conn(conn->context);
+}
+
 static void cxgbit_set_emss(struct cxgbit_sock *csk, u16 opt)
 {
 	csk->emss = csk->com.cdev->lldi.mtus[TCPOPT_MSS_G(opt)] -
@@ -803,6 +818,7 @@ void _cxgbit_free_csk(struct kref *kref)
 	spin_unlock_bh(&cdev->cskq.lock);
 
 	cxgbit_free_skb(csk);
+	cxgbit_put_cnp(csk->cnp);
 	cxgbit_put_cdev(cdev);
 
 	kfree(csk);
@@ -1351,6 +1367,7 @@ cxgbit_pass_accept_req(struct cxgbit_device *cdev, struct sk_buff *skb)
 		goto rel_skb;
 	}
 
+	cxgbit_get_cnp(cnp);
 	cxgbit_get_cdev(cdev);
 
 	spin_lock(&cdev->cskq.lock);
-- 
2.19.1



