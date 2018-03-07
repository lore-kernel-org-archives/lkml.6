Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtSocSfp2fVxTp0af+SkjvP5JCTxSoOhSfMIVPGkEEnfC2UvOmvhZ1oeYsEyeSkA8YW3oSp
ARC-Seal: i=1; a=rsa-sha256; t=1520451835; cv=none;
        d=google.com; s=arc-20160816;
        b=RSfKohQJO5bu2CWItje6hcZwvrKMSB6YS1Jfzhg6tUw55UfKBsP8xzcJ21QeDOzTIP
         Nky1Qwqs/7OapFcHep3PLe13udoxgaC5zkvQfTmw1GlnKDv2Xaxji7PtumunhA4wEW+M
         bezGKEycpv5hyJEFjxQiz8X9U2Q2t6ulopT97ktIYhYGDvcTN9ZilZayETk32ceqwAhv
         XDbkiQvIYVtGxALfBhLj1YsYY50IKH9lKSGABLIYBQaUyRYkMIzcRpcoJS7dBGfnBY4s
         KkQiIqRdi0Pgilwi9gD6oPwXmy0jn13fN+EcJEWRVTclZe3YUtfNtWcCuNA3PnFJbAgY
         +o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yPMh4EmjQ3JR3poFTomY+NqCmUjforj2KeOjFeJyjJs=;
        b=h1PY9RZ8VeAIpKqqVdOLGkNIZyOJPL5RsefNslk7lDLViz5Ivq4P/JZ1T/4/U/HYnR
         LkFjNqdKefOz5z5krr7o3EyO2xrk3yyA3+P2EkXwFgNGQ1/sLRvdp37Cp7InVmdeUypU
         JUkq9yu26pmYk7NmCsQlXlYlDdrf+0iAbhIBCjFFSZCOoj/vqDCP8UXYLFk/vAYg7Egl
         sVef0vImjgJ6qjpLaQJcngu5x7TZNAA3zJiWql688PgnDhIWGQvZLXNjBz4+77P8PHAT
         Nfx+LXivgjrIxQWG1wqwi5N9qIjR4VGi8d3UgAvx5ODGRIs6MAaTgLQIhqW7ipbNYly1
         hRQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Pismenny <borisp@mellanox.com>,
	Ilya Lesokhin <ilyal@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 070/122] tls: Use correct sk->sk_prot for IPV6
Date: Wed,  7 Mar 2018 11:38:02 -0800
Message-Id: <20180307191739.488275683@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309303852952237?=
X-GMAIL-MSGID: =?utf-8?q?1594309303852952237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Pismenny <borisp@mellanox.com>


[ Upstream commit c113187d38ff85dc302a1bb55864b203ebb2ba10 ]

The tls ulp overrides sk->prot with a new tls specific proto structs.
The tls specific structs were previously based on the ipv4 specific
tcp_prot sturct.
As a result, attaching the tls ulp to an ipv6 tcp socket replaced
some ipv6 callback with the ipv4 equivalents.

This patch adds ipv6 tls proto structs and uses them when
attached to ipv6 sockets.

Fixes: 3c4d7559159b ('tls: kernel TLS support')
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |   52 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -46,16 +46,26 @@ MODULE_DESCRIPTION("Transport Layer Secu
 MODULE_LICENSE("Dual BSD/GPL");
 
 enum {
+	TLSV4,
+	TLSV6,
+	TLS_NUM_PROTS,
+};
+
+enum {
 	TLS_BASE_TX,
 	TLS_SW_TX,
 	TLS_NUM_CONFIG,
 };
 
-static struct proto tls_prots[TLS_NUM_CONFIG];
+static struct proto *saved_tcpv6_prot;
+static DEFINE_MUTEX(tcpv6_prot_mutex);
+static struct proto tls_prots[TLS_NUM_PROTS][TLS_NUM_CONFIG];
 
 static inline void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
-	sk->sk_prot = &tls_prots[ctx->tx_conf];
+	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
+
+	sk->sk_prot = &tls_prots[ip_ver][ctx->tx_conf];
 }
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
@@ -450,8 +460,21 @@ static int tls_setsockopt(struct sock *s
 	return do_tls_setsockopt(sk, optname, optval, optlen);
 }
 
+static void build_protos(struct proto *prot, struct proto *base)
+{
+	prot[TLS_BASE_TX] = *base;
+	prot[TLS_BASE_TX].setsockopt	= tls_setsockopt;
+	prot[TLS_BASE_TX].getsockopt	= tls_getsockopt;
+	prot[TLS_BASE_TX].close		= tls_sk_proto_close;
+
+	prot[TLS_SW_TX] = prot[TLS_BASE_TX];
+	prot[TLS_SW_TX].sendmsg		= tls_sw_sendmsg;
+	prot[TLS_SW_TX].sendpage	= tls_sw_sendpage;
+}
+
 static int tls_init(struct sock *sk)
 {
+	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
 	int rc = 0;
@@ -476,6 +499,17 @@ static int tls_init(struct sock *sk)
 	ctx->getsockopt = sk->sk_prot->getsockopt;
 	ctx->sk_proto_close = sk->sk_prot->close;
 
+	/* Build IPv6 TLS whenever the address of tcpv6_prot changes */
+	if (ip_ver == TLSV6 &&
+	    unlikely(sk->sk_prot != smp_load_acquire(&saved_tcpv6_prot))) {
+		mutex_lock(&tcpv6_prot_mutex);
+		if (likely(sk->sk_prot != saved_tcpv6_prot)) {
+			build_protos(tls_prots[TLSV6], sk->sk_prot);
+			smp_store_release(&saved_tcpv6_prot, sk->sk_prot);
+		}
+		mutex_unlock(&tcpv6_prot_mutex);
+	}
+
 	ctx->tx_conf = TLS_BASE_TX;
 	update_sk_prot(sk, ctx);
 out:
@@ -488,21 +522,9 @@ static struct tcp_ulp_ops tcp_tls_ulp_op
 	.init			= tls_init,
 };
 
-static void build_protos(struct proto *prot, struct proto *base)
-{
-	prot[TLS_BASE_TX] = *base;
-	prot[TLS_BASE_TX].setsockopt	= tls_setsockopt;
-	prot[TLS_BASE_TX].getsockopt	= tls_getsockopt;
-	prot[TLS_BASE_TX].close		= tls_sk_proto_close;
-
-	prot[TLS_SW_TX] = prot[TLS_BASE_TX];
-	prot[TLS_SW_TX].sendmsg		= tls_sw_sendmsg;
-	prot[TLS_SW_TX].sendpage	= tls_sw_sendpage;
-}
-
 static int __init tls_register(void)
 {
-	build_protos(tls_prots, &tcp_prot);
+	build_protos(tls_prots[TLSV4], &tcp_prot);
 
 	tcp_register_ulp(&tcp_tls_ulp_ops);
 
