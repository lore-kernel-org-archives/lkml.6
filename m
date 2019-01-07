Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E870D20449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865150;
	bh=bV+Nje7V3/u0Oo21KMeYV1TtIiYioliVdhbGkCvXDTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tgsIQ14aT6FBYMkhuuRjuwWkrJFAD0c26JQkx8LM7VZjWq0PK3PfmjuJbI/C9+/u9
	 hrkJ+wdziph+o8S04R4xnhFdMlLBdUTR0lKVuvngNobLw2tUhI/f1SNRc/fyCNaDZ7
	 h99VbncbG8/rxjUv6i5bhmk2vR0+TmM6iwTLsfxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfAGMpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfAGMpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9BD218A1;
        Mon,  7 Jan 2019 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865144;
        bh=bV+Nje7V3/u0Oo21KMeYV1TtIiYioliVdhbGkCvXDTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/nL0veJO8qFJvee5S8ldVKSTH4AjV9X9aNdQiD8MJDzwJ46y/7CiSqZ9qT8lfZew
         hIu8Ys+nM20OhxOuJ5cISoJv5tfAb7etNBRw56VPVE6PYpvAa10KF3A6HjxqjGp6tQ
         IPF5xwMhvak46TMZ1xRv7OuQbFfGIgGEZRYXqmbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+f621cda8b7e598908efa@syzkaller.appspotmail.com
Subject: [PATCH 4.19 018/170] netrom: fix locking in nr_find_socket()
Date:   Mon,  7 Jan 2019 13:30:45 +0100
Message-Id: <20190107104455.202756371@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 7314f5480f3e37e570104dc5e0f28823ef849e72 ]

nr_find_socket(), nr_find_peer() and nr_find_listener() lock the
sock after finding it in the global list. However, the call path
requires BH disabled for the sock lock consistently.

Actually the locking is unnecessary at this point, we can just hold
the sock refcnt to make sure it is not gone after we unlock the global
list, and lock it later only when needed.

Reported-and-tested-by: syzbot+f621cda8b7e598908efa@syzkaller.appspotmail.com
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netrom/af_netrom.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -153,7 +153,7 @@ static struct sock *nr_find_listener(ax2
 	sk_for_each(s, &nr_list)
 		if (!ax25cmp(&nr_sk(s)->source_addr, addr) &&
 		    s->sk_state == TCP_LISTEN) {
-			bh_lock_sock(s);
+			sock_hold(s);
 			goto found;
 		}
 	s = NULL;
@@ -174,7 +174,7 @@ static struct sock *nr_find_socket(unsig
 		struct nr_sock *nr = nr_sk(s);
 
 		if (nr->my_index == index && nr->my_id == id) {
-			bh_lock_sock(s);
+			sock_hold(s);
 			goto found;
 		}
 	}
@@ -198,7 +198,7 @@ static struct sock *nr_find_peer(unsigne
 
 		if (nr->your_index == index && nr->your_id == id &&
 		    !ax25cmp(&nr->dest_addr, dest)) {
-			bh_lock_sock(s);
+			sock_hold(s);
 			goto found;
 		}
 	}
@@ -224,7 +224,7 @@ static unsigned short nr_find_next_circu
 		if (i != 0 && j != 0) {
 			if ((sk=nr_find_socket(i, j)) == NULL)
 				break;
-			bh_unlock_sock(sk);
+			sock_put(sk);
 		}
 
 		id++;
@@ -920,6 +920,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 	}
 
 	if (sk != NULL) {
+		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);
 
 		if (frametype == NR_CONNACK && skb->len == 22)
@@ -929,6 +930,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 
 		ret = nr_process_rx_frame(sk, skb);
 		bh_unlock_sock(sk);
+		sock_put(sk);
 		return ret;
 	}
 
@@ -960,10 +962,12 @@ int nr_rx_frame(struct sk_buff *skb, str
 	    (make = nr_make_new(sk)) == NULL) {
 		nr_transmit_refusal(skb, 0);
 		if (sk)
-			bh_unlock_sock(sk);
+			sock_put(sk);
 		return 0;
 	}
 
+	bh_lock_sock(sk);
+
 	window = skb->data[20];
 
 	skb->sk             = make;
@@ -1016,6 +1020,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 		sk->sk_data_ready(sk);
 
 	bh_unlock_sock(sk);
+	sock_put(sk);
 
 	nr_insert_socket(make);
 


