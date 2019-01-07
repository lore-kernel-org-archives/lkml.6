Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7012AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4077421736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866313;
	bh=ghzC8jBenfIE/TJltV3fa46m9gr51F1rLg6CvLpsboM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/C7QLXxTXfpRxWHwXGzCejTcX++dE650LlJ9cQXX/CTa+owZtLaWltDc60zya4fj
	 51ui5JJob5wJ+rsgfOCCz8UrrWMgxU5jKL2wjzuCks+QsV3/cd+phvYHeRLEwSj+vR
	 jydVVu6UB6qhXKvGTO/gaUCuN7EApdbb5OGOqS3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfAGNFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfAGNFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8812089F;
        Mon,  7 Jan 2019 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866306;
        bh=ghzC8jBenfIE/TJltV3fa46m9gr51F1rLg6CvLpsboM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7HGCJ+cnjLwGCXXamkdqho8I+LbY17is+W2xR9aTvtKXoR/57DBQnJ/46Kn1GO5z
         0FaeHzaujq8czq6Ecanw0wFfAVU5CRCH2HPNrh2d9NqfooJ2t8PSMQhDnuRRlAMvlm
         DrNRZctmMmCHQZpiB7uwidsjnvT0A/8sYR+H7lpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+f621cda8b7e598908efa@syzkaller.appspotmail.com
Subject: [PATCH 4.9 14/71] netrom: fix locking in nr_find_socket()
Date:   Mon,  7 Jan 2019 13:32:43 +0100
Message-Id: <20190107105331.662034392@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -918,6 +918,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 	}
 
 	if (sk != NULL) {
+		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);
 
 		if (frametype == NR_CONNACK && skb->len == 22)
@@ -927,6 +928,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 
 		ret = nr_process_rx_frame(sk, skb);
 		bh_unlock_sock(sk);
+		sock_put(sk);
 		return ret;
 	}
 
@@ -958,10 +960,12 @@ int nr_rx_frame(struct sk_buff *skb, str
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
@@ -1014,6 +1018,7 @@ int nr_rx_frame(struct sk_buff *skb, str
 		sk->sk_data_ready(sk);
 
 	bh_unlock_sock(sk);
+	sock_put(sk);
 
 	nr_insert_socket(make);
 


