Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5E8C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74812082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74812082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeJ3O6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:58:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:50376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbeJ3O6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:58:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 330CBACA7;
        Tue, 30 Oct 2018 06:06:04 +0000 (UTC)
Date:   Tue, 30 Oct 2018 07:06:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
Message-ID: <20181030060601.GR32673@dhcp22.suse.cz>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
 <20181029081706.GC32673@dhcp22.suse.cz>
 <1540862950.12374.40.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540862950.12374.40.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-10-18 09:29:10, Miles Chen wrote:
> On Mon, 2018-10-29 at 09:17 +0100, Michal Hocko wrote:
> > On Mon 29-10-18 09:07:08, Michal Hocko wrote:
> > [...]
> > > Besides that, the following doesn't make much sense to me. It simply
> > > makes no sense to use vmalloc for sub page allocation regardless of
> > > HIGHMEM.
> > 
> > OK, it is still early morning here. Now I get the point of the patch.
> > You just want to (ab)use highmeme for smaller requests. I do not like
> > this, to be honest. It causes an internal fragmentation and more
> > importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
> > have any 64b with HIGHMEM btw?) is quite small to be wasted like that.
> > 
> thanks for your comment. It looks like that using vmalloc fallback for
> sub page allocation is not good here.
> 
> Your comment gave another idea:
> 
> 1. force kbuf to PAGE_SIZE
> 2. allocate a page by alloc_page(GFP_KERNEL | __GFP_HIGHMEM); so we can
> get a highmem page if possible
> 3. use kmap/kunmap pair to create mapping for this page. No vmalloc
> space is used.
> 4. do not change kvmalloc logic.

If you mean for this particular situation then is this really worth
it? I mean this is a short term allocation for root only so you do not
have to worry about low mem depletion.

If you are thiking in more generic terms to allow kmalloc to use highmem
then I am not really sure this will work out.
-- 
Michal Hocko
SUSE Labs
