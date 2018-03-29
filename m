Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MgZTNHYUJXAZTMStUvr3If9pEClxL0zfMxO+Kog9JOH0GqJNfihPy5FGv0IZJGBLId/rp
ARC-Seal: i=1; a=rsa-sha256; t=1522346548; cv=none;
        d=google.com; s=arc-20160816;
        b=0trLYka7wu+/QODwpkkjzDViEeKaY05lx8JX48NMZAxd5ipjeMo2gd2hiW5IfZwexN
         9nxHLuzPJGUE+KKzG8sB26Tq5cnbaSedGei7l5k9RC/81Xz6Ds5jzT35rk6ytlbiw2sj
         B0lNgxi4YaoinsgSba83YDtJkLcADgaMSS0vULyY6OZurGZO47AfU5G4xrpD4v3A7nxH
         mmygZaraCbDu9sCAgBHUmWOZ7mNj3enJD3lG7lqbBzZOWhx0pFSXdqQ5sVv0xIHec2JX
         zjg9sOCdVgRd4W6uIbdkfOFLzFQ6fU5uex4W21C/l9lDYTqeb/bZJHHXjxoKGEzPt+at
         6t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=71+T5BBmS1jFiCHQFGajd9XUZFLllTwxPnxbHCqZb8g=;
        b=FRuDeUGP2XplHl/M7iryWMgfEIn2o70dKbFd/01w+C0HbYOpWk6E5iFec1S1Mn3UiY
         TWmHSkMjjn9btH71RT5/0Qt35dQQnTwpRzC45zLgLRkzsyCMj2OclQSJiBKMVBAdJwba
         jov8OsTqpUQf99l1Wj5tticyYwuxJOJrPPxGiGmDQLQCP23xVEDQyoTzi/Z5crxkHJtt
         Tox8+fFg6goCOQqYaQK7Lo6pqaY5IZN435uUv4j499i0pmcZ6ODmMDkFQcW9ZTwibfjy
         gE56ScGp/dsUNAgXGSWhHNYB22SY+cS7hkWgrxI7nCNtgykpd8S4QXQyCyuEbxONkc+k
         JaKQ==
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
Subject: [PATCH 4.15 24/47] net: use skb_to_full_sk() in skb_update_prio()
Date: Thu, 29 Mar 2018 20:00:05 +0200
Message-Id: <20180329175731.036306102@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296054834790372?=
X-GMAIL-MSGID: =?utf-8?q?1596296054834790372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -755,13 +755,13 @@ struct sock_cgroup_data {
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
@@ -3247,15 +3247,23 @@ static inline int __dev_xmit_skb(struct
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
