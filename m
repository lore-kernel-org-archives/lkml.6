Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeEBCCZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 22:02:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40109 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEBCCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 22:02:23 -0400
X-Google-Smtp-Source: AB8JxZp8HqfCxf04oz9SC7F3nhA2Gdf7zWTGdzQMNUvQke99NEbQS7iKtmvsTUVb22Cjpws8PX6CTw==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH] net/xfrm: Fix lookups for states with spi == 0
Date: Wed,  2 May 2018 03:02:20 +0100
Message-Id: <20180502020220.2027-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be a valid use case to add xfrm state without
Security Parameter Indexes (SPI) value associated:
ip xfrm state add src $src dst $dst proto $proto mode $mode sel src $src dst $dst $algo

The bad thing is that it's currently impossible to get/delete the state
without SPI: __xfrm_state_insert() obviously doesn't add hash for zero
SPI in xfrm.state_byspi, and xfrm_user_state_lookup() will fail as
xfrm_state_lookup() does lookups by hash.

It also isn't possible to workaround from userspace as
xfrm_id_proto_match() will be always true for ah/esp/comp protos.

So, don't try looking up by hash if SPI == 0.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 080035f056d9..6b38503255c8 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -681,7 +681,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 	int err;
 	u32 mark = xfrm_mark_get(attrs, &m);
 
-	if (xfrm_id_proto_match(p->proto, IPSEC_PROTO_ANY)) {
+	if (xfrm_id_proto_match(p->proto, IPSEC_PROTO_ANY) && p->spi) {
 		err = -ESRCH;
 		x = xfrm_state_lookup(net, mark, &p->daddr, p->spi, p->proto, p->family);
 	} else {
-- 
2.13.6
