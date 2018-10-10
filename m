Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90828C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD582150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ArjDnXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD582150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJKGiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeJKGiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:09 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE9AB214C4;
        Wed, 10 Oct 2018 23:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213223;
        bh=yEBRWaPrq83d+Ue6LxgT4tnfRQzzSyII/4nOUE33Ypk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ArjDnXNsuuAk7QTofY3SfHRIFMr+Ox0kVCTRoQJuLedjCaot3Jfnp+tyeaJq73Y2
         BTWTEtgIuo4Fq4bTcp33Uoi1vU0QBrUef14apRp4aZNkqCus8EwrLYC1xRoXhNA4Kk
         QhuBO8HfDkKoa6ieXvJIykzoxQRi1uuzwKkOz0po=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 23/30] rwlock: Prepare write_[un]lock_bh() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:10 +0200
Message-Id: <1539213137-13953-24-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

This pair of function is implemented on top of __local_bh_disable_ip()
that is going to handle a softirq mask in order to apply finegrained
vector disablement. The lock function is going to return the previous
vectors enabled mask prior to the last call to local_bh_disable(),
following a similar model to that of local_irq_save/restore. Subsequent
calls to local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		bh2 = write_lock_bh(...);
		...
		write_unlock_bh(..., bh2);
	local_bh_enable(bh);

To prepare for that, make write_lock_bh() able to return a saved vector
enabled mask and pass it back to write_unlock_bh(). We'll plug it to
__local_bh_disable_ip() in a subsequent patch.

Thanks to coccinelle that helped a lot with scripts such as the
following:

	@rw exists@
	identifier func;
	expression e;
	@@
	func(...) {
	+ unsigned int bh;
	...
	- write_lock_bh(e);
	+ bh = write_lock_bh(e);
	...
	- write_unlock_bh(e);
	+ write_unlock_bh(e, bh);
	...
	}

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 drivers/block/drbd/drbd_receiver.c                 |  10 +-
 drivers/infiniband/core/roce_gid_mgmt.c            |   5 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   5 +-
 drivers/isdn/mISDN/socket.c                        |  17 +--
 drivers/isdn/mISDN/stack.c                         |  10 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c |  17 +--
 drivers/net/ethernet/chelsio/cxgb3/l2t.c           |  10 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c      |  41 +++---
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |  17 +--
 drivers/net/ethernet/chelsio/cxgb4/smt.c           |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |   5 +-
 drivers/net/hamradio/6pack.c                       |   5 +-
 drivers/net/hamradio/mkiss.c                       |   5 +-
 drivers/net/ieee802154/fakelb.c                    |  20 +--
 drivers/net/ppp/ppp_generic.c                      |  35 +++---
 drivers/net/ppp/pppoe.c                            |  24 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   5 +-
 .../net/wireless/intersil/hostap/hostap_80211_rx.c |   5 +-
 drivers/net/wireless/intersil/hostap/hostap_main.c |  12 +-
 drivers/net/wireless/intersil/hostap/hostap_proc.c |   2 +-
 drivers/s390/net/netiucv.c                         |  36 +++---
 drivers/s390/net/qeth_l3_main.c                    |  10 +-
 drivers/scsi/bnx2i/bnx2i_iscsi.c                   |  45 ++++---
 drivers/scsi/cxgbi/libcxgbi.c                      |  15 ++-
 drivers/scsi/iscsi_tcp.c                           |  31 +++--
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  69 +++++-----
 drivers/target/iscsi/iscsi_target_nego.c           |  60 +++++----
 drivers/tty/hvc/hvc_iucv.c                         |  10 +-
 drivers/xen/pvcalls-back.c                         |  20 +--
 fs/dlm/lowcomms.c                                  |  40 +++---
 fs/ocfs2/cluster/tcp.c                             |  35 +++---
 include/linux/rwlock.h                             |   8 +-
 include/linux/rwlock_api_smp.h                     |  30 +++--
 include/linux/spinlock_api_up.h                    |   2 +-
 include/net/ping.h                                 |   1 +
 include/net/sock.h                                 |  10 +-
 kernel/bpf/reuseport_array.c                       |  22 ++--
 kernel/bpf/sockmap.c                               |  20 +--
 kernel/locking/spinlock.c                          |  26 ++--
 net/6lowpan/ndisc.c                                |  12 +-
 net/appletalk/aarp.c                               |  48 ++++---
 net/appletalk/atalk_proc.c                         |   6 +-
 net/appletalk/ddp.c                                |  65 ++++++----
 net/atm/mpc.c                                      |   5 +-
 net/atm/mpoa_caches.c                              |  41 +++---
 net/ax25/ax25_iface.c                              |  15 ++-
 net/ax25/ax25_route.c                              |  33 ++---
 net/bridge/netfilter/ebtables.c                    |  32 ++---
 net/core/dev.c                                     |  19 +--
 net/core/link_watch.c                              |   5 +-
 net/core/neighbour.c                               | 139 ++++++++++++---------
 net/core/netpoll.c                                 |   5 +-
 net/core/pktgen.c                                  |   5 +-
 net/core/rtnetlink.c                               |  10 +-
 net/core/skbuff.c                                  |   5 +-
 net/core/sock.c                                    |  10 +-
 net/decnet/af_decnet.c                             |  20 +--
 net/decnet/dn_table.c                              |  27 ++--
 net/hsr/hsr_device.c                               |   7 +-
 net/ieee802154/6lowpan/tx.c                        |   5 +-
 net/ieee802154/socket.c                            |  20 +--
 net/ipv4/arp.c                                     |  10 +-
 net/ipv4/ipmr.c                                    |  17 +--
 net/ipv4/ping.c                                    |  22 ++--
 net/ipv4/raw.c                                     |  10 +-
 net/ipv6/addrconf.c                                | 120 ++++++++++--------
 net/ipv6/anycast.c                                 |  38 +++---
 net/ipv6/ip6_fib.c                                 |  10 +-
 net/ipv6/ip6mr.c                                   |  27 ++--
 net/ipv6/ipv6_sockglue.c                           |  11 +-
 net/ipv6/mcast.c                                   | 128 +++++++++++--------
 net/ipv6/ndisc.c                                   |  17 +--
 net/ipv6/netfilter/nf_tproxy_ipv6.c                |   5 +-
 net/iucv/af_iucv.c                                 |  20 +--
 net/kcm/kcmsock.c                                  |  24 ++--
 net/l2tp/l2tp_core.c                               |  33 ++---
 net/l2tp/l2tp_debugfs.c                            |   5 +-
 net/l2tp/l2tp_ip.c                                 |  29 +++--
 net/l2tp/l2tp_ip6.c                                |  29 +++--
 net/lapb/lapb_iface.c                              |  15 ++-
 net/mac802154/llsec.c                              |  31 +++--
 net/netfilter/ipset/ip_set_core.c                  |  45 ++++---
 net/netfilter/ipvs/ip_vs_conn.c                    |   8 +-
 net/netfilter/nf_conntrack_proto_gre.c             |  27 ++--
 net/netfilter/nf_log_common.c                      |   5 +-
 net/netfilter/nf_nat_redirect.c                    |   5 +-
 net/netfilter/nfnetlink_log.c                      |   7 +-
 net/netfilter/nfnetlink_queue.c                    |  12 +-
 net/netfilter/nft_meta.c                           |  13 +-
 net/netfilter/nft_set_rbtree.c                     |  32 +++--
 net/rds/tcp.c                                      |  10 +-
 net/rds/tcp_connect.c                              |   5 +-
 net/rds/tcp_listen.c                               |  15 ++-
 net/rds/tcp_recv.c                                 |   5 +-
 net/rds/tcp_send.c                                 |   5 +-
 net/rxrpc/ar-internal.h                            |  15 ++-
 net/rxrpc/call_accept.c                            |  12 +-
 net/rxrpc/call_object.c                            |   5 +-
 net/rxrpc/conn_client.c                            |   5 +-
 net/rxrpc/conn_event.c                             |   5 +-
 net/rxrpc/recvmsg.c                                |  26 ++--
 net/rxrpc/sendmsg.c                                |  10 +-
 net/sctp/ipv6.c                                    |   5 +-
 net/sctp/proc.c                                    |   5 +-
 net/sctp/socket.c                                  |   5 +-
 net/smc/af_smc.c                                   |  10 +-
 net/smc/smc_cdc.c                                  |   5 +-
 net/smc/smc_core.c                                 |  41 +++---
 net/sunrpc/xprtsock.c                              |  45 ++++---
 net/tipc/monitor.c                                 |  54 ++++----
 net/tipc/node.c                                    |  14 ++-
 net/tipc/topsrv.c                                  |  35 +++---
 net/tls/tls_sw.c                                   |  10 +-
 net/x25/af_x25.c                                   |  45 ++++---
 net/x25/x25_forward.c                              |  25 ++--
 net/x25/x25_link.c                                 |  30 +++--
 net/x25/x25_proc.c                                 |   6 +-
 net/x25/x25_route.c                                |  25 ++--
 net/xfrm/xfrm_policy.c                             |   7 +-
 122 files changed, 1494 insertions(+), 1050 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 75f6b47..a763105 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -704,6 +704,7 @@ static void drbd_incoming_connection(struct sock *sk)
 
 static int prepare_listen_socket(struct drbd_connection *connection, struct accept_wait_data *ad)
 {
+	unsigned int bh;
 	int err, sndbuf_size, rcvbuf_size, my_addr_len;
 	struct sockaddr_in6 my_addr;
 	struct socket *s_listen;
@@ -740,11 +741,11 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 		goto out;
 
 	ad->s_listen = s_listen;
-	write_lock_bh(&s_listen->sk->sk_callback_lock);
+	bh = write_lock_bh(&s_listen->sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	ad->original_sk_state_change = s_listen->sk->sk_state_change;
 	s_listen->sk->sk_state_change = drbd_incoming_connection;
 	s_listen->sk->sk_user_data = ad;
-	write_unlock_bh(&s_listen->sk->sk_callback_lock);
+	write_unlock_bh(&s_listen->sk->sk_callback_lock, bh);
 
 	what = "listen";
 	err = s_listen->ops->listen(s_listen, 5);
@@ -767,10 +768,11 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 
 static void unregister_state_change(struct sock *sk, struct accept_wait_data *ad)
 {
-	write_lock_bh(&sk->sk_callback_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sk->sk_state_change = ad->original_sk_state_change;
 	sk->sk_user_data = NULL;
-	write_unlock_bh(&sk->sk_callback_lock);
+	write_unlock_bh(&sk->sk_callback_lock, bh);
 }
 
 static struct socket *drbd_wait_for_connect(struct drbd_connection *connection, struct accept_wait_data *ad)
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index ee36619..d1ed810 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -370,6 +370,7 @@ static void enum_netdev_ipv4_ips(struct ib_device *ib_dev,
 static void enum_netdev_ipv6_ips(struct ib_device *ib_dev,
 				 u8 port, struct net_device *ndev)
 {
+	unsigned int bh;
 	struct inet6_ifaddr *ifp;
 	struct inet6_dev *in6_dev;
 	struct sin6_list {
@@ -388,7 +389,7 @@ static void enum_netdev_ipv6_ips(struct ib_device *ib_dev,
 	if (!in6_dev)
 		return;
 
-	read_lock_bh(&in6_dev->lock);
+	bh = read_lock_bh(&in6_dev->lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
 		struct sin6_list *entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
 
@@ -399,7 +400,7 @@ static void enum_netdev_ipv6_ips(struct ib_device *ib_dev,
 		entry->sin6.sin6_addr = ifp->addr;
 		list_add_tail(&entry->list, &sin6_list);
 	}
-	read_unlock_bh(&in6_dev->lock);
+	read_unlock_bh(&in6_dev->lock, bh);
 
 	in6_dev_put(in6_dev);
 
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 0f83cbe..e064387 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -3163,6 +3163,7 @@ static int pick_local_ipaddrs(struct c4iw_dev *dev, struct iw_cm_id *cm_id)
 static int get_lladdr(struct net_device *dev, struct in6_addr *addr,
 		      unsigned char banned_flags)
 {
+	unsigned int bh;
 	struct inet6_dev *idev;
 	int err = -EADDRNOTAVAIL;
 
@@ -3171,7 +3172,7 @@ static int get_lladdr(struct net_device *dev, struct in6_addr *addr,
 	if (idev != NULL) {
 		struct inet6_ifaddr *ifp;
 
-		read_lock_bh(&idev->lock);
+		bh = read_lock_bh(&idev->lock, SOFTIRQ_ALL_MASK);
 		list_for_each_entry(ifp, &idev->addr_list, if_list) {
 			if (ifp->scope == IFA_LINK &&
 			    !(ifp->flags & banned_flags)) {
@@ -3180,7 +3181,7 @@ static int get_lladdr(struct net_device *dev, struct in6_addr *addr,
 				break;
 			}
 		}
-		read_unlock_bh(&idev->lock);
+		read_unlock_bh(&idev->lock, bh);
 	}
 	rcu_read_unlock();
 	return err;
diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 18c0a12..2c83d3d 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -54,16 +54,18 @@ _l2_alloc_skb(unsigned int len, gfp_t gfp_mask)
 static void
 mISDN_sock_link(struct mISDN_sock_list *l, struct sock *sk)
 {
-	write_lock_bh(&l->lock);
+	unsigned int bh;
+	bh = write_lock_bh(&l->lock, SOFTIRQ_ALL_MASK);
 	sk_add_node(sk, &l->head);
-	write_unlock_bh(&l->lock);
+	write_unlock_bh(&l->lock, bh);
 }
 
 static void mISDN_sock_unlink(struct mISDN_sock_list *l, struct sock *sk)
 {
-	write_lock_bh(&l->lock);
+	unsigned int bh;
+	bh = write_lock_bh(&l->lock, SOFTIRQ_ALL_MASK);
 	sk_del_node_init(sk);
-	write_unlock_bh(&l->lock);
+	write_unlock_bh(&l->lock, bh);
 }
 
 static int
@@ -474,6 +476,7 @@ static int data_sock_getsockopt(struct socket *sock, int level, int optname,
 static int
 data_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 {
+	unsigned int bh;
 	struct sockaddr_mISDN *maddr = (struct sockaddr_mISDN *) addr;
 	struct sock *sk = sock->sk;
 	struct sock *csk;
@@ -499,7 +502,7 @@ data_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	}
 
 	if (sk->sk_protocol < ISDN_P_B_START) {
-		read_lock_bh(&data_sockets.lock);
+		bh = read_lock_bh(&data_sockets.lock, SOFTIRQ_ALL_MASK);
 		sk_for_each(csk, &data_sockets.head) {
 			if (sk == csk)
 				continue;
@@ -510,11 +513,11 @@ data_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 			if (IS_ISDN_P_TE(csk->sk_protocol)
 			    == IS_ISDN_P_TE(sk->sk_protocol))
 				continue;
-			read_unlock_bh(&data_sockets.lock);
+			read_unlock_bh(&data_sockets.lock, bh);
 			err = -EBUSY;
 			goto done;
 		}
-		read_unlock_bh(&data_sockets.lock);
+		read_unlock_bh(&data_sockets.lock, bh);
 	}
 
 	_pms(sk)->ch.send = mISDN_send;
diff --git a/drivers/isdn/mISDN/stack.c b/drivers/isdn/mISDN/stack.c
index d97c6dd..fafa705 100644
--- a/drivers/isdn/mISDN/stack.c
+++ b/drivers/isdn/mISDN/stack.c
@@ -428,6 +428,7 @@ int
 connect_layer1(struct mISDNdevice *dev, struct mISDNchannel *ch,
 	       u_int protocol, struct sockaddr_mISDN *adr)
 {
+	unsigned int bh;
 	struct mISDN_sock	*msk = container_of(ch, struct mISDN_sock, ch);
 	struct channel_req	rq;
 	int			err;
@@ -452,9 +453,9 @@ connect_layer1(struct mISDNdevice *dev, struct mISDNchannel *ch,
 		       dev->id);
 		if (err)
 			return err;
-		write_lock_bh(&dev->D.st->l1sock.lock);
+		bh = write_lock_bh(&dev->D.st->l1sock.lock, SOFTIRQ_ALL_MASK);
 		sk_add_node(&msk->sk, &dev->D.st->l1sock.head);
-		write_unlock_bh(&dev->D.st->l1sock.lock);
+		write_unlock_bh(&dev->D.st->l1sock.lock, bh);
 		break;
 	default:
 		return -ENOPROTOOPT;
@@ -572,6 +573,7 @@ create_l2entity(struct mISDNdevice *dev, struct mISDNchannel *ch,
 void
 delete_channel(struct mISDNchannel *ch)
 {
+	unsigned int bh;
 	struct mISDN_sock	*msk = container_of(ch, struct mISDN_sock, ch);
 	struct mISDNchannel	*pch;
 
@@ -594,9 +596,9 @@ delete_channel(struct mISDNchannel *ch)
 	case ISDN_P_TE_S0:
 	case ISDN_P_NT_E1:
 	case ISDN_P_TE_E1:
-		write_lock_bh(&ch->st->l1sock.lock);
+		bh = write_lock_bh(&ch->st->l1sock.lock, SOFTIRQ_ALL_MASK);
 		sk_del_node_init(&msk->sk);
-		write_unlock_bh(&ch->st->l1sock.lock);
+		write_unlock_bh(&ch->st->l1sock.lock, bh);
 		ch->st->dev->D.ctrl(&ch->st->dev->D, CLOSE_CHANNEL, NULL);
 		break;
 	case ISDN_P_LAPD_TE:
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
index 10a1520..26a2b4d 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
@@ -1061,19 +1061,20 @@ EXPORT_SYMBOL(cxgb3_ofld_send);
 
 static int is_offloading(struct net_device *dev)
 {
+	unsigned int bh;
 	struct adapter *adapter;
 	int i;
 
-	read_lock_bh(&adapter_list_lock);
+	bh = read_lock_bh(&adapter_list_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(adapter, &adapter_list, adapter_list) {
 		for_each_port(adapter, i) {
 			if (dev == adapter->port[i]) {
-				read_unlock_bh(&adapter_list_lock);
+				read_unlock_bh(&adapter_list_lock, bh);
 				return 1;
 			}
 		}
 	}
-	read_unlock_bh(&adapter_list_lock);
+	read_unlock_bh(&adapter_list_lock, bh);
 	return 0;
 }
 
@@ -1209,16 +1210,18 @@ static void free_tid_maps(struct tid_info *t)
 
 static inline void add_adapter(struct adapter *adap)
 {
-	write_lock_bh(&adapter_list_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&adapter_list_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&adap->adapter_list, &adapter_list);
-	write_unlock_bh(&adapter_list_lock);
+	write_unlock_bh(&adapter_list_lock, bh);
 }
 
 static inline void remove_adapter(struct adapter *adap)
 {
-	write_lock_bh(&adapter_list_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&adapter_list_lock, SOFTIRQ_ALL_MASK);
 	list_del(&adap->adapter_list);
-	write_unlock_bh(&adapter_list_lock);
+	write_unlock_bh(&adapter_list_lock, bh);
 }
 
 int cxgb3_offload_activate(struct adapter *adapter)
diff --git a/drivers/net/ethernet/chelsio/cxgb3/l2t.c b/drivers/net/ethernet/chelsio/cxgb3/l2t.c
index 1e2d466..3c27b94 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/l2t.c
@@ -305,6 +305,7 @@ static inline void reuse_entry(struct l2t_entry *e, struct neighbour *neigh)
 struct l2t_entry *t3_l2t_get(struct t3cdev *cdev, struct dst_entry *dst,
 			     struct net_device *dev, const void *daddr)
 {
+	unsigned int bh;
 	struct l2t_entry *e = NULL;
 	struct neighbour *neigh;
 	struct port_info *p;
@@ -333,7 +334,7 @@ struct l2t_entry *t3_l2t_get(struct t3cdev *cdev, struct dst_entry *dst,
 
 	hash = arp_hash(addr, ifidx, d);
 
-	write_lock_bh(&d->lock);
+	bh = write_lock_bh(&d->lock, SOFTIRQ_ALL_MASK);
 	for (e = d->l2tab[hash].first; e; e = e->next)
 		if (e->addr == addr && e->ifindex == ifidx &&
 		    e->smt_idx == smt_idx) {
@@ -362,7 +363,7 @@ struct l2t_entry *t3_l2t_get(struct t3cdev *cdev, struct dst_entry *dst,
 		spin_unlock(&e->lock);
 	}
 done_unlock:
-	write_unlock_bh(&d->lock);
+	write_unlock_bh(&d->lock, bh);
 done_rcu:
 	if (neigh)
 		neigh_release(neigh);
@@ -401,6 +402,7 @@ static void handle_failed_resolution(struct t3cdev *dev, struct sk_buff_head *ar
  */
 void t3_l2t_update(struct t3cdev *dev, struct neighbour *neigh)
 {
+	unsigned int bh;
 	struct sk_buff_head arpq;
 	struct l2t_entry *e;
 	struct l2t_data *d = L2DATA(dev);
@@ -408,13 +410,13 @@ void t3_l2t_update(struct t3cdev *dev, struct neighbour *neigh)
 	int ifidx = neigh->dev->ifindex;
 	int hash = arp_hash(addr, ifidx, d);
 
-	read_lock_bh(&d->lock);
+	bh = read_lock_bh(&d->lock, SOFTIRQ_ALL_MASK);
 	for (e = d->l2tab[hash].first; e; e = e->next)
 		if (e->addr == addr && e->ifindex == ifidx) {
 			spin_lock(&e->lock);
 			goto found;
 		}
-	read_unlock_bh(&d->lock);
+	read_unlock_bh(&d->lock, bh);
 	return;
 
 found:
diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
index 33314fe..a3da529 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c
@@ -73,6 +73,8 @@ static int clip6_release_mbox(const struct net_device *dev,
 
 int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 {
+	unsigned int bh;
+	unsigned int bh;
 	struct adapter *adap = netdev2adap(dev);
 	struct clip_tbl *ctbl = adap->clipt;
 	struct clip_entry *ce, *cte;
@@ -85,7 +87,7 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 
 	hash = clip_addr_hash(ctbl, addr, v6);
 
-	read_lock_bh(&ctbl->lock);
+	bh = read_lock_bh(&ctbl->lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(cte, &ctbl->hash_list[hash], list) {
 		if (cte->addr6.sin6_family == AF_INET6 && v6)
 			ret = memcmp(lip, cte->addr6.sin6_addr.s6_addr,
@@ -95,14 +97,14 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 				     sizeof(struct in_addr));
 		if (!ret) {
 			ce = cte;
-			read_unlock_bh(&ctbl->lock);
+			read_unlock_bh(&ctbl->lock, bh);
 			refcount_inc(&ce->refcnt);
 			return 0;
 		}
 	}
-	read_unlock_bh(&ctbl->lock);
+	read_unlock_bh(&ctbl->lock, bh);
 
-	write_lock_bh(&ctbl->lock);
+	bh = write_lock_bh(&ctbl->lock, SOFTIRQ_ALL_MASK);
 	if (!list_empty(&ctbl->ce_free_head)) {
 		ce = list_first_entry(&ctbl->ce_free_head,
 				      struct clip_entry, list);
@@ -118,7 +120,7 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 			       lip, sizeof(struct in6_addr));
 			ret = clip6_get_mbox(dev, (const struct in6_addr *)lip);
 			if (ret) {
-				write_unlock_bh(&ctbl->lock);
+				write_unlock_bh(&ctbl->lock, bh);
 				dev_err(adap->pdev_dev,
 					"CLIP FW cmd failed with error %d, "
 					"Connections using %pI6c wont be "
@@ -132,13 +134,13 @@ int cxgb4_clip_get(const struct net_device *dev, const u32 *lip, u8 v6)
 			       sizeof(struct in_addr));
 		}
 	} else {
-		write_unlock_bh(&ctbl->lock);
+		write_unlock_bh(&ctbl->lock, bh);
 		dev_info(adap->pdev_dev, "CLIP table overflow, "
 			 "Connections using %pI6c wont be offloaded",
 			 (void *)lip);
 		return -ENOMEM;
 	}
-	write_unlock_bh(&ctbl->lock);
+	write_unlock_bh(&ctbl->lock, bh);
 	refcount_set(&ce->refcnt, 1);
 	return 0;
 }
@@ -147,6 +149,7 @@ EXPORT_SYMBOL(cxgb4_clip_get);
 void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
 {
 	unsigned int bh;
+	unsigned int bh2;
 	struct adapter *adap = netdev2adap(dev);
 	struct clip_tbl *ctbl = adap->clipt;
 	struct clip_entry *ce, *cte;
@@ -159,7 +162,7 @@ void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
 
 	hash = clip_addr_hash(ctbl, addr, v6);
 
-	read_lock_bh(&ctbl->lock);
+	bh = read_lock_bh(&ctbl->lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(cte, &ctbl->hash_list[hash], list) {
 		if (cte->addr6.sin6_family == AF_INET6 && v6)
 			ret = memcmp(lip, cte->addr6.sin6_addr.s6_addr,
@@ -169,16 +172,16 @@ void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
 				     sizeof(struct in_addr));
 		if (!ret) {
 			ce = cte;
-			read_unlock_bh(&ctbl->lock);
+			read_unlock_bh(&ctbl->lock, bh);
 			goto found;
 		}
 	}
-	read_unlock_bh(&ctbl->lock);
+	read_unlock_bh(&ctbl->lock, bh);
 
 	return;
 found:
-	write_lock_bh(&ctbl->lock);
-	bh = spin_lock_bh(&ce->lock, SOFTIRQ_ALL_MASK);
+	bh = write_lock_bh(&ctbl->lock, SOFTIRQ_ALL_MASK);
+	bh2 = spin_lock_bh(&ce->lock, SOFTIRQ_ALL_MASK);
 	if (refcount_dec_and_test(&ce->refcnt)) {
 		list_del(&ce->list);
 		INIT_LIST_HEAD(&ce->list);
@@ -187,8 +190,8 @@ void cxgb4_clip_release(const struct net_device *dev, const u32 *lip, u8 v6)
 		if (v6)
 			clip6_release_mbox(dev, (const struct in6_addr *)lip);
 	}
-	spin_unlock_bh(&ce->lock, bh);
-	write_unlock_bh(&ctbl->lock);
+	spin_unlock_bh(&ce->lock, bh2);
+	write_unlock_bh(&ctbl->lock, bh);
 }
 EXPORT_SYMBOL(cxgb4_clip_release);
 
@@ -199,6 +202,7 @@ EXPORT_SYMBOL(cxgb4_clip_release);
 static int cxgb4_update_dev_clip(struct net_device *root_dev,
 				 struct net_device *dev)
 {
+	unsigned int bh;
 	struct inet6_dev *idev = NULL;
 	struct inet6_ifaddr *ifa;
 	int ret = 0;
@@ -207,13 +211,13 @@ static int cxgb4_update_dev_clip(struct net_device *root_dev,
 	if (!idev)
 		return ret;
 
-	read_lock_bh(&idev->lock);
+	bh = read_lock_bh(&idev->lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
 		ret = cxgb4_clip_get(dev, (const u32 *)ifa->addr.s6_addr, 1);
 		if (ret < 0)
 			break;
 	}
-	read_unlock_bh(&idev->lock);
+	read_unlock_bh(&idev->lock, bh);
 
 	return ret;
 }
@@ -252,13 +256,14 @@ EXPORT_SYMBOL(cxgb4_update_root_dev_clip);
 
 int clip_tbl_show(struct seq_file *seq, void *v)
 {
+	unsigned int bh;
 	struct adapter *adapter = seq->private;
 	struct clip_tbl *ctbl = adapter->clipt;
 	struct clip_entry *ce;
 	char ip[60];
 	int i;
 
-	read_lock_bh(&ctbl->lock);
+	bh = read_lock_bh(&ctbl->lock, SOFTIRQ_ALL_MASK);
 
 	seq_puts(seq, "IP Address                  Users\n");
 	for (i = 0 ; i < ctbl->clipt_size;  ++i) {
@@ -271,7 +276,7 @@ int clip_tbl_show(struct seq_file *seq, void *v)
 	}
 	seq_printf(seq, "Free clip entries : %d\n", atomic_read(&ctbl->nfree));
 
-	read_unlock_bh(&ctbl->lock);
+	read_unlock_bh(&ctbl->lock, bh);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
index 3653fd0..7cf1976 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -422,6 +422,7 @@ struct l2t_entry *cxgb4_l2t_get(struct l2t_data *d, struct neighbour *neigh,
 				const struct net_device *physdev,
 				unsigned int priority)
 {
+	unsigned int bh;
 	u8 lport;
 	u16 vlan;
 	struct l2t_entry *e;
@@ -440,7 +441,7 @@ struct l2t_entry *cxgb4_l2t_get(struct l2t_data *d, struct neighbour *neigh,
 	else
 		vlan = VLAN_NONE;
 
-	write_lock_bh(&d->lock);
+	bh = write_lock_bh(&d->lock, SOFTIRQ_ALL_MASK);
 	for (e = d->l2tab[hash].first; e; e = e->next)
 		if (!addreq(e, addr) && e->ifindex == ifidx &&
 		    e->vlan == vlan && e->lport == lport) {
@@ -470,7 +471,7 @@ struct l2t_entry *cxgb4_l2t_get(struct l2t_data *d, struct neighbour *neigh,
 		spin_unlock(&e->lock);
 	}
 done:
-	write_unlock_bh(&d->lock);
+	write_unlock_bh(&d->lock, bh);
 	return e;
 }
 EXPORT_SYMBOL(cxgb4_l2t_get);
@@ -536,6 +537,7 @@ static void handle_failed_resolution(struct adapter *adap, struct l2t_entry *e)
  */
 void t4_l2t_update(struct adapter *adap, struct neighbour *neigh)
 {
+	unsigned int bh;
 	struct l2t_entry *e;
 	struct sk_buff_head *arpq = NULL;
 	struct l2t_data *d = adap->l2t;
@@ -544,7 +546,7 @@ void t4_l2t_update(struct adapter *adap, struct neighbour *neigh)
 	int ifidx = neigh->dev->ifindex;
 	int hash = addr_hash(d, addr, addr_len, ifidx);
 
-	read_lock_bh(&d->lock);
+	bh = read_lock_bh(&d->lock, SOFTIRQ_ALL_MASK);
 	for (e = d->l2tab[hash].first; e; e = e->next)
 		if (!addreq(e, addr) && e->ifindex == ifidx) {
 			spin_lock(&e->lock);
@@ -553,7 +555,7 @@ void t4_l2t_update(struct adapter *adap, struct neighbour *neigh)
 			spin_unlock(&e->lock);
 			break;
 		}
-	read_unlock_bh(&d->lock);
+	read_unlock_bh(&d->lock, bh);
 	return;
 
  found:
@@ -588,11 +590,12 @@ void t4_l2t_update(struct adapter *adap, struct neighbour *neigh)
 struct l2t_entry *t4_l2t_alloc_switching(struct adapter *adap, u16 vlan,
 					 u8 port, u8 *eth_addr)
 {
+	unsigned int bh;
 	struct l2t_data *d = adap->l2t;
 	struct l2t_entry *e;
 	int ret;
 
-	write_lock_bh(&d->lock);
+	bh = write_lock_bh(&d->lock, SOFTIRQ_ALL_MASK);
 	e = find_or_alloc_l2e(d, vlan, port, eth_addr);
 	if (e) {
 		spin_lock(&e->lock);          /* avoid race with t4_l2t_free */
@@ -606,7 +609,7 @@ struct l2t_entry *t4_l2t_alloc_switching(struct adapter *adap, u16 vlan,
 			if (ret < 0) {
 				_t4_l2e_free(e);
 				spin_unlock(&e->lock);
-				write_unlock_bh(&d->lock);
+				write_unlock_bh(&d->lock, bh);
 				return NULL;
 			}
 		} else {
@@ -615,7 +618,7 @@ struct l2t_entry *t4_l2t_alloc_switching(struct adapter *adap, u16 vlan,
 
 		spin_unlock(&e->lock);
 	}
-	write_unlock_bh(&d->lock);
+	write_unlock_bh(&d->lock, bh);
 	return e;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/smt.c b/drivers/net/ethernet/chelsio/cxgb4/smt.c
index c660e9d..7201434 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/smt.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/smt.c
@@ -210,10 +210,11 @@ static int write_smt_entry(struct adapter *adapter, struct smt_entry *e)
 static struct smt_entry *t4_smt_alloc_switching(struct adapter *adap, u16 pfvf,
 						u8 *smac)
 {
+	unsigned int bh;
 	struct smt_data *s = adap->smt;
 	struct smt_entry *e;
 
-	write_lock_bh(&s->lock);
+	bh = write_lock_bh(&s->lock, SOFTIRQ_ALL_MASK);
 	e = find_or_alloc_smte(s, smac);
 	if (e) {
 		spin_lock(&e->lock);
@@ -228,7 +229,7 @@ static struct smt_entry *t4_smt_alloc_switching(struct adapter *adap, u16 pfvf,
 		}
 		spin_unlock(&e->lock);
 	}
-	write_unlock_bh(&s->lock);
+	write_unlock_bh(&s->lock, bh);
 	return e;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 48a1f16..bb6b21c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -386,6 +386,7 @@ static void mlx5e_rep_update_flows(struct mlx5e_priv *priv,
 
 static void mlx5e_rep_neigh_update(struct work_struct *work)
 {
+	unsigned int bh;
 	struct mlx5e_neigh_hash_entry *nhe =
 		container_of(work, struct mlx5e_neigh_hash_entry, neigh_update_work);
 	struct neighbour *n = nhe->n;
@@ -403,11 +404,11 @@ static void mlx5e_rep_neigh_update(struct work_struct *work)
 	 * We use this lock to avoid inconsistency between the neigh validity
 	 * and it's hw address.
 	 */
-	read_lock_bh(&n->lock);
+	bh = read_lock_bh(&n->lock, SOFTIRQ_ALL_MASK);
 	memcpy(ha, n->ha, ETH_ALEN);
 	nud_state = n->nud_state;
 	dead = n->dead;
-	read_unlock_bh(&n->lock);
+	read_unlock_bh(&n->lock, bh);
 
 	neigh_connected = (nud_state & NUD_VALID) && !dead;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9fed540..ffe8e61 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2307,6 +2307,7 @@ static int mlx5e_create_encap_header_ipv4(struct mlx5e_priv *priv,
 					  struct net_device *mirred_dev,
 					  struct mlx5e_encap_entry *e)
 {
+	unsigned int bh;
 	int max_encap_size = MLX5_CAP_ESW(priv->mdev, max_encap_header_size);
 	int ipv4_encap_size = ETH_HLEN + sizeof(struct iphdr) + VXLAN_HLEN;
 	struct ip_tunnel_key *tun_key = &e->tun_info.key;
@@ -2366,10 +2367,10 @@ static int mlx5e_create_encap_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	read_lock_bh(&n->lock);
+	bh = read_lock_bh(&n->lock, SOFTIRQ_ALL_MASK);
 	nud_state = n->nud_state;
 	ether_addr_copy(e->h_dest, n->ha);
-	read_unlock_bh(&n->lock);
+	read_unlock_bh(&n->lock, bh);
 
 	switch (e->tunnel_type) {
 	case MLX5_HEADER_TYPE_VXLAN:
@@ -2416,6 +2417,7 @@ static int mlx5e_create_encap_header_ipv6(struct mlx5e_priv *priv,
 					  struct net_device *mirred_dev,
 					  struct mlx5e_encap_entry *e)
 {
+	unsigned int bh;
 	int max_encap_size = MLX5_CAP_ESW(priv->mdev, max_encap_header_size);
 	int ipv6_encap_size = ETH_HLEN + sizeof(struct ipv6hdr) + VXLAN_HLEN;
 	struct ip_tunnel_key *tun_key = &e->tun_info.key;
@@ -2475,10 +2477,10 @@ static int mlx5e_create_encap_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	read_lock_bh(&n->lock);
+	bh = read_lock_bh(&n->lock, SOFTIRQ_ALL_MASK);
 	nud_state = n->nud_state;
 	ether_addr_copy(e->h_dest, n->ha);
-	read_unlock_bh(&n->lock);
+	read_unlock_bh(&n->lock, bh);
 
 	switch (e->tunnel_type) {
 	case MLX5_HEADER_TYPE_VXLAN:
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 2ab9cf2..420d0e0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2345,6 +2345,7 @@ struct mlxsw_sp_netevent_work {
 
 static void mlxsw_sp_router_neigh_event_work(struct work_struct *work)
 {
+	unsigned int bh;
 	struct mlxsw_sp_netevent_work *net_work =
 		container_of(work, struct mlxsw_sp_netevent_work, work);
 	struct mlxsw_sp *mlxsw_sp = net_work->mlxsw_sp;
@@ -2358,11 +2359,11 @@ static void mlxsw_sp_router_neigh_event_work(struct work_struct *work)
 	 * then we are guaranteed to receive another event letting us
 	 * know about it.
 	 */
-	read_lock_bh(&n->lock);
+	bh = read_lock_bh(&n->lock, SOFTIRQ_ALL_MASK);
 	memcpy(ha, n->ha, ETH_ALEN);
 	nud_state = n->nud_state;
 	dead = n->dead;
-	read_unlock_bh(&n->lock);
+	read_unlock_bh(&n->lock, bh);
 
 	rtnl_lock();
 	mlxsw_sp_span_respin(mlxsw_sp);
@@ -3379,6 +3380,7 @@ static void mlxsw_sp_nexthop_rif_fini(struct mlxsw_sp_nexthop *nh)
 static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
 				       struct mlxsw_sp_nexthop *nh)
 {
+	unsigned int bh;
 	struct mlxsw_sp_neigh_entry *neigh_entry;
 	struct neighbour *n;
 	u8 nud_state, dead;
@@ -3418,10 +3420,10 @@ static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
 
 	nh->neigh_entry = neigh_entry;
 	list_add_tail(&nh->neigh_list_node, &neigh_entry->nexthop_list);
-	read_lock_bh(&n->lock);
+	bh = read_lock_bh(&n->lock, SOFTIRQ_ALL_MASK);
 	nud_state = n->nud_state;
 	dead = n->dead;
-	read_unlock_bh(&n->lock);
+	read_unlock_bh(&n->lock, bh);
 	__mlxsw_sp_nexthop_neigh_update(nh, !(nud_state & NUD_VALID && !dead));
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index d965fd2..40517d2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -110,6 +110,7 @@ static int mlxsw_sp_span_dmac(struct neigh_table *tbl,
 			      struct net_device *dev,
 			      unsigned char dmac[ETH_ALEN])
 {
+	unsigned int bh;
 	struct neighbour *neigh = neigh_lookup(tbl, pkey, dev);
 	int err = 0;
 
@@ -121,12 +122,12 @@ static int mlxsw_sp_span_dmac(struct neigh_table *tbl,
 
 	neigh_event_send(neigh, NULL);
 
-	read_lock_bh(&neigh->lock);
+	bh = read_lock_bh(&neigh->lock, SOFTIRQ_ALL_MASK);
 	if ((neigh->nud_state & NUD_VALID) && !neigh->dead)
 		memcpy(dmac, neigh->ha, ETH_ALEN);
 	else
 		err = -ENOENT;
-	read_unlock_bh(&neigh->lock);
+	read_unlock_bh(&neigh->lock, bh);
 
 	neigh_release(neigh);
 	return err;
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 8317571..0bf7009 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -661,12 +661,13 @@ static int sixpack_open(struct tty_struct *tty)
  */
 static void sixpack_close(struct tty_struct *tty)
 {
+	unsigned int bh;
 	struct sixpack *sp;
 
-	write_lock_bh(&disc_data_lock);
+	bh = write_lock_bh(&disc_data_lock, SOFTIRQ_ALL_MASK);
 	sp = tty->disc_data;
 	tty->disc_data = NULL;
-	write_unlock_bh(&disc_data_lock);
+	write_unlock_bh(&disc_data_lock, bh);
 	if (!sp)
 		return;
 
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index ff57063..dce4a3f 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -786,12 +786,13 @@ static int mkiss_open(struct tty_struct *tty)
 
 static void mkiss_close(struct tty_struct *tty)
 {
+	unsigned int bh;
 	struct mkiss *ax;
 
-	write_lock_bh(&disc_data_lock);
+	bh = write_lock_bh(&disc_data_lock, SOFTIRQ_ALL_MASK);
 	ax = tty->disc_data;
 	tty->disc_data = NULL;
-	write_unlock_bh(&disc_data_lock);
+	write_unlock_bh(&disc_data_lock, bh);
 
 	if (!ax)
 		return;
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 3b0588d..72d7369 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -57,20 +57,22 @@ static int fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 
 static int fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
+	unsigned int bh;
 	struct fakelb_phy *phy = hw->priv;
 
-	write_lock_bh(&fakelb_ifup_phys_lock);
+	bh = write_lock_bh(&fakelb_ifup_phys_lock, SOFTIRQ_ALL_MASK);
 	phy->page = page;
 	phy->channel = channel;
-	write_unlock_bh(&fakelb_ifup_phys_lock);
+	write_unlock_bh(&fakelb_ifup_phys_lock, bh);
 	return 0;
 }
 
 static int fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct fakelb_phy *current_phy = hw->priv, *phy;
 
-	read_lock_bh(&fakelb_ifup_phys_lock);
+	bh = read_lock_bh(&fakelb_ifup_phys_lock, SOFTIRQ_ALL_MASK);
 	WARN_ON(current_phy->suspended);
 	list_for_each_entry(phy, &fakelb_ifup_phys, list_ifup) {
 		if (current_phy == phy)
@@ -84,7 +86,7 @@ static int fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 				ieee802154_rx_irqsafe(phy->hw, newskb, 0xcc);
 		}
 	}
-	read_unlock_bh(&fakelb_ifup_phys_lock);
+	read_unlock_bh(&fakelb_ifup_phys_lock, bh);
 
 	ieee802154_xmit_complete(hw, skb, false);
 	return 0;
@@ -92,24 +94,26 @@ static int fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 static int fakelb_hw_start(struct ieee802154_hw *hw)
 {
+	unsigned int bh;
 	struct fakelb_phy *phy = hw->priv;
 
-	write_lock_bh(&fakelb_ifup_phys_lock);
+	bh = write_lock_bh(&fakelb_ifup_phys_lock, SOFTIRQ_ALL_MASK);
 	phy->suspended = false;
 	list_add(&phy->list_ifup, &fakelb_ifup_phys);
-	write_unlock_bh(&fakelb_ifup_phys_lock);
+	write_unlock_bh(&fakelb_ifup_phys_lock, bh);
 
 	return 0;
 }
 
 static void fakelb_hw_stop(struct ieee802154_hw *hw)
 {
+	unsigned int bh;
 	struct fakelb_phy *phy = hw->priv;
 
-	write_lock_bh(&fakelb_ifup_phys_lock);
+	bh = write_lock_bh(&fakelb_ifup_phys_lock, SOFTIRQ_ALL_MASK);
 	phy->suspended = true;
 	list_del(&phy->list_ifup);
-	write_unlock_bh(&fakelb_ifup_phys_lock);
+	write_unlock_bh(&fakelb_ifup_phys_lock, bh);
 }
 
 static int
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index c6cda50..23bc409 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1935,7 +1935,8 @@ static void __ppp_channel_push(struct channel *pch)
 
 static void ppp_channel_push(struct channel *pch)
 {
-	read_lock_bh(&pch->upl);
+	unsigned int bh;
+	bh = read_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 	if (pch->ppp) {
 		(*this_cpu_ptr(pch->ppp->xmit_recursion))++;
 		__ppp_channel_push(pch);
@@ -1943,7 +1944,7 @@ static void ppp_channel_push(struct channel *pch)
 	} else {
 		__ppp_channel_push(pch);
 	}
-	read_unlock_bh(&pch->upl);
+	read_unlock_bh(&pch->upl, bh);
 }
 
 /*
@@ -1970,6 +1971,7 @@ ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 void
 ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 {
+	unsigned int bh;
 	struct channel *pch = chan->ppp;
 	int proto;
 
@@ -1978,7 +1980,7 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 		return;
 	}
 
-	read_lock_bh(&pch->upl);
+	bh = read_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 	if (!pskb_may_pull(skb, 2)) {
 		kfree_skb(skb);
 		if (pch->ppp) {
@@ -2002,20 +2004,21 @@ ppp_input(struct ppp_channel *chan, struct sk_buff *skb)
 	}
 
 done:
-	read_unlock_bh(&pch->upl);
+	read_unlock_bh(&pch->upl, bh);
 }
 
 /* Put a 0-length skb in the receive queue as an error indication */
 void
 ppp_input_error(struct ppp_channel *chan, int code)
 {
+	unsigned int bh;
 	struct channel *pch = chan->ppp;
 	struct sk_buff *skb;
 
 	if (!pch)
 		return;
 
-	read_lock_bh(&pch->upl);
+	bh = read_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 	if (pch->ppp) {
 		skb = alloc_skb(0, GFP_ATOMIC);
 		if (skb) {
@@ -2024,7 +2027,7 @@ ppp_input_error(struct ppp_channel *chan, int code)
 			ppp_do_recv(pch->ppp, skb, pch);
 		}
 	}
-	read_unlock_bh(&pch->upl);
+	read_unlock_bh(&pch->upl, bh);
 }
 
 /*
@@ -2606,14 +2609,15 @@ int ppp_channel_index(struct ppp_channel *chan)
  */
 int ppp_unit_number(struct ppp_channel *chan)
 {
+	unsigned int bh;
 	struct channel *pch = chan->ppp;
 	int unit = -1;
 
 	if (pch) {
-		read_lock_bh(&pch->upl);
+		bh = read_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 		if (pch->ppp)
 			unit = pch->ppp->file.index;
-		read_unlock_bh(&pch->upl);
+		read_unlock_bh(&pch->upl, bh);
 	}
 	return unit;
 }
@@ -2623,14 +2627,15 @@ int ppp_unit_number(struct ppp_channel *chan)
  */
 char *ppp_dev_name(struct ppp_channel *chan)
 {
+	unsigned int bh;
 	struct channel *pch = chan->ppp;
 	char *name = NULL;
 
 	if (pch) {
-		read_lock_bh(&pch->upl);
+		bh = read_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 		if (pch->ppp && pch->ppp->dev)
 			name = pch->ppp->dev->name;
-		read_unlock_bh(&pch->upl);
+		read_unlock_bh(&pch->upl, bh);
 	}
 	return name;
 }
@@ -3134,6 +3139,7 @@ static int
 ppp_connect_channel(struct channel *pch, int unit)
 {
 	unsigned int bh;
+	unsigned int bh;
 	struct ppp *ppp;
 	struct ppp_net *pn;
 	int ret = -ENXIO;
@@ -3145,7 +3151,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 	ppp = ppp_find_unit(pn, unit);
 	if (!ppp)
 		goto out;
-	write_lock_bh(&pch->upl);
+	bh = write_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 	ret = -EINVAL;
 	if (pch->ppp)
 		goto outl;
@@ -3173,7 +3179,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 	ret = 0;
 
  outl:
-	write_unlock_bh(&pch->upl);
+	write_unlock_bh(&pch->upl, bh);
  out:
 	mutex_unlock(&pn->all_ppp_mutex);
 	return ret;
@@ -3185,13 +3191,14 @@ ppp_connect_channel(struct channel *pch, int unit)
 static int
 ppp_disconnect_channel(struct channel *pch)
 {
+	unsigned int bh;
 	struct ppp *ppp;
 	int err = -EINVAL;
 
-	write_lock_bh(&pch->upl);
+	bh = write_lock_bh(&pch->upl, SOFTIRQ_ALL_MASK);
 	ppp = pch->ppp;
 	pch->ppp = NULL;
-	write_unlock_bh(&pch->upl);
+	write_unlock_bh(&pch->upl, bh);
 	if (ppp) {
 		/* remove it from the ppp unit's list */
 		ppp_lock(ppp);
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 62dc564..68bf348 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -230,13 +230,14 @@ static void __delete_item(struct pppoe_net *pn, __be16 sid,
 static inline struct pppox_sock *get_item(struct pppoe_net *pn, __be16 sid,
 					unsigned char *addr, int ifindex)
 {
+	unsigned int bh;
 	struct pppox_sock *po;
 
-	read_lock_bh(&pn->hash_lock);
+	bh = read_lock_bh(&pn->hash_lock, SOFTIRQ_ALL_MASK);
 	po = __get_item(pn, sid, addr, ifindex);
 	if (po)
 		sock_hold(sk_pppox(po));
-	read_unlock_bh(&pn->hash_lock);
+	read_unlock_bh(&pn->hash_lock, bh);
 
 	return po;
 }
@@ -265,9 +266,10 @@ static inline struct pppox_sock *get_item_by_addr(struct net *net,
 static inline void delete_item(struct pppoe_net *pn, __be16 sid,
 					char *addr, int ifindex)
 {
-	write_lock_bh(&pn->hash_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&pn->hash_lock, SOFTIRQ_ALL_MASK);
 	__delete_item(pn, sid, addr, ifindex);
-	write_unlock_bh(&pn->hash_lock);
+	write_unlock_bh(&pn->hash_lock, bh);
 }
 
 /***************************************************************************
@@ -279,11 +281,12 @@ static inline void delete_item(struct pppoe_net *pn, __be16 sid,
 
 static void pppoe_flush_dev(struct net_device *dev)
 {
+	unsigned int bh;
 	struct pppoe_net *pn;
 	int i;
 
 	pn = pppoe_pernet(dev_net(dev));
-	write_lock_bh(&pn->hash_lock);
+	bh = write_lock_bh(&pn->hash_lock, SOFTIRQ_ALL_MASK);
 	for (i = 0; i < PPPOE_HASH_SIZE; i++) {
 		struct pppox_sock *po = pn->hash_table[i];
 		struct sock *sk;
@@ -327,11 +330,11 @@ static void pppoe_flush_dev(struct net_device *dev)
 			 */
 
 			BUG_ON(pppoe_pernet(dev_net(dev)) == NULL);
-			write_lock_bh(&pn->hash_lock);
+			write_lock_bh(&pn->hash_lock, SOFTIRQ_ALL_MASK);
 			po = pn->hash_table[i];
 		}
 	}
-	write_unlock_bh(&pn->hash_lock);
+	write_unlock_bh(&pn->hash_lock, bh);
 }
 
 static int pppoe_device_event(struct notifier_block *this,
@@ -612,6 +615,7 @@ static int pppoe_release(struct socket *sock)
 static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 		  int sockaddr_len, int flags)
 {
+	unsigned int bh;
 	struct sock *sk = sock->sk;
 	struct sockaddr_pppox *sp = (struct sockaddr_pppox *)uservaddr;
 	struct pppox_sock *po = pppox_sk(sk);
@@ -684,9 +688,9 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 		       &sp->sa_addr.pppoe,
 		       sizeof(struct pppoe_addr));
 
-		write_lock_bh(&pn->hash_lock);
+		bh = write_lock_bh(&pn->hash_lock, SOFTIRQ_ALL_MASK);
 		error = __set_item(pn, po);
-		write_unlock_bh(&pn->hash_lock);
+		write_unlock_bh(&pn->hash_lock, bh);
 		if (error < 0)
 			goto err_put;
 
@@ -1054,7 +1058,7 @@ static void *pppoe_seq_start(struct seq_file *seq, loff_t *pos)
 	struct pppoe_net *pn = pppoe_pernet(seq_file_net(seq));
 	loff_t l = *pos;
 
-	read_lock_bh(&pn->hash_lock);
+	read_lock_bh(&pn->hash_lock, SOFTIRQ_ALL_MASK);
 	return l ? pppoe_get_idx(pn, --l) : SEQ_START_TOKEN;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 79bdae9..ea8c31f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -99,13 +99,14 @@ void iwl_mvm_ipv6_addr_change(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct inet6_dev *idev)
 {
+	unsigned int bh;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct inet6_ifaddr *ifa;
 	int idx = 0;
 
 	memset(mvmvif->tentative_addrs, 0, sizeof(mvmvif->tentative_addrs));
 
-	read_lock_bh(&idev->lock);
+	bh = read_lock_bh(&idev->lock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
 		mvmvif->target_ipv6_addrs[idx] = ifa->addr;
 		if (ifa->flags & IFA_F_TENTATIVE)
@@ -114,7 +115,7 @@ void iwl_mvm_ipv6_addr_change(struct ieee80211_hw *hw,
 		if (idx >= IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_MAX)
 			break;
 	}
-	read_unlock_bh(&idev->lock);
+	read_unlock_bh(&idev->lock, bh);
 
 	mvmvif->num_target_ipv6_addrs = idx;
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_80211_rx.c b/drivers/net/wireless/intersil/hostap/hostap_80211_rx.c
index 61be822..d6cf897 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_80211_rx.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_80211_rx.c
@@ -532,10 +532,11 @@ hostap_rx_frame_mgmt(local_info_t *local, struct sk_buff *skb,
 static struct net_device *prism2_rx_get_wds(local_info_t *local,
 						   u8 *addr)
 {
+	unsigned int bh;
 	struct hostap_interface *iface = NULL;
 	struct list_head *ptr;
 
-	read_lock_bh(&local->iface_lock);
+	bh = read_lock_bh(&local->iface_lock, SOFTIRQ_ALL_MASK);
 	list_for_each(ptr, &local->hostap_interfaces) {
 		iface = list_entry(ptr, struct hostap_interface, list);
 		if (iface->type == HOSTAP_INTERFACE_WDS &&
@@ -543,7 +544,7 @@ static struct net_device *prism2_rx_get_wds(local_info_t *local,
 			break;
 		iface = NULL;
 	}
-	read_unlock_bh(&local->iface_lock);
+	read_unlock_bh(&local->iface_lock, bh);
 
 	return iface ? iface->dev : NULL;
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_main.c b/drivers/net/wireless/intersil/hostap/hostap_main.c
index 012930d..004318f 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_main.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_main.c
@@ -142,12 +142,13 @@ static inline int prism2_wds_special_addr(u8 *addr)
 int prism2_wds_add(local_info_t *local, u8 *remote_addr,
 		   int rtnl_locked)
 {
+	unsigned int bh;
 	struct net_device *dev;
 	struct list_head *ptr;
 	struct hostap_interface *iface, *empty, *match;
 
 	empty = match = NULL;
-	read_lock_bh(&local->iface_lock);
+	bh = read_lock_bh(&local->iface_lock, SOFTIRQ_ALL_MASK);
 	list_for_each(ptr, &local->hostap_interfaces) {
 		iface = list_entry(ptr, struct hostap_interface, list);
 		if (iface->type != HOSTAP_INTERFACE_WDS)
@@ -163,12 +164,12 @@ int prism2_wds_add(local_info_t *local, u8 *remote_addr,
 	if (!match && empty && !prism2_wds_special_addr(remote_addr)) {
 		/* take pre-allocated entry into use */
 		memcpy(empty->u.wds.remote_addr, remote_addr, ETH_ALEN);
-		read_unlock_bh(&local->iface_lock);
+		read_unlock_bh(&local->iface_lock, bh);
 		printk(KERN_DEBUG "%s: using pre-allocated WDS netdevice %s\n",
 		       local->dev->name, empty->dev->name);
 		return 0;
 	}
-	read_unlock_bh(&local->iface_lock);
+	read_unlock_bh(&local->iface_lock, bh);
 
 	if (!prism2_wds_special_addr(remote_addr)) {
 		if (match)
@@ -702,6 +703,7 @@ static int prism2_open(struct net_device *dev)
 
 static int prism2_set_mac_address(struct net_device *dev, void *p)
 {
+	unsigned int bh;
 	struct hostap_interface *iface;
 	local_info_t *local;
 	struct list_head *ptr;
@@ -714,13 +716,13 @@ static int prism2_set_mac_address(struct net_device *dev, void *p)
 				 ETH_ALEN) < 0 || local->func->reset_port(dev))
 		return -EINVAL;
 
-	read_lock_bh(&local->iface_lock);
+	bh = read_lock_bh(&local->iface_lock, SOFTIRQ_ALL_MASK);
 	list_for_each(ptr, &local->hostap_interfaces) {
 		iface = list_entry(ptr, struct hostap_interface, list);
 		memcpy(iface->dev->dev_addr, addr->sa_data, ETH_ALEN);
 	}
 	memcpy(local->dev->dev_addr, addr->sa_data, ETH_ALEN);
-	read_unlock_bh(&local->iface_lock);
+	read_unlock_bh(&local->iface_lock, bh);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intersil/hostap/hostap_proc.c b/drivers/net/wireless/intersil/hostap/hostap_proc.c
index 56ae726..f3042bb 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_proc.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_proc.c
@@ -98,7 +98,7 @@ static int prism2_wds_proc_show(struct seq_file *m, void *v)
 static void *prism2_wds_proc_start(struct seq_file *m, loff_t *_pos)
 {
 	local_info_t *local = PDE_DATA(file_inode(m->file));
-	read_lock_bh(&local->iface_lock);
+	read_lock_bh(&local->iface_lock, SOFTIRQ_ALL_MASK);
 	return seq_list_start(&local->hostap_interfaces, *_pos);
 }
 
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index 5ce2424..1a48261 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -543,6 +543,7 @@ static void netiucv_callback_connack(struct iucv_path *path, u8 ipuser[16])
 static int netiucv_callback_connreq(struct iucv_path *path, u8 *ipvmid,
 				    u8 *ipuser)
 {
+	unsigned int bh;
 	struct iucv_connection *conn = path->private;
 	struct iucv_event ev;
 	static char tmp_user[9];
@@ -553,7 +554,7 @@ static int netiucv_callback_connreq(struct iucv_path *path, u8 *ipvmid,
 	memcpy(tmp_user, netiucv_printname(ipvmid, 8), 8);
 	memcpy(tmp_udat, ipuser, 16);
 	EBCASC(tmp_udat, 16);
-	read_lock_bh(&iucv_connection_rwlock);
+	bh = read_lock_bh(&iucv_connection_rwlock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(conn, &iucv_connection_list, list) {
 		if (strncmp(ipvmid, conn->userid, 8) ||
 		    strncmp(ipuser, conn->userdata, 16))
@@ -567,7 +568,7 @@ static int netiucv_callback_connreq(struct iucv_path *path, u8 *ipvmid,
 	}
 	IUCV_DBF_TEXT_(setup, 2, "Connection requested for %s.%s\n",
 		       tmp_user, netiucv_printname(tmp_udat, 16));
-	read_unlock_bh(&iucv_connection_rwlock);
+	read_unlock_bh(&iucv_connection_rwlock, bh);
 	return rc;
 }
 
@@ -1476,6 +1477,7 @@ static int netiucv_check_user(const char *buf, size_t count, char *username,
 static ssize_t user_write(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
+	unsigned int bh;
 	struct netiucv_priv *priv = dev_get_drvdata(dev);
 	struct net_device *ndev = priv->conn->netdev;
 	char	username[9];
@@ -1494,17 +1496,17 @@ static ssize_t user_write(struct device *dev, struct device_attribute *attr,
 		IUCV_DBF_TEXT(setup, 2, "user_write: device active\n");
 		return -EPERM;
 	}
-	read_lock_bh(&iucv_connection_rwlock);
+	bh = read_lock_bh(&iucv_connection_rwlock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(cp, &iucv_connection_list, list) {
 		if (!strncmp(username, cp->userid, 9) &&
 		   !strncmp(userdata, cp->userdata, 17) && cp->netdev != ndev) {
-			read_unlock_bh(&iucv_connection_rwlock);
+			read_unlock_bh(&iucv_connection_rwlock, bh);
 			IUCV_DBF_TEXT_(setup, 2, "user_write: Connection to %s "
 				"already exists\n", netiucv_printuser(cp));
 			return -EEXIST;
 		}
 	}
-	read_unlock_bh(&iucv_connection_rwlock);
+	read_unlock_bh(&iucv_connection_rwlock, bh);
 	memcpy(priv->conn->userid, username, 9);
 	memcpy(priv->conn->userdata, userdata, 17);
 	return count;
@@ -1845,6 +1847,7 @@ static struct iucv_connection *netiucv_new_connection(struct net_device *dev,
 						      char *username,
 						      char *userdata)
 {
+	unsigned int bh;
 	struct iucv_connection *conn;
 
 	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
@@ -1879,9 +1882,9 @@ static struct iucv_connection *netiucv_new_connection(struct net_device *dev,
 		fsm_newstate(conn->fsm, CONN_STATE_STOPPED);
 	}
 
-	write_lock_bh(&iucv_connection_rwlock);
+	bh = write_lock_bh(&iucv_connection_rwlock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&conn->list, &iucv_connection_list);
-	write_unlock_bh(&iucv_connection_rwlock);
+	write_unlock_bh(&iucv_connection_rwlock, bh);
 	return conn;
 
 out_tx:
@@ -1900,11 +1903,12 @@ static struct iucv_connection *netiucv_new_connection(struct net_device *dev,
  */
 static void netiucv_remove_connection(struct iucv_connection *conn)
 {
+	unsigned int bh;
 
 	IUCV_DBF_TEXT(trace, 3, __func__);
-	write_lock_bh(&iucv_connection_rwlock);
+	bh = write_lock_bh(&iucv_connection_rwlock, SOFTIRQ_ALL_MASK);
 	list_del_init(&conn->list);
-	write_unlock_bh(&iucv_connection_rwlock);
+	write_unlock_bh(&iucv_connection_rwlock, bh);
 	fsm_deltimer(&conn->timer);
 	netiucv_purge_skb_queue(&conn->collect_queue);
 	if (conn->path) {
@@ -2007,6 +2011,7 @@ static struct net_device *netiucv_init_netdevice(char *username, char *userdata)
 static ssize_t connection_store(struct device_driver *drv, const char *buf,
 				size_t count)
 {
+	unsigned int bh;
 	char username[9];
 	char userdata[17];
 	int rc;
@@ -2019,17 +2024,17 @@ static ssize_t connection_store(struct device_driver *drv, const char *buf,
 	if (rc)
 		return rc;
 
-	read_lock_bh(&iucv_connection_rwlock);
+	bh = read_lock_bh(&iucv_connection_rwlock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(cp, &iucv_connection_list, list) {
 		if (!strncmp(username, cp->userid, 9) &&
 		    !strncmp(userdata, cp->userdata, 17)) {
-			read_unlock_bh(&iucv_connection_rwlock);
+			read_unlock_bh(&iucv_connection_rwlock, bh);
 			IUCV_DBF_TEXT_(setup, 2, "conn_write: Connection to %s "
 				"already exists\n", netiucv_printuser(cp));
 			return -EEXIST;
 		}
 	}
-	read_unlock_bh(&iucv_connection_rwlock);
+	read_unlock_bh(&iucv_connection_rwlock, bh);
 
 	dev = netiucv_init_netdevice(username, userdata);
 	if (!dev) {
@@ -2071,6 +2076,7 @@ static DRIVER_ATTR_WO(connection);
 static ssize_t remove_store(struct device_driver *drv, const char *buf,
 			    size_t count)
 {
+	unsigned int bh;
 	struct iucv_connection *cp;
         struct net_device *ndev;
         struct netiucv_priv *priv;
@@ -2092,14 +2098,14 @@ static ssize_t remove_store(struct device_driver *drv, const char *buf,
         }
         name[i] = '\0';
 
-	read_lock_bh(&iucv_connection_rwlock);
+	bh = read_lock_bh(&iucv_connection_rwlock, SOFTIRQ_ALL_MASK);
 	list_for_each_entry(cp, &iucv_connection_list, list) {
 		ndev = cp->netdev;
 		priv = netdev_priv(ndev);
                 dev = priv->dev;
 		if (strncmp(name, ndev->name, count))
 			continue;
-		read_unlock_bh(&iucv_connection_rwlock);
+		read_unlock_bh(&iucv_connection_rwlock, bh);
                 if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
 			dev_warn(dev, "The IUCV device is connected"
 				" to %s and cannot be removed\n",
@@ -2111,7 +2117,7 @@ static ssize_t remove_store(struct device_driver *drv, const char *buf,
                 netiucv_unregister_device(dev);
                 return count;
         }
-	read_unlock_bh(&iucv_connection_rwlock);
+	read_unlock_bh(&iucv_connection_rwlock, bh);
 	IUCV_DBF_TEXT(data, 2, "remove_write: unknown device\n");
         return -EINVAL;
 }
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 16df663..085cbd9 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1229,6 +1229,7 @@ static void qeth_l3_add_mc6_to_hash(struct qeth_card *card,
 /* called with rcu_read_lock */
 static void qeth_l3_add_vlan_mc6(struct qeth_card *card)
 {
+	unsigned int bh;
 	struct inet6_dev *in_dev;
 	u16 vid;
 
@@ -1248,15 +1249,16 @@ static void qeth_l3_add_vlan_mc6(struct qeth_card *card)
 		in_dev = in6_dev_get(netdev);
 		if (!in_dev)
 			continue;
-		read_lock_bh(&in_dev->lock);
+		bh = read_lock_bh(&in_dev->lock, SOFTIRQ_ALL_MASK);
 		qeth_l3_add_mc6_to_hash(card, in_dev);
-		read_unlock_bh(&in_dev->lock);
+		read_unlock_bh(&in_dev->lock, bh);
 		in6_dev_put(in_dev);
 	}
 }
 
 static void qeth_l3_add_multicast_ipv6(struct qeth_card *card)
 {
+	unsigned int bh;
 	struct inet6_dev *in6_dev;
 
 	QETH_CARD_TEXT(card, 4, "chkmcv6");
@@ -1268,10 +1270,10 @@ static void qeth_l3_add_multicast_ipv6(struct qeth_card *card)
 		return;
 
 	rcu_read_lock();
-	read_lock_bh(&in6_dev->lock);
+	bh = read_lock_bh(&in6_dev->lock, SOFTIRQ_ALL_MASK);
 	qeth_l3_add_mc6_to_hash(card, in6_dev);
 	qeth_l3_add_vlan_mc6(card);
-	read_unlock_bh(&in6_dev->lock);
+	read_unlock_bh(&in6_dev->lock, bh);
 	rcu_read_unlock();
 	in6_dev_put(in6_dev);
 }
diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
index cda021f..12817ce 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -606,9 +606,10 @@ void bnx2i_drop_session(struct iscsi_cls_session *cls_session)
 static int bnx2i_ep_destroy_list_add(struct bnx2i_hba *hba,
 				     struct bnx2i_endpoint *ep)
 {
-	write_lock_bh(&hba->ep_rdwr_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&ep->link, &hba->ep_destroy_list);
-	write_unlock_bh(&hba->ep_rdwr_lock);
+	write_unlock_bh(&hba->ep_rdwr_lock, bh);
 	return 0;
 }
 
@@ -623,9 +624,10 @@ static int bnx2i_ep_destroy_list_add(struct bnx2i_hba *hba,
 static int bnx2i_ep_destroy_list_del(struct bnx2i_hba *hba,
 				     struct bnx2i_endpoint *ep)
 {
-	write_lock_bh(&hba->ep_rdwr_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_del_init(&ep->link);
-	write_unlock_bh(&hba->ep_rdwr_lock);
+	write_unlock_bh(&hba->ep_rdwr_lock, bh);
 
 	return 0;
 }
@@ -640,9 +642,10 @@ static int bnx2i_ep_destroy_list_del(struct bnx2i_hba *hba,
 static int bnx2i_ep_ofld_list_add(struct bnx2i_hba *hba,
 				  struct bnx2i_endpoint *ep)
 {
-	write_lock_bh(&hba->ep_rdwr_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&ep->link, &hba->ep_ofld_list);
-	write_unlock_bh(&hba->ep_rdwr_lock);
+	write_unlock_bh(&hba->ep_rdwr_lock, bh);
 	return 0;
 }
 
@@ -656,9 +659,10 @@ static int bnx2i_ep_ofld_list_add(struct bnx2i_hba *hba,
 static int bnx2i_ep_ofld_list_del(struct bnx2i_hba *hba,
 				  struct bnx2i_endpoint *ep)
 {
-	write_lock_bh(&hba->ep_rdwr_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_del_init(&ep->link);
-	write_unlock_bh(&hba->ep_rdwr_lock);
+	write_unlock_bh(&hba->ep_rdwr_lock, bh);
 	return 0;
 }
 
@@ -673,11 +677,12 @@ static int bnx2i_ep_ofld_list_del(struct bnx2i_hba *hba,
 struct bnx2i_endpoint *
 bnx2i_find_ep_in_ofld_list(struct bnx2i_hba *hba, u32 iscsi_cid)
 {
+	unsigned int bh;
 	struct list_head *list;
 	struct list_head *tmp;
 	struct bnx2i_endpoint *ep = NULL;
 
-	read_lock_bh(&hba->ep_rdwr_lock);
+	bh = read_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_safe(list, tmp, &hba->ep_ofld_list) {
 		ep = (struct bnx2i_endpoint *)list;
 
@@ -685,7 +690,7 @@ bnx2i_find_ep_in_ofld_list(struct bnx2i_hba *hba, u32 iscsi_cid)
 			break;
 		ep = NULL;
 	}
-	read_unlock_bh(&hba->ep_rdwr_lock);
+	read_unlock_bh(&hba->ep_rdwr_lock, bh);
 
 	if (!ep)
 		printk(KERN_ERR "l5 cid %d not found\n", iscsi_cid);
@@ -701,11 +706,12 @@ bnx2i_find_ep_in_ofld_list(struct bnx2i_hba *hba, u32 iscsi_cid)
 struct bnx2i_endpoint *
 bnx2i_find_ep_in_destroy_list(struct bnx2i_hba *hba, u32 iscsi_cid)
 {
+	unsigned int bh;
 	struct list_head *list;
 	struct list_head *tmp;
 	struct bnx2i_endpoint *ep = NULL;
 
-	read_lock_bh(&hba->ep_rdwr_lock);
+	bh = read_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_for_each_safe(list, tmp, &hba->ep_destroy_list) {
 		ep = (struct bnx2i_endpoint *)list;
 
@@ -713,7 +719,7 @@ bnx2i_find_ep_in_destroy_list(struct bnx2i_hba *hba, u32 iscsi_cid)
 			break;
 		ep = NULL;
 	}
-	read_unlock_bh(&hba->ep_rdwr_lock);
+	read_unlock_bh(&hba->ep_rdwr_lock, bh);
 
 	if (!ep)
 		printk(KERN_ERR "l5 cid %d not found\n", iscsi_cid);
@@ -731,9 +737,10 @@ bnx2i_find_ep_in_destroy_list(struct bnx2i_hba *hba, u32 iscsi_cid)
 static void bnx2i_ep_active_list_add(struct bnx2i_hba *hba,
 				     struct bnx2i_endpoint *ep)
 {
-	write_lock_bh(&hba->ep_rdwr_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_add_tail(&ep->link, &hba->ep_active_list);
-	write_unlock_bh(&hba->ep_rdwr_lock);
+	write_unlock_bh(&hba->ep_rdwr_lock, bh);
 }
 
 
@@ -747,9 +754,10 @@ static void bnx2i_ep_active_list_add(struct bnx2i_hba *hba,
 static void bnx2i_ep_active_list_del(struct bnx2i_hba *hba,
 				     struct bnx2i_endpoint *ep)
 {
-	write_lock_bh(&hba->ep_rdwr_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 	list_del_init(&ep->link);
-	write_unlock_bh(&hba->ep_rdwr_lock);
+	write_unlock_bh(&hba->ep_rdwr_lock, bh);
 }
 
 
@@ -1558,6 +1566,7 @@ static int bnx2i_ep_get_param(struct iscsi_endpoint *ep,
 static int bnx2i_host_get_param(struct Scsi_Host *shost,
 				enum iscsi_host_param param, char *buf)
 {
+	unsigned int bh;
 	struct bnx2i_hba *hba = iscsi_host_priv(shost);
 	int len = 0;
 
@@ -1571,7 +1580,7 @@ static int bnx2i_host_get_param(struct Scsi_Host *shost,
 	case ISCSI_HOST_PARAM_IPADDRESS: {
 		struct list_head *active_list = &hba->ep_active_list;
 
-		read_lock_bh(&hba->ep_rdwr_lock);
+		bh = read_lock_bh(&hba->ep_rdwr_lock, SOFTIRQ_ALL_MASK);
 		if (!list_empty(&hba->ep_active_list)) {
 			struct bnx2i_endpoint *bnx2i_ep;
 			struct cnic_sock *csk;
@@ -1585,7 +1594,7 @@ static int bnx2i_host_get_param(struct Scsi_Host *shost,
 			else
 				len = sprintf(buf, "%pI4\n", csk->src_ip);
 		}
-		read_unlock_bh(&hba->ep_rdwr_lock);
+		read_unlock_bh(&hba->ep_rdwr_lock, bh);
 		break;
 	}
 	default:
diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
index 6f59276..2885e60 100644
--- a/drivers/scsi/cxgbi/libcxgbi.c
+++ b/drivers/scsi/cxgbi/libcxgbi.c
@@ -836,16 +836,17 @@ EXPORT_SYMBOL_GPL(cxgbi_sock_established);
 
 static void cxgbi_inform_iscsi_conn_closing(struct cxgbi_sock *csk)
 {
+	unsigned int bh;
 	log_debug(1 << CXGBI_DBG_SOCK,
 		"csk 0x%p, state %u, flags 0x%lx, conn 0x%p.\n",
 		csk, csk->state, csk->flags, csk->user_data);
 
 	if (csk->state != CTP_ESTABLISHED) {
-		read_lock_bh(&csk->callback_lock);
+		bh = read_lock_bh(&csk->callback_lock, SOFTIRQ_ALL_MASK);
 		if (csk->user_data)
 			iscsi_conn_failure(csk->user_data,
 					ISCSI_ERR_TCP_CONN_CLOSE);
-		read_unlock_bh(&csk->callback_lock);
+		read_unlock_bh(&csk->callback_lock, bh);
 	}
 }
 
@@ -2377,6 +2378,7 @@ int cxgbi_bind_conn(struct iscsi_cls_session *cls_session,
 				struct iscsi_cls_conn *cls_conn,
 				u64 transport_eph, int is_leading)
 {
+	unsigned int bh;
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	struct cxgbi_conn *cconn = tcp_conn->dd_data;
@@ -2407,12 +2409,12 @@ int cxgbi_bind_conn(struct iscsi_cls_session *cls_session,
 	/*  calculate the tag idx bits needed for this conn based on cmds_max */
 	cconn->task_idx_bits = (__ilog2_u32(conn->session->cmds_max - 1)) + 1;
 
-	write_lock_bh(&csk->callback_lock);
+	bh = write_lock_bh(&csk->callback_lock, SOFTIRQ_ALL_MASK);
 	csk->user_data = conn;
 	cconn->chba = cep->chba;
 	cconn->cep = cep;
 	cep->cconn = cconn;
-	write_unlock_bh(&csk->callback_lock);
+	write_unlock_bh(&csk->callback_lock, bh);
 
 	cxgbi_conn_max_xmit_dlength(conn);
 	cxgbi_conn_max_recv_dlength(conn);
@@ -2664,6 +2666,7 @@ EXPORT_SYMBOL_GPL(cxgbi_ep_poll);
 
 void cxgbi_ep_disconnect(struct iscsi_endpoint *ep)
 {
+	unsigned int bh;
 	struct cxgbi_endpoint *cep = ep->dd_data;
 	struct cxgbi_conn *cconn = cep->cconn;
 	struct cxgbi_sock *csk = cep->csk;
@@ -2674,10 +2677,10 @@ void cxgbi_ep_disconnect(struct iscsi_endpoint *ep)
 
 	if (cconn && cconn->iconn) {
 		iscsi_suspend_tx(cconn->iconn);
-		write_lock_bh(&csk->callback_lock);
+		bh = write_lock_bh(&csk->callback_lock, SOFTIRQ_ALL_MASK);
 		cep->csk->user_data = NULL;
 		cconn->cep = NULL;
-		write_unlock_bh(&csk->callback_lock);
+		write_unlock_bh(&csk->callback_lock, bh);
 	}
 	iscsi_destroy_endpoint(ep);
 
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 44a6a66..5d26296 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -129,14 +129,15 @@ static inline int iscsi_sw_sk_state_check(struct sock *sk)
 
 static void iscsi_sw_tcp_data_ready(struct sock *sk)
 {
+	unsigned int bh;
 	struct iscsi_conn *conn;
 	struct iscsi_tcp_conn *tcp_conn;
 	read_descriptor_t rd_desc;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	bh = read_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	conn = sk->sk_user_data;
 	if (!conn) {
-		read_unlock_bh(&sk->sk_callback_lock);
+		read_unlock_bh(&sk->sk_callback_lock, bh);
 		return;
 	}
 	tcp_conn = conn->dd_data;
@@ -156,20 +157,21 @@ static void iscsi_sw_tcp_data_ready(struct sock *sk)
 	/* If we had to (atomically) map a highmem page,
 	 * unmap it now. */
 	iscsi_tcp_segment_unmap(&tcp_conn->in.segment);
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock, bh);
 }
 
 static void iscsi_sw_tcp_state_change(struct sock *sk)
 {
+	unsigned int bh;
 	struct iscsi_tcp_conn *tcp_conn;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn;
 	struct iscsi_conn *conn;
 	void (*old_state_change)(struct sock *);
 
-	read_lock_bh(&sk->sk_callback_lock);
+	bh = read_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	conn = sk->sk_user_data;
 	if (!conn) {
-		read_unlock_bh(&sk->sk_callback_lock);
+		read_unlock_bh(&sk->sk_callback_lock, bh);
 		return;
 	}
 
@@ -179,7 +181,7 @@ static void iscsi_sw_tcp_state_change(struct sock *sk)
 	tcp_sw_conn = tcp_conn->dd_data;
 	old_state_change = tcp_sw_conn->old_state_change;
 
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock, bh);
 
 	old_state_change(sk);
 }
@@ -190,22 +192,23 @@ static void iscsi_sw_tcp_state_change(struct sock *sk)
  **/
 static void iscsi_sw_tcp_write_space(struct sock *sk)
 {
+	unsigned int bh;
 	struct iscsi_conn *conn;
 	struct iscsi_tcp_conn *tcp_conn;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn;
 	void (*old_write_space)(struct sock *);
 
-	read_lock_bh(&sk->sk_callback_lock);
+	bh = read_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	conn = sk->sk_user_data;
 	if (!conn) {
-		read_unlock_bh(&sk->sk_callback_lock);
+		read_unlock_bh(&sk->sk_callback_lock, bh);
 		return;
 	}
 
 	tcp_conn = conn->dd_data;
 	tcp_sw_conn = tcp_conn->dd_data;
 	old_write_space = tcp_sw_conn->old_write_space;
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock, bh);
 
 	old_write_space(sk);
 
@@ -215,12 +218,13 @@ static void iscsi_sw_tcp_write_space(struct sock *sk)
 
 static void iscsi_sw_tcp_conn_set_callbacks(struct iscsi_conn *conn)
 {
+	unsigned int bh;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
 	struct sock *sk = tcp_sw_conn->sock->sk;
 
 	/* assign new callbacks */
-	write_lock_bh(&sk->sk_callback_lock);
+	bh = write_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sk->sk_user_data = conn;
 	tcp_sw_conn->old_data_ready = sk->sk_data_ready;
 	tcp_sw_conn->old_state_change = sk->sk_state_change;
@@ -228,24 +232,25 @@ static void iscsi_sw_tcp_conn_set_callbacks(struct iscsi_conn *conn)
 	sk->sk_data_ready = iscsi_sw_tcp_data_ready;
 	sk->sk_state_change = iscsi_sw_tcp_state_change;
 	sk->sk_write_space = iscsi_sw_tcp_write_space;
-	write_unlock_bh(&sk->sk_callback_lock);
+	write_unlock_bh(&sk->sk_callback_lock, bh);
 }
 
 static void
 iscsi_sw_tcp_conn_restore_callbacks(struct iscsi_conn *conn)
 {
+	unsigned int bh;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
 	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
 	struct sock *sk = tcp_sw_conn->sock->sk;
 
 	/* restore socket callbacks, see also: iscsi_conn_set_callbacks() */
-	write_lock_bh(&sk->sk_callback_lock);
+	bh = write_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sk->sk_user_data    = NULL;
 	sk->sk_data_ready   = tcp_sw_conn->old_data_ready;
 	sk->sk_state_change = tcp_sw_conn->old_state_change;
 	sk->sk_write_space  = tcp_sw_conn->old_write_space;
 	sk->sk_no_check_tx = 0;
-	write_unlock_bh(&sk->sk_callback_lock);
+	write_unlock_bh(&sk->sk_callback_lock, bh);
 }
 
 /**
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index bc05c69..a812d61 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2692,6 +2692,7 @@ need_resume(VCHIQ_STATE_T *state)
 static int
 block_resume(VCHIQ_ARM_STATE_T *arm_state)
 {
+	unsigned int bh;
 	int status = VCHIQ_SUCCESS;
 	const unsigned long timeout_val =
 				msecs_to_jiffies(FORCE_SUSPEND_TIMEOUT_MS);
@@ -2713,12 +2714,12 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 			vchiq_log_error(vchiq_susp_log_level, "%s wait for "
 				"previously blocked clients failed", __func__);
 			status = VCHIQ_ERROR;
-			write_lock_bh(&arm_state->susp_res_lock);
+			write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 			goto out;
 		}
 		vchiq_log_info(vchiq_susp_log_level, "%s previously blocked "
 			"clients resumed", __func__);
-		write_lock_bh(&arm_state->susp_res_lock);
+		bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	}
 
 	/* We need to wait for resume to complete if it's in process */
@@ -2730,7 +2731,7 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 				"many times for resume", __func__);
 			goto out;
 		}
-		write_unlock_bh(&arm_state->susp_res_lock);
+		write_unlock_bh(&arm_state->susp_res_lock, bh);
 		vchiq_log_info(vchiq_susp_log_level, "%s wait for resume",
 			__func__);
 		if (wait_for_completion_interruptible_timeout(
@@ -2741,11 +2742,11 @@ block_resume(VCHIQ_ARM_STATE_T *arm_state)
 				resume_state_names[arm_state->vc_resume_state +
 							VC_RESUME_NUM_OFFSET]);
 			status = VCHIQ_ERROR;
-			write_lock_bh(&arm_state->susp_res_lock);
+			write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 			goto out;
 		}
 		vchiq_log_info(vchiq_susp_log_level, "%s resumed", __func__);
-		write_lock_bh(&arm_state->susp_res_lock);
+		bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 		resume_count++;
 	}
 	reinit_completion(&arm_state->resume_blocker);
@@ -2816,6 +2817,7 @@ vchiq_arm_vcsuspend(VCHIQ_STATE_T *state)
 void
 vchiq_platform_check_suspend(VCHIQ_STATE_T *state)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	int susp = 0;
 
@@ -2824,13 +2826,13 @@ vchiq_platform_check_suspend(VCHIQ_STATE_T *state)
 
 	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
 
-	write_lock_bh(&arm_state->susp_res_lock);
+	bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	if (arm_state->vc_suspend_state == VC_SUSPEND_REQUESTED &&
 			arm_state->vc_resume_state == VC_RESUME_RESUMED) {
 		set_suspend_state(arm_state, VC_SUSPEND_IN_PROGRESS);
 		susp = 1;
 	}
-	write_unlock_bh(&arm_state->susp_res_lock);
+	write_unlock_bh(&arm_state->susp_res_lock, bh);
 
 	if (susp)
 		vchiq_platform_suspend(state);
@@ -2888,6 +2890,7 @@ output_timeout_error(VCHIQ_STATE_T *state)
 VCHIQ_STATUS_T
 vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	VCHIQ_STATUS_T status = VCHIQ_ERROR;
 	long rc = 0;
@@ -2898,7 +2901,7 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 
 	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
 
-	write_lock_bh(&arm_state->susp_res_lock);
+	bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 
 	status = block_resume(arm_state);
 	if (status != VCHIQ_SUCCESS)
@@ -2944,7 +2947,7 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 				&arm_state->vc_suspend_complete,
 				msecs_to_jiffies(FORCE_SUSPEND_TIMEOUT_MS));
 
-		write_lock_bh(&arm_state->susp_res_lock);
+		write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 		if (rc < 0) {
 			vchiq_log_warning(vchiq_susp_log_level, "%s "
 				"interrupted waiting for suspend", __func__);
@@ -2989,7 +2992,7 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 	unblock_resume(arm_state);
 
 unlock:
-	write_unlock_bh(&arm_state->susp_res_lock);
+	write_unlock_bh(&arm_state->susp_res_lock, bh);
 
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, status);
@@ -2999,6 +3002,7 @@ vchiq_arm_force_suspend(VCHIQ_STATE_T *state)
 void
 vchiq_check_suspend(VCHIQ_STATE_T *state)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 
 	if (!arm_state)
@@ -3006,13 +3010,13 @@ vchiq_check_suspend(VCHIQ_STATE_T *state)
 
 	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
 
-	write_lock_bh(&arm_state->susp_res_lock);
+	bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	if (arm_state->vc_suspend_state != VC_SUSPEND_SUSPENDED &&
 			arm_state->first_connect &&
 			!vchiq_videocore_wanted(state)) {
 		vchiq_arm_vcsuspend(state);
 	}
-	write_unlock_bh(&arm_state->susp_res_lock);
+	write_unlock_bh(&arm_state->susp_res_lock, bh);
 
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit", __func__);
@@ -3021,6 +3025,8 @@ vchiq_check_suspend(VCHIQ_STATE_T *state)
 int
 vchiq_arm_allow_resume(VCHIQ_STATE_T *state)
 {
+	unsigned int bh;
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	int resume = 0;
 	int ret = -1;
@@ -3030,10 +3036,10 @@ vchiq_arm_allow_resume(VCHIQ_STATE_T *state)
 
 	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
 
-	write_lock_bh(&arm_state->susp_res_lock);
+	bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	unblock_resume(arm_state);
 	resume = vchiq_check_resume(state);
-	write_unlock_bh(&arm_state->susp_res_lock);
+	write_unlock_bh(&arm_state->susp_res_lock, bh);
 
 	if (resume) {
 		if (wait_for_completion_interruptible(
@@ -3046,7 +3052,7 @@ vchiq_arm_allow_resume(VCHIQ_STATE_T *state)
 		}
 	}
 
-	read_lock_bh(&arm_state->susp_res_lock);
+	bh = read_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	if (arm_state->vc_suspend_state == VC_SUSPEND_SUSPENDED) {
 		vchiq_log_info(vchiq_susp_log_level,
 				"%s: Videocore remains suspended", __func__);
@@ -3055,7 +3061,7 @@ vchiq_arm_allow_resume(VCHIQ_STATE_T *state)
 				"%s: Videocore resumed", __func__);
 		ret = 0;
 	}
-	read_unlock_bh(&arm_state->susp_res_lock);
+	read_unlock_bh(&arm_state->susp_res_lock, bh);
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
 	return ret;
@@ -3088,6 +3094,7 @@ VCHIQ_STATUS_T
 vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		enum USE_TYPE_E use_type)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	VCHIQ_STATUS_T ret = VCHIQ_SUCCESS;
 	char entity[16];
@@ -3114,7 +3121,7 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 		goto out;
 	}
 
-	write_lock_bh(&arm_state->susp_res_lock);
+	bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	while (arm_state->resume_blocked) {
 		/* If we call 'use' while force suspend is waiting for suspend,
 		 * then we're about to block the thread which the force is
@@ -3143,14 +3150,14 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 					"wait for resume blocker interrupted",
 					__func__, entity);
 				ret = VCHIQ_ERROR;
-				write_lock_bh(&arm_state->susp_res_lock);
+				write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 				arm_state->blocked_count--;
 				write_unlock_bh(&arm_state->susp_res_lock);
 				goto out;
 			}
 			vchiq_log_info(vchiq_susp_log_level, "%s %s resume "
 				"unblocked", __func__, entity);
-			write_lock_bh(&arm_state->susp_res_lock);
+			write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 			if (--arm_state->blocked_count == 0)
 				complete_all(&arm_state->blocked_blocker);
 		}
@@ -3179,7 +3186,7 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 			"%s %s count %d, state count %d",
 			__func__, entity, *entity_uc, local_uc);
 
-	write_unlock_bh(&arm_state->susp_res_lock);
+	write_unlock_bh(&arm_state->susp_res_lock, bh);
 
 	/* Completion is in a done state when we're not suspended, so this won't
 	 * block for the non-suspended case. */
@@ -3220,6 +3227,7 @@ vchiq_use_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service,
 VCHIQ_STATUS_T
 vchiq_release_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	VCHIQ_STATUS_T ret = VCHIQ_SUCCESS;
 	char entity[16];
@@ -3241,7 +3249,7 @@ vchiq_release_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service)
 		entity_uc = &arm_state->peer_use_count;
 	}
 
-	write_lock_bh(&arm_state->susp_res_lock);
+	bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	if (!arm_state->videocore_use_count || !(*entity_uc)) {
 		/* Don't use BUG_ON - don't allow user thread to crash kernel */
 		WARN_ON(!arm_state->videocore_use_count);
@@ -3272,7 +3280,7 @@ vchiq_release_internal(VCHIQ_STATE_T *state, VCHIQ_SERVICE_T *service)
 			arm_state->videocore_use_count);
 
 unlock:
-	write_unlock_bh(&arm_state->susp_res_lock);
+	write_unlock_bh(&arm_state->susp_res_lock, bh);
 
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit %d", __func__, ret);
@@ -3419,6 +3427,7 @@ struct service_data_struct {
 void
 vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 	struct service_data_struct *service_data;
 	int i, found = 0;
@@ -3441,7 +3450,7 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 	if (!service_data)
 		return;
 
-	read_lock_bh(&arm_state->susp_res_lock);
+	bh = read_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	vc_suspend_state = arm_state->vc_suspend_state;
 	vc_resume_state  = arm_state->vc_resume_state;
 	peer_count = arm_state->peer_use_count;
@@ -3470,7 +3479,7 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 			break;
 	}
 
-	read_unlock_bh(&arm_state->susp_res_lock);
+	read_unlock_bh(&arm_state->susp_res_lock, bh);
 
 	vchiq_log_warning(vchiq_susp_log_level,
 		"-- Videcore suspend state: %s --",
@@ -3505,6 +3514,7 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
 VCHIQ_STATUS_T
 vchiq_check_service(VCHIQ_SERVICE_T *service)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state;
 	VCHIQ_STATUS_T ret = VCHIQ_ERROR;
 
@@ -3515,10 +3525,10 @@ vchiq_check_service(VCHIQ_SERVICE_T *service)
 
 	arm_state = vchiq_platform_get_arm_state(service->state);
 
-	read_lock_bh(&arm_state->susp_res_lock);
+	bh = read_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 	if (service->service_use_count)
 		ret = VCHIQ_SUCCESS;
-	read_unlock_bh(&arm_state->susp_res_lock);
+	read_unlock_bh(&arm_state->susp_res_lock, bh);
 
 	if (ret == VCHIQ_ERROR) {
 		vchiq_log_error(vchiq_susp_log_level,
@@ -3544,17 +3554,18 @@ void vchiq_on_remote_use_active(VCHIQ_STATE_T *state)
 void vchiq_platform_conn_state_changed(VCHIQ_STATE_T *state,
 	VCHIQ_CONNSTATE_T oldstate, VCHIQ_CONNSTATE_T newstate)
 {
+	unsigned int bh;
 	VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
 
 	vchiq_log_info(vchiq_susp_log_level, "%d: %s->%s", state->id,
 		get_conn_state_name(oldstate), get_conn_state_name(newstate));
 	if (state->conn_state == VCHIQ_CONNSTATE_CONNECTED) {
-		write_lock_bh(&arm_state->susp_res_lock);
+		bh = write_lock_bh(&arm_state->susp_res_lock, SOFTIRQ_ALL_MASK);
 		if (!arm_state->first_connect) {
 			char threadname[16];
 
 			arm_state->first_connect = 1;
-			write_unlock_bh(&arm_state->susp_res_lock);
+			write_unlock_bh(&arm_state->susp_res_lock, bh);
 			snprintf(threadname, sizeof(threadname), "vchiq-keep/%d",
 				state->id);
 			arm_state->ka_thread = kthread_create(
@@ -3569,7 +3580,7 @@ void vchiq_platform_conn_state_changed(VCHIQ_STATE_T *state,
 				wake_up_process(arm_state->ka_thread);
 			}
 		} else
-			write_unlock_bh(&arm_state->susp_res_lock);
+			write_unlock_bh(&arm_state->susp_res_lock, bh);
 	}
 }
 
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 7d9eea7..1137e8c 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -598,10 +598,11 @@ static void o2net_set_nn_state(struct o2net_node *nn,
 /* see o2net_register_callbacks() */
 static void o2net_data_ready(struct sock *sk)
 {
+	unsigned int bh;
 	void (*ready)(struct sock *sk);
 	struct o2net_sock_container *sc;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	bh = read_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sc = sk->sk_user_data;
 	if (sc) {
 		sclog(sc, "data_ready hit\n");
@@ -611,7 +612,7 @@ static void o2net_data_ready(struct sock *sk)
 	} else {
 		ready = sk->sk_data_ready;
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock, bh);
 
 	ready(sk);
 }
@@ -619,10 +620,11 @@ static void o2net_data_ready(struct sock *sk)
 /* see o2net_register_callbacks() */
 static void o2net_state_change(struct sock *sk)
 {
+	unsigned int bh;
 	void (*state_change)(struct sock *sk);
 	struct o2net_sock_container *sc;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	bh = read_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sc = sk->sk_user_data;
 	if (sc == NULL) {
 		state_change = sk->sk_state_change;
@@ -649,7 +651,7 @@ static void o2net_state_change(struct sock *sk)
 		break;
 	}
 out:
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock, bh);
 	state_change(sk);
 }
 
@@ -661,7 +663,8 @@ static void o2net_state_change(struct sock *sk)
 static void o2net_register_callbacks(struct sock *sk,
 				     struct o2net_sock_container *sc)
 {
-	write_lock_bh(&sk->sk_callback_lock);
+	unsigned int bh;
+	bh = write_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 
 	/* accepted sockets inherit the old listen socket data ready */
 	if (sk->sk_data_ready == o2net_listen_data_ready) {
@@ -680,22 +683,23 @@ static void o2net_register_callbacks(struct sock *sk,
 
 	mutex_init(&sc->sc_send_lock);
 
-	write_unlock_bh(&sk->sk_callback_lock);
+	write_unlock_bh(&sk->sk_callback_lock, bh);
 }
 
 static int o2net_unregister_callbacks(struct sock *sk,
 			           struct o2net_sock_container *sc)
 {
+	unsigned int bh;
 	int ret = 0;
 
-	write_lock_bh(&sk->sk_callback_lock);
+	bh = write_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	if (sk->sk_user_data == sc) {
 		ret = 1;
 		sk->sk_user_data = NULL;
 		sk->sk_data_ready = sc->sc_data_ready;
 		sk->sk_state_change = sc->sc_state_change;
 	}
-	write_unlock_bh(&sk->sk_callback_lock);
+	write_unlock_bh(&sk->sk_callback_lock, bh);
 
 	return ret;
 }
@@ -1986,9 +1990,10 @@ static void o2net_accept_many(struct work_struct *work)
 
 static void o2net_listen_data_ready(struct sock *sk)
 {
+	unsigned int bh;
 	void (*ready)(struct sock *sk);
 
-	read_lock_bh(&sk->sk_callback_lock);
+	bh = read_lock_bh(&sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	ready = sk->sk_user_data;
 	if (ready == NULL) { /* check for teardown race */
 		ready = sk->sk_data_ready;
@@ -2015,13 +2020,14 @@ static void o2net_listen_data_ready(struct sock *sk)
 	}
 
 out:
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock, bh);
 	if (ready != NULL)
 		ready(sk);
 }
 
 static int o2net_open_listening_sock(__be32 addr, __be16 port)
 {
+	unsigned int bh;
 	struct socket *sock = NULL;
 	int ret;
 	struct sockaddr_in sin = {
@@ -2038,10 +2044,10 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 
 	sock->sk->sk_allocation = GFP_ATOMIC;
 
-	write_lock_bh(&sock->sk->sk_callback_lock);
+	bh = write_lock_bh(&sock->sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sock->sk->sk_user_data = sock->sk->sk_data_ready;
 	sock->sk->sk_data_ready = o2net_listen_data_ready;
-	write_unlock_bh(&sock->sk->sk_callback_lock);
+	write_unlock_bh(&sock->sk->sk_callback_lock, bh);
 
 	o2net_listen_sock = sock;
 	INIT_WORK(&o2net_listen_work, o2net_accept_many);
@@ -2104,6 +2110,7 @@ int o2net_start_listening(struct o2nm_node *node)
  * tearing it down */
 void o2net_stop_listening(struct o2nm_node *node)
 {
+	unsigned int bh;
 	struct socket *sock = o2net_listen_sock;
 	size_t i;
 
@@ -2111,10 +2118,10 @@ void o2net_stop_listening(struct o2nm_node *node)
 	BUG_ON(o2net_listen_sock == NULL);
 
 	/* stop the listening socket from generating work */
-	write_lock_bh(&sock->sk->sk_callback_lock);
+	bh = write_lock_bh(&sock->sk->sk_callback_lock, SOFTIRQ_ALL_MASK);
 	sock->sk->sk_data_ready = sock->sk->sk_user_data;
 	sock->sk->sk_user_data = NULL;
-	write_unlock_bh(&sock->sk->sk_callback_lock);
+	write_unlock_bh(&sock->sk->sk_callback_lock, bh);
 
 	for (i = 0; i < ARRAY_SIZE(o2net_nodes); i++) {
 		struct o2nm_node *node = o2nm_get_node_by_num(i);
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 3dcd617..cda528b 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -99,9 +99,9 @@ do {								\
 #endif
 
 #define read_lock_irq(lock)		_raw_read_lock_irq(lock)
-#define read_lock_bh(lock)		_raw_read_lock_bh(lock)
+#define read_lock_bh(lock, mask)	_raw_read_lock_bh(lock, mask)
 #define write_lock_irq(lock)		_raw_write_lock_irq(lock)
-#define write_lock_bh(lock)		_raw_write_lock_bh(lock)
+#define write_lock_bh(lock, mask)	_raw_write_lock_bh(lock, mask)
 #define read_unlock(lock)		_raw_read_unlock(lock)
 #define write_unlock(lock)		_raw_write_unlock(lock)
 #define read_unlock_irq(lock)		_raw_read_unlock_irq(lock)
@@ -112,14 +112,14 @@ do {								\
 		typecheck(unsigned long, flags);		\
 		_raw_read_unlock_irqrestore(lock, flags);	\
 	} while (0)
-#define read_unlock_bh(lock)		_raw_read_unlock_bh(lock)
+#define read_unlock_bh(lock, bh)		_raw_read_unlock_bh(lock, bh)
 
 #define write_unlock_irqrestore(lock, flags)		\
 	do {						\
 		typecheck(unsigned long, flags);	\
 		_raw_write_unlock_irqrestore(lock, flags);	\
 	} while (0)
-#define write_unlock_bh(lock)		_raw_write_unlock_bh(lock)
+#define write_unlock_bh(lock, bh)	_raw_write_unlock_bh(lock, bh)
 
 #define write_trylock_irqsave(lock, flags) \
 ({ \
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 86ebb4b..fb66489 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -17,8 +17,8 @@
 
 void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_write_lock(rwlock_t *lock)		__acquires(lock);
-void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires(lock);
-void __lockfunc _raw_write_lock_bh(rwlock_t *lock)	__acquires(lock);
+unsigned int __lockfunc _raw_read_lock_bh(rwlock_t *lock, unsigned int mask)	__acquires(lock);
+unsigned int __lockfunc _raw_write_lock_bh(rwlock_t *lock, unsigned int mask)	__acquires(lock);
 void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires(lock);
 void __lockfunc _raw_write_lock_irq(rwlock_t *lock)	__acquires(lock);
 unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
@@ -29,8 +29,8 @@ int __lockfunc _raw_read_trylock(rwlock_t *lock);
 int __lockfunc _raw_write_trylock(rwlock_t *lock);
 void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases(lock);
 void __lockfunc _raw_write_unlock(rwlock_t *lock)	__releases(lock);
-void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases(lock);
-void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock_bh(rwlock_t *lock, unsigned int bh)	__releases(lock);
+void __lockfunc _raw_write_unlock_bh(rwlock_t *lock, unsigned int bh)	__releases(lock);
 void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)	__releases(lock);
 void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)	__releases(lock);
 void __lockfunc
@@ -49,11 +49,11 @@ _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 #endif
 
 #ifdef CONFIG_INLINE_READ_LOCK_BH
-#define _raw_read_lock_bh(lock) __raw_read_lock_bh(lock)
+#define _raw_read_lock_bh(lock, mask) __raw_read_lock_bh(lock, mask)
 #endif
 
 #ifdef CONFIG_INLINE_WRITE_LOCK_BH
-#define _raw_write_lock_bh(lock) __raw_write_lock_bh(lock)
+#define _raw_write_lock_bh(lock, mask) __raw_write_lock_bh(lock, mask)
 #endif
 
 #ifdef CONFIG_INLINE_READ_LOCK_IRQ
@@ -89,11 +89,11 @@ _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 #endif
 
 #ifdef CONFIG_INLINE_READ_UNLOCK_BH
-#define _raw_read_unlock_bh(lock) __raw_read_unlock_bh(lock)
+#define _raw_read_unlock_bh(lock, bh) __raw_read_unlock_bh(lock, bh)
 #endif
 
 #ifdef CONFIG_INLINE_WRITE_UNLOCK_BH
-#define _raw_write_unlock_bh(lock) __raw_write_unlock_bh(lock)
+#define _raw_write_unlock_bh(lock, bh) __raw_write_unlock_bh(lock, bh)
 #endif
 
 #ifdef CONFIG_INLINE_READ_UNLOCK_IRQ
@@ -170,11 +170,13 @@ static inline void __raw_read_lock_irq(rwlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
 }
 
-static inline void __raw_read_lock_bh(rwlock_t *lock)
+static inline unsigned int __raw_read_lock_bh(rwlock_t *lock,
+					      unsigned int mask)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
+	return 0;
 }
 
 static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
@@ -197,11 +199,13 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
-static inline void __raw_write_lock_bh(rwlock_t *lock)
+static inline unsigned int  __raw_write_lock_bh(rwlock_t *lock,
+						unsigned int mask)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
+	return 0;
 }
 
 static inline void __raw_write_lock(rwlock_t *lock)
@@ -244,7 +248,8 @@ static inline void __raw_read_unlock_irq(rwlock_t *lock)
 	preempt_enable();
 }
 
-static inline void __raw_read_unlock_bh(rwlock_t *lock)
+static inline void __raw_read_unlock_bh(rwlock_t *lock,
+					unsigned int bh)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -268,7 +273,8 @@ static inline void __raw_write_unlock_irq(rwlock_t *lock)
 	preempt_enable();
 }
 
-static inline void __raw_write_unlock_bh(rwlock_t *lock)
+static inline void __raw_write_unlock_bh(rwlock_t *lock,
+					 unsigned int bh)
 {
 	rwlock_release(&lock->dep_map, 1, _RET_IP_);
 	do_raw_write_unlock(lock);
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index a4b6124..e2bfafe 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -61,7 +61,7 @@
 #define _raw_write_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_bh(lock)			({ __LOCK_BH(lock); 0; }, SOFTIRQ_ALL_MASK)
 #define _raw_read_lock_bh(lock)			({ __LOCK_BH(lock); 0; })
-#define _raw_write_lock_bh(lock)		({ __LOCK_BH(lock); 0; })
+#define _raw_write_lock_bh(lock)		({ __LOCK_BH(lock); 0; }, SOFTIRQ_ALL_MASK)
 #define _raw_spin_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_write_lock_irq(lock)		__LOCK_IRQ(lock)
-- 
2.7.4

