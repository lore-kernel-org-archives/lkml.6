Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeC3WSD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 18:18:03 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:51792
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751275AbeC3WSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 18:18:01 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 1/2] cifs: smbd: avoid reconnect lockup
Date: Fri, 30 Mar 2018 15:16:35 -0700
Message-Id: <20180330221636.32512-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfOk9/GjI/YXBjbKCG+YrISH5CJBlpV5FjFxjVk1KcKuTihwxZNW6ASWujcNaHjG81LxNzrdzJquDLgEcGsEeDVkUat4rooOv15ucu+7chNBurPgV3KCt
 e6RS57aL3YOiiolbCS1pzaJVmB7Zh9tQLeHpVYJLmRYEJe5+8LAJMTX9Ej1jxI+H8v9HrWWGGfux6c61zmZcNKJLyd7Jk9qdpVe3J2P97c5yus0+V7zxw7mC
 4xqhAT/1RH5WD2riCyH/NWHYG64tg/hatJ4mSoGxu29SWO5Mr10pJBpKRpzp3xGvTaLd5C4qyDB5IZsaUTLfuXCw+/Q5WAYSUdsVEZxS9mHrxoCOPVeXQSu/
 6+PZRa0+3p0AYKnXvdDHSO/vK+73xA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

During transport reconnect, other processes may have registered memory
and blocked on transport. This creates a deadlock situation because the
transport resources can't be freed, and reconnect is blocked.

Fix this by returning to upper layer on timeout. Before returning,
transport status is set to reconnecting so other processes will release
memory registration resources.

Upper layer will retry the reconnect. This is not in fast I/O path so
setting the timeout to 5 seconds.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/smbdirect.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 5aa0b54..3f7883e 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1498,8 +1498,8 @@ int smbd_reconnect(struct TCP_Server_Info *server)
 	log_rdma_event(INFO, "reconnecting rdma session\n");
 
 	if (!server->smbd_conn) {
-		log_rdma_event(ERR, "rdma session already destroyed\n");
-		return -EINVAL;
+		log_rdma_event(INFO, "rdma session already destroyed\n");
+		goto create_conn;
 	}
 
 	/*
@@ -1512,15 +1512,19 @@ int smbd_reconnect(struct TCP_Server_Info *server)
 	}
 
 	/* wait until the transport is destroyed */
-	wait_event(server->smbd_conn->wait_destroy,
-		server->smbd_conn->transport_status == SMBD_DESTROYED);
+	if (!wait_event_timeout(server->smbd_conn->wait_destroy,
+		server->smbd_conn->transport_status == SMBD_DESTROYED, 5*HZ))
+		return -EAGAIN;
 
 	destroy_workqueue(server->smbd_conn->workqueue);
 	kfree(server->smbd_conn);
 
+create_conn:
 	log_rdma_event(INFO, "creating rdma session\n");
 	server->smbd_conn = smbd_get_connection(
 		server, (struct sockaddr *) &server->dstaddr);
+	log_rdma_event(INFO, "created rdma session info=%p\n",
+		server->smbd_conn);
 
 	return server->smbd_conn ? 0 : -ENOENT;
 }
-- 
2.7.4
