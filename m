Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411976-5-7882803175653638090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411975; b=B4mPIyJtqokStFrkLv6HohNQ36LBGBBgIlPF7mrsZfKREZg
    d7IlUdR/wQeOOZ8sxR9RoJovUUfQhPMoaizrc30/JxNbRL/OuH1y2TsFGvzj0KeZ
    XkzWd5XDxJl5sQF4Q1Vdnbr1M5Yk5CZrQS+CtsBCF5dyezrPyN7c5vIPH6/AkAEQ
    DxA8+nd26jaH7qEUdp6xx+x5PWCadIcjSwZsNcSKA0wtrI356ren1538u3crZc1N
    PyMtt+omFIf+PDtHX85gmkhmL2kDjCUlkd49xrGsJEx7KaIqxvZVXfP86+Onst5F
    CdOHtt+LOf7zwsAELCHAiH47ZhSM7Vx3m995U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411975; bh=n1LUAFRYCKZbkI0t5a4oarteUR
    2PwoKz16VjAg63npY=; b=u90/LLcNeT3FFI14gz/pPD2GrPhI3qmTGxrmOFU4n/
    4MyKlNMWAx6Acy6g28WmIbEdzRFDc1qjW19CAoh4aCCFLHEDo8bIyQR6T2FuKqAQ
    OhcxhEHCGkWUx6v4TpJ+5nI97/USSeZuPW71qWIyx6hFzIB6lBD1we0pZKXZBuXa
    NlXdvKzxPdOoR+U+XlQzXunTszOgqVrreJEK5PbjfpVsZFK+Ups01a5VBK62Dari
    ZI/Jc8L+cHfYVgUskslgcMzaVJNI71nR4vZd/TsGpw2+hOD+Jkf4ZjF7g2rCYQeQ
    /kygnNeWzeJWRu0QDS0E4Z0ytoX3spUsCiuNJh9XK5Pw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935223AbeBWSwv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935204AbeBWSwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 041/159] rds: tcp: correctly sequence cleanup on netns deletion.
Date: Fri, 23 Feb 2018 19:25:49 +0100
Message-Id: <20180223170748.406395347@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

commit 681648e67d43cf269c5590ecf021ed481f4551fc upstream.

Commit 8edc3affc077 ("rds: tcp: Take explicit refcounts on struct net")
introduces a regression in rds-tcp netns cleanup. The cleanup_net(),
(and thus rds_tcp_dev_event notification) is only called from put_net()
when all netns refcounts go to 0, but this cannot happen if the
rds_connection itself is holding a c_net ref that it expects to
release in rds_tcp_kill_sock.

Instead, the rds_tcp_kill_sock callback should make sure to
tear down state carefully, ensuring that the socket teardown
is only done after all data-structures and workqs that depend
on it are quiesced.

The original motivation for commit 8edc3affc077 ("rds: tcp: Take explicit
refcounts on struct net") was to resolve a race condition reported by
syzkaller where workqs for tx/rx/connect were triggered after the
namespace was deleted. Those worker threads should have been
cancelled/flushed before socket tear-down and indeed,
rds_conn_path_destroy() does try to sequence this by doing
     /* cancel cp_send_w */
     /* cancel cp_recv_w */
     /* flush cp_down_w */
     /* free data structures */
Here the "flush cp_down_w" will trigger rds_conn_shutdown and thus
invoke rds_tcp_conn_path_shutdown() to close the tcp socket, so that
we ought to have satisfied the requirement that "socket-close is
done after all other dependent state is quiesced". However,
rds_conn_shutdown has a bug in that it *always* triggers the reconnect
workq (and if connection is successful, we always restart tx/rx
workqs so with the right timing, we risk the race conditions reported
by syzkaller).

Netns deletion is like module teardown- no need to restart a
reconnect in this case. We can use the c_destroy_in_prog bit
to avoid restarting the reconnect.

Fixes: 8edc3affc077 ("rds: tcp: Take explicit refcounts on struct net")
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/connection.c |    3 ++-
 net/rds/rds.h        |    6 +++---
 net/rds/tcp.c        |    4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -366,6 +366,8 @@ void rds_conn_shutdown(struct rds_conn_p
 	 * to the conn hash, so we never trigger a reconnect on this
 	 * conn - the reconnect is always triggered by the active peer. */
 	cancel_delayed_work_sync(&cp->cp_conn_w);
+	if (conn->c_destroy_in_prog)
+		return;
 	rcu_read_lock();
 	if (!hlist_unhashed(&conn->c_hash_node)) {
 		rcu_read_unlock();
@@ -445,7 +447,6 @@ void rds_conn_destroy(struct rds_connect
 	 */
 	rds_cong_remove_conn(conn);
 
-	put_net(conn->c_net);
 	kfree(conn->c_path);
 	kmem_cache_free(rds_conn_slab, conn);
 
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -150,7 +150,7 @@ struct rds_connection {
 
 	/* Protocol version */
 	unsigned int		c_version;
-	struct net		*c_net;
+	possible_net_t		c_net;
 
 	struct list_head	c_map_item;
 	unsigned long		c_map_queued;
@@ -165,13 +165,13 @@ struct rds_connection {
 static inline
 struct net *rds_conn_net(struct rds_connection *conn)
 {
-	return conn->c_net;
+	return read_pnet(&conn->c_net);
 }
 
 static inline
 void rds_conn_net_set(struct rds_connection *conn, struct net *net)
 {
-	conn->c_net = get_net(net);
+	write_pnet(&conn->c_net, net);
 }
 
 #define RDS_FLAG_CONG_BITMAP	0x01
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -527,7 +527,7 @@ static void rds_tcp_kill_sock(struct net
 	rds_tcp_listen_stop(lsock, &rtn->rds_tcp_accept_w);
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
-		struct net *c_net = tc->t_cpath->cp_conn->c_net;
+		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
 
 		if (net != c_net || !tc->t_sock)
 			continue;
@@ -586,7 +586,7 @@ static void rds_tcp_sysctl_reset(struct
 
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
-		struct net *c_net = tc->t_cpath->cp_conn->c_net;
+		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
 
 		if (net != c_net || !tc->t_sock)
 			continue;
