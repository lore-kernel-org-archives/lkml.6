Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeDROe2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:34:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752684AbeDROe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:34:27 -0400
Date: Wed, 18 Apr 2018 10:34:26 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
cc: Joby Poriyath <joby.poriyath@citrix.com>,
        Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: don't use kvzalloc for DMA memory
Message-ID: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 74d332c13b21 changes alloc_netdev_mqs to use vzalloc if kzalloc
fails (later patches change it to kvzalloc).

The problem with this is that if the vzalloc function is actually used, 
virtio_net doesn't work (because it expects that the extra memory should 
be accessible with DMA-API and memory allocated with vzalloc isn't).

This patch changes it back to kzalloc and adds a warning if the allocated
size is too large (the allocation is unreliable in this case).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 74d332c13b21 ("net: extend net_device allocation to vmalloc()")

---
 net/core/dev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/net/core/dev.c
===================================================================
--- linux-2.6.orig/net/core/dev.c	2018-04-16 21:08:36.000000000 +0200
+++ linux-2.6/net/core/dev.c	2018-04-18 16:24:43.000000000 +0200
@@ -8366,7 +8366,8 @@ struct net_device *alloc_netdev_mqs(int
 	/* ensure 32-byte alignment of whole construct */
 	alloc_size += NETDEV_ALIGN - 1;
 
-	p = kvzalloc(alloc_size, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	WARN_ON(alloc_size > PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
+	p = kzalloc(alloc_size, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!p)
 		return NULL;
 
