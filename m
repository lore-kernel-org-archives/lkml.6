Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6185C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C320863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQB+NfYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2C320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440808AbeKXEEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:04:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391344AbeKXEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+tDJPqADyLK0s+AAhHSK1fHW/0Vyl+qrtSAs4K3JO4A=; b=PQB+NfYX5LrUF95Q8HBSqrA0L
        U9wX2S8r/H5zfbFePeMTCtFPYeVNlLCjEbS/uDup5JiXlcjXBIT0Ey8GuZKVBw8kMA8Ens6z1hSFD
        wPS9s0J/f3SBdksVSwabEbDuq945oSTUIS9jZK6Kz1ZRnRNfdBSocLiSwEsZx+kXL0D+JV0vjXBDw
        v6SK46/Os1FOIFNvVidmQdPbO2DBtleRBzcvyjytQ/t9QnEKM7viTkYcdlevdSdeexjiel1gHkzch
        YkEMKYoPymenHZsY2Ts3eu1jjpfHxRQQQ4H90EQ8CB2nK1TpZMH4LKMrx3IS4GYo3M4zUFGdzah3m
        G4pqphH5A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQF6a-00046D-Cz; Fri, 23 Nov 2018 17:19:00 +0000
Date:   Fri, 23 Nov 2018 09:19:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 2/2] page cache: Store only head pages in i_pages
Message-ID: <20181123171900.GU3065@bombadil.infradead.org>
References: <20181122213224.12793-1-willy@infradead.org>
 <20181122213224.12793-3-willy@infradead.org>
 <20181123105643.fxqk7l57rdurdubx@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123105643.fxqk7l57rdurdubx@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:56:44PM +0300, Kirill A. Shutemov wrote:
> On Thu, Nov 22, 2018 at 01:32:24PM -0800, Matthew Wilcox wrote:
> > Transparent Huge Pages are currently stored in i_pages as pointers to
> > consecutive subpages.  This patch changes that to storing consecutive
> > pointers to the head page in preparation for storing huge pages more
> > efficiently in i_pages.
> 
> I probably miss something, I don't see how it wouldn't break
> split_huge_page().
> 
> I don't see what would replace head pages in i_pages with
> formerly-tail-pages?

You're quite right.  Where's your test-suite?  ;-)

I think this should do the job:

+++ b/mm/huge_memory.c
@@ -2464,6 +2464,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
                        if (IS_ENABLED(CONFIG_SHMEM) && PageSwapBacked(head))
                                shmem_uncharge(head->mapping->host, 1);
                        put_page(head + i);
+               } else if (!PageAnon(page)) {
+                       __xa_store(&head->mapping->i_pages, head[i].index,
+                                       head + i, 0);
                }
        }
 

Having looked at this area, I think there was actually a bug in the patch
you wrote that I'm cribbing from.  You inserted the tail pages before
calling __split_huge_page_tail(), so a racing lookup would have found
a tail page before it got transformed into a non-tail page.
