Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBGWYb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:24:31 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36063 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750736AbeBGWYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:24:30 -0500
X-ME-Sender: <xms:nXx7Wl4iWD2hzuFMrO7fFAkURl10lfIVIxuy9vF3IBAjnnAOucCP3A>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] xen: xenbus: WARN_ON XS_TRANSACTION_{START,END} misuse
Date: Wed,  7 Feb 2018 23:22:36 +0100
Message-Id: <20180207222236.7434-2-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207222236.7434-1-simon@invisiblethingslab.com>
References: <20180207222236.7434-1-simon@invisiblethingslab.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the previous commit shows it's quite easy to confuse the transaction
reference counting by ending a transaction twice. So at least try to
detect and report it.

Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3e59590c7254..aed954b09b9b 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -137,11 +137,20 @@ static uint32_t xs_request_enter(struct xb_req_data *req)
 
 void xs_request_exit(struct xb_req_data *req)
 {
+	unsigned int users_old;
+
 	spin_lock(&xs_state_lock);
+	users_old = xs_state_users;
 	xs_state_users--;
 	if ((req->type == XS_TRANSACTION_START && req->msg.type == XS_ERROR) ||
 	    req->type == XS_TRANSACTION_END)
 		xs_state_users--;
+	if (WARN_ON(xs_state_users > users_old))
+		/*
+		 * Someone misused XS_TRANSACTION_{START,END}. Reset the
+		 * reference counter so we might survive.
+		 */
+		xs_state_users = 0;
 	spin_unlock(&xs_state_lock);
 
 	if (xs_suspend_active && !xs_state_users)
-- 
2.15.1
