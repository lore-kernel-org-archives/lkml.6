Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E45C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098C1208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jiz1v/yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098C1208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeIYDNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:13:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeIYDNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mPr8K+6sp9gKpKbjou9LzZieACzDvEfRFHzlw1LN+rc=; b=jiz1v/ylHErK+5FDaMna2QCUq
        4TcO7ki9AqaL4yBAc0fGbIyb/IQS3Ugth9LXIctCurzN9Sb065o/MmylZ0vixckFXKLC39rya3J/o
        Kc75nCg/xPdvay6qQ7C1XgrML67aKQ0PzkF/vf2OaJi9ImGm2ROW2XPScaD88vyZDRxpflHU+1jCx
        90Pue4+dEKX+cuh73WeaX02gURaSTxIaYglwOftgHfI3yaQL1yDhAX8bfmnZFsDq20k8c6J2myUT4
        9Bl5NvZiVp/n5s09P2UpKANH8fNvQQKNpGCWLSrFr1wQEhN6BcF/HZN+KFMaEdR2+tUHSZzrsJQ/n
        aaLzyMOjA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4Y6T-0000eK-9W; Mon, 24 Sep 2018 21:09:13 +0000
Date:   Mon, 24 Sep 2018 14:09:13 -0700
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
Message-ID: <20180924210913.GB2542@bombadil.infradead.org>
References: <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
 <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
 <20180924185753.GA32269@bombadil.infradead.org>
 <1537818978.195115.25.camel@acm.org>
 <20180924204148.GA2542@bombadil.infradead.org>
 <1537822441.195115.32.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537822441.195115.32.camel@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:54:01PM -0700, Bart Van Assche wrote:
> On Mon, 2018-09-24 at 13:41 -0700, Matthew Wilcox wrote:
> > Good job snipping the part of my reply which addressed this.  Go read
> > DMA-API.txt yourself.  Carefully.
> 
> The snipped part did not contradict your claim that "You're not supposed to use
> kmalloc memory for DMA." In the DMA-API.txt document however there are multiple
> explicit statements that support allocating memory for DMA with kmalloc(). Here
> is one example from the DMA-API.txt section about dma_map_single():
> 
> 	Not all memory regions in a machine can be mapped by this API.
> 	Further, contiguous kernel virtual space may not be contiguous as
> 	physical memory.  Since this API does not provide any scatter/gather
> 	capability, it will fail if the user tries to map a non-physically
> 	contiguous piece of memory.  For this reason, memory to be mapped by
> 	this API should be obtained from sources which guarantee it to be
> 	physically contiguous (like kmalloc).

Since you're only interested in reading the parts which support your
viewpoint, I'll do the work for you.

        Memory coherency operates at a granularity called the cache
        line width.  In order for memory mapped by this API to operate
        correctly, the mapped region must begin exactly on a cache line
        boundary and end exactly on one (to prevent two separately mapped
        regions from sharing a single cache line).  Since the cache line size
        may not be known at compile time, the API will not enforce this
        requirement.  THEREFORE, IT IS RECOMMENDED THAT DRIVER WRITERS WHO
        DON'T TAKE SPECIAL CARE TO DETERMINE THE CACHE LINE SIZE AT RUN TIME
        ONLY MAP VIRTUAL REGIONS THAT BEGIN AND END ON PAGE BOUNDARIES (WHICH
        ARE GUARANTEED ALSO TO BE CACHE LINE BOUNDARIES).

