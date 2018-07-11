Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53AEC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549E2208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549E2208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbeGKKXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:23:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeGKKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:23:38 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MSmNI-1fTGac3xZM-00RdNd; Wed, 11 Jul 2018 12:19:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Westphal <fw@strlen.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [RESEND, net-next] xfrm: use time64_t for in-kernel timestamps
Date:   Wed, 11 Jul 2018 12:19:13 +0200
Message-Id: <20180711101941.4039411-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:eDumljfDIEgHVihgCRbl9UVrxtg59JBdT0VLc0Ob8CtDSEf/hf4
 0BN3jxW5YxWEec1341SDa9cl2klFVSSgSYuuYo8jihvqqj9VuxnxrJ8zs3XozBdrp4E3h3e
 QcyWuXz/pKyDvDqrw1hNeSixNwjREna8gU09GIEM3iCGLOJGWfiEmiwmMy6U6cJH2AtjKq4
 Ua3y8oIvg6NxfU7AsGUWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kj5RcVlUw28=:mIcs7d2odMq/VxSBLsiOvr
 6JwCHasJeR1geWlq7+pcob9cIPn3OGH2a4fcdeRhIb8Hpp/vcD0NaF/XXE+OJoOeU4b4pwYlY
 j1mLi0n5W2PzmBNzH+6SdPaI7Ucnv9fA21LG8UkjBsz67p27POmw7jmR02536pY1Ux4KT/wFH
 r18HqTtAopKpltgK+Za/kMQFQUf5gwJxsuzrb++CgiqHfFpCKymUOXhbASxxR5dnCezQ5OcTR
 OFfnw8c1/+dhpJVBSsQbEeNue8Xfl+ZALsDuz3bwOY2doTmT4eXrCbsOhj1wrTsRF13kRJlyN
 SD65Z8dsRl9dAamBtIT64MRKQWe9Wx9DoGS3c4RmyDg51iV2oo2R7puorRvv/84Y2UfOMY61H
 dRA6k9ZsZbQMLdBxmjff3r7zWioSMb6+l/scVCjftpEOObv2/nUBIPbPkXPFnRerZoIIEF3qM
 fDjmEH9q0kb+rVLTjr9nYFYZEuaCyowDuMqqXVtOsCst839xUct5CHqJ4bVtgGEW2Nc1Rkxio
 zlFqM7urZ/WJgwmBXGC05PPrieW7R87qs2jtMXqWYihhY+yU07P2mLqZsJAvUm5Bkd7KYp+t2
 wh8lxh6inMLE5NKoINK38U2yqUh1C+CaAAll49YIXQSTxzQ/8S1VUcDqsHkXudw8hOwOdvcXN
 z9wktGXKugmIfMcY7rp3VJ3uRZdchN9CvYCEwsfXz7FcnmhrU7EVrGMxwpBxc3j4cMf0=
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
index 7338610d7b8f..9dbbb0d3771b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -189,8 +189,8 @@ static inline unsigned long make_jiffies(long secs)
 static void xfrm_policy_timer(struct timer_list *t)
 {
 	struct xfrm_policy *xp = from_timer(xp, t, timer);
-	unsigned long now = get_seconds();
-	long next = LONG_MAX;
+	time64_t now = ktime_get_real_seconds();
+	time64_t next = TIME64_MAX;
 	int warn = 0;
 	int dir;
 
@@ -202,7 +202,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 	dir = xfrm_policy_id2dir(xp->index);
 
 	if (xp->lft.hard_add_expires_seconds) {
-		long tmo = xp->lft.hard_add_expires_seconds +
+		time64_t tmo = xp->lft.hard_add_expires_seconds +
 			xp->curlft.add_time - now;
 		if (tmo <= 0)
 			goto expired;
@@ -210,7 +210,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 			next = tmo;
 	}
 	if (xp->lft.hard_use_expires_seconds) {
-		long tmo = xp->lft.hard_use_expires_seconds +
+		time64_t tmo = xp->lft.hard_use_expires_seconds +
 			(xp->curlft.use_time ? : xp->curlft.add_time) - now;
 		if (tmo <= 0)
 			goto expired;
@@ -218,7 +218,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 			next = tmo;
 	}
 	if (xp->lft.soft_add_expires_seconds) {
-		long tmo = xp->lft.soft_add_expires_seconds +
+		time64_t tmo = xp->lft.soft_add_expires_seconds +
 			xp->curlft.add_time - now;
 		if (tmo <= 0) {
 			warn = 1;
@@ -228,7 +228,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 			next = tmo;
 	}
 	if (xp->lft.soft_use_expires_seconds) {
-		long tmo = xp->lft.soft_use_expires_seconds +
+		time64_t tmo = xp->lft.soft_use_expires_seconds +
 			(xp->curlft.use_time ? : xp->curlft.add_time) - now;
 		if (tmo <= 0) {
 			warn = 1;
@@ -240,7 +240,7 @@ static void xfrm_policy_timer(struct timer_list *t)
 
 	if (warn)
 		km_policy_expired(xp, dir, 0, 0);
-	if (next != LONG_MAX &&
+	if (next != TIME64_MAX &&
 	    !mod_timer(&xp->timer, jiffies + make_jiffies(next)))
 		xfrm_pol_hold(xp);
 
@@ -791,7 +791,7 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	}
 	policy->index = delpol ? delpol->index : xfrm_gen_index(net, dir, policy->index);
 	hlist_add_head(&policy->byidx, net->xfrm.policy_byidx+idx_hash(net, policy->index));
-	policy->curlft.add_time = get_seconds();
+	policy->curlft.add_time = ktime_get_real_seconds();
 	policy->curlft.use_time = 0;
 	if (!mod_timer(&policy->timer, jiffies + HZ))
 		xfrm_pol_hold(policy);
@@ -1282,7 +1282,7 @@ int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol)
 	old_pol = rcu_dereference_protected(sk->sk_policy[dir],
 				lockdep_is_held(&net->xfrm.xfrm_policy_lock));
 	if (pol) {
-		pol->curlft.add_time = get_seconds();
+		pol->curlft.add_time = ktime_get_real_seconds();
 		pol->index = xfrm_gen_index(net, XFRM_POLICY_MAX+dir, 0);
 		xfrm_sk_policy_link(pol, dir);
 	}
@@ -2132,7 +2132,7 @@ struct dst_entry *xfrm_lookup(struct net *net, struct dst_entry *dst_orig,
 	}
 
 	for (i = 0; i < num_pols; i++)
-		pols[i]->curlft.use_time = get_seconds();
+		pols[i]->curlft.use_time = ktime_get_real_seconds();
 
 	if (num_xfrms < 0) {
 		/* Prohibit the flow */
@@ -2355,7 +2355,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		return 1;
 	}
 
-	pol->curlft.use_time = get_seconds();
+	pol->curlft.use_time = ktime_get_real_seconds();
 
 	pols[0] = pol;
 	npols++;
@@ -2369,7 +2369,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 				XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
 				return 0;
 			}
-			pols[1]->curlft.use_time = get_seconds();
+			pols[1]->curlft.use_time = ktime_get_real_seconds();
 			npols++;
 		}
 	}
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e04a510ec992..7efc299fba56 100644
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
@@ -1579,7 +1579,7 @@ EXPORT_SYMBOL(xfrm_state_update);
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
 	if (!x->curlft.use_time)
-		x->curlft.use_time = get_seconds();
+		x->curlft.use_time = ktime_get_real_seconds();
 
 	if (x->curlft.bytes >= x->lft.hard_byte_limit ||
 	    x->curlft.packets >= x->lft.hard_packet_limit) {
-- 
2.9.0

