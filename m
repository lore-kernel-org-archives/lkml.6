Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50849C64E75
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E973F217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Lsjursvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeLYB5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 20:57:47 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:6259 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeLYB5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 20:57:46 -0500
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1545703051; h=from:subject:to:date:message-id;
        bh=5kcMcV4j26eFbtDPz0YBO0/OXTctBg9upQNoskpAMhw=;
        b=Lsjursvr3cPHw0QLLRzu5bLmRl9F8snAV9OH4nRMoKCfi96jz4oB+R++rRiS6TFJM1aRJQJQX+p
        tQcNgqwzliqRqEa4SeWionQk99iPOg6lE/hnaQyw0yuRdjH182UX/bn0wvlPgcFTJbTawJXFyo7G9
        +tEC81vBEHLUC5BgXZI=
Received: from localhost.localdomain (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 25 Dec 2018 09:57:31 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <sfr@canb.auug.org.au>, <alexey.skidanov@intel.com>,
        <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 1/2 fix] lib/genalloc.c: Use the vzalloc_node to allocate the bitmap.
Date:   Tue, 25 Dec 2018 09:57:01 +0800
Message-ID: <20181225015701.6289-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181224070622.22197-1-sjhuang@iluvatar.ai>
References: <20181224070622.22197-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may have big memory on chip, such as over 1G.
In some cases, the nbytes maybe bigger then 4M which is the bounday of
the memory buddy system (4K default).

So use vzalloc_node() to allocate the bitmap.
Also use vfree to free the it.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
The v1 did not free the memory with vfree.
This patch fixes it.

---
 lib/genalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 5deb25c40a5a..f365d71cdc77 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -187,7 +187,7 @@ int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phy
 	int nbytes = sizeof(struct gen_pool_chunk) +
 				BITS_TO_LONGS(nbits) * sizeof(long);
 
-	chunk = kzalloc_node(nbytes, GFP_KERNEL, nid);
+	chunk = vzalloc_node(nbytes, nid);
 	if (unlikely(chunk == NULL))
 		return -ENOMEM;
 
@@ -251,7 +251,7 @@ void gen_pool_destroy(struct gen_pool *pool)
 		bit = find_next_bit(chunk->bits, end_bit, 0);
 		BUG_ON(bit < end_bit);
 
-		kfree(chunk);
+		vfree(chunk);
 	}
 	kfree_const(pool->name);
 	kfree(pool);
-- 
2.17.1

