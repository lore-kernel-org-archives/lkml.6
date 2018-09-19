Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44599C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82A1214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82A1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbeISPkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeISPkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:40:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 234D2C047B69;
        Wed, 19 Sep 2018 10:03:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2BA3272D8;
        Wed, 19 Sep 2018 10:03:02 +0000 (UTC)
Date:   Wed, 19 Sep 2018 18:02:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180919100256.GD23172@ming.t460p>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <877ejh3jv0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ejh3jv0.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 19 Sep 2018 10:03:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

On Wed, Sep 19, 2018 at 11:41:07AM +0200, Vitaly Kuznetsov wrote:
> Ming Lei <tom.leiming@gmail.com> writes:
> 
> > Hi Guys,
> >
> > Some storage controllers have DMA alignment limit, which is often set via
> > blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.
> 
> While mostly drivers use 512-byte alignment it is not a rule of thumb,
> 'git grep' tell me we have:
> ide-cd.c with 32-byte alignment
> ps3disk.c and rsxx/dev.c with variable alignment.
> 
> What if our block configuration consists of several devices (in raid
> array, for example) with different requirements, e.g. one requiring
> 512-byte alignment and the other requiring 256?

512-byte alignment is also 256-byte aligned, and the sector size is 512 byte.

> 
> >
> > Block layer now only checks if this limit is respected for buffer of
> > pass-through request,
> > see blk_rq_map_user_iov(), bio_map_user_iov().
> >
> > The userspace buffer for direct IO is checked in dio path, see
> > do_blockdev_direct_IO().
> > IO buffer from page cache should be fine wrt. this limit too.
> >
> > However, some file systems, such as XFS, may allocate single sector IO buffer
> > via slab. Usually I guess kmalloc-512 should be fine to return
> > 512-aligned buffer.
> > But once KASAN or other slab debug options are enabled, looks this
> > isn't true any
> > more, kmalloc-512 may not return 512-aligned buffer. Then data corruption
> > can be observed because the IO buffer from fs layer doesn't respect the DMA
> > alignment limit any more.
> >
> > Follows several related questions:
> >
> > 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
> > yes, is it a stable rule?
> >
> > 2) If it is a rule for kmalloc-N slab to return N-byte aligned buffer,
> > seems KASAN violates this
> > rule?
> 
> (as I was kinda involved in debugging): the issue was observed with SLUB
> allocator KASAN is not to blame, everything wich requires aditional
> metadata space will break this, see e.g. calculate_sizes() in slub.c

Buffer allocated via kmalloc() should be aligned with L1 HW cache size
at least.

I have raised the question: does kmalloc-512 slab guarantee to return
512-byte aligned buffer, let's see what the answer is from MM guys,:-) 

From the Red Hat BZ, looks I understand this issue is only triggered when
KASAN is enabled, or you have figured out how to reproduce it without
KASAN involved?

> 
> >
> > 3) If slab can't guarantee to return 512-aligned buffer, how to fix
> > this data corruption issue?
> 
> I'm no expert in block layer but in case of complex block device
> configurations when bio submitter can't know all the requirements I see
> no other choice than bouncing.

I guess that might be the last straw, given the current way without
bouncing works for decades, and seems no one complains before.

Thanks,
Ming
