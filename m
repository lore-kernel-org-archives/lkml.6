Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165185AbeE1NFy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163626AbeE1Kwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:52:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 208/496] rds: Incorrect reference counting in TCP socket creation
Date: Mon, 28 May 2018 11:59:53 +0200
Message-Id: <20180528100328.701966267@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>

[ Upstream commit 84eef2b2187ed73c0e4520cbfeb874e964a0b56a ]

Commit 0933a578cd55 ("rds: tcp: use sock_create_lite() to create the
accept socket") has a reference counting issue in TCP socket creation
when accepting a new connection.  The code uses sock_create_lite() to
create a kernel socket.  But it does not do __module_get() on the
socket owner.  When the connection is shutdown and sock_release() is
called to free the socket, the owner's reference count is decremented
and becomes incorrect.  Note that this bug only shows up when the socket
owner is configured as a kernel module.

v2: Update comments

Fixes: 0933a578cd55 ("rds: tcp: use sock_create_lite() to create the accept socket")
Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/tcp_listen.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2006 Oracle.  All rights reserved.
+ * Copyright (c) 2006, 2018 Oracle.  All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
@@ -142,12 +142,20 @@ int rds_tcp_accept_one(struct socket *so
 	if (ret)
 		goto out;
 
-	new_sock->type = sock->type;
-	new_sock->ops = sock->ops;
 	ret = sock->ops->accept(sock, new_sock, O_NONBLOCK, true);
 	if (ret < 0)
 		goto out;
 
+	/* sock_create_lite() does not get a hold on the owner module so we
+	 * need to do it here.  Note that sock_release() uses sock->ops to
+	 * determine if it needs to decrement the reference count.  So set
+	 * sock->ops after calling accept() in case that fails.  And there's
+	 * no need to do try_module_get() as the listener should have a hold
+	 * already.
+	 */
+	new_sock->ops = sock->ops;
+	__module_get(new_sock->ops->owner);
+
 	ret = rds_tcp_keepalive(new_sock);
 	if (ret < 0)
 		goto out;
