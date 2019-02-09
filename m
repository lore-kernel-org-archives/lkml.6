Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E2C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C3320869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 04:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Uyx8KnH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBIElv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:41:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36010 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfBIElv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 23:41:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id r9so6437082qtt.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=USeCh6j0FsmLopx2MZxpLbxv8BeR2zl+0L2tQUmFxuY=;
        b=Uyx8KnH013ecHNcSjOImmFRrRi/e+kAFqBooYZeje3twAyxLmL8LfEDM1IT4kSf8u2
         /YVdKthWzIS7yxtK5i10pc3c+/5W1oZREDNFnJzz3qHwnAAuzQ/9Fn7R+AzJ7DsKELoB
         m4thanJUTuMXhg/zzwfh7v1TvnaXJ4c1Fp/JJtfTdJTCNutO/mb7n+M8hXaIOgIjE7EO
         hO8lI6qO3hRrBRh66iNwU764tW7W6d+To7SFZP8aSSmy53Ae1AwsoxDSwgr4z3nAxAsI
         bnQ90YffdslRz0Ljzh+QhPXYf3GAWNOtcjAAQG3FWLkTpejmlb837JdmpRdwvGoGv0BR
         8y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=USeCh6j0FsmLopx2MZxpLbxv8BeR2zl+0L2tQUmFxuY=;
        b=ZO0JS81XSQ6g+EgI5N+jBFSIf/F2t/xm2ZJT987Hpmv/Um25advrr+MVK0VJ9DMnSs
         c014P8vBeB1DeTX401c9LZM6jT+VydLhXmBOnSqh9nX2HUFzqX2afHMwCK1rVNO1h2Ng
         sux3+evPIs30uQwX+tFwrdmNbnFiJEL3MC7zX4VfGrMrWACM8gYNCYwo9zQUt07Xy8Pf
         ddBnDGVy6SdjUGDIlQ5gLjMT8i9C+Q0U/wOE0GWskmFK+nL7CflVVeDMVIYn+p9fZIMp
         S5kvR7SwGwdu3e6EIrB1Fyxho9xrNjIk8emCuP+VVnmL+sOlrrUcVTTgFOGCdNvnCJlO
         13QQ==
X-Gm-Message-State: AHQUAubUJb74RfwBqCLE0wMERcs1fxcmTB4Dvw9v4zMfKtMBaIy6jvj9
        FuU8jN1iUkZ68+rJyGr4FdWS2A==
X-Google-Smtp-Source: AHgI3IYzSMi38GNhzPEP+51nPuIlZiOKRKouOQIjBm3cBD5rK5Ii5RCR2yrpxd835hPI04jUPpyrtA==
X-Received: by 2002:a0c:8aa1:: with SMTP id 30mr3182502qvv.1.1549687309536;
        Fri, 08 Feb 2019 20:41:49 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r24sm5147743qtr.2.2019.02.08.20.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 20:41:48 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     andreyknvl@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] slub: fix SLAB_CONSISTENCY_CHECKS + KASAN_SW_TAGS
Date:   Fri,  8 Feb 2019 23:41:28 -0500
Message-Id: <20190209044128.3290-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling SLUB_DEBUG's SLAB_CONSISTENCY_CHECKS with KASAN_SW_TAGS
triggers endless false positives during boot below due to
check_valid_pointer() checks tagged pointers which have no addresses
that is valid within slab pages.

[    0.000000] BUG radix_tree_node (Tainted: G    B            ): Freelist Pointer check fails
[    0.000000] -----------------------------------------------------------------------------
[    0.000000]
[    0.000000] INFO: Slab 0x(____ptrval____) objects=69 used=69 fp=0x          (null) flags=0x7ffffffc000200
[    0.000000] INFO: Object 0x(____ptrval____) @offset=15060037153926966016 fp=0x(____ptrval____)
[    0.000000]
[    0.000000] Redzone (____ptrval____): bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 18 6b 06 00 08 80 ff d0  .........k......
[    0.000000] Object (____ptrval____): 18 6b 06 00 08 80 ff d0 00 00 00 00 00 00 00 00  .k..............
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Object (____ptrval____): 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    0.000000] Redzone (____ptrval____): bb bb bb bb bb bb bb bb                          ........
[    0.000000] Padding (____ptrval____): 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B             5.0.0-rc5+ #18
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x0/0x450
[    0.000000]  show_stack+0x20/0x2c
[    0.000000]  __dump_stack+0x20/0x28
[    0.000000]  dump_stack+0xa0/0xfc
[    0.000000]  print_trailer+0x1bc/0x1d0
[    0.000000]  object_err+0x40/0x50
[    0.000000]  alloc_debug_processing+0xf0/0x19c
[    0.000000]  ___slab_alloc+0x554/0x704
[    0.000000]  kmem_cache_alloc+0x2f8/0x440
[    0.000000]  radix_tree_node_alloc+0x90/0x2fc
[    0.000000]  idr_get_free+0x1e8/0x6d0
[    0.000000]  idr_alloc_u32+0x11c/0x2a4
[    0.000000]  idr_alloc+0x74/0xe0
[    0.000000]  worker_pool_assign_id+0x5c/0xbc
[    0.000000]  workqueue_init_early+0x49c/0xd50
[    0.000000]  start_kernel+0x52c/0xac4
[    0.000000] FIX radix_tree_node: Marking all objects used
[    0.000000]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1e3d0ec4e200..075ebc529788 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -507,6 +507,7 @@ static inline int check_valid_pointer(struct kmem_cache *s,
 		return 1;
 
 	base = page_address(page);
+	object = kasan_reset_tag(object);
 	object = restore_red_left(s, object);
 	if (object < base || object >= base + page->objects * s->size ||
 		(object - base) % s->size) {
-- 
2.17.2 (Apple Git-113)

