Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC85C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61CD20858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 04:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tLv15Ytr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61CD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIYKuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 06:50:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeIYKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 06:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wDvpu8H3Ikr//X/klTD2dMiWhainW0pREkRQNoQ66N0=; b=tLv15YtrA5V5wNI2oroTMSsKR
        r7FVBluvimuMza1U8nmsZyDPd6KJPR9rT0F6bbLxepa0lIAauI6Ks6bUkDUMgNoPYG06nXOHzm75S
        JIR6NjhHqlzuZNfOzmoURGCOR77f+7GpbupWaWV3H9UeCctfTGlpbG2QQe6RFDOwB9J4IbukF2IYH
        6SZg9/XWENDsCiDQR9iFJD7UN76mI6NHznYmoFF8my08NOodaF332x/DP+9WSvzaBYz8LMG4/ox+x
        uMIAqqE4oS8tskLDG9oi8D2IqJMkNC2s5WM2ilktAWkeAIiYZKAURY6vv9o+q50WVwZEHl4O/Qurm
        2q2xe7uNQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4fCv-0004Q8-GD; Tue, 25 Sep 2018 04:44:21 +0000
Date:   Mon, 24 Sep 2018 21:44:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
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
Message-ID: <20180925044421.GA11163@bombadil.infradead.org>
References: <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
 <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
 <20180924185753.GA32269@bombadil.infradead.org>
 <20180925001615.GA14386@ming.t460p>
 <20180925032826.GA4110@bombadil.infradead.org>
 <4a19ac2f-82c1-db55-9b93-4005ace5e2fe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a19ac2f-82c1-db55-9b93-4005ace5e2fe@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 09:10:43PM -0700, Bart Van Assche wrote:
> On 9/24/18 8:28 PM, Matthew Wilcox wrote:
> > [ ... ] Because if we have to
> > round all allocations below 64 bytes up to 64 bytes, [ ... ]
> Have you noticed that in another e-mail in this thread it has been explained
> why it is not necessary on x86 to align buffers allocated by kmalloc() on a
> 64-byte boundary even if these buffers are used for DMA?

Oh, so drivers which do this only break on !x86.  Yes, that'll work
out great.
