Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeCOCqe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:46:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43181 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751666AbeCOCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:46:32 -0400
X-ME-Sender: <xms:h96pWrnZqb9rwblpDRuq_4LSaAKZvsWVhO_l66WFoWu_tx0K0h2TZQ>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] xen: xenbus_dev_frontend: Verify body of XS_TRANSACTION_END
Date: Thu, 15 Mar 2018 03:43:22 +0100
Message-Id: <20180315024322.27429-3-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315024322.27429-1-simon@invisiblethingslab.com>
References: <20180315024322.27429-1-simon@invisiblethingslab.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By guaranteeing that the argument of XS_TRANSACTION_END is valid we can
assume that the transaction has been closed when we get an XS_ERROR
response from xenstore (Note that we already verify that it's a valid
transaction id).

Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 81a84b3c1c50..0d6d9264d6a9 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -429,6 +429,10 @@ static int xenbus_write_transaction(unsigned msg_type,
 {
 	int rc;
 	struct xenbus_transaction_holder *trans = NULL;
+	struct {
+		struct xsd_sockmsg hdr;
+		char body[];
+	} *msg = (void *)u->u.buffer;
 
 	if (msg_type == XS_TRANSACTION_START) {
 		trans = kzalloc(sizeof(*trans), GFP_KERNEL);
@@ -437,11 +441,15 @@ static int xenbus_write_transaction(unsigned msg_type,
 			goto out;
 		}
 		list_add(&trans->list, &u->transactions);
-	} else if (u->u.msg.tx_id != 0 &&
-		   !xenbus_get_transaction(u, u->u.msg.tx_id))
+	} else if (msg->hdr.tx_id != 0 &&
+		   !xenbus_get_transaction(u, msg->hdr.tx_id))
 		return xenbus_command_reply(u, XS_ERROR, "ENOENT");
+	else if (msg_type == XS_TRANSACTION_END &&
+		 !(msg->hdr.len == 2 &&
+		   (!strcmp(msg->body, "T") || !strcmp(msg->body, "F"))))
+		return xenbus_command_reply(u, XS_ERROR, "EINVAL");
 
-	rc = xenbus_dev_request_and_reply(&u->u.msg, u);
+	rc = xenbus_dev_request_and_reply(&msg->hdr, u);
 	if (rc && trans) {
 		list_del(&trans->list);
 		kfree(trans);
-- 
2.16.2
