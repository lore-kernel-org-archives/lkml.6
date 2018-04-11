Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48yjiNFEO8040gJQA32hxZCqWSIHS8FpCf/+8KRTDisTpn+F4gs4NyYNgEQ1JDNRMK+dl80
ARC-Seal: i=1; a=rsa-sha256; t=1523473143; cv=none;
        d=google.com; s=arc-20160816;
        b=sfCiR7YY+elSC5Q7YCoQdTCoPFePC+xLdZq4wy1NFELjIMOT0kJculs16NagIktAia
         JWsiwYKoykVHqPJDDGgiUCMBcKu52Hji0OKWD85ZstGCeLotG5Qcq2bCys/s+pfUhhBh
         UoV6TwgTp5ohhpLJRR5Juhvj4K8dxvcj3JKQSRs6wg5PXACukRn3qFXQJtWnpXr/KfTc
         lwlXyK0JE/B4bDrD+ytzZKPWe5VrAUloGDn6sv108DX1K46BpzjLeamSQIfLdtXZ5dn6
         WC0iuvC3fWxcQewNfztDCc+iNHJNn9RljJEpTiff6DW6LQS4PfaqskUlrGUHQLxSVRkP
         BOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9l8wDL23Ab7Zp9f+L2xgtyBfaE+yoisH6EXtSLxa9iQ=;
        b=JSRdjJwcHwAyPb0ABbWkzf108sg4hdi38CTYNYpiPhI+OvKuzyczPptItALSvV2W5G
         ShB2QaiyIBeh/K26A3vWb1W28BSDdvfp3FHhi2KTDb8H/DR7g/j74Tzy5t+yx9ICXmNF
         r3c6u9PADgHN+aZNGoo94MB07VQ2MQg+hY2EJuzxHBH5tuDGqPTGbpv50kFbLtCnwJML
         7Er2r2ZYzSDwJcAt4QCL0vVPWmZ6YAiKtc6WbPaAaESbERKRUvXUSy1OObMao4MUJt4d
         tF8mJnD1UqCPjlk6nJCIOXoHsguMzSgxF6/57gArd6zzPAgDSdC2YavZuyj7teD/cRAN
         NYvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Kapl <roman.kapl@sysgo.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 110/310] net: move somaxconn init from sysctl code
Date: Wed, 11 Apr 2018 20:34:09 +0200
Message-Id: <20180411183626.930010814@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476157557466481?=
X-GMAIL-MSGID: =?utf-8?q?1597477375549252263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Kapl <roman.kapl@sysgo.com>


[ Upstream commit 7c3f1875c66fbc19762760097cabc91849ea0bbb ]

The default value for somaxconn is set in sysctl_core_net_init(), but this
function is not called when kernel is configured without CONFIG_SYSCTL.

This results in the kernel not being able to accept TCP connections,
because the backlog has zero size. Usually, the user ends up with:
"TCP: request_sock_TCP: Possible SYN flooding on port 7. Dropping request.  Check SNMP counters."
If SYN cookies are not enabled the connection is rejected.

Before ef547f2ac16 (tcp: remove max_qlen_log), the effects were less
severe, because the backlog was always at least eight slots long.

Signed-off-by: Roman Kapl <roman.kapl@sysgo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net_namespace.c   |   19 +++++++++++++++++++
 net/core/sysctl_net_core.c |    2 --
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -312,6 +312,25 @@ out_undo:
 	goto out;
 }
 
+static int __net_init net_defaults_init_net(struct net *net)
+{
+	net->core.sysctl_somaxconn = SOMAXCONN;
+	return 0;
+}
+
+static struct pernet_operations net_defaults_ops = {
+	.init = net_defaults_init_net,
+};
+
+static __init int net_defaults_init(void)
+{
+	if (register_pernet_subsys(&net_defaults_ops))
+		panic("Cannot initialize net default settings");
+
+	return 0;
+}
+
+core_initcall(net_defaults_init);
 
 #ifdef CONFIG_NET_NS
 static struct ucounts *inc_net_namespaces(struct user_namespace *ns)
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -438,8 +438,6 @@ static __net_init int sysctl_core_net_in
 {
 	struct ctl_table *tbl;
 
-	net->core.sysctl_somaxconn = SOMAXCONN;
-
 	tbl = netns_core_table;
 	if (!net_eq(net, &init_net)) {
 		tbl = kmemdup(tbl, sizeof(netns_core_table), GFP_KERNEL);
