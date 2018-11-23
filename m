Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA504C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B3820863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rgmDXiSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B3820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441055AbeKXEou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:44:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeKXEou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ilUvtvGAlq0RxOf3U5Kwm0YPD6DckdcEC5wYTtotjMk=; b=rgmDXiSUqHqzwqTbIsdvf/GQL
        W0HaH/Ev5eNCoCcNiYzY5QejkGOTJXpJ9S/Tc40paU/8V+XPuSrkiuCJY/9BPhhAAyyAV8Wso9gqG
        QIL26mzcWVl9rYTbpVh5t9ilvRedyQG3IS4L2bITcBaoVOA+KteMPkLcyJg/poc5Sv6ztwFPW3tvg
        TARkIX/xu8tRYLIy13KVg1vn1M8HZKJ4B86ZekHPLTzgtmpqPpgCYxku1kYdBHJCzbHdKtT1Ne++6
        CkeikBgoOHf2W2UGmyubGlWy3PCaxCXOTo6rfBboucMNC7w1Q8nf573DkcepUVsZyHQiek+ghlwsD
        2vZk4R6MA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQFjo-00011h-DE; Fri, 23 Nov 2018 17:59:32 +0000
Date:   Fri, 23 Nov 2018 09:59:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/2] mm: Remove redundant test from find_get_pages_contig
Message-ID: <20181123175932.GV3065@bombadil.infradead.org>
References: <20181122213224.12793-1-willy@infradead.org>
 <20181122213224.12793-2-willy@infradead.org>
 <20181123104732.gvhdqyddbsiq3i42@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123104732.gvhdqyddbsiq3i42@kshutemo-mobl1>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:47:32PM +0300, Kirill A. Shutemov wrote:
> On Thu, Nov 22, 2018 at 01:32:23PM -0800, Matthew Wilcox wrote:
> > After we establish a reference on the page, we check the pointer continues
> > to be in the correct position in i_pages.  There's no need to check the
> > page->mapping or page->index afterwards; if those can change after we've
> > got the reference, they can change after we return the page to the caller.
> 
> Hm. IIRC, page->mapping can be set to NULL due truncation, but what about
> index? When it can be changed? Truncation doesn't touch it.

I think index can only be changed after the refcount has hit zero and
the page is safely out of the pagecache.  I agree that page->mapping can
be set to NULL after the call to xas_reload() ... but then it can also
happen after the check, so the check isn't really buying us anything
that the xas_reload() call doesn't already check.
