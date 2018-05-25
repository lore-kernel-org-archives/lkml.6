Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936099AbeEYKOS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:14:18 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:46696 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935638AbeEYKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:14:16 -0400
X-Google-Smtp-Source: AB8JxZpGBk+zCKX19xf+/0+9ah41JovDkLygARqVLKBYadO/JyTeKOX1AQiy60rmzNZfqgY9qrTvoA==
From: Yafang Shao <laoar.shao@gmail.com>
To: songliubraving@fb.com
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next] tcp: use data length instead of skb->len in tcp_probe
Date: Fri, 25 May 2018 18:14:05 +0800
Message-Id: <1527243245-29582-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb->len is meaningless to user.
data length could be more helpful, with which we can easily filter out
the packet without payload.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/tcp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index c1a5284..703abb6 100644
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
@@ -261,7 +261,7 @@
 		__entry->dport = ntohs(inet->inet_dport);
 		__entry->mark = skb->mark;
 
-		__entry->length = skb->len;
+		__entry->data_len = skb->len - tcp_hdrlen(skb);
 		__entry->snd_nxt = tp->snd_nxt;
 		__entry->snd_una = tp->snd_una;
 		__entry->snd_cwnd = tp->snd_cwnd;
@@ -272,9 +272,9 @@
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
