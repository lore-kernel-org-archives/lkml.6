Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0252146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0252146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbeIREgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbeIREgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:13 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 594EBC49;
        Mon, 17 Sep 2018 23:06:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zubin Mithra <zsm@chromium.org>
Subject: [PATCH 4.14 123/126] tun: fix use after free for ptr_ring
Date:   Tue, 18 Sep 2018 00:42:51 +0200
Message-Id: <20180917211712.041602122@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

commit b196d88aba8ac72b775137854121097f4c4c6862 upstream.

We used to initialize ptr_ring during TUNSETIFF, this is because its
size depends on the tx_queue_len of netdevice. And we try to clean it
up when socket were detached from netdevice. A race were spotted when
trying to do uninit during a read which will lead a use after free for
pointer ring. Solving this by always initialize a zero size ptr_ring
in open() and do resizing during TUNSETIFF, and then we can safely do
cleanup during close(). With this, there's no need for the workaround
that was introduced by commit 4df0bfc79904 ("tun: fix a memory leak
for tfile->tx_array").

Backport Note :-
Comparison with the upstream patch:
[1] A "semantic revert" of the changes made in
    4df0bfc799("tun: fix a memory leak for tfile->tx_array").
        4df0bfc799 was applied upstream, and then skb array was changed
	to use ptr_ring. The upstream patch then removes the changes introduced
	by 4df0bfc799. This backport does the same; "revert" the changes
	made by 4df0bfc799.
[2] xdp_rxq_info_unreg() being called in relevant locations
        As xdp_rxq_info related patches are not present in 4.14, these
	changes are not needed in the backport.
[3] An instance of ptr_ring_init needs to be replaced by skb_array_init
	Inside tun_attach()
[4] ptr_ring_cleanup needs to be replaced by skb_array_cleanup
	Inside tun_chr_close()

Note that the backport for 7063efd33b ("tuntap: fix use after free during release")
needs to be applied on top of this patch.

Reported-by: syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -534,14 +534,6 @@ static void tun_queue_purge(struct tun_f
 	skb_queue_purge(&tfile->sk.sk_error_queue);
 }
 
-static void tun_cleanup_tx_array(struct tun_file *tfile)
-{
-	if (tfile->tx_array.ring.queue) {
-		skb_array_cleanup(&tfile->tx_array);
-		memset(&tfile->tx_array, 0, sizeof(tfile->tx_array));
-	}
-}
-
 static void __tun_detach(struct tun_file *tfile, bool clean)
 {
 	struct tun_file *ntfile;
@@ -583,7 +575,6 @@ static void __tun_detach(struct tun_file
 			    tun->dev->reg_state == NETREG_REGISTERED)
 				unregister_netdevice(tun->dev);
 		}
-		tun_cleanup_tx_array(tfile);
 		sock_put(&tfile->sk);
 	}
 }
@@ -623,13 +614,11 @@ static void tun_detach_all(struct net_de
 		/* Drop read queue */
 		tun_queue_purge(tfile);
 		sock_put(&tfile->sk);
-		tun_cleanup_tx_array(tfile);
 	}
 	list_for_each_entry_safe(tfile, tmp, &tun->disabled, next) {
 		tun_enable_queue(tfile);
 		tun_queue_purge(tfile);
 		sock_put(&tfile->sk);
-		tun_cleanup_tx_array(tfile);
 	}
 	BUG_ON(tun->numdisabled != 0);
 
@@ -675,7 +664,7 @@ static int tun_attach(struct tun_struct
 	}
 
 	if (!tfile->detached &&
-	    skb_array_init(&tfile->tx_array, dev->tx_queue_len, GFP_KERNEL)) {
+	    skb_array_resize(&tfile->tx_array, dev->tx_queue_len, GFP_KERNEL)) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -2624,6 +2613,11 @@ static int tun_chr_open(struct inode *in
 					    &tun_proto, 0);
 	if (!tfile)
 		return -ENOMEM;
+	if (skb_array_init(&tfile->tx_array, 0, GFP_KERNEL)) {
+		sk_free(&tfile->sk);
+		return -ENOMEM;
+	}
+
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
 	tfile->ifindex = 0;
@@ -2644,8 +2638,6 @@ static int tun_chr_open(struct inode *in
 
 	sock_set_flag(&tfile->sk, SOCK_ZEROCOPY);
 
-	memset(&tfile->tx_array, 0, sizeof(tfile->tx_array));
-
 	return 0;
 }
 
@@ -2654,6 +2646,7 @@ static int tun_chr_close(struct inode *i
 	struct tun_file *tfile = file->private_data;
 
 	tun_detach(tfile, true);
+	skb_array_cleanup(&tfile->tx_array);
 
 	return 0;
 }


