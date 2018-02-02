Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeBBK2B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:28:01 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44951 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeBBK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:27:53 -0500
X-Google-Smtp-Source: AH8x225ZApjDFY65gZs4eaC6ly0/zmc+or3uDEE0HYEn+vxN8zhsDqcTn1NGrnO1evyacX9nuk4ZGA==
Date: Fri, 2 Feb 2018 02:27:49 -0800
From: Kees Cook <keescook@chromium.org>
To: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Eric Biggers <ebiggers3@gmail.com>, james.morse@arm.com,
        keun-o.park@darkmatter.ae, labbott@redhat.com, linux-mm@kvack.org,
        mingo@kernel.org
Subject: [PATCH v2] socket: Provide put_cmsg_whitelist() for constant size
 copies
Message-ID: <20180202102749.GA34019@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most callers of put_cmsg() use a "sizeof(foo)" for the length argument.
But within put_cmsg(), the copy_to_user() call is made with a dynamic
length, as a result of the cmsg header calculations. This means that
hardened usercopy will examine the copy, even though it was technically
a fixed size and should be implicitly whitelisted.

Most callers of put_cmsg() are copying out of stack or kmalloc, so these
cases aren't a problem for hardened usercopy. However, some try to copy
out of the skbuff_head_cache slab, including the "cb" region. Since
whitelisting the slab area would leave other protocol definition of the
"cb" region exposed to usercopy bugs, this creates put_cmsg_whitelist(),
which internally uses sizeof() to provide a constant-sized length and
a stack bounce buffer, in order to explicitly whitelist an otherwise
disallowed slab region.

Original report was:

Bad or missing usercopy whitelist? Kernel memory exposure attempt detected from SLAB object 'skbuff_head_cache' (offset 64, size 16)!
WARNING: CPU: 0 PID: 3663 at mm/usercopy.c:81 usercopy_warn+0xdb/0x100 mm/usercopy.c:76
...
 __check_heap_object+0x89/0xc0 mm/slab.c:4426
 check_heap_object mm/usercopy.c:236 [inline]
 __check_object_size+0x272/0x530 mm/usercopy.c:259
 check_object_size include/linux/thread_info.h:112 [inline]
 check_copy_size include/linux/thread_info.h:143 [inline]
 copy_to_user include/linux/uaccess.h:154 [inline]
 put_cmsg+0x233/0x3f0 net/core/scm.c:242
 sock_recv_errqueue+0x200/0x3e0 net/core/sock.c:2913
 packet_recvmsg+0xb2e/0x17a0 net/packet/af_packet.c:3296
 sock_recvmsg_nosec net/socket.c:803 [inline]
 sock_recvmsg+0xc9/0x110 net/socket.c:810
 ___sys_recvmsg+0x2a4/0x640 net/socket.c:2179
 __sys_recvmmsg+0x2a9/0xaf0 net/socket.c:2287
 SYSC_recvmmsg net/socket.c:2368 [inline]
 SyS_recvmmsg+0xc4/0x160 net/socket.c:2352
 entry_SYSCALL_64_fastpath+0x29/0xa0

Reported-by: syzbot+e2d6cfb305e9f3911dea@syzkaller.appspotmail.com
Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/socket.h   | 8 ++++++++
 net/core/sock.c          | 4 +---
 net/iucv/af_iucv.c       | 5 ++---
 net/netlink/af_netlink.c | 4 ++--
 net/socket.c             | 4 ++--
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 9286a5a8c60c..1f52e998068b 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -343,6 +343,14 @@ struct ucred {
 
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
+/*
+ * Provide a bounce buffer for copying cmsg data to userspace when the
+ * target memory isn't already whitelisted for hardened usercopy.
+ */
+#define put_cmsg_whitelist(_msg, _level, _type, _ptr) ({		\
+		typeof(*(_ptr)) _val = *(_ptr);				\
+		put_cmsg(_msg, _level, _type, sizeof(_val), &_val);	\
+	})
 
 struct timespec;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index f39206b41b32..d8a3228acfd0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2879,7 +2879,6 @@ void sock_enable_timestamp(struct sock *sk, int flag)
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
 		       int level, int type)
 {
-	struct sock_exterr_skb *serr;
 	struct sk_buff *skb;
 	int copied, err;
 
@@ -2899,8 +2898,7 @@ int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
 
 	sock_recv_timestamp(msg, sk, skb);
 
-	serr = SKB_EXT_ERR(skb);
-	put_cmsg(msg, level, type, sizeof(serr->ee), &serr->ee);
+	put_cmsg_whitelist(msg, level, type, &SKB_EXT_ERR(skb)->ee);
 
 	msg->msg_flags |= MSG_ERRQUEUE;
 	err = copied;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 148533169b1d..676c019ba357 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1407,9 +1407,8 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	/* create control message to store iucv msg target class:
 	 * get the trgcls from the control buffer of the skb due to
 	 * fragmentation of original iucv message. */
-	err = put_cmsg(msg, SOL_IUCV, SCM_IUCV_TRGCLS,
-		       sizeof(IUCV_SKB_CB(skb)->class),
-		       (void *)&IUCV_SKB_CB(skb)->class);
+	err = put_cmsg_whitelist(msg, SOL_IUCV, SCM_IUCV_TRGCLS,
+				 &IUCV_SKB_CB(skb)->class);
 	if (err) {
 		if (!(flags & MSG_PEEK))
 			skb_queue_head(&sk->sk_receive_queue, skb);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b9e0ee4e22f5..4420dba35a44 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1781,8 +1781,8 @@ static void netlink_cmsg_listen_all_nsid(struct sock *sk, struct msghdr *msg,
 	if (!NETLINK_CB(skb).nsid_is_set)
 		return;
 
-	put_cmsg(msg, SOL_NETLINK, NETLINK_LISTEN_ALL_NSID, sizeof(int),
-		 &NETLINK_CB(skb).nsid);
+	put_cmsg_whitelist(msg, SOL_NETLINK, NETLINK_LISTEN_ALL_NSID,
+			   &NETLINK_CB(skb).nsid);
 }
 
 static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
diff --git a/net/socket.c b/net/socket.c
index 42d8e9c9ccd5..cb03ae055eb1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -787,8 +787,8 @@ static inline void sock_recv_drops(struct msghdr *msg, struct sock *sk,
 				   struct sk_buff *skb)
 {
 	if (sock_flag(sk, SOCK_RXQ_OVFL) && skb && SOCK_SKB_CB(skb)->dropcount)
-		put_cmsg(msg, SOL_SOCKET, SO_RXQ_OVFL,
-			sizeof(__u32), &SOCK_SKB_CB(skb)->dropcount);
+		put_cmsg_whitelist(msg, SOL_SOCKET, SO_RXQ_OVFL,
+				   &SOCK_SKB_CB(skb)->dropcount);
 }
 
 void __sock_recv_ts_and_drops(struct msghdr *msg, struct sock *sk,
-- 
2.7.4


-- 
Kees Cook
Pixel Security
