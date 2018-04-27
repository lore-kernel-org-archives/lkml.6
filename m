Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp0ArU8ut9USHUMdb+qNZM92qX50GMapBg5FZ/aZDaKw0n7xCK2EuMX4Aw3iSR5e66vnQf9
ARC-Seal: i=1; a=rsa-sha256; t=1524838354; cv=none;
        d=google.com; s=arc-20160816;
        b=Zd+vENBaXdxS+dS27sv7k80pbIi9jDXjXATubB2SMC8hg5iCgM7mIe4S6d1Hm0IwTH
         WtbDvpMzavwUw3BnujIdoV0yPWjXZCB1ma48cwW7hUNqGZLGIdLPfkDfMpTKp/zpoQqd
         scz2mMnjGHLHJ2uwS7WA4qhF91AYB6w5CBX+jjWxN/uApT+EhJk2AUNK6HoF3/w8iLJz
         2hAwES+zL3CDmY15X8+lQNSA2zdREl1GNeuiMQ/zPDC+IyQ/TgIdfNQcTaShuxsoU2+o
         co3qAoIhzyp7WXKUGBvcXATwaVjfZz0PtAzkjUZq3ENFoH515qUH70vAv4Mr/L1dYkXM
         Ks9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=P/6hFPj0kzIN7kVOgPz376n9hpal8sy9wcmxcnivhzc=;
        b=FJPZyZ18urcOwquAXi5/oEUeUiioj2if+F+QX0SxlxCShe9/Zrw5UoE3I5TMx1unPm
         qYfrLYyxUqRegDcc0hV68CoACuswax2l6Mzt8YVjjt5SfrRnJdzWO5yqrZnwgoqv/SpG
         sckAQ/k7C0fAABp1GD6+Z6HYUne0yYPphS5/PYvO5LuV3tiMuztvwK/xejviD1x1lxRx
         JNwTJas+GPPw4sxwnmrrNKNiUmC8jFOJ6PVGDWqtrDDVt/aUC381+ZFyDhLm4823jHkP
         eTBOeWxXNXw5fe8Xdgq0ykGJkP5cTBqucqPeE9OlonyELBxqVMJBlQl/14eGOqvedmJ5
         zauQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98F721895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 41/81] l2tp: hold reference on tunnels in netlink dumps
Date: Fri, 27 Apr 2018 15:58:43 +0200
Message-Id: <20180427135745.475083315@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908902820698317?=
X-GMAIL-MSGID: =?utf-8?q?1598908902820698317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 5846c131c39b6d0add36ec19dc8650700690f930 ]

l2tp_tunnel_find_nth() is unsafe: no reference is held on the returned
tunnel, therefore it can be freed whenever the caller uses it.
This patch defines l2tp_tunnel_get_nth() which works similarly, but
also takes a reference on the returned tunnel. The caller then has to
drop it after it stops using the tunnel.

Convert netlink dumps to make them safe against concurrent tunnel
deletion.

Fixes: 309795f4bec2 ("l2tp: Add netlink control API for L2TP")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c    |   20 ++++++++++++++++++++
 net/l2tp/l2tp_core.h    |    2 ++
 net/l2tp/l2tp_netlink.c |   11 ++++++++---
 3 files changed, 30 insertions(+), 3 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -183,6 +183,26 @@ struct l2tp_tunnel *l2tp_tunnel_get(cons
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get);
 
+struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
+{
+	const struct l2tp_net *pn = l2tp_pernet(net);
+	struct l2tp_tunnel *tunnel;
+	int count = 0;
+
+	rcu_read_lock_bh();
+	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
+		if (++count > nth) {
+			l2tp_tunnel_inc_refcount(tunnel);
+			rcu_read_unlock_bh();
+			return tunnel;
+		}
+	}
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
+
 /* Lookup a session. A new reference is held on the returned session. */
 struct l2tp_session *l2tp_session_get(const struct net *net,
 				      struct l2tp_tunnel *tunnel,
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -212,6 +212,8 @@ static inline void *l2tp_session_priv(st
 }
 
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
+struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
+
 void l2tp_tunnel_free(struct l2tp_tunnel *tunnel);
 
 struct l2tp_session *l2tp_session_get(const struct net *net,
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -487,14 +487,17 @@ static int l2tp_nl_cmd_tunnel_dump(struc
 	struct net *net = sock_net(skb->sk);
 
 	for (;;) {
-		tunnel = l2tp_tunnel_find_nth(net, ti);
+		tunnel = l2tp_tunnel_get_nth(net, ti);
 		if (tunnel == NULL)
 			goto out;
 
 		if (l2tp_nl_tunnel_send(skb, NETLINK_CB(cb->skb).portid,
 					cb->nlh->nlmsg_seq, NLM_F_MULTI,
-					tunnel, L2TP_CMD_TUNNEL_GET) < 0)
+					tunnel, L2TP_CMD_TUNNEL_GET) < 0) {
+			l2tp_tunnel_dec_refcount(tunnel);
 			goto out;
+		}
+		l2tp_tunnel_dec_refcount(tunnel);
 
 		ti++;
 	}
@@ -848,7 +851,7 @@ static int l2tp_nl_cmd_session_dump(stru
 
 	for (;;) {
 		if (tunnel == NULL) {
-			tunnel = l2tp_tunnel_find_nth(net, ti);
+			tunnel = l2tp_tunnel_get_nth(net, ti);
 			if (tunnel == NULL)
 				goto out;
 		}
@@ -856,6 +859,7 @@ static int l2tp_nl_cmd_session_dump(stru
 		session = l2tp_session_get_nth(tunnel, si);
 		if (session == NULL) {
 			ti++;
+			l2tp_tunnel_dec_refcount(tunnel);
 			tunnel = NULL;
 			si = 0;
 			continue;
@@ -865,6 +869,7 @@ static int l2tp_nl_cmd_session_dump(stru
 					 cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					 session, L2TP_CMD_SESSION_GET) < 0) {
 			l2tp_session_dec_refcount(session);
+			l2tp_tunnel_dec_refcount(tunnel);
 			break;
 		}
 		l2tp_session_dec_refcount(session);
