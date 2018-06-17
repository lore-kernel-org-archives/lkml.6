Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B6AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AEF208B6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bNqe1cQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AEF208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934169AbeFQUEi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 16:04:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45132 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbeFQUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 16:04:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id z1-v6so6536205pgv.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1aEWhbYTu0k1BM5uwwCOuLuUj8CVLiw4bbQtiEWl9Ec=;
        b=bNqe1cQ9J9jg34xmSvy/mqCcjStYzyGG89M97bnhzpM/C6bHb0L0om2wns3fcZDIWl
         7w/PzlxPc9CuX2orLToQRuX3A/glEVg0qbvL7d0RhCv/ActvGlcj+Y+ZSpjZ2wko5SVV
         nyIoicpjj7hm4J/SnCoNCLKrOiX7u8e2ZLf/99uf8UMieZsAx8y3DkGSRfnbPT4EZEDq
         deua5QTtkQDQ/r7KmIYaIg09za6AkR5lHs4lKix07g0x4jkuhImdXccviADeMkYk//UW
         DwHGIs5+HqG1PIrHdWWR72DDPzpbpe8eyvbbZahbDg2D4ywaYiQzrvPo7bnjRf0nzump
         Vx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1aEWhbYTu0k1BM5uwwCOuLuUj8CVLiw4bbQtiEWl9Ec=;
        b=beGpwaXJ9sJYkDKV68wb7GcZBpTsaHOYS1Ofvy23cJUR1JOw6oE3wiP9aVwwpfqeHh
         i70bGUqBhY7wvkAXVwD9+kSCeEKkQrod8tliggKD+zF43UfcyQuJNoJlw4fVom6fuxEr
         d8C5XXcjzegrQuIv9br65ib62pwGfRtQQ4UkQlDhT8dVk37BVS8/iuzS4JJYkLhgZbAs
         rmUP3iIQJycffAS2sSWaxgVQ0ahhxsugBbTSOZ5XjZ35z76GmG5EWriHV9N9/2MZbKrK
         3tHwZRsUiCcuWp8J3QkmE6R4UiOB41G0SqisH8zXmer5A5BLYJzmm+10Ci1CNp77n3AH
         oCZg==
X-Gm-Message-State: APt69E2SwNAdgAL2jQqg2DB++ylfM0iWZLqGhu/U+Bq2vEBcNN22jXrJ
        00ghO3gIuCQGuwPboAMXcPnEH8gjO7M=
X-Google-Smtp-Source: ADUXVKJ55LedqgY67rhU36zNEYnl1+rk2SeD0CONNDqCR1zRkQHJxgN7EWLKqIylgw017Mzgn2Ba9g==
X-Received: by 2002:a62:1146:: with SMTP id z67-v6mr10595796pfi.135.1529265874328;
        Sun, 17 Jun 2018 13:04:34 -0700 (PDT)
Received: from ziepe.ca (S01061cabc0afab23.cg.shawcable.net. [68.146.141.74])
        by smtp.gmail.com with ESMTPSA id t17-v6sm21822917pfj.75.2018.06.17.13.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 13:04:33 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.89)
        (envelope-from <jgg@ziepe.ca>)
        id 1fUdua-00013h-Mn; Sun, 17 Jun 2018 14:04:32 -0600
Date:   Sun, 17 Jun 2018 14:04:32 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180617200432.krw36wrcwidb25cj@ziepe.ca>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 12:53:04PM -0700, Dan Williams wrote:
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 6db729dc4c50..37576f0a4645 100644
> > +++ b/mm/rmap.c
> > @@ -1360,6 +1360,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >                                 flags & TTU_SPLIT_FREEZE, page);
> >         }
> >
> > +       if (PageDmaPinned(page))
> > +               return false;
> >         /*
> >          * We have to assume the worse case ie pmd for invalidation. Note that
> >          * the page can not be free in this function as call of try_to_unmap()
> 
> We have a similiar problem with DAX and the conclusion we came to is
> that it is not acceptable for userspace to arbitrarily block kernel
> actions. The conclusion there was: 'wait' if the DMA is transient, and
> 'revoke' if the DMA is long lived, or otherwise 'block' long-lived DMA
> if a revocation mechanism is not available.

This might be the right answer for certain things, but it shouldn't be
the immediate reaction to everthing. There are many user APIs that
block kernel actions and hold kernel resources.

IMHO, there should be an identifiable objection, eg is blocking going
to create a DOS, dead-lock, insecurity, etc?

Jason
