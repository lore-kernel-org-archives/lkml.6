Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeEDBUP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 21:20:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33758 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeEDBUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 21:20:13 -0400
X-Google-Smtp-Source: AB8JxZrMY6kVVxVTqgi1rJ1gzxE3/LihB8PNPFk5ODVa7NcqWVfbuOnDL2h1TXyb8PRtYiELpuad/g==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCHv2] net/xfrm: Revert "[XFRM]: Do not add a state whose SPI is zero to the SPI hash."
Date: Fri,  4 May 2018 02:20:09 +0100
Message-Id: <20180504012009.643-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7b4dc3600e48 ("[XFRM]: Do not add a state whose SPI
is zero to the SPI hash.").

Zero SPI is legal and defined for IPcomp.
We shouldn't omit adding the state to SPI hash because it'll not be
possible to delete or lookup for it afterward:
__xfrm_state_insert() obviously doesn't add hash for zero
SPI in xfrm.state_byspi, and xfrm_user_state_lookup() will fail as
xfrm_state_lookup() does lookups by hash.

It also isn't possible to workaround from userspace as
xfrm_id_proto_match() will be always true for ah/esp/comp protos.

v1 link: https://lkml.kernel.org/r/<20180502020220.2027-1-dima@arista.com>

Cc: Masahide NAKAMURA <nakam@linux-ipv6.org>
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_state.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f9d2f2233f09..03afe5423448 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -97,12 +97,9 @@ static void xfrm_hash_transfer(struct hlist_head *list,
 				    nhashmask);
 		hlist_add_head_rcu(&x->bysrc, nsrctable + h);
 
-		if (x->id.spi) {
-			h = __xfrm_spi_hash(&x->id.daddr, x->id.spi,
-					    x->id.proto, x->props.family,
-					    nhashmask);
-			hlist_add_head_rcu(&x->byspi, nspitable + h);
-		}
+		h = __xfrm_spi_hash(&x->id.daddr, x->id.spi, x->id.proto,
+				    x->props.family, nhashmask);
+		hlist_add_head_rcu(&x->byspi, nspitable + h);
 	}
 }
 
@@ -613,8 +610,7 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		list_del(&x->km.all);
 		hlist_del_rcu(&x->bydst);
 		hlist_del_rcu(&x->bysrc);
-		if (x->id.spi)
-			hlist_del_rcu(&x->byspi);
+		hlist_del_rcu(&x->byspi);
 		net->xfrm.state_num--;
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
@@ -958,7 +954,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    xfrm_state_addr_check(x, daddr, saddr, encap_family) &&
 		    tmpl->mode == x->props.mode &&
 		    tmpl->id.proto == x->id.proto &&
-		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+		    tmpl->id.spi == x->id.spi)
 			xfrm_state_look_at(pol, x, fl, encap_family,
 					   &best, &acquire_in_progress, &error);
 	}
@@ -974,7 +970,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		    xfrm_addr_equal(&x->id.daddr, daddr, encap_family) &&
 		    tmpl->mode == x->props.mode &&
 		    tmpl->id.proto == x->id.proto &&
-		    (tmpl->id.spi == x->id.spi || !tmpl->id.spi))
+		    tmpl->id.spi == x->id.spi)
 			xfrm_state_look_at(pol, x, fl, encap_family,
 					   &best, &acquire_in_progress, &error);
 	}
@@ -982,8 +978,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 found:
 	x = best;
 	if (!x && !error && !acquire_in_progress) {
-		if (tmpl->id.spi &&
-		    (x0 = __xfrm_state_lookup(net, mark, daddr, tmpl->id.spi,
+		if ((x0 = __xfrm_state_lookup(net, mark, daddr, tmpl->id.spi,
 					      tmpl->id.proto, encap_family)) != NULL) {
 			to_put = x0;
 			error = -EEXIST;
@@ -1025,10 +1020,8 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 			hlist_add_head_rcu(&x->bydst, net->xfrm.state_bydst + h);
 			h = xfrm_src_hash(net, daddr, saddr, encap_family);
 			hlist_add_head_rcu(&x->bysrc, net->xfrm.state_bysrc + h);
-			if (x->id.spi) {
-				h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
-				hlist_add_head_rcu(&x->byspi, net->xfrm.state_byspi + h);
-			}
+			h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, encap_family);
+			hlist_add_head_rcu(&x->byspi, net->xfrm.state_byspi + h);
 			x->lft.hard_add_expires_seconds = net->xfrm.sysctl_acq_expires;
 			tasklet_hrtimer_start(&x->mtimer, ktime_set(net->xfrm.sysctl_acq_expires, 0), HRTIMER_MODE_REL);
 			net->xfrm.state_num++;
@@ -1134,7 +1127,7 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 	h = xfrm_src_hash(net, &x->id.daddr, &x->props.saddr, x->props.family);
 	hlist_add_head_rcu(&x->bysrc, net->xfrm.state_bysrc + h);
 
-	if (x->id.spi) {
+	if (xfrm_id_proto_match(x->id.proto, IPSEC_PROTO_ANY)) {
 		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto,
 				  x->props.family);
 
@@ -1787,14 +1780,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high)
 			xfrm_state_put(x0);
 		}
 	}
-	if (x->id.spi) {
-		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
-		hlist_add_head_rcu(&x->byspi, net->xfrm.state_byspi + h);
-		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+	spin_lock_bh(&net->xfrm.xfrm_state_lock);
+	h = xfrm_spi_hash(net, &x->id.daddr, x->id.spi, x->id.proto, x->props.family);
+	hlist_add_head_rcu(&x->byspi, net->xfrm.state_byspi + h);
+	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
-		err = 0;
-	}
+	err = 0;
 
 unlock:
 	spin_unlock_bh(&x->lock);
-- 
2.13.6
