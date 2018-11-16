Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F51DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E275208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VeSo/jHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E275208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbeKPPwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:52:24 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:20768 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeKPPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:52:24 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id wAG5ecAP027159;
        Fri, 16 Nov 2018 14:40:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com wAG5ecAP027159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542346839;
        bh=5PnlOFqIrjmUDve9THM46Xu/J7k9W11ea4jWIoAESmU=;
        h=From:To:Cc:Subject:Date:From;
        b=VeSo/jHp6/Dip4hZPzh8MJXwuypQl+tUyqUatjwNxAI33n9oJSes0CKcsJEU7/JgN
         gUHDld6a5yq60RnG4X5AzyBqCGkOaT+39HqCHrG8//PuC+0n/tIIrqutX1LaqVcfVt
         pKoMzlHjeon96n6/5HydZBP4yNURSdkeyyRJdZRGhQcyTF3/Ti7JotJOq/lK9KgZoX
         hn4lqUc1ZhH/KinJzVFiU3J9jUJOSk8Qkb1VHp94lCznIdgL/ud31501zHDSetrsRU
         hxflNDf8BjqaAVqbCNbhM9nnXVGIaIQ+jF4lFIEUV8BnnLJYlueNqmaz9kUsV4PtIs
         0FnDlsmE10b/g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slab: fix 'dubious: x & !y' warning from Sparse
Date:   Fri, 16 Nov 2018 14:40:29 +0900
Message-Id: <1542346829-31063-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports:
./include/linux/slab.h:332:43: warning: dubious: x & !y

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 918f374..d395c73 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -329,7 +329,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 	 * If an allocation is both __GFP_DMA and __GFP_RECLAIMABLE, return
 	 * KMALLOC_DMA and effectively ignore __GFP_RECLAIMABLE
 	 */
-	return type_dma + (is_reclaimable & !is_dma) * KMALLOC_RECLAIM;
+	return type_dma + (is_reclaimable && !is_dma) * KMALLOC_RECLAIM;
 }
 
 /*
-- 
2.7.4

