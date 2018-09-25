Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35700C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17EC2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17EC2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIYGVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeIYGVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:21:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C893281DF3;
        Tue, 25 Sep 2018 00:16:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A741980D;
        Tue, 25 Sep 2018 00:16:20 +0000 (UTC)
Date:   Tue, 25 Sep 2018 08:16:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20180925001615.GA14386@ming.t460p>
References: <20180923224206.GA13618@ming.t460p>
 <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
 <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
 <1537801706.195115.7.camel@acm.org>
 <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com>
 <1537804720.195115.9.camel@acm.org>
 <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
 <20180924185753.GA32269@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924185753.GA32269@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 25 Sep 2018 00:16:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:57:53AM -0700, Matthew Wilcox wrote:
> On Mon, Sep 24, 2018 at 09:19:44AM -0700, Bart Van Assche wrote:
> > That means that two buffers allocated with kmalloc() may share a cache line on
> > x86-64. Since it is allowed to use a buffer allocated by kmalloc() for DMA, can
> > this lead to data corruption, e.g. if the CPU writes into one buffer allocated
> > with kmalloc() and a device performs a DMA write to another kmalloc() buffer and
> > both write operations affect the same cache line?
> 
> You're not supposed to use kmalloc memory for DMA.  This is why we have
> dma_alloc_coherent() and friends.  Also, from DMA-API.txt:

Please take a look at USB drivers, or storage drivers or scsi layer. Lot of
DMA buffers are allocated via kmalloc.

Also see the following description in DMA-API-HOWTO.txt:

	If the device supports DMA, the driver sets up a buffer using kmalloc() or
	a similar interface, which returns a virtual address (X).  The virtual
	memory system maps X to a physical address (Y) in system RAM.  The driver
	can use virtual address X to access the buffer, but the device itself
	cannot because DMA doesn't go through the CPU virtual memory system.

Also still see DMA-API-HOWTO.txt:

Types of DMA mappings
=====================

There are two types of DMA mappings:

- Consistent DMA mappings which are usually mapped at driver
  initialization, unmapped at the end and for which the hardware should
  guarantee that the device and the CPU can access the data
  in parallel and will see updates made by each other without any
  explicit software flushing.

  Think of "consistent" as "synchronous" or "coherent".


- Streaming DMA mappings which are usually mapped for one DMA
  transfer, unmapped right after it (unless you use dma_sync_* below)
  and for which hardware can optimize for sequential accesses.



Thanks,
Ming
