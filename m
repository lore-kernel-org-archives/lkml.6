Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeDZHN1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:13:27 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:49549 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeDZHNZ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 26 Apr 2018 03:13:25 -0400
From: Gang He <ghe@suse.com>
To: teigland@redhat.com
Cc: Gang He <ghe@suse.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dlm: make sctp_connect_to_sock() return in specified time
Date: Thu, 26 Apr 2018 15:14:36 +0800
Message-Id: <1524726876-4770-1-git-send-email-ghe@suse.com>
X-Mailer: git-send-email 1.8.5.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user setup a two-ring cluster, DLM kernel module
will automatically selects to use SCTP protocol to communicate
between each node. There will be about 5 minute hang in DLM
kernel module, in case one ring is broken before switching to
another ring, this will potentially affect the dependent upper
applications, e.g. ocfs2, gfs2, clvm and clustered-MD, etc.
Unfortunately, if the user setup a two-ring cluster, we can not
specify DLM communication protocol with TCP explicitly, since
DLM kernel module only supports SCTP protocol for multiple
ring cluster.
Base on my investigation, the time is spent in sock->ops->connect()
function before returns ETIMEDOUT(-110) error, since O_NONBLOCK
argument in connect() function does not work here, then we should
make sock->ops->connect() function return in specified time via
setting socket SO_SNDTIMEO atrribute.

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/dlm/lowcomms.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 5243989..b786acc 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1037,6 +1037,7 @@ static void sctp_connect_to_sock(struct connection *con)
 	int result;
 	int addr_len;
 	struct socket *sock;
+	struct timeval tv = { .tv_sec = 5, .tv_usec = 0 };
 
 	if (con->nodeid == 0) {
 		log_print("attempt to connect sock 0 foiled");
@@ -1083,8 +1084,19 @@ static void sctp_connect_to_sock(struct connection *con)
 	kernel_setsockopt(sock, SOL_TCP, TCP_NODELAY, (char *)&one,
 			  sizeof(one));
 
+	/*
+	 * Make sock->ops->connect() function return in specified time,
+	 * since O_NONBLOCK argument in connect() function does not work here,
+	 * then, we should restore the default value of this attribute.
+	 */
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
+			  sizeof(tv));
 	result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
 				   O_NONBLOCK);
+	memset(&tv, 0, sizeof(tv));
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
+			  sizeof(tv));
+
 	if (result == -EINPROGRESS)
 		result = 0;
 	if (result == 0)
-- 
1.8.5.6
