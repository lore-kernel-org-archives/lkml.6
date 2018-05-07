Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753406AbeEGWVy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:21:54 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:60958
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753061AbeEGWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:21:47 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 7/7] cifs: Call MID callback before destroying transport
Date: Mon,  7 May 2018 15:20:06 -0700
Message-Id: <20180507222006.20781-7-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180507222006.20781-1-longli@linuxonhyperv.com>
References: <20180507222006.20781-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfCRQ3yB3TOmgwTXaZHe3IEA/HYY6qeOMBY+CJgza5j2EpphbxO+TI/6uFygdf9enw4ZFE1Rx/AyVR7u6FVSCb8gpBzghYkfnZ6UncUobsz4n+NbWaV0X
 YWgLKdCJ7b8+CjRM3PlRlIygVEOckdpPLAjIMAWLXqrUwTxxYW89ldob/V+Prx9vg56d2ESKlL2xlv59RldqLmEB+8IN2jIfjDWn4oK4kHoEhP7HWIJkgZjK
 sOj5kt04Vcf94sv66uWnRFWrtHT6H1LJjD+xuDG/BNf+il38z4DatikxmUVss1aaISfYjoGS5JGy6QEa39N/yh3P/yqspJ0KbLaL+zzj8ePPM4AhdjHC4KJ+
 Iu5YehcgPXtWYo594pTjHAeWlVP0PGAIekgSkRB4AoGKEAX5WJnRvDkLO2Yfx96utB5RjEdA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

When transport is being destroyed, it's possible that some processes may
hold memory registrations that need to be deregistred.

Call them first so nobody is using transport resources, and it can be
destroyed.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/connect.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 5db3e9d..7e7d40e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -369,22 +369,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
 	/* do not want to be sending data on a socket we are freeing */
 	cifs_dbg(FYI, "%s: tearing down socket\n", __func__);
 	mutex_lock(&server->srv_mutex);
-	if (server->ssocket) {
-		cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
-			 server->ssocket->state, server->ssocket->flags);
-		kernel_sock_shutdown(server->ssocket, SHUT_WR);
-		cifs_dbg(FYI, "Post shutdown state: 0x%x Flags: 0x%lx\n",
-			 server->ssocket->state, server->ssocket->flags);
-		sock_release(server->ssocket);
-		server->ssocket = NULL;
-	} else if (cifs_rdma_enabled(server))
-		smbd_destroy(server);
-	server->sequence_number = 0;
-	server->session_estab = false;
-	kfree(server->session_key.response);
-	server->session_key.response = NULL;
-	server->session_key.len = 0;
-	server->lstrp = jiffies;
 
 	/* mark submitted MIDs for retry and issue callback */
 	INIT_LIST_HEAD(&retry_list);
@@ -397,7 +381,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		list_move(&mid_entry->qhead, &retry_list);
 	}
 	spin_unlock(&GlobalMid_Lock);
-	mutex_unlock(&server->srv_mutex);
 
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
 	list_for_each_safe(tmp, tmp2, &retry_list) {
@@ -406,6 +389,25 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		mid_entry->callback(mid_entry);
 	}
 
+	if (server->ssocket) {
+		cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
+			 server->ssocket->state, server->ssocket->flags);
+		kernel_sock_shutdown(server->ssocket, SHUT_WR);
+		cifs_dbg(FYI, "Post shutdown state: 0x%x Flags: 0x%lx\n",
+			 server->ssocket->state, server->ssocket->flags);
+		sock_release(server->ssocket);
+		server->ssocket = NULL;
+	} else if (cifs_rdma_enabled(server))
+		smbd_destroy(server);
+	server->sequence_number = 0;
+	server->session_estab = false;
+	kfree(server->session_key.response);
+	server->session_key.response = NULL;
+	server->session_key.len = 0;
+	server->lstrp = jiffies;
+
+	mutex_unlock(&server->srv_mutex);
+
 	do {
 		try_to_freeze();
 
-- 
2.7.4
