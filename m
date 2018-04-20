Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755936AbeDTP4R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:56:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37546 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755903AbeDTPz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:55:57 -0400
X-Google-Smtp-Source: AIpwx48pACIQBdRZoa8zadbigeB0f0sgP9lSw83Z0qRDVBLpXcpkWBZicow84dLfQ3yz9ODlPwoUiA==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net-next 4/4] tcp: mmap: move the skb cleanup to tcp_mmap_hook()
Date: Fri, 20 Apr 2018 08:55:42 -0700
Message-Id: <20180420155542.122183-5-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180420155542.122183-1-edumazet@google.com>
References: <20180420155542.122183-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freeing all skbs and sending ACK is time consuming.

This is currently done while both current->mm->mmap_sem and socket
lock are held, in tcp_mmap()

Thanks to mmap_hook infrastructure, we can perform the cleanup
after current->mm->mmap_sem has been released, thus allowing
other threads to perform mm operations without delay.

Note that the preparation work (building the array of page
pointers) can also be done from tcp_mmap_hook() while
mmap_sem has not been taken yet, but this is another independent change.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e913b2dd5df321f2789e8d5f233ede9c2f1d5624..82f7c3e47253cecac6ea1819fbb7a0712058ec55 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1740,9 +1740,16 @@ int tcp_mmap_hook(struct socket *sock, enum mmap_hook mode)
 		 */
 		return 0;
 	}
-	/* TODO: Move here the stuff that can been done after
-	 * current->mm->mmap_sem has been released.
-	 */
+	if (mode == MMAP_HOOK_COMMIT) {
+		u32 offset;
+
+		tcp_rcv_space_adjust(sk);
+
+		/* Clean up data we have read: This will do ACK frames. */
+		tcp_recv_skb(sk, tcp_sk(sk)->copied_seq, &offset);
+
+		tcp_cleanup_rbuf(sk, PAGE_SIZE);
+	}
 	release_sock(sk);
 	return 0;
 }
@@ -1843,13 +1850,8 @@ int tcp_mmap(struct file *file, struct socket *sock,
 		if (ret)
 			goto out;
 	}
-	/* operation is complete, we can 'consume' all skbs */
+	/* operation is complete, skbs will be freed from tcp_mmap_hook() */
 	tp->copied_seq = seq;
-	tcp_rcv_space_adjust(sk);
-
-	/* Clean up data we have read: This will do ACK frames. */
-	tcp_recv_skb(sk, seq, &offset);
-	tcp_cleanup_rbuf(sk, size);
 
 	ret = 0;
 out:
-- 
2.17.0.484.g0c8726318c-goog
