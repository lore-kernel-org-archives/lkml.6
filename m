Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91962C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CA821473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KeBUucrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CA821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeJFEtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:49:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38461 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJFEtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:49:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so7407284plr.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RmpIuzTYoCLJjlcKuFXKb3VkkcNBiZBingQdKG49O2U=;
        b=KeBUucrvIMPO1hFGRZgn+8VgPuVhEnRElgOzBYR/t91HM+6MGrFVSj0DSihFfukbKN
         JcQMEYmjzBDS/cNhKHzShQezYv/mdojZz50LsUx7evAJnjmA7Ov1ArP2ry/pdYeTEAz2
         3UQe4c5vUzDmNmW82gebzhrj8C2ulZMzN8Qa+prif7x72p5YFsZX9fzQgDseco31wzqC
         tOrDPUJ+oaKE8xvNUuhBGx8u7eNsnZ5n4VAVcs64Gdf+zn+h3xaumJFBqwRSBCOV8nfJ
         SmphB5rQDzLESHJif5N+Akr2bbgns1uniclcbnXOFnOXmlXQCmWT9P31rqCY5/gowtb6
         BXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RmpIuzTYoCLJjlcKuFXKb3VkkcNBiZBingQdKG49O2U=;
        b=EV97jII9dR7qj9JA7kY6iMeAA1zaWHnpo9orcQT9ry6ar1ythQBtdHrdHlArSnGwgO
         mpjYw36Flyyuz/LtKmFKNVPHP13rlU47RJz7EvVxQiovx0gnCEg7HmQE6NgA0STaZnuH
         bAXjuaaGaQm4NatpInd9FUAIMu/fHh7W6Ph2Lh3VEbrConoUvE4wRrkZGm9mf5c2/uhF
         7as6exyUp/LEJqVPftYS/cmRYkXtr7J2/cRRUQsLQPaqS0w4v0hqvWQF0B/ss+AGZsKJ
         POd8ThcgC7RHz5iEA10Xg8ldQIctVKufXdEDjrQLckfihdaFdnG6gcHwQSqZAEgRqO/z
         sOxg==
X-Gm-Message-State: ABuFfojG5Tbqd8QVj4AvwljXF/43TTqE6yok7wofCx0crf5oqCW373z3
        Bt44AiyFPrjm33Gf80v4QLcC6g==
X-Google-Smtp-Source: ACcGV632Dp38QUy6gGHK00OshA/PYdSBC5NWHgfNGseXoglN+rQ5ebDMYyp0AE49Uhj4ohuFk6fCHQ==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13-v6mr13425633plm.114.1538776110327;
        Fri, 05 Oct 2018 14:48:30 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s13-v6sm13600379pfj.105.2018.10.05.14.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 14:48:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g8XxS-0001Fx-HM; Fri, 05 Oct 2018 15:48:26 -0600
Date:   Fri, 5 Oct 2018 15:48:26 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/3] mm: introduce put_user_page[s](), placeholder
 versions
Message-ID: <20181005214826.GD20776@ziepe.ca>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
 <20181005040225.14292-3-jhubbard@nvidia.com>
 <20181005151726.GA20776@ziepe.ca>
 <c6f31004-3a67-880b-47bb-b560dfd85343@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f31004-3a67-880b-47bb-b560dfd85343@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 12:49:06PM -0700, John Hubbard wrote:
> On 10/5/18 8:17 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 04, 2018 at 09:02:24PM -0700, john.hubbard@gmail.com wrote:
> >> From: John Hubbard <jhubbard@nvidia.com>
> >>
> >> Introduces put_user_page(), which simply calls put_page().
> >> This provides a way to update all get_user_pages*() callers,
> >> so that they call put_user_page(), instead of put_page().
> >>
> >> Also introduces put_user_pages(), and a few dirty/locked variations,
> >> as a replacement for release_pages(), for the same reasons.
> >> These may be used for subsequent performance improvements,
> >> via batching of pages to be released.
> >>
> >> This prepares for eventually fixing the problem described
> >> in [1], and is following a plan listed in [2], [3], [4].
> >>
> >> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
> >>
> >> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
> >>     Proposed steps for fixing get_user_pages() + DMA problems.
> >>
> >> [3]https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
> >>     Bounce buffers (otherwise [2] is not really viable).
> >>
> >> [4] https://lkml.kernel.org/r/20181003162115.GG24030@quack2.suse.cz
> >>     Follow-up discussions.
> >>
> [...]
> >>  
> >> +/* Placeholder version, until all get_user_pages*() callers are updated. */
> >> +static inline void put_user_page(struct page *page)
> >> +{
> >> +	put_page(page);
> >> +}
> >> +
> >> +/* For get_user_pages*()-pinned pages, use these variants instead of
> >> + * release_pages():
> >> + */
> >> +static inline void put_user_pages_dirty(struct page **pages,
> >> +					unsigned long npages)
> >> +{
> >> +	while (npages) {
> >> +		set_page_dirty(pages[npages]);
> >> +		put_user_page(pages[npages]);
> >> +		--npages;
> >> +	}
> >> +}
> > 
> > Shouldn't these do the !PageDirty(page) thing?
> > 
> 
> Well, not yet. This is the "placeholder" patch, in which I planned to keep
> the behavior the same, while I go to all the get_user_pages call sites and change 
> put_page() and release_pages() over to use these new routines.

Hmm.. Well, if it is the right thing to do here, why not include it and
take it out of callers when doing the conversion?

If it is the wrong thing, then let us still take it out of callers
when doing the conversion :)

Just seems like things will be in a better place to make future
changes if all the call sights are de-duplicated and correct.

Jason
