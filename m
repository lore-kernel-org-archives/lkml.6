Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeDVNu0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 09:50:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34047 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeDVNuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 09:50:23 -0400
X-Google-Smtp-Source: AIpwx4+zOi5lmPqSGpSmmrCsPMS2eJs8DBsamxlURMAME0MV6q8NDIUGcPnfVfWAMUiNDX0oVUy/GQ==
From: Yafang Shao <laoar.shao@gmail.com>
To: eric.dumazet@gmail.com, alexei.starovoitov@gmail.com,
        davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] net: init sk_cookie for inet socket
Date: Sun, 22 Apr 2018 21:50:04 +0800
Message-Id: <1524405004-10960-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sk_cookie we can identify a socket, that is very helpful for
traceing and statistic, i.e. tcp tracepiont and ebpf.
So we'd better init it by default for inet socket.
When using it, we just need call atomic64_read(&sk->sk_cookie).

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/sock_diag.h | 9 +++++++++
 net/ipv4/tcp_input.c      | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/sock_diag.h b/include/linux/sock_diag.h
index 15fe980..5c916e6 100644
--- a/include/linux/sock_diag.h
+++ b/include/linux/sock_diag.h
@@ -25,6 +25,15 @@ struct sock_diag_handler {
 void sock_diag_register_inet_compat(int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh));
 void sock_diag_unregister_inet_compat(int (*fn)(struct sk_buff *skb, struct nlmsghdr *nlh));
 
+static inline
+void sock_init_cookie(struct sock *sk)
+{
+	u64 res;
+
+	res = atomic64_inc_return(&sock_net(sk)->cookie_gen);
+	atomic64_set(&sk->sk_cookie, res);
+}
+
 u64 sock_gen_cookie(struct sock *sk);
 int sock_diag_check_cookie(struct sock *sk, const __u32 *cookie);
 void sock_diag_save_cookie(struct sock *sk, __u32 *cookie);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0396fb9..e6a64a3 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -78,6 +78,7 @@
 #include <linux/errqueue.h>
 #include <trace/events/tcp.h>
 #include <linux/static_key.h>
+#include <linux/sock_diag.h>
 
 int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 
@@ -6188,10 +6189,15 @@ struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
 #if IS_ENABLED(CONFIG_IPV6)
 		ireq->pktopts = NULL;
 #endif
-		atomic64_set(&ireq->ir_cookie, 0);
 		ireq->ireq_state = TCP_NEW_SYN_RECV;
 		write_pnet(&ireq->ireq_net, sock_net(sk_listener));
 		ireq->ireq_family = sk_listener->sk_family;
+
+		BUILD_BUG_ON(offsetof(struct inet_request_sock, ir_cookie) !=
+					offsetof(struct sock, sk_cookie));
+		BUILD_BUG_ON(offsetof(struct inet_request_sock, ireq_net) !=
+					offsetof(struct sock, sk_net));
+		sock_init_cookie((struct sock *)ireq);
 	}
 
 	return req;
-- 
1.8.3.1
