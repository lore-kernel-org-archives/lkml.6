Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/gMkl5USTpKAQ8XetN9aRVtIpgvym/U5kS41HLT7fp+a0lVoWMXPIUq/wZxkpm71j8fJnQ
ARC-Seal: i=1; a=rsa-sha256; t=1523980849; cv=none;
        d=google.com; s=arc-20160816;
        b=L9b1QJuGDNWeUNocNg6vIc6wtQhzZ6aAP9vR8/arnxAn8xPIoZcZ0C/1w7ewm3My/B
         8YtCHOC4UyfFnrbdh4n1R3YzpZSWIHmD07/RyWWJoPk6+Adb/diFTzCXojbYzqSH8YOx
         M3zd0R1od4JEP+SrV0GTOaXFg7ZWh2qu1oAJRSiaD618TOVLMXKrA8Jwzo6TFbQevm4t
         BYgq7nW3MrYIm4V8rY2in96Y1SO2Ww8d+X6Z0nKcaXGaGFMmV1V9dihEX2sh30yVOjVm
         dWb8hsEvLwtEoyHSOB4d28YS/CO1u34jgxESDj+r8nh1pX84c6tXZXxkk9BhiNCF3YKf
         MxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zxntr3lk+nF37aCoozV0l9PmtZbcSQ8jIxGSielSUAA=;
        b=tZdt8J1Uzu2Coy1sDtoxBIbAmGf9RqpyUypSpFJtXx01iX916FH/VJm82Q7AEnoVos
         2egW7Rty27FoTHYlhRrijYokxrDG/xCgsWxYOGcWCw8r64yI/gxECRogxzX4RfZpyLmv
         /EYXxZiF9fFKeBySmJU3suYlgkV71TIIvQ+/fREJaoz2Zg5AKnmX7Xli8/xOIdNJIkJ8
         dFgW99D42hs1FjoxJ4JBZRivR7EfBb784hJAhNMoIe6gifjE3dg12FcK3+1FYGL9XceA
         laCCvfqDqMadrfySh7uu7Uk6yanehSKdwHGY3polHf3qDMygOITsiBH835olpuhjh7oc
         tNFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+fbeeb5c3b538e8545644@syzkaller.appspotmail.com,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 05/68] l2tp: fix races in tunnel creation
Date: Tue, 17 Apr 2018 17:57:18 +0200
Message-Id: <20180417155749.560655625@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009742897398618?=
X-GMAIL-MSGID: =?utf-8?q?1598009742897398618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 6b9f34239b00e6956a267abed2bc559ede556ad6 ]

l2tp_tunnel_create() inserts the new tunnel into the namespace's tunnel
list and sets the socket's ->sk_user_data field, before returning it to
the caller. Therefore, there are two ways the tunnel can be accessed
and freed, before the caller even had the opportunity to take a
reference. In practice, syzbot could crash the module by closing the
socket right after a new tunnel was returned to pppol2tp_create().

This patch moves tunnel registration out of l2tp_tunnel_create(), so
that the caller can safely hold a reference before publishing the
tunnel. This second step is done with the new l2tp_tunnel_register()
function, which is now responsible for associating the tunnel to its
socket and for inserting it into the namespace's list.

While moving the code to l2tp_tunnel_register(), a few modifications
have been done. First, the socket validation tests are done in a helper
function, for clarity. Also, modifying the socket is now done after
having inserted the tunnel to the namespace's tunnels list. This will
allow insertion to fail, without having to revert theses modifications
in the error path (a followup patch will check for duplicate tunnels
before insertion). Either the socket is a kernel socket which we
control, or it is a user-space socket for which we have a reference on
the file descriptor. In any case, the socket isn't going to be closed
from under us.

Reported-by: syzbot+fbeeb5c3b538e8545644@syzkaller.appspotmail.com
Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c    |  192 +++++++++++++++++++++---------------------------
 net/l2tp/l2tp_core.h    |    3 
 net/l2tp/l2tp_netlink.c |   16 +++-
 net/l2tp/l2tp_ppp.c     |    9 ++
 4 files changed, 110 insertions(+), 110 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1436,74 +1436,11 @@ int l2tp_tunnel_create(struct net *net,
 {
 	struct l2tp_tunnel *tunnel = NULL;
 	int err;
-	struct socket *sock = NULL;
-	struct sock *sk = NULL;
-	struct l2tp_net *pn;
 	enum l2tp_encap_type encap = L2TP_ENCAPTYPE_UDP;
 
-	/* Get the tunnel socket from the fd, which was opened by
-	 * the userspace L2TP daemon. If not specified, create a
-	 * kernel socket.
-	 */
-	if (fd < 0) {
-		err = l2tp_tunnel_sock_create(net, tunnel_id, peer_tunnel_id,
-				cfg, &sock);
-		if (err < 0)
-			goto err;
-	} else {
-		sock = sockfd_lookup(fd, &err);
-		if (!sock) {
-			pr_err("tunl %u: sockfd_lookup(fd=%d) returned %d\n",
-			       tunnel_id, fd, err);
-			err = -EBADF;
-			goto err;
-		}
-
-		/* Reject namespace mismatches */
-		if (!net_eq(sock_net(sock->sk), net)) {
-			pr_err("tunl %u: netns mismatch\n", tunnel_id);
-			err = -EINVAL;
-			goto err;
-		}
-	}
-
-	sk = sock->sk;
-
 	if (cfg != NULL)
 		encap = cfg->encap;
 
-	/* Quick sanity checks */
-	err = -EPROTONOSUPPORT;
-	if (sk->sk_type != SOCK_DGRAM) {
-		pr_debug("tunl %hu: fd %d wrong socket type\n",
-			 tunnel_id, fd);
-		goto err;
-	}
-	switch (encap) {
-	case L2TP_ENCAPTYPE_UDP:
-		if (sk->sk_protocol != IPPROTO_UDP) {
-			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
-			       tunnel_id, fd, sk->sk_protocol, IPPROTO_UDP);
-			goto err;
-		}
-		break;
-	case L2TP_ENCAPTYPE_IP:
-		if (sk->sk_protocol != IPPROTO_L2TP) {
-			pr_err("tunl %hu: fd %d wrong protocol, got %d, expected %d\n",
-			       tunnel_id, fd, sk->sk_protocol, IPPROTO_L2TP);
-			goto err;
-		}
-		break;
-	}
-
-	/* Check if this socket has already been prepped */
-	tunnel = l2tp_tunnel(sk);
-	if (tunnel != NULL) {
-		/* This socket has already been prepped */
-		err = -EBUSY;
-		goto err;
-	}
-
 	tunnel = kzalloc(sizeof(struct l2tp_tunnel), GFP_KERNEL);
 	if (tunnel == NULL) {
 		err = -ENOMEM;
@@ -1520,72 +1457,113 @@ int l2tp_tunnel_create(struct net *net,
 	rwlock_init(&tunnel->hlist_lock);
 	tunnel->acpt_newsess = true;
 
-	/* The net we belong to */
-	tunnel->l2tp_net = net;
-	pn = l2tp_pernet(net);
-
 	if (cfg != NULL)
 		tunnel->debug = cfg->debug;
 
-	/* Mark socket as an encapsulation socket. See net/ipv4/udp.c */
 	tunnel->encap = encap;
-	if (encap == L2TP_ENCAPTYPE_UDP) {
-		struct udp_tunnel_sock_cfg udp_cfg = { };
-
-		udp_cfg.sk_user_data = tunnel;
-		udp_cfg.encap_type = UDP_ENCAP_L2TPINUDP;
-		udp_cfg.encap_rcv = l2tp_udp_encap_recv;
-		udp_cfg.encap_destroy = l2tp_udp_encap_destroy;
-
-		setup_udp_tunnel_sock(net, sock, &udp_cfg);
-	} else {
-		sk->sk_user_data = tunnel;
-	}
 
-	/* Bump the reference count. The tunnel context is deleted
-	 * only when this drops to zero. A reference is also held on
-	 * the tunnel socket to ensure that it is not released while
-	 * the tunnel is extant. Must be done before sk_destruct is
-	 * set.
-	 */
 	refcount_set(&tunnel->ref_count, 1);
-	sock_hold(sk);
-	tunnel->sock = sk;
 	tunnel->fd = fd;
 
-	/* Hook on the tunnel socket destructor so that we can cleanup
-	 * if the tunnel socket goes away.
-	 */
-	tunnel->old_sk_destruct = sk->sk_destruct;
-	sk->sk_destruct = &l2tp_tunnel_destruct;
-	lockdep_set_class_and_name(&sk->sk_lock.slock, &l2tp_socket_class, "l2tp_sock");
-
-	sk->sk_allocation = GFP_ATOMIC;
-
 	/* Init delete workqueue struct */
 	INIT_WORK(&tunnel->del_work, l2tp_tunnel_del_work);
 
-	/* Add tunnel to our list */
 	INIT_LIST_HEAD(&tunnel->list);
-	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
-	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
-	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
 
 	err = 0;
 err:
 	if (tunnelp)
 		*tunnelp = tunnel;
 
-	/* If tunnel's socket was created by the kernel, it doesn't
-	 *  have a file.
-	 */
-	if (sock && sock->file)
-		sockfd_put(sock);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_create);
 
+static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
+				enum l2tp_encap_type encap)
+{
+	if (!net_eq(sock_net(sk), net))
+		return -EINVAL;
+
+	if (sk->sk_type != SOCK_DGRAM)
+		return -EPROTONOSUPPORT;
+
+	if ((encap == L2TP_ENCAPTYPE_UDP && sk->sk_protocol != IPPROTO_UDP) ||
+	    (encap == L2TP_ENCAPTYPE_IP && sk->sk_protocol != IPPROTO_L2TP))
+		return -EPROTONOSUPPORT;
+
+	if (sk->sk_user_data)
+		return -EBUSY;
+
+	return 0;
+}
+
+int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
+			 struct l2tp_tunnel_cfg *cfg)
+{
+	struct l2tp_net *pn;
+	struct socket *sock;
+	struct sock *sk;
+	int ret;
+
+	if (tunnel->fd < 0) {
+		ret = l2tp_tunnel_sock_create(net, tunnel->tunnel_id,
+					      tunnel->peer_tunnel_id, cfg,
+					      &sock);
+		if (ret < 0)
+			goto err;
+	} else {
+		sock = sockfd_lookup(tunnel->fd, &ret);
+		if (!sock)
+			goto err;
+
+		ret = l2tp_validate_socket(sock->sk, net, tunnel->encap);
+		if (ret < 0)
+			goto err_sock;
+	}
+
+	sk = sock->sk;
+
+	sock_hold(sk);
+	tunnel->sock = sk;
+	tunnel->l2tp_net = net;
+
+	pn = l2tp_pernet(net);
+	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
+	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
+	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+
+	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
+		struct udp_tunnel_sock_cfg udp_cfg = {
+			.sk_user_data = tunnel,
+			.encap_type = UDP_ENCAP_L2TPINUDP,
+			.encap_rcv = l2tp_udp_encap_recv,
+			.encap_destroy = l2tp_udp_encap_destroy,
+		};
+
+		setup_udp_tunnel_sock(net, sock, &udp_cfg);
+	} else {
+		sk->sk_user_data = tunnel;
+	}
+
+	tunnel->old_sk_destruct = sk->sk_destruct;
+	sk->sk_destruct = &l2tp_tunnel_destruct;
+	lockdep_set_class_and_name(&sk->sk_lock.slock, &l2tp_socket_class,
+				   "l2tp_sock");
+	sk->sk_allocation = GFP_ATOMIC;
+
+	if (tunnel->fd >= 0)
+		sockfd_put(sock);
+
+	return 0;
+
+err_sock:
+	sockfd_put(sock);
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(l2tp_tunnel_register);
+
 /* This function is used by the netlink TUNNEL_DELETE command.
  */
 void l2tp_tunnel_delete(struct l2tp_tunnel *tunnel)
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -226,6 +226,9 @@ struct l2tp_tunnel *l2tp_tunnel_find_nth
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
 		       u32 peer_tunnel_id, struct l2tp_tunnel_cfg *cfg,
 		       struct l2tp_tunnel **tunnelp);
+int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
+			 struct l2tp_tunnel_cfg *cfg);
+
 void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel);
 void l2tp_tunnel_delete(struct l2tp_tunnel *tunnel);
 struct l2tp_session *l2tp_session_create(int priv_size,
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -251,9 +251,19 @@ static int l2tp_nl_cmd_tunnel_create(str
 		break;
 	}
 
-	if (ret >= 0)
-		ret = l2tp_tunnel_notify(&l2tp_nl_family, info,
-					 tunnel, L2TP_CMD_TUNNEL_CREATE);
+	if (ret < 0)
+		goto out;
+
+	l2tp_tunnel_inc_refcount(tunnel);
+	ret = l2tp_tunnel_register(tunnel, net, &cfg);
+	if (ret < 0) {
+		kfree(tunnel);
+		goto out;
+	}
+	ret = l2tp_tunnel_notify(&l2tp_nl_family, info, tunnel,
+				 L2TP_CMD_TUNNEL_CREATE);
+	l2tp_tunnel_dec_refcount(tunnel);
+
 out:
 	return ret;
 }
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -698,6 +698,15 @@ static int pppol2tp_connect(struct socke
 			error = l2tp_tunnel_create(sock_net(sk), fd, ver, tunnel_id, peer_tunnel_id, &tcfg, &tunnel);
 			if (error < 0)
 				goto end;
+
+			l2tp_tunnel_inc_refcount(tunnel);
+			error = l2tp_tunnel_register(tunnel, sock_net(sk),
+						     &tcfg);
+			if (error < 0) {
+				kfree(tunnel);
+				goto end;
+			}
+			drop_tunnel = true;
 		}
 	} else {
 		/* Error if we can't find the tunnel */
