Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeBVJgx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:36:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752991AbeBVJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:36:51 -0500
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, christoffer.dall@linaro.org,
        sergei.shtylyov@cogentembedded.com, Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v3 1/2] Revert "tuntap: add missing xdp flush"
Date: Thu, 22 Feb 2018 17:36:45 +0800
Message-Id: <1519292206-6384-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 762c330d670e3d4b795cf7a8d761866fdd1eef49. The
reason is we try to batch packets for devmap which causes calling
xdp_do_flush() in the process context. Simply disabling preemption
may not work since process may move among processors which lead
xdp_do_flush() to miss some flushes on some processors.

So simply revert the patch, a follow-up patch will add the xdp flush
correctly.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Fixes: 762c330d670e ("tuntap: add missing xdp flush")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b52258c..2823a4a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -181,7 +181,6 @@ struct tun_file {
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
 	struct xdp_rxq_info xdp_rxq;
-	int xdp_pending_pkts;
 };
 
 struct tun_flow_entry {
@@ -1662,7 +1661,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		case XDP_REDIRECT:
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
-			++tfile->xdp_pending_pkts;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
 			if (err)
 				goto err_redirect;
@@ -1984,11 +1982,6 @@ static ssize_t tun_chr_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	result = tun_get_user(tun, tfile, NULL, from,
 			      file->f_flags & O_NONBLOCK, false);
 
-	if (tfile->xdp_pending_pkts) {
-		tfile->xdp_pending_pkts = 0;
-		xdp_do_flush_map();
-	}
-
 	tun_put(tun);
 	return result;
 }
@@ -2325,13 +2318,6 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	ret = tun_get_user(tun, tfile, m->msg_control, &m->msg_iter,
 			   m->msg_flags & MSG_DONTWAIT,
 			   m->msg_flags & MSG_MORE);
-
-	if (tfile->xdp_pending_pkts >= NAPI_POLL_WEIGHT ||
-	    !(m->msg_flags & MSG_MORE)) {
-		tfile->xdp_pending_pkts = 0;
-		xdp_do_flush_map();
-	}
-
 	tun_put(tun);
 	return ret;
 }
@@ -3163,7 +3149,6 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	sock_set_flag(&tfile->sk, SOCK_ZEROCOPY);
 
 	memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
-	tfile->xdp_pending_pkts = 0;
 
 	return 0;
 }
-- 
2.7.4
