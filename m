Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416129-2-385391407760580746
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
    t=1519416128; b=BTDAPa3lySiJRCLV8OaaM1oDeQFDBDSWKbExIcjghheP3qh
    hAgiL/tHYV+yNz0GfqQ2HwV783zDs+k2IoYiOxgUm4pRVjAH2PRgArCbeW/7/N4r
    GKwHM6caMJwXCj+fTSkvrM/+5zrooMEqOc7vgZyFfAaorXGAjdX/LnZInP8EOGGT
    VZpLp8ZuU5ewp/WaVLbP0LCyVUsFfdtxRkAtiwAdVCv5Bv7SjV8mfTz7izOblfBz
    yfPWoL/w2AfgdOSxQ80qQ5aIRc8RvsG0HCCoxdNjTFgYSHgvacZo/wdbqSLTuwAO
    zU3GX7EIIu2v8Yx/Xh+WLPfJXJjzjed4KrCNWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416128; bh=dxMl/DhNSjKxGi99DJixwgN/Zc
    1K+CIiBEJSrsgE0E4=; b=qMbaj2pUy6+gLW81BxHLTc/RZt6NM+fYfIEjpPNIY0
    XPpPl+2m0bcCXIRKcTlrQic1krzDuYiyKZA5X/EjR7LdykoyNZC7O6/X63uV55wI
    ProkTWf9w+dRi35Z6Mt/OAG3UGO2nJOD8IWwfwMT8wcuAWnnAuN1f1moeMBF2iqT
    u/b8p+coZAKQVzPD6yaIANL0GxMyGN4oi+HKyCxq/xWmk+7WpkDLpidewzIUU1n0
    tb3WabOfE3xhPZSda1d4DbJ2jPFqGdbiXWovPe6Yfc+mBOjJoi2v75QRkP7B6K1J
    Awykscge5bHXDXW6ajNW/9/K5PyWoqh/zSA4+J5ctmaA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbeBWUBt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:01:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933245AbeBWSnQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 028/145] rds: tcp: atomically purge entries from rds_tcp_conn_list during netns delete
Date: Fri, 23 Feb 2018 19:25:34 +0100
Message-Id: <20180223170728.477640744@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

commit f10b4cff98c6977668434fbf5dd58695eeca2897 upstream.

The rds_tcp_kill_sock() function parses the rds_tcp_conn_list
to find the rds_connection entries marked for deletion as part
of the netns deletion under the protection of the rds_tcp_conn_lock.
Since the rds_tcp_conn_list tracks rds_tcp_connections (which
have a 1:1 mapping with rds_conn_path), multiple tc entries in
the rds_tcp_conn_list will map to a single rds_connection, and will
be deleted as part of the rds_conn_destroy() operation that is
done outside the rds_tcp_conn_lock.

The rds_tcp_conn_list traversal done under the protection of
rds_tcp_conn_lock should not leave any doomed tc entries in
the list after the rds_tcp_conn_lock is released, else another
concurrently executiong netns delete (for a differnt netns) thread
may trip on these entries.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/tcp.c |    9 +++++++--
 net/rds/tcp.h |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -303,7 +303,8 @@ static void rds_tcp_conn_free(void *arg)
 	rdsdebug("freeing tc %p\n", tc);
 
 	spin_lock_irqsave(&rds_tcp_conn_lock, flags);
-	list_del(&tc->t_tcp_node);
+	if (!tc->t_tcp_node_detached)
+		list_del(&tc->t_tcp_node);
 	spin_unlock_irqrestore(&rds_tcp_conn_lock, flags);
 
 	kmem_cache_free(rds_tcp_conn_slab, tc);
@@ -528,8 +529,12 @@ static void rds_tcp_kill_sock(struct net
 
 		if (net != c_net || !tc->t_sock)
 			continue;
-		if (!list_has_conn(&tmp_list, tc->t_cpath->cp_conn))
+		if (!list_has_conn(&tmp_list, tc->t_cpath->cp_conn)) {
 			list_move_tail(&tc->t_tcp_node, &tmp_list);
+		} else {
+			list_del(&tc->t_tcp_node);
+			tc->t_tcp_node_detached = true;
+		}
 	}
 	spin_unlock_irq(&rds_tcp_conn_lock);
 	list_for_each_entry_safe(tc, _tc, &tmp_list, t_tcp_node) {
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -11,6 +11,7 @@ struct rds_tcp_incoming {
 struct rds_tcp_connection {
 
 	struct list_head	t_tcp_node;
+	bool			t_tcp_node_detached;
 	struct rds_conn_path	*t_cpath;
 	/* t_conn_path_lock synchronizes the connection establishment between
 	 * rds_tcp_accept_one and rds_tcp_conn_path_connect
