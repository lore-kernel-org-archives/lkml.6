Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755959AbeDTP4o (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:56:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42764 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbeDTPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:55:52 -0400
X-Google-Smtp-Source: AIpwx4+mvdAxLPOv+jJe6jl7DaYUBcy4F/SczjgBfdWw8de9jlGb8k4jvQAnzsqYAluj8LIs2QUZ+A==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net-next 2/4] net: implement sock_mmap_hook()
Date: Fri, 20 Apr 2018 08:55:40 -0700
Message-Id: <20180420155542.122183-3-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180420155542.122183-1-edumazet@google.com>
References: <20180420155542.122183-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sock_mmap_hook() is the mmap_hook handler provided for socket_file_ops

Following patch will provide tcp_mmap_hook() for TCP protocol.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/net.h | 1 +
 net/socket.c        | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index 6554d3ba4396b3df49acac934ad16eeb71a695f4..5192bf502b11e42c3d9eb342ce67361916149bfa 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -181,6 +181,7 @@ struct proto_ops {
 				      size_t total_len, int flags);
 	int		(*mmap)	     (struct file *file, struct socket *sock,
 				      struct vm_area_struct * vma);
+	int		(*mmap_hook) (struct socket *sock, enum mmap_hook);
 	ssize_t		(*sendpage)  (struct socket *sock, struct page *page,
 				      int offset, size_t size, int flags);
 	ssize_t 	(*splice_read)(struct socket *sock,  loff_t *ppos,
diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78c193b49379b0ec641d81367fb4cf..75a5c2ebe57e0621dae17c6c9e1a796ee818b107 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -131,6 +131,14 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 				struct pipe_inode_info *pipe, size_t len,
 				unsigned int flags);
 
+static int sock_mmap_hook(struct file *file, enum mmap_hook mode)
+{
+	struct socket *sock = file->private_data;
+
+	if (!sock->ops->mmap_hook)
+		return 0;
+	return sock->ops->mmap_hook(sock, mode);
+}
 /*
  *	Socket files have a set of 'special' operations as well as the generic file ones. These don't appear
  *	in the operation structures but are done directly via the socketcall() multiplexor.
@@ -147,6 +155,7 @@ static const struct file_operations socket_file_ops = {
 	.compat_ioctl = compat_sock_ioctl,
 #endif
 	.mmap =		sock_mmap,
+	.mmap_hook =	sock_mmap_hook,
 	.release =	sock_close,
 	.fasync =	sock_fasync,
 	.sendpage =	sock_sendpage,
-- 
2.17.0.484.g0c8726318c-goog
