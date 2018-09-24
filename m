Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDFFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF222086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IvcNmsaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF222086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbeIYBBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:01:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIYBBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k7iQCXwMvlhTNvfq6aPrxiTLrLx04wD5o2gOyZQCUnI=; b=IvcNmsaIWJB7U+vnVoPprpgaZ
        Rh+p0blwp3P4hvb+SmnSOmI8TuUd09L9g3D5fmhCNfo0b9o4koeEY3PN+8UizNuYBgTvrQNLHl6ZO
        IWRXQ0MqHaKq4tvLRbuQaOA07K+B0Ta6LjoEb2idpQMV736CUOznrKzakj1xqXKHcpFJslkKYLS7f
        +nlMTB8INvmiCWUDBXmjnSsupA+hYQJhE3XEgbUyrRF4mDobuEeCt9Q6sPUHlIjEULe68Ukizr+99
        YEHbNXmNUXgH0r6TabxeLU5/bc1oksLZxqvSM79yYU6n9fbTNxoXr6Yl4xkSdkVV2bYPnxHeqw0g9
        9WePqATsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4W3O-0007B1-2b; Mon, 24 Sep 2018 18:57:54 +0000
Date:   Mon, 24 Sep 2018 11:57:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ming Lei <ming.lei@redhat.com>,
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
Message-ID: <20180924185753.GA32269@bombadil.infradead.org>
References: <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180923224206.GA13618@ming.t460p>
 <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
 <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
 <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537805984.195115.14.camel@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 09:19:44AM -0700, Bart Van Assche wrote:
> That means that two buffers allocated with kmalloc() may share a cache line on
> x86-64. Since it is allowed to use a buffer allocated by kmalloc() for DMA, can
> this lead to data corruption, e.g. if the CPU writes into one buffer allocated
> with kmalloc() and a device performs a DMA write to another kmalloc() buffer and
> both write operations affect the same cache line?

You're not supposed to use kmalloc memory for DMA.  This is why we have
dma_alloc_coherent() and friends.  Also, from DMA-API.txt:

        Memory coherency operates at a granularity called the cache
        line width.  In order for memory mapped by this API to operate
        correctly, the mapped region must begin exactly on a cache line
        boundary and end exactly on one (to prevent two separately mapped
        regions from sharing a single cache line).  Since the cache line size
        may not be known at compile time, the API will not enforce this
        requirement.  Therefore, it is recommended that driver writers who
        don't take special care to determine the cache line size at run time
        only map virtual regions that begin and end on page boundaries (which
        are guaranteed also to be cache line boundaries).

