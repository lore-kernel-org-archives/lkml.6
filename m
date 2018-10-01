Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94346C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1422064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VSKlpbDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1422064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeJAT16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:27:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbeJAT16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NonZwhYN1xJ/vVVD3nbyJq69mXPUQ3mi0852cfgwYIA=; b=VSKlpbDhFhqm38A6Uv1txT8Ih
        Tc7wr5SGUgkak9snJm4Y9Rr1Bb3fWwQCSLWsI5hEF4p3+Sv90RIWCFzuI9y+aRgqzpZdPsmbQ8KgR
        bhUnlwNPoYFYmT8GtAJu/egkUBXc8JQNvN6jgFMu5sjvZNWyAe9VV6keAZzAk9owGBqqTqJ6hOU3W
        kWVg9SG6gzt3EyJSbsWod3G3AjXhb5yG6EXM14phBvIhMzfJxmR/Kk3UChoMb9t0OD5JTbhubB5c5
        UJVwJd4AeKe/HUVRMQURMA6yURrJGOHBYq/2WSGutqbXyVhYGNusv9qIwZZCCfajwjLdC9023tstF
        Mhh3xq1IQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g6xeP-0002ww-Oi; Mon, 01 Oct 2018 12:50:13 +0000
Date:   Mon, 1 Oct 2018 05:50:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        john.hubbard@gmail.com, Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH 3/4] infiniband/mm: convert to the new put_user_page()
 call
Message-ID: <20181001125013.GA6357@infradead.org>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
 <20180928053949.5381-3-jhubbard@nvidia.com>
 <20180928153922.GA17076@ziepe.ca>
 <36bc65a3-8c2a-87df-44fc-89a1891b86db@nvidia.com>
 <20180929162117.GA31216@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929162117.GA31216@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 09:21:17AM -0700, Matthew Wilcox wrote:
> > being slow to pick it up. It looks like there are several patterns, and
> > we have to support both set_page_dirty() and set_page_dirty_lock(). So
> > the best combination looks to be adding a few variations of
> > release_user_pages*(), but leaving put_user_page() alone, because it's
> > the "do it yourself" basic one. Scatter-gather will be stuck with that.
> 
> I think our current interfaces are wrong.  We should really have a
> get_user_sg() / put_user_sg() function that will set up / destroy an
> SG list appropriate for that range of user memory.  This is almost
> orthogonal to the original intent here, so please don't see this as a
> "must do first" kind of argument that might derail the whole thing.

The SG list really is the wrong interface, as it mixes up information
about the pages/phys addr range and a potential dma mapping.  I think
the right interface is an array of bio_vecs.  In fact I've recently
been looking into a get_user_pages variant that does fill bio_vecs,
as it fundamentally is the right thing for doing I/O on large pages,
and will really help with direct I/O performance in that case.
