Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeEVGVO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:21:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751069AbeEVGVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:21:12 -0400
From: Jason Wang <jasowang@redhat.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, Jason Wang <jasowang@redhat.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] tuntap: correctly set SOCKWQ_ASYNC_NOSPACE
Date: Tue, 22 May 2018 14:21:04 +0800
Message-Id: <1526970064-29711-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When link is down, writes to the device might fail with
-EIO. Userspace needs an indication when the status is resolved.  As a
fix, tun_net_open() attempts to wake up writers - but that is only
effective if SOCKWQ_ASYNC_NOSPACE has been set in the past. This is
not the case of vhost_net which only poll for EPOLLOUT after it meets
errors during sendmsg().

This patch fixes this by making sure SOCKWQ_ASYNC_NOSPACE is set when
socket is not writable or device is down to guarantee EPOLLOUT will be
raised in either tun_chr_poll() or tun_sock_write_space() after device
is up.

Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: Eric Dumazet <edumazet@google.com>
Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d45ac37..45d8077 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1423,6 +1423,13 @@ static void tun_net_init(struct net_device *dev)
 	dev->max_mtu = MAX_MTU - dev->hard_header_len;
 }
 
+static bool tun_sock_writeable(struct tun_struct *tun, struct tun_file *tfile)
+{
+	struct sock *sk = tfile->socket.sk;
+
+	return (tun->dev->flags & IFF_UP) && sock_writeable(sk);
+}
+
 /* Character device part */
 
 /* Poll */
@@ -1445,10 +1452,14 @@ static __poll_t tun_chr_poll(struct file *file, poll_table *wait)
 	if (!ptr_ring_empty(&tfile->tx_ring))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
-	if (tun->dev->flags & IFF_UP &&
-	    (sock_writeable(sk) ||
-	     (!test_and_set_bit(SOCKWQ_ASYNC_NOSPACE, &sk->sk_socket->flags) &&
-	      sock_writeable(sk))))
+	/* Make sure SOCKWQ_ASYNC_NOSPACE is set if not writable to
+	 * guarantee EPOLLOUT to be raised by either here or
+	 * tun_sock_write_space(). Then process could get notification
+	 * after it writes to a down device and meets -EIO.
+	 */
+	if (tun_sock_writeable(tun, tfile) ||
+	    (!test_and_set_bit(SOCKWQ_ASYNC_NOSPACE, &sk->sk_socket->flags) &&
+	     tun_sock_writeable(tun, tfile)))
 		mask |= EPOLLOUT | EPOLLWRNORM;
 
 	if (tun->dev->reg_state != NETREG_REGISTERED)
-- 
2.7.4
