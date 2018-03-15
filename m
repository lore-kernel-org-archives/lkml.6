Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeCODIo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 23:08:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46675 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751682AbeCODIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 23:08:43 -0400
X-ME-Sender: <xms:uuOpWlZkthJBjhm6BO6_GgIvspJLUtFWR55c9IOVU-Gy3Kvbz509Kg>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: xenbus_dev_frontend: Really return response string
Date: Thu, 15 Mar 2018 04:08:03 +0100
Message-Id: <20180315030803.27781-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xenbus_command_reply() did not actually copy the response string and
leaked stack content instead.

Fixes: 9a6161fe73bd ("xen: return xenstore command failures via response instead of rc")
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---

PS: AFAICS this is not a security issue since /dev/xen/xenbus is
normally only accessible by root and giving xenstore access to a less
trusted entity probably has a bunch of other unintended consequences.

 drivers/xen/xenbus/xenbus_dev_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index a493e99bed21..845a70fa7f79 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -403,7 +403,7 @@ static int xenbus_command_reply(struct xenbus_file_priv *u,
 {
 	struct {
 		struct xsd_sockmsg hdr;
-		const char body[16];
+		char body[16];
 	} msg;
 	int rc;
 
@@ -412,6 +412,7 @@ static int xenbus_command_reply(struct xenbus_file_priv *u,
 	msg.hdr.len = strlen(reply) + 1;
 	if (msg.hdr.len > sizeof(msg.body))
 		return -E2BIG;
+	memcpy(&msg.body, reply, msg.hdr.len);
 
 	mutex_lock(&u->reply_mutex);
 	rc = queue_reply(&u->read_buffers, &msg, sizeof(msg.hdr) + msg.hdr.len);
-- 
2.16.2
