Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27AC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725022173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oBzkRlX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfAGUCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:02:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L2csFkuIpaJFSD1R4XQC20uR44/yfYBbN7aqwGxOgyU=; b=oBzkRlX7xTW5/t1XtBRxZj5rK
        0t4q3oP84C8TlYEhQA27GQZmgEBlWaRwYwmssd8McxRlW7jXyApnzWqb76naYCTf23pTXL0TIPcxl
        G2iS/EXKd/WENZU9xHPpA7q13PHV6QUMd6WdAElUnj69AZIU3sACm2tO8y6bj9XVGvs5uBbhfC5vJ
        VNEPuSME+Lw84E3OOTbqiV+qBddxzoU9ztnVclCSlE7fOtg8LACJRFtIgohCyz+D1Y4D0euVhIO0z
        LYxd0uFtk/uA8JwCgNHDqbQRj5h8Gz9lzIN+sNGE3MlIYoRrOHJKfQofaLUP/5hj9Ry9JFCQaXRpW
        6gl7o5zRQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggb6R-0003Vg-Ho; Mon, 07 Jan 2019 20:02:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm: Remove redundant test from find_get_pages_contig
Date:   Mon,  7 Jan 2019 12:02:24 -0800
Message-Id: <20190107200224.13260-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we establish a reference on the page, we check the pointer continues
to be in the correct position in i_pages.  There's no need to check the
page->mapping or page->index afterwards; if those can change after we've
got the reference, they can change after we return the page to the caller.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/filemap.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f5e323e883e6..935fbc29aeb13 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1837,16 +1837,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
 		if (unlikely(page != xas_reload(&xas)))
 			goto put_page;
 
-		/*
-		 * must check mapping and index after taking the ref.
-		 * otherwise we can get both false positives and false
-		 * negatives, which is just confusing to the caller.
-		 */
-		if (!page->mapping || page_to_pgoff(page) != xas.xa_index) {
-			put_page(page);
-			break;
-		}
-
 		pages[ret] = page;
 		if (++ret == nr_pages)
 			break;
-- 
2.20.1

