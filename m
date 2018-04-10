Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDJBSZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:18:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33201 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeDJBSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:18:23 -0400
X-Google-Smtp-Source: AIpwx48CLw8qLPfxzG86efgTt/9vXF2p7TWvY9Yz77Z65tTKw2RkTet5PLbVkZccyB37rkz525uVvw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: davem@davemloft.net, weiwan@google.com, kafai@fb.com,
        hannes@stressinduktion.org, fw@strlen.de, dsa@cumulusnetworks.com,
        johannes.berg@intel.com
Cc: linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] net: decnet: Replace GFP_ATOMIC with GFP_KERNEL in dn_route_init
Date: Tue, 10 Apr 2018 09:18:13 +0800
Message-Id: <1523323093-28196-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dn_route_init() is never called in atomic context.

The call chain ending up at dn_route_init() is:
[1] dn_route_init() <- decnet_init()
decnet_init() is only set as a parameter of module_init().

Despite never getting called from atomic context,
dn_route_init() calls __get_free_pages() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Modify the description of GFP_ATOMIC in v1.
  Thank Eric for good advice.
---
 net/decnet/dn_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
index 0bd3afd..59ed12a 100644
--- a/net/decnet/dn_route.c
+++ b/net/decnet/dn_route.c
@@ -1898,7 +1898,7 @@ void __init dn_route_init(void)
 		while(dn_rt_hash_mask & (dn_rt_hash_mask - 1))
 			dn_rt_hash_mask--;
 		dn_rt_hash_table = (struct dn_rt_hash_bucket *)
-			__get_free_pages(GFP_ATOMIC, order);
+			__get_free_pages(GFP_KERNEL, order);
 	} while (dn_rt_hash_table == NULL && --order > 0);
 
 	if (!dn_rt_hash_table)
-- 
1.9.1
