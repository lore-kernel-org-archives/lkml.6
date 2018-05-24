Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966783AbeEXMsl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:48:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:39094 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965191AbeEXMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:48:37 -0400
X-Google-Smtp-Source: AB8JxZodHTCLjnv4y5uSsrDBgZtTZE3iMUy6mDBAa4O15xdhZRqR3XfhoX2PVFxO9EKuiM+1/QqQCw==
From: Yafang Shao <laoar.shao@gmail.com>
To: davem@davemloft.net, songliubraving@fb.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: use data length instead of skb->len in tcp_probe
Date: Thu, 24 May 2018 20:48:17 +0800
Message-Id: <1527166097-10908-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb->len is meaningless to user.
data length could be more helpful, with which we can easily filter out
the packet without payload.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index c1a5284..259b991 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -261,7 +261,7 @@
 		__entry->dport = ntohs(inet->inet_dport);
 		__entry->mark = skb->mark;
 
-		__entry->length = skb->len;
+		__entry->length = skb->len - tcp_hdrlen(skb);
 		__entry->snd_nxt = tp->snd_nxt;
 		__entry->snd_una = tp->snd_una;
 		__entry->snd_cwnd = tp->snd_cwnd;
@@ -272,7 +272,7 @@
 		__entry->sock_cookie = sock_gen_cookie(sk);
 	),
 
-	TP_printk("src=%pISpc dest=%pISpc mark=%#x length=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
+	TP_printk("src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
 		  __entry->saddr, __entry->daddr, __entry->mark,
 		  __entry->length, __entry->snd_nxt, __entry->snd_una,
 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
-- 
1.8.3.1
