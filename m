Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64262C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF39D206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="nmhwRqzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLXHWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:22:12 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:51353 "EHLO owa.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbeLXHWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:22:12 -0500
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Dec 2018 02:22:11 EST
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1545635207; h=from:subject:to:date:message-id;
        bh=o0/BudkDeESOycxFk/umCyHG5IkeZqskpiWlXBC69Q4=;
        b=nmhwRqzQ07gUiioaiKFdiBA+jxJ7wFj76CcLT+C+2QdxBTaXMuf3WPj9M/DqtlhUCneHtg4869h
        Yy6FKRW8H20ohFcS//U0Mnqww4qEfSby57FxCkLVa0YJmHhPVpDG/vR45F3N8Cm3Rxkg6G8y+B+M3
        +zV2+RIhxe3TVTnSvAU=
Received: from localhost.localdomain (10.101.1.99) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Mon, 24 Dec 2018 15:06:47 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <sfr@canb.auug.org.au>, <alexey.skidanov@intel.com>,
        <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 1/2] lib/genalloc.c: Use the vzalloc_node to allocate the bitmap.
Date:   Mon, 24 Dec 2018 15:06:21 +0800
Message-ID: <20181224070622.22197-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.1.99]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may have over 1G memory on chip.
In some cases, the nbytes may big then 4M which is the bounday of
the memory buddy system. So use vzalloc_node() to allocate the bitmap.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 lib/genalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 5deb25c40a5a..0d0ff9f0483f 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -187,7 +187,7 @@ int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phy
 	int nbytes = sizeof(struct gen_pool_chunk) +
 				BITS_TO_LONGS(nbits) * sizeof(long);
 
-	chunk = kzalloc_node(nbytes, GFP_KERNEL, nid);
+	chunk = vzalloc_node(nbytes, nid);
 	if (unlikely(chunk == NULL))
 		return -ENOMEM;
 
-- 
2.17.1

