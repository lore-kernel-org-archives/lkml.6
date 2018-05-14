Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo1YlOujERExNodnru/bAXgqM99Ydcohv0qUcbQm6VkBp5q+e4hX2jnkuk6hmWFrMdhqZMy
ARC-Seal: i=1; a=rsa-sha256; t=1526281145; cv=none;
        d=google.com; s=arc-20160816;
        b=o2tioIR3iGr2EbBTLLFdDOBOlRGD/Uw1Mp+8/Clkvxdl5gfzwliNRaZvPnKuDPl6iU
         6egAmbPIF4NVNlfqOz1XSncZxyX8hRZQ7NIyRTrgrsGCN5v1nSdxmkX4SmXK9I7k8dxR
         FSoL679PSCCn9bdRST0ME7Tdyx1oBtxyRMj0IvuaAkzgFUBAJm68KigS4TOvCKUa30pg
         +Hj2wgx3bDsNasKSEyPQKX1g8fQE5CcUefCQAM9SRkbrQEipmAOI3O9KxZ9kAil+Uqq9
         muCE3zj2CaKXU3Z+NhQ9jsp7sOxR445iIB8jCp3LHZJye00sX8D+elOZmfOBr2ONYaCD
         BJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ixyc5Yy042tYvBJJ6gigePMd0XHcGFKi2jnrHkETjMU=;
        b=HfxN37oWNzc8nil4+2XCPSxXJajGlyw4cNCgoWw1gIc6xP+O40i7jENUM3fCGlObIj
         T5/3/l7FNxU0PhBI9Kss+X3yiRyxmtLAlL6WnTJF0JXLPDgAlTPw0ZOdGCA15ZB4o1vY
         Eb1JbPvbZK0XoXCZXLCp42yFPjeeo3EZCcfhvfYLrSsuV1Jlenj2JwwC/YwN5DwMCEIB
         WHYMIvRAnU7h06/w9u4YPv0ljZqVkFDF5uh/Y1vSkulVk+TQlfBEf7mIahIXtZkA0tgW
         b+3ysMeiOkOSxvhrAANgSGc2K9dfZa3agDfZFDPCFgCxVwMqKA2hhzS1ecY0lKf34xWq
         rBIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ORHnUwNO;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ORHnUwNO;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+c68e51bb5e699d3f8d91@syzkaller.appspotmail.com,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 05/72] rds: tcp: must use spin_lock_irq* and not spin_lock_bh with rds_tcp_conn_lock
Date: Mon, 14 May 2018 08:48:22 +0200
Message-Id: <20180514064823.266716354@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421778486757524?=
X-GMAIL-MSGID: =?utf-8?q?1600421778486757524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

commit 53d0e83f9329aa51dcc205b514dbee05cb4df309 upstream.

rds_tcp_connection allocation/free management has the potential to be
called from __rds_conn_create after IRQs have been disabled, so
spin_[un]lock_bh cannot be used with rds_tcp_conn_lock.

Bottom-halves that need to synchronize for critical sections protected
by rds_tcp_conn_lock should instead use rds_destroy_pending() correctly.

Reported-by: syzbot+c68e51bb5e699d3f8d91@syzkaller.appspotmail.com
Fixes: ebeeb1ad9b8a ("rds: tcp: use rds_destroy_pending() to synchronize
       netns/module teardown and rds connection/workq management")
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/tcp.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -275,13 +275,14 @@ static int rds_tcp_laddr_check(struct ne
 static void rds_tcp_conn_free(void *arg)
 {
 	struct rds_tcp_connection *tc = arg;
+	unsigned long flags;
 
 	rdsdebug("freeing tc %p\n", tc);
 
-	spin_lock_bh(&rds_tcp_conn_lock);
+	spin_lock_irqsave(&rds_tcp_conn_lock, flags);
 	if (!tc->t_tcp_node_detached)
 		list_del(&tc->t_tcp_node);
-	spin_unlock_bh(&rds_tcp_conn_lock);
+	spin_unlock_irqrestore(&rds_tcp_conn_lock, flags);
 
 	kmem_cache_free(rds_tcp_conn_slab, tc);
 }
@@ -311,13 +312,13 @@ static int rds_tcp_conn_alloc(struct rds
 		rdsdebug("rds_conn_path [%d] tc %p\n", i,
 			 conn->c_path[i].cp_transport_data);
 	}
-	spin_lock_bh(&rds_tcp_conn_lock);
+	spin_lock_irq(&rds_tcp_conn_lock);
 	for (i = 0; i < RDS_MPATH_WORKERS; i++) {
 		tc = conn->c_path[i].cp_transport_data;
 		tc->t_tcp_node_detached = false;
 		list_add_tail(&tc->t_tcp_node, &rds_tcp_conn_list);
 	}
-	spin_unlock_bh(&rds_tcp_conn_lock);
+	spin_unlock_irq(&rds_tcp_conn_lock);
 fail:
 	if (ret) {
 		for (j = 0; j < i; j++)
@@ -529,7 +530,7 @@ static void rds_tcp_kill_sock(struct net
 
 	rtn->rds_tcp_listen_sock = NULL;
 	rds_tcp_listen_stop(lsock, &rtn->rds_tcp_accept_w);
-	spin_lock_bh(&rds_tcp_conn_lock);
+	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
 		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
 
@@ -542,7 +543,7 @@ static void rds_tcp_kill_sock(struct net
 			tc->t_tcp_node_detached = true;
 		}
 	}
-	spin_unlock_bh(&rds_tcp_conn_lock);
+	spin_unlock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &tmp_list, t_tcp_node)
 		rds_conn_destroy(tc->t_cpath->cp_conn);
 }
@@ -590,7 +591,7 @@ static void rds_tcp_sysctl_reset(struct
 {
 	struct rds_tcp_connection *tc, *_tc;
 
-	spin_lock_bh(&rds_tcp_conn_lock);
+	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
 		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
 
@@ -600,7 +601,7 @@ static void rds_tcp_sysctl_reset(struct
 		/* reconnect with new parameters */
 		rds_conn_path_drop(tc->t_cpath, false);
 	}
-	spin_unlock_bh(&rds_tcp_conn_lock);
+	spin_unlock_irq(&rds_tcp_conn_lock);
 }
 
 static int rds_tcp_skbuf_handler(struct ctl_table *ctl, int write,
