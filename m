Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D530BC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DC5218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfB0Ffp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 00:35:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbfB0Ffo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 00:35:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F5E9C718E25090FC042;
        Wed, 27 Feb 2019 13:35:39 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.201)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 27 Feb 2019 13:35:29
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] staging: erofs: fix illegal address access under memory pressure
Date:   Wed, 27 Feb 2019 13:33:31 +0800
Message-ID: <20190227053332.38504-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190227053332.38504-1-gaoxiang25@huawei.com>
References: <20190227053332.38504-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering a read request with two decompressed file pages,
If a decompression work cannot be started on the previous page
due to memory pressure but in-memory LTP map lookup is done,
builder->work should be still NULL.

Moreover, if the current page also belongs to the same map,
it won't try to start the decompression work again and then
run into trouble.

This patch aims to solve the above issue only with little changes
as much as possible in order to make the fix backport easier.

kernel message is:
<4>[1051408.015930s]SLUB: Unable to allocate memory on node -1, gfp=0x2408040(GFP_NOFS|__GFP_ZERO)
<4>[1051408.015930s]  cache: erofs_compress, object size: 144, buffer size: 144, default order: 0, min order: 0
<4>[1051408.015930s]  node 0: slabs: 98, objs: 2744, free: 0
  * Cannot allocate the decompression work

<3>[1051408.015960s]erofs: z_erofs_vle_normalaccess_readpages, readahead error at page 1008 of nid 5391488
  * Note that the previous page was failed to read

<0>[1051408.015960s]Internal error: Accessing user space memory outside uaccess.h routines: 96000005 [#1] PREEMPT SMP
...
<4>[1051408.015991s]Hardware name: kirin710 (DT)
...
<4>[1051408.016021s]PC is at z_erofs_vle_work_add_page+0xa0/0x17c
<4>[1051408.016021s]LR is at z_erofs_do_read_page+0x12c/0xcf0
...
<4>[1051408.018096s][<ffffff80c6fb0fd4>] z_erofs_vle_work_add_page+0xa0/0x17c
<4>[1051408.018096s][<ffffff80c6fb3814>] z_erofs_vle_normalaccess_readpages+0x1a0/0x37c
<4>[1051408.018096s][<ffffff80c6d670b8>] read_pages+0x70/0x190
<4>[1051408.018127s][<ffffff80c6d6736c>] __do_page_cache_readahead+0x194/0x1a8
<4>[1051408.018127s][<ffffff80c6d59318>] filemap_fault+0x398/0x684
<4>[1051408.018127s][<ffffff80c6d8a9e0>] __do_fault+0x8c/0x138
<4>[1051408.018127s][<ffffff80c6d8f90c>] handle_pte_fault+0x730/0xb7c
<4>[1051408.018127s][<ffffff80c6d8fe04>] __handle_mm_fault+0xac/0xf4
<4>[1051408.018157s][<ffffff80c6d8fec8>] handle_mm_fault+0x7c/0x118
<4>[1051408.018157s][<ffffff80c8c52998>] do_page_fault+0x354/0x474
<4>[1051408.018157s][<ffffff80c8c52af8>] do_translation_fault+0x40/0x48
<4>[1051408.018157s][<ffffff80c6c002f4>] do_mem_abort+0x80/0x100
<4>[1051408.018310s]---[ end trace 9f4009a3283bd78b ]---

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 416dde4e8ea1..74c13b0a3d33 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -698,8 +698,12 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 
 	/* lucky, within the range of the current map_blocks */
 	if (offset + cur >= map->m_la &&
-		offset + cur < map->m_la + map->m_llen)
+		offset + cur < map->m_la + map->m_llen) {
+		/* didn't get a valid unzip work previously (very rare) */
+		if (!builder->work)
+			goto restart_now;
 		goto hitted;
+	}
 
 	/* go ahead the next map_blocks */
 	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
@@ -713,6 +717,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	if (unlikely(err))
 		goto err_out;
 
+restart_now:
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
 		goto hitted;
 
-- 
2.14.5

