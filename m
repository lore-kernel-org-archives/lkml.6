Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88207C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4854D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eTFshXAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4854D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438929AbeKWINt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:13:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeKWINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=21pgTH4nPwYMtfybAiOSoRz5R27AR1FrdXTO1XlQXYY=; b=eTFshXAgAJQAxCBZKbL3dpgrn
        zKL49ibd5UXIuPJ/EeSFwG51NqZ3wDYUFs0YJKTtZycS6CDqvOK/7HThwURimjQFDD4F6RX4OXkJg
        9LNGXXsQnbEjrGxeeMQcwLZoB8iUczK7rb/CUMJs3CW1y2TnrRJ700HWIgRJsJNmFiGzSMxZTuwSg
        wmAqGIZN5VC+J0nFZnWtGgtAS9pIvX5y1ZdQU5Bjw5BMKzYJ/dbRJ+05VoXtGkAfPljA3PoorTs20
        hHKZkZgY9h07PpxFfbXG7YO566nn74Ocn6VJplwJxKdekSUozfD9ZPNKKyVzot0r337KNXvUJWcs1
        Kabo2mRFA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPwaR-0003LR-8h; Thu, 22 Nov 2018 21:32:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/2] mm: Remove redundant test from find_get_pages_contig
Date:   Thu, 22 Nov 2018 13:32:23 -0800
Message-Id: <20181122213224.12793-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122213224.12793-1-willy@infradead.org>
References: <20181122213224.12793-1-willy@infradead.org>
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
index 81adec8ee02cc..538531590ef2d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1776,16 +1776,6 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
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
2.19.1

