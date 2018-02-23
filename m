Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224p/QG2rs+1EG5gOTljwNsU4Y8PD5Mj1Nvatket3IUlkcnVsODeXPNFOOcrDr2ypYjKPpdk
ARC-Seal: i=1; a=rsa-sha256; t=1519412256; cv=none;
        d=google.com; s=arc-20160816;
        b=Q4cSoeex3wp3RpdwIcCsnmdmMVtP9rSv61EhVDYgtYaMVq8JpgrX7zwRjrlyokq/Vu
         7JroZ6ryQL4hZBvuUSZkqxqsddECERL4ngLSM1QkhmBqfY4CKSAs5L+rhuR8iKDfaUEt
         29GEkvamuSqjfaM6OZP0mYE0uN2mkumgZuNT/Ur0G4E8YF6EJ0kEF5aZR+X/5mRAWLa0
         Nj1K4bpiFC9TdgoK3LQNp9bF0/W/oa2x3BTFM5qvqYuM/HvffrfUoo51LgLyiBbNoX1v
         Sg1uWdHYPesbVdZDEjrNmVFefAMzipNmrHsw8BwnvIoODNUu/PUlVgGYe964NKH5TFu/
         GWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jvqJmPSUTxYNrxWK2M5u5DXBCv4zGwOJkNeN9WaUaMg=;
        b=iRbEVXjVokue3ih9is7i91RC8zQVY7mKjwVYVPVPlHAN1gXd8lGcSUSC45DxNT9a3E
         Fg2zoBjiKBxi7rpiP0w4HeYKTZH8fsvDQfcY2aeW6CLnkE2UaAPyGrFNarbW+iUNJrxS
         irCAer5oQgzXSNNQoesEekaszrG1IUbwpMsU5PyUSx3RZ2lpJWwxYs4ABXUPPRo+MXRZ
         03oQdu729fUq9KSFjKwqZGpWyV4s3jm+GBRZZwyRJDs2CKlBwzh7dt/919yjmqp5cvvU
         vgB6hrjBp95o96t52aqV7thfdQbGJlJLzgCWzSv41q4Qp4iZ9i9lXGtFVoaKbaf83s24
         5M6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 19/45] rds: tcp: correctly sequence cleanup on netns deletion.
Date: Fri, 23 Feb 2018 19:28:58 +0100
Message-Id: <20180223170718.380458441@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218922684144246?=
X-GMAIL-MSGID: =?utf-8?q?1593219225771951955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -528,7 +528,7 @@ static void rds_tcp_kill_sock(struct net
 	rds_tcp_listen_stop(lsock, &rtn->rds_tcp_accept_w);
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
-		struct net *c_net = tc->t_cpath->cp_conn->c_net;
+		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
 
 		if (net != c_net || !tc->t_sock)
 			continue;
@@ -587,7 +587,7 @@ static void rds_tcp_sysctl_reset(struct
 
 	spin_lock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &rds_tcp_conn_list, t_tcp_node) {
-		struct net *c_net = tc->t_cpath->cp_conn->c_net;
+		struct net *c_net = read_pnet(&tc->t_cpath->cp_conn->c_net);
 
 		if (net != c_net || !tc->t_sock)
 			continue;
