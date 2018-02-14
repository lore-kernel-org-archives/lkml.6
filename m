Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966746AbeBNDgM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:36:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966671AbeBNDgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:36:11 -0500
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, christoffer.dall@linaro.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] tuntap: try not batch packets for devmap
Date: Wed, 14 Feb 2018 11:36:05 +0800
Message-Id: <1518579365-4851-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 762c330d670e ("tuntap: add missing xdp flush") tries to fix the
devmap stall caused by missed xdp flush by counting the pending xdp
redirected packets and flush when it exceeds NAPI_POLL_WEIGHT or
MSG_MORE is clear. This may lead BUG() since xdp_do_flush() was
called under process context with preemption enabled. Simply disable
preemption may silent the warning but be not enough since process may
move between different CPUS during a batch which cause xdp_do_flush()
misses some CPU where the process run previously. For -net, fix this
by simply calling xdp_do_flush() immediately after xdp_do_redirect(),
a side effect is that this removes any possibility of batching which
could be addressed in the future.

Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
Fixes: 762c330d670e ("tuntap: add missing xdp flush")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 17e496b..6a4cd97 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -181,7 +181,6 @@ struct tun_file {
 	struct tun_struct *detached;
 	struct ptr_ring tx_ring;
 	struct xdp_rxq_info xdp_rxq;
-	int xdp_pending_pkts;
 };
 
 struct tun_flow_entry {
@@ -1666,10 +1665,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		case XDP_REDIRECT:
 			get_page(alloc_frag->page);
 			alloc_frag->offset += buflen;
-			++tfile->xdp_pending_pkts;
 			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
 			if (err)
 				goto err_redirect;
+			xdp_do_flush_map();
 			rcu_read_unlock();
 			return NULL;
 		case XDP_TX:
@@ -1988,11 +1987,6 @@ static ssize_t tun_chr_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
@@ -2330,12 +2324,6 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 			   m->msg_flags & MSG_DONTWAIT,
 			   m->msg_flags & MSG_MORE);
 
-	if (tfile->xdp_pending_pkts >= NAPI_POLL_WEIGHT ||
-	    !(m->msg_flags & MSG_MORE)) {
-		tfile->xdp_pending_pkts = 0;
-		xdp_do_flush_map();
-	}
-
 	tun_put(tun);
 	return ret;
 }
@@ -3167,7 +3155,6 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	sock_set_flag(&tfile->sk, SOCK_ZEROCOPY);
 
 	memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
-	tfile->xdp_pending_pkts = 0;
 
 	return 0;
 }
-- 
2.7.4
