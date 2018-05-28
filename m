Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969055AbeE1PgY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:36:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43057 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968791AbeE1PgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:36:18 -0400
X-Google-Smtp-Source: AB8JxZqEaBKQNug7dkm/cLBPvX+s9heDHVMvc68JjKBtNiF3z+lhqOEQdHI6JlvBZ+g4d6bJDaGBlA==
From: Yafang Shao <laoar.shao@gmail.com>
To: songliubraving@fb.com, edumazet@google.com, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 net-next 1/2] tcp: use data length instead of skb->len in tcp_probe
Date: Mon, 28 May 2018 23:35:52 +0800
Message-Id: <1527521753-17963-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point skb->len is including tcp header length, so it is meaningless
to user. data length could be more helpful, with which we can easily filter
out the packet without payload.

Cc: Eric Dumazet <edumazet@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

---
v3: tcp_hdr() is a little expensive than skb->data, so replace it with
    skb->data.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/tcp.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index c1a5284..7ff0446 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -236,7 +236,7 @@
 		__field(__u16, sport)
 		__field(__u16, dport)
 		__field(__u32, mark)
-		__field(__u16, length)
+		__field(__u16, data_len)
 		__field(__u32, snd_nxt)
 		__field(__u32, snd_una)
 		__field(__u32, snd_cwnd)
@@ -250,6 +250,7 @@
 	TP_fast_assign(
 		const struct tcp_sock *tp = tcp_sk(sk);
 		const struct inet_sock *inet = inet_sk(sk);
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
@@ -261,7 +262,7 @@
 		__entry->dport = ntohs(inet->inet_dport);
 		__entry->mark = skb->mark;
 
-		__entry->length = skb->len;
+		__entry->data_len = skb->len - __tcp_hdrlen(th);
 		__entry->snd_nxt = tp->snd_nxt;
 		__entry->snd_una = tp->snd_una;
 		__entry->snd_cwnd = tp->snd_cwnd;
@@ -272,9 +273,9 @@
 		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
+	TP_printk("src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
 		  __entry->saddr, __entry->daddr, __entry->mark,
-		  __entry->length, __entry->snd_nxt, __entry->snd_una,
+		  __entry->data_len, __entry->snd_nxt, __entry->snd_una,
 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
 		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
 );
-- 
1.8.3.1
