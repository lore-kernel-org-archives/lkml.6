Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeDTPz7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:55:59 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:46214 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbeDTPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:55:54 -0400
X-Google-Smtp-Source: AIpwx4/DdBs+cKjbFPbWmsBwu3bkMBDGt7+McwA79bVNTaArWNzSEeoZVggHxJ/CeRlsg5CIprWbqw==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net-next 3/4] tcp: provide tcp_mmap_hook()
Date: Fri, 20 Apr 2018 08:55:41 -0700
Message-Id: <20180420155542.122183-4-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180420155542.122183-1-edumazet@google.com>
References: <20180420155542.122183-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many socket operations can copy data between user and kernel space
while socket lock is held. This means mm->mmap_sem can be taken
after socket lock.

When implementing tcp mmap(), I forgot this and syzbot was kind enough
to point this to my attention.

This patch adds tcp_mmap_hook(), allowing us to grab socket lock
before vm_mmap_pgoff() grabs mm->mmap_sem

This same hook is responsible for releasing socket lock when
vm_mmap_pgoff() has released mm->mmap_sem (or failed to acquire it)

Note that follow-up patches can transfer code from tcp_mmap()
to tcp_mmap_hook() to shorten tcp_mmap() execution time
and thus increase mmap() performance in multi-threaded programs.

Fixes: 93ab6cc69162 ("tcp: implement mmap() for zero copy receive")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 include/net/tcp.h   |  1 +
 net/ipv4/af_inet.c  |  1 +
 net/ipv4/tcp.c      | 25 ++++++++++++++++++++++---
 net/ipv6/af_inet6.c |  1 +
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 833154e3df173ea41aa16dd1ec739a175c679c5c..f68c8e8957840cacdbdd3d02bd149fce33ae324f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -404,6 +404,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int nonblock,
 		int flags, int *addr_len);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_data_ready(struct sock *sk);
+int tcp_mmap_hook(struct socket *sock, enum mmap_hook mode);
 int tcp_mmap(struct file *file, struct socket *sock,
 	     struct vm_area_struct *vma);
 void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3ebf599cebaea4926decc1aad7274b12ec7e1566..af597440ff59c049b7fd02f7d7f79c23b9e195bb 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -995,6 +995,7 @@ const struct proto_ops inet_stream_ops = {
 	.sendmsg	   = inet_sendmsg,
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = tcp_mmap,
+	.mmap_hook	   = tcp_mmap_hook,
 	.sendpage	   = inet_sendpage,
 	.splice_read	   = tcp_splice_read,
 	.read_sock	   = tcp_read_sock,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4022073b0aeea9d07af0fa825b640a00512908a3..e913b2dd5df321f2789e8d5f233ede9c2f1d5624 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1726,6 +1726,28 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_set_rcvlowat);
 
+/* mmap() on TCP needs to grab socket lock before current->mm->mmap_sem
+ * is taken in vm_mmap_pgoff() to avoid possible dead locks.
+ */
+int tcp_mmap_hook(struct socket *sock, enum mmap_hook mode)
+{
+	struct sock *sk = sock->sk;
+
+	if (mode == MMAP_HOOK_PREPARE) {
+		lock_sock(sk);
+		/* TODO: Move here all the preparation work that can be done
+		 * before having to grab current->mm->mmap_sem.
+		 */
+		return 0;
+	}
+	/* TODO: Move here the stuff that can been done after
+	 * current->mm->mmap_sem has been released.
+	 */
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(tcp_mmap_hook);
+
 /* When user wants to mmap X pages, we first need to perform the mapping
  * before freeing any skbs in receive queue, otherwise user would be unable
  * to fallback to standard recvmsg(). This happens if some data in the
@@ -1756,8 +1778,6 @@ int tcp_mmap(struct file *file, struct socket *sock,
 	/* TODO: Maybe the following is not needed if pages are COW */
 	vma->vm_flags &= ~VM_MAYWRITE;
 
-	lock_sock(sk);
-
 	ret = -ENOTCONN;
 	if (sk->sk_state == TCP_LISTEN)
 		goto out;
@@ -1833,7 +1853,6 @@ int tcp_mmap(struct file *file, struct socket *sock,
 
 	ret = 0;
 out:
-	release_sock(sk);
 	kvfree(pages_array);
 	return ret;
 }
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 36d622c477b1ed3c5d2b753938444526344a6109..31ce68c001c223d3351f73453273ae517a051816 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -579,6 +579,7 @@ const struct proto_ops inet6_stream_ops = {
 	.sendmsg	   = inet_sendmsg,		/* ok		*/
 	.recvmsg	   = inet_recvmsg,		/* ok		*/
 	.mmap		   = tcp_mmap,
+	.mmap_hook	   = tcp_mmap_hook,
 	.sendpage	   = inet_sendpage,
 	.sendmsg_locked    = tcp_sendmsg_locked,
 	.sendpage_locked   = tcp_sendpage_locked,
-- 
2.17.0.484.g0c8726318c-goog
