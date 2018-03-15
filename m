Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCOCpf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:45:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55961 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751488AbeCOCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:45:34 -0400
X-ME-Sender: <xms:Tt6pWmE2mu7EhrC1KOt9I2wRilhnIw5Z3WuHWHwy16sfrlXmPs9l-w>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] xen: xenbus: Catch closing of non existent transactions
Date: Thu, 15 Mar 2018 03:43:21 +0100
Message-Id: <20180315024322.27429-2-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315024322.27429-1-simon@invisiblethingslab.com>
References: <20180315024322.27429-1-simon@invisiblethingslab.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of the xenbus functions should never close a non existent
transaction (for example by trying to closing the same transaction
twice) but better catch it in xs_request_exit() than to corrupt the
reference counter.

Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3f3b29398ab8..49a3874ae6bb 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -140,7 +140,9 @@ void xs_request_exit(struct xb_req_data *req)
 	spin_lock(&xs_state_lock);
 	xs_state_users--;
 	if ((req->type == XS_TRANSACTION_START && req->msg.type == XS_ERROR) ||
-	    req->type == XS_TRANSACTION_END)
+	    (req->type == XS_TRANSACTION_END &&
+	     !WARN_ON_ONCE(req->msg.type == XS_ERROR &&
+			   !strcmp(req->body, "ENOENT"))))
 		xs_state_users--;
 	spin_unlock(&xs_state_lock);
 
-- 
2.16.2
