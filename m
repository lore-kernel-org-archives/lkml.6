Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B7A2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wg8v54vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B7A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeIYJd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:33:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48276 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeIYJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5CbcUBYBFIPCmPwBa2J163ZQiedLk4RMXohWTq7HAx0=; b=Wg8v54vxqBNf5QISNIJxqTnw+
        oFNxWusaQXeCFQN/8dwTJrgh2OYVQclkDnxt2acQ6a7yI0RZsEWYw+ZHY4XV9Szofq9wsVW73vhGX
        HDOGQ9Wa91MVLqx+MXv6bjRegtRRiTgyIOxazhSijOYqt+8M3fW/GNsAnvRYwqstXi3sfLgbZlbjC
        08VTHD5zGDOxG8iJ71uVFDxalEis6Fw5dlB+fi2xGn+5S7b38L6Ynzo4wLfrOqyJqRbFYx+Zl65k6
        h0Ibou6AyQS2IMFa5gyz/ESOzHuc86NjrVvCwJ8NnTvM1CZztF2sYL4mqd38j6NhsSfSlBIFnD6bv
        b0NK4RSzw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4e1S-0001Ej-Tx; Tue, 25 Sep 2018 03:28:26 +0000
Date:   Mon, 24 Sep 2018 20:28:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180925032826.GA4110@bombadil.infradead.org>
References: <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
 <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
 <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
 <20180924185753.GA32269@bombadil.infradead.org>
 <20180925001615.GA14386@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925001615.GA14386@ming.t460p>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:16:16AM +0800, Ming Lei wrote:
> On Mon, Sep 24, 2018 at 11:57:53AM -0700, Matthew Wilcox wrote:
> > On Mon, Sep 24, 2018 at 09:19:44AM -0700, Bart Van Assche wrote:
> > You're not supposed to use kmalloc memory for DMA.  This is why we have
> > dma_alloc_coherent() and friends.  Also, from DMA-API.txt:
> 
> Please take a look at USB drivers, or storage drivers or scsi layer. Lot of
> DMA buffers are allocated via kmalloc.

Then we have lots of broken places.  I mean, this isn't new.  We used
to have lots of broken places that did DMA to the stack.  And then
the stack was changed to be vmalloc'ed and all those places got fixed.
The difference this time is that it's only certain rare configurations
that are broken, and the brokenness is only found by corruption in some
fairly unlikely scenarios.

> Also see the following description in DMA-API-HOWTO.txt:
> 
> 	If the device supports DMA, the driver sets up a buffer using kmalloc() or
> 	a similar interface, which returns a virtual address (X).  The virtual
> 	memory system maps X to a physical address (Y) in system RAM.  The driver
> 	can use virtual address X to access the buffer, but the device itself
> 	cannot because DMA doesn't go through the CPU virtual memory system.

Sure, but that's not addressing the cacheline coherency problem.

Regardless of what the docs did or didn't say, let's try answering
the question: what makes for a more useful system?

A: A kmalloc implementation which always returns an address suitable
for mapping using the DMA interfaces

B: A kmalloc implementation which is more efficient, but requires drivers
to use a different interface for allocating space for the purposes of DMA

I genuinely don't know the answer to this question, and I think there are
various people in this thread who believe A or B quite strongly.

I would also like to ask people who believe in A what should happen in
this situation:

        blocks = kmalloc(4, GFP_KERNEL);
        sg_init_one(&sg, blocks, 4);
...
        result = ntohl(*blocks);
        kfree(blocks);

(this is just one example; there are others).  Because if we have to
round all allocations below 64 bytes up to 64 bytes, that's going to be
a memory consumption problem.  On my laptop:

kmalloc-96         11527  15792     96   42    1 : slabdata    376    376      0
kmalloc-64         54406  62912     64   64    1 : slabdata    983    983      0
kmalloc-32         80325  84096     32  128    1 : slabdata    657    657      0
kmalloc-16         26844  30208     16  256    1 : slabdata    118    118      0
kmalloc-8          17141  21504      8  512    1 : slabdata     42     42      0

I make that an extra 1799 pages (7MB).  Not the end of the world, but
not free either.
