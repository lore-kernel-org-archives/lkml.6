Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCEBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E05208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E05208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeFRPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:23:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeFRPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:23:09 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M8iqK-1fNFxj1kUu-00C6RC; Mon, 18 Jun 2018 17:22:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] xfrm: use time64_t for in-kernel timestamps
Date:   Mon, 18 Jun 2018 17:22:13 +0200
Message-Id: <20180618152242.1566661-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:YDM89EYLc97ArtFrjQTZBNvz2IcWh0tqsY+SSdl47X9836aok9V
 a8FMh1HsyU8JZhh/h9kyhL5vSol5FDtB0FswCmZ3lH72pM7/ckTWMdRSOXD/ysaDTJjo4qE
 FcxfClAxpiTFc9IIT8oRBpjPZ0l7N4QJAimAxXH/u6AMEcMY6oSIThLmJaWyJtwLNvwWHEW
 4fil9jJG8uBYZDibuKNNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rBt5a3aPgVA=:T4lqh41oShp+kH2mVwezeB
 uvPeeKtcvyfCXGs6ye2QSXdBAMtWW0mfcrZ+KUkAinOQ+EYUkIjJTGyi7ql08Wl0XRpg5y+l+
 gGXmD3wj9bWUGyexbKJ/8h/3rRsAqsICP0qYzSY90N8X+vscxJhwfPeVtfMnEmLB2uL6i4v3L
 9u/S2ikNbFvSAa/ApazOwUY9MBDlDHBYm1q/J7cKYAMG7qr4keaBE3bwFU5WLzVfsy7NmSCqF
 g1ueTk9JEcaiWb9MxvNxgL6igHAO3qEeasJwluQkDlnHTYQTxVLydU+fzvIpj01W7Ni1/WUf7
 CE5axfQYCEZLWiY59uZXYUQ1GgSULrmHk/JxTq3Z4m/DiIpIVHiPr3Y12zS+9gi+gAJNEsk1m
 ZMnaVuUTPTqO409/mIp1/zw2sMvc3docPLiPrdDIjYNieSn4NcdCf5Vt9/rsKwMUqJHoynobs
 pb1p1q/0gn91oALWwlbH/mjFOrnTKLqKQRm4bpG5Vu5NxxgY9rT3gIi5uxMkQOqZFOXdDLG+W
 s837/EUzPT0JO7hLlGnG9FiwDnDqFuKgYKKVvSJHVRBxj9CuW9h427CrXsVzPBVjPAr/AxSEu
 RT50ZKz6jrseP7jlXCFlUvbc1FMCzqND78kkiEj34tFtyJX0d7jkDUY0wXj1q7qbmUkjrps+Q
 Zf/8okQOU5Ppk+b6BWkPvp6aoKkNBl0jwwuAuJBDLQ2CJG9VCrXt72FzsBWmpDJQFKsw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lifetime managment uses '__u64' timestamps on the user space
interface, but 'unsigned long' for reading the current time in the kernel
with get_seconds().

While this is probably safe beyond y2038, it will still overflow in 2106,
and the get_seconds() call is deprecated because fo that.

This changes the xfrm time handling to use time64_t consistently, along
with reading the time using the safer ktime_get_real_seconds(). It still
suffers from problems that can happen from a concurrent settimeofday()
call or (to a lesser degree) a leap second update, but since the time
stamps are part of the user API, there is nothing we can do to prevent
that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/xfrm/xfrm_policy.c | 24 ++++++++++++------------
 net/xfrm/xfrm_state.c  | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5f48251c1319..9f4afca8b4f5 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -182,8 +182,8 @@ static inline unsigned long make_jiffies(long secs)
 static void xfrm_policy_timer(struct timer_list *t)
 {
 	struct xfrm_policy *xp = from_timer(xp, t, timer);
-	unsigned long now = get_seconds();
-	long next = LONG_MAX;
+	time64_t now = ktime_get_real_seconds();
+	time64_t next = TIME64_MAX;
 	int warn = 0;
 	int dir;
 
@@ -195,7 +195,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 	dir = xfrm_policy_id2dir(xp->index);
 
 	if (xp->lft.hard_add_expires_seconds) {
-		long tmo = xp->lft.hard_add_expires_seconds +
+		time64_t tmo = xp->lft.hard_add_expires_seconds +
 			xp->curlft.add_time - now;
 		if (tmo <= 0)
 			goto expired;
@@ -203,7 +203,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 			next = tmo;
 	}
 	if (xp->lft.hard_use_expires_seconds) {
-		long tmo = xp->lft.hard_use_expires_seconds +
+		time64_t tmo = xp->lft.hard_use_expires_seconds +
 			(xp->curlft.use_time ? : xp->curlft.add_time) - now;
 		if (tmo <= 0)
 			goto expired;
@@ -211,7 +211,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 			next = tmo;
 	}
 	if (xp->lft.soft_add_expires_seconds) {
-		long tmo = xp->lft.soft_add_expires_seconds +
+		time64_t tmo = xp->lft.soft_add_expires_seconds +
 			xp->curlft.add_time - now;
 		if (tmo <= 0) {
 			warn = 1;
@@ -221,7 +221,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 			next = tmo;
 	}
 	if (xp->lft.soft_use_expires_seconds) {
-		long tmo = xp->lft.soft_use_expires_seconds +
+		time64_t tmo = xp->lft.soft_use_expires_seconds +
 			(xp->curlft.use_time ? : xp->curlft.add_time) - now;
 		if (tmo <= 0) {
 			warn = 1;
@@ -233,7 +233,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 
 	if (warn)
 		km_policy_expired(xp, dir, 0, 0);
-	if (next != LONG_MAX &&
+	if (next != TIME64_MAX &&
 	    !mod_timer(&xp->timer, jiffies + make_jiffies(next)))
 		xfrm_pol_hold(xp);
 
@@ -783,7 +783,7 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	}
 	policy->index = delpol ? delpol->index : xfrm_gen_index(net, dir, policy->index);
 	hlist_add_head(&policy->byidx, net->xfrm.policy_byidx+idx_hash(net, policy->index));
-	policy->curlft.add_time = get_seconds();
+	policy->curlft.add_time = ktime_get_real_seconds();
 	policy->curlft.use_time = 0;
 	if (!mod_timer(&policy->timer, jiffies + HZ))
 		xfrm_pol_hold(policy);
@@ -1268,7 +1268,7 @@ int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol)
 	old_pol = rcu_dereference_protected(sk->sk_policy[dir],
 				lockdep_is_held(&net->xfrm.xfrm_policy_lock));
 	if (pol) {
-		pol->curlft.add_time = get_seconds();
+		pol->curlft.add_time = ktime_get_real_seconds();
 		pol->index = xfrm_gen_index(net, XFRM_POLICY_MAX+dir, 0);
 		xfrm_sk_policy_link(pol, dir);
 	}
@@ -2234,7 +2234,7 @@ struct dst_entry *xfrm_lookup(struct net *net, struct dst_entry *dst_orig,
 	}
 
 	for (i = 0; i < num_pols; i++)
-		pols[i]->curlft.use_time = get_seconds();
+		pols[i]->curlft.use_time = ktime_get_real_seconds();
 
 	if (num_xfrms < 0) {
 		/* Prohibit the flow */
@@ -2446,7 +2446,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		return 1;
 	}
 
-	pol->curlft.use_time = get_seconds();
+	pol->curlft.use_time = ktime_get_real_seconds();
 
 	pols[0] = pol;
 	npols++;
@@ -2460,7 +2460,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
 				return 0;
 			}
-			pols[1]->curlft.use_time = get_seconds();
+			pols[1]->curlft.use_time = ktime_get_real_seconds();
 			npols++;
 		}
 	}
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 8308281f3253..1c2b6fdd9518 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -475,8 +475,8 @@ static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
 {
 	struct tasklet_hrtimer *thr = container_of(me, struct tasklet_hrtimer, timer);
 	struct xfrm_state *x = container_of(thr, struct xfrm_state, mtimer);
-	unsigned long now = get_seconds();
-	long next = LONG_MAX;
+	time64_t now = ktime_get_real_seconds();
+	time64_t next = TIME64_MAX;
 	int warn = 0;
 	int err = 0;
 
@@ -537,7 +537,7 @@ static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
 	if (warn)
 		km_state_expired(x, 0, 0);
 resched:
-	if (next != LONG_MAX) {
+	if (next != TIME64_MAX) {
 		tasklet_hrtimer_start(&x->mtimer, ktime_set(next, 0), HRTIMER_MODE_REL);
 	}
 
@@ -577,7 +577,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 		tasklet_hrtimer_init(&x->mtimer, xfrm_timer_handler,
 					CLOCK_BOOTTIME, HRTIMER_MODE_ABS);
 		timer_setup(&x->rtimer, xfrm_replay_timer_handler, 0);
-		x->curlft.add_time = get_seconds();
+		x->curlft.add_time = ktime_get_real_seconds();
 		x->lft.soft_byte_limit = XFRM_INF;
 		x->lft.soft_packet_limit = XFRM_INF;
 		x->lft.hard_byte_limit = XFRM_INF;
@@ -1571,7 +1571,7 @@ EXPORT_SYMBOL(xfrm_state_update);
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
 	if (!x->curlft.use_time)
-		x->curlft.use_time = get_seconds();
+		x->curlft.use_time = ktime_get_real_seconds();
 
 	if (x->curlft.bytes >= x->lft.hard_byte_limit ||
 	    x->curlft.packets >= x->lft.hard_packet_limit) {
-- 
2.9.0

