Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB892C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB24E2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216228;
	bh=sz6nh7noQJYQ3i1NOrwtQlAM03C/iOgcpVgrEb+aMPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ct1rluUXsz0eH0jmpXzktzBbgUSIbDvwWgk9vRD5ZjtdH1rj1FhAoiveePB1bNmsu
	 2X1thz+563kmfiWKzGjAqmlG2QcAgRkp88IBOZMwyWRSMOyUz8SvS1vEe9fKyNKCHP
	 sPA+q57O8PFtfLG44HKMzzXf8lN+Ep8Y/pN5ngco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbfAKORH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:17:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387792AbfAKORF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:17:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7CCC21783;
        Fri, 11 Jan 2019 14:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216224;
        bh=sz6nh7noQJYQ3i1NOrwtQlAM03C/iOgcpVgrEb+aMPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qx2ZV/Y9uDAmessH4CwF6+5+JOl+Tv15EZGSNpBEOH+o3EPcM1a2E67l96BgHfozH
         iqaMPMttBJmZAUziVg356gYCjLE7sz8Azo0+2UOrs0BJbwNprwsKIuPmgPejTIUNEk
         Z4gV8VIraEKIlyzIBffU4MoBjM3t54JpZ9DiK9/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+f621cda8b7e598908efa@syzkaller.appspotmail.com
Subject: [PATCH 4.4 21/88] netrom: fix locking in nr_find_socket()
Date:   Fri, 11 Jan 2019 15:07:50 +0100
Message-Id: <20190111131049.284504602@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 


