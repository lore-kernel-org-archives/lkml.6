Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qJxOLqyQ22qflGMwrjIabi4/vnBpAn6zkK7OOdPR4t7eiMJhGvwt7SrZs8dAl8v23pqp2
ARC-Seal: i=1; a=rsa-sha256; t=1522346769; cv=none;
        d=google.com; s=arc-20160816;
        b=hZFxOh+6MJ9MeAH+lZQ+ljBkcLUjfIKPGH4sQxusRM+LSdh/2vtKUxzXrjRdCOmA+y
         A5lRWPLZWr1NDr6wycnuI+N40qnrSkKPOvRRx2XNdcx68c+RrINBzF8XBo/cpBYwgRdC
         W8fOYnD3aqiw7TK29SLwiTY8Fn8Lsld/jIaCbK2XSdfLLy145oqxBNMCTJlTyl1S/ZLe
         +AknuZ4Mn5Zoq+Ad8rmd1/iofnzDkvao50IMLOv7UYXW8bBIX0CFRTpOfF27mxMLPcgx
         PHLbxbd7MzRm7OE5DOlt8IsnmkmMG7x2b3BCYGzxiDCEx4GhQITSbPln6qJZpBDcq8X9
         m7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BbmrdoVDTGu1GajC20QVuzUcR49x3+jRQGVpAaMG2YQ=;
        b=0Srj8TLBMJ4D5bvNz+HAX8cAHPgZZguB4Qi3jzopte5sO601JVlJd38LsmhMAZ8WIz
         8ba0xeMN4Vi/Rzoed9e8AlTvq5hkA50pIs6Le6cevMg02zAXHIYiwR0n8uy5VOCPxAft
         IBUS9KhmeiKYVk44/nqdXmjrT/Lqa/5sGITa7/nWZ/S+yjgbbhFkMUZG0QSkos2GjCvW
         E/85JbGLOU42hlOxnBIrMIuRrl9HluMSSI1nvt/qT9x2CwJnbfZUZwpzgwxsmuKNpfSg
         BPHnacyiGWaRQT0ObIVUBIYT5trZPtvglMuzhoVPY1F0U/OvWOxv2IUv0C7XGOcjVmfr
         kmgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Andrei Vagin <avagin@virtuozzo.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 20/43] net: use skb_to_full_sk() in skb_update_prio()
Date: Thu, 29 Mar 2018 20:00:15 +0200
Message-Id: <20180329175732.206226535@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296054834790372?=
X-GMAIL-MSGID: =?utf-8?q?1596296286238453215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 4dcb31d4649df36297296b819437709f5407059c ]

Andrei Vagin reported a KASAN: slab-out-of-bounds error in
skb_update_prio()

Since SYNACK might be attached to a request socket, we need to
get back to the listener socket.
Since this listener is manipulated without locks, add const
qualifiers to sock_cgroup_prioidx() so that the const can also
be used in skb_update_prio()

Also add the const qualifier to sock_cgroup_classid() for consistency.

Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets instead of listener")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Andrei Vagin <avagin@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cgroup-defs.h |    4 ++--
 net/core/dev.c              |   22 +++++++++++++++-------
 2 files changed, 17 insertions(+), 9 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -696,13 +696,13 @@ struct sock_cgroup_data {
  * updaters and return part of the previous pointer as the prioidx or
  * classid.  Such races are short-lived and the result isn't critical.
  */
-static inline u16 sock_cgroup_prioidx(struct sock_cgroup_data *skcd)
+static inline u16 sock_cgroup_prioidx(const struct sock_cgroup_data *skcd)
 {
 	/* fallback to 1 which is always the ID of the root cgroup */
 	return (skcd->is_data & 1) ? skcd->prioidx : 1;
 }
 
-static inline u32 sock_cgroup_classid(struct sock_cgroup_data *skcd)
+static inline u32 sock_cgroup_classid(const struct sock_cgroup_data *skcd)
 {
 	/* fallback to 0 which is the unconfigured default classid */
 	return (skcd->is_data & 1) ? skcd->classid : 0;
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3224,15 +3224,23 @@ static inline int __dev_xmit_skb(struct
 #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
 static void skb_update_prio(struct sk_buff *skb)
 {
-	struct netprio_map *map = rcu_dereference_bh(skb->dev->priomap);
+	const struct netprio_map *map;
+	const struct sock *sk;
+	unsigned int prioidx;
 
-	if (!skb->priority && skb->sk && map) {
-		unsigned int prioidx =
-			sock_cgroup_prioidx(&skb->sk->sk_cgrp_data);
+	if (skb->priority)
+		return;
+	map = rcu_dereference_bh(skb->dev->priomap);
+	if (!map)
+		return;
+	sk = skb_to_full_sk(skb);
+	if (!sk)
+		return;
 
-		if (prioidx < map->priomap_len)
-			skb->priority = map->priomap[prioidx];
-	}
+	prioidx = sock_cgroup_prioidx(&sk->sk_cgrp_data);
+
+	if (prioidx < map->priomap_len)
+		skb->priority = map->priomap[prioidx];
 }
 #else
 #define skb_update_prio(skb)
