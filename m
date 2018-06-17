Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F5CC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD99A20895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SgMqnn/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD99A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936525AbeFQCJ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:09:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933944AbeFQCBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QGWajXY6YcCVi/fqymIb3c788sAMALnbzKJrf6tBoCc=; b=SgMqnn/8xfz2IiRU7lHnx/TBQ
        aMfcp0dcLWY+F41KJ9xNXcl1kVHMcfojiyv+6mfWW+nsqMK1cJmfmtywd8rZN6kbXZqOzrTNRgLbn
        IKdpY99/3Bcwf4wIluHRrERHG/bvPiBcKAH6QinISQUF0FAM0DMybtSx4WvKotbChxSzbiNfq3PTi
        VFgg4eUMGRdQs3NjKJnoStI5jRB7D3/nrEFx8tFWIwZhyMd2IOTFvjN2UJhGb1b2x0NFwNeGCntMx
        PeAAkzImw2KNN5zdCmvdMwwSGXv6dibwUL/4qjfWLtHB35ute1Z8LY3HSnUF59S/c3g54vG3B++7W
        DGGYIMFFA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN07-0001N4-BU; Sun, 17 Jun 2018 02:01:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v14 45/74] mm: Convert is_page_cache_freeable to XArray
Date:   Sat, 16 Jun 2018 19:00:23 -0700
Message-Id: <20180617020052.4759-46-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a variable rename and comment change.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/vmscan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0448b1b366d9..575747728ee6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -572,12 +572,12 @@ static inline int is_page_cache_freeable(struct page *page)
 {
 	/*
 	 * A freeable page cache page is referenced only by the caller
-	 * that isolated the page, the page cache radix tree and
-	 * optional buffer heads at page->private.
+	 * that isolated the page, the page cache and optional buffer
+	 * heads at page->private.
 	 */
-	int radix_pins = PageTransHuge(page) && PageSwapCache(page) ?
+	int page_cache_pins = PageTransHuge(page) && PageSwapCache(page) ?
 		HPAGE_PMD_NR : 1;
-	return page_count(page) - page_has_private(page) == 1 + radix_pins;
+	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
 }
 
 static int may_write_to_inode(struct inode *inode, struct scan_control *sc)
-- 
2.17.1

