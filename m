Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ORrzirWoYRpZThtJ+VbuXwMh8C0TR+O7tYhlGDzAtktBVa9oj5EKtwdg3Bc1wC9iCw23b
ARC-Seal: i=1; a=rsa-sha256; t=1523980851; cv=none;
        d=google.com; s=arc-20160816;
        b=oCMn89DBswtC+KVllHNs+cU8SXgxVr9FA6AiUZOutua1i5Dr5LBMNj6AGuNch9I+I2
         BdiVwHCuP8+tQlGVEpuHdv7f2quA6oUiIpXCckMcRVZxfbJvkIrJ8neUUXwPVsE534FN
         IGXTRwed+/EwiNnL9GGNRh2vmrNy8zmCIPFOOD+q78cnq8LjYD/CwfjRl70S8COeCT2I
         ir4YkwZe0QQzt1lIwD6I9EmOBD+1ZWOHq5Lw4bhaTRf6kL+EXn53COy0NyjbcRjdQZtk
         MyLiI7wEYSFA4E/1OpQcqOmuVsUcRuK/fnjHogbO7z3+v+mIEs1nBbs25ofz16/dHo6A
         qiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=texO1TTFz/gFTDtlZboWciZgh/DfQidOetvKISwQIDs=;
        b=ZnXLzgoSZy5MFJSUjZzdEy8frrOnWMu2eXvOTgcWdgaQJ4+j9CzjRBNTIdwXQQVUsF
         dscalKmEx4mFp713y0Csf+v9i5UuzYt/3xOOxOSvIUWn6MZ2/N2oKWgKLguWd74hMIRf
         /sV0Uue339280Za4XBKlXeFODn2qtKlc3DEK5h/nOPJ4N/1rxwj0YLB3hAX8mIfPHDSN
         HJdh0mWoRSh6dBpxPErpQMYjFKUj2sHsEf56PcDEfnObxQ9xRDjAEJe+kluuAAY2uyZ+
         pk7KRa2edkIuzH/Jk6LgKZxKDS/ubGrvYXU6os5rRBSs9OQNyS0R7OuoGEEkHiTgWZMD
         odbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 06/68] l2tp: fix race in duplicate tunnel detection
Date: Tue, 17 Apr 2018 17:57:19 +0200
Message-Id: <20180417155749.597425588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009745128989148?=
X-GMAIL-MSGID: =?utf-8?q?1598009745128989148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit f6cd651b056ffd3b4e8496afd44d4ed44bf69136 ]

We can't use l2tp_tunnel_find() to prevent l2tp_nl_cmd_tunnel_create()
from creating a duplicate tunnel. A tunnel can be concurrently
registered after l2tp_tunnel_find() returns. Therefore, searching for
duplicates must be done at registration time.

Finally, remove l2tp_tunnel_find() entirely as it isn't use anywhere
anymore.

Fixes: 309795f4bec2 ("l2tp: Add netlink control API for L2TP")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c    |   35 ++++++++++++++---------------------
 net/l2tp/l2tp_core.h    |    1 -
 net/l2tp/l2tp_netlink.c |    6 ------
 3 files changed, 14 insertions(+), 28 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -335,26 +335,6 @@ err_tlock:
 }
 EXPORT_SYMBOL_GPL(l2tp_session_register);
 
-/* Lookup a tunnel by id
- */
-struct l2tp_tunnel *l2tp_tunnel_find(const struct net *net, u32 tunnel_id)
-{
-	struct l2tp_tunnel *tunnel;
-	struct l2tp_net *pn = l2tp_pernet(net);
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
-		if (tunnel->tunnel_id == tunnel_id) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_find);
-
 struct l2tp_tunnel *l2tp_tunnel_find_nth(const struct net *net, int nth)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
@@ -1501,6 +1481,7 @@ static int l2tp_validate_socket(const st
 int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 			 struct l2tp_tunnel_cfg *cfg)
 {
+	struct l2tp_tunnel *tunnel_walk;
 	struct l2tp_net *pn;
 	struct socket *sock;
 	struct sock *sk;
@@ -1529,7 +1510,16 @@ int l2tp_tunnel_register(struct l2tp_tun
 	tunnel->l2tp_net = net;
 
 	pn = l2tp_pernet(net);
+
 	spin_lock_bh(&pn->l2tp_tunnel_list_lock);
+	list_for_each_entry(tunnel_walk, &pn->l2tp_tunnel_list, list) {
+		if (tunnel_walk->tunnel_id == tunnel->tunnel_id) {
+			spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
+
+			ret = -EEXIST;
+			goto err_sock;
+		}
+	}
 	list_add_rcu(&tunnel->list, &pn->l2tp_tunnel_list);
 	spin_unlock_bh(&pn->l2tp_tunnel_list_lock);
 
@@ -1558,7 +1548,10 @@ int l2tp_tunnel_register(struct l2tp_tun
 	return 0;
 
 err_sock:
-	sockfd_put(sock);
+	if (tunnel->fd < 0)
+		sock_release(sock);
+	else
+		sockfd_put(sock);
 err:
 	return ret;
 }
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -220,7 +220,6 @@ struct l2tp_session *l2tp_session_get(co
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname);
-struct l2tp_tunnel *l2tp_tunnel_find(const struct net *net, u32 tunnel_id);
 struct l2tp_tunnel *l2tp_tunnel_find_nth(const struct net *net, int nth);
 
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -236,12 +236,6 @@ static int l2tp_nl_cmd_tunnel_create(str
 	if (info->attrs[L2TP_ATTR_DEBUG])
 		cfg.debug = nla_get_u32(info->attrs[L2TP_ATTR_DEBUG]);
 
-	tunnel = l2tp_tunnel_find(net, tunnel_id);
-	if (tunnel != NULL) {
-		ret = -EEXIST;
-		goto out;
-	}
-
 	ret = -EINVAL;
 	switch (cfg.encap) {
 	case L2TP_ENCAPTYPE_UDP:
