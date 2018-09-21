Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2B2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE2B2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbeIUHmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:42:43 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:25238 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeIUHmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:42:43 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 21 Sep 2018 11:26:11 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g3Afw-00089q-VT; Fri, 21 Sep 2018 11:56:09 +1000
Date:   Fri, 21 Sep 2018 11:56:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180921015608.GA31060@dastard>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
> Hi Guys,
> 
> Some storage controllers have DMA alignment limit, which is often set via
> blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.
> 
> Block layer now only checks if this limit is respected for buffer of
> pass-through request,
> see blk_rq_map_user_iov(), bio_map_user_iov().
> 
> The userspace buffer for direct IO is checked in dio path, see
> do_blockdev_direct_IO().
> IO buffer from page cache should be fine wrt. this limit too.
> 
> However, some file systems, such as XFS, may allocate single sector IO buffer
> via slab. Usually I guess kmalloc-512 should be fine to return
> 512-aligned buffer.
> But once KASAN or other slab debug options are enabled, looks this
> isn't true any
> more, kmalloc-512 may not return 512-aligned buffer. Then data corruption
> can be observed because the IO buffer from fs layer doesn't respect the DMA
> alignment limit any more.
> 
> Follows several related questions:
> 
> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
> yes, is it a stable rule?

It has behaved like this for both slab and slub for many, many
years.  A quick check indicates that at least XFS and hfsplus feed
kmalloc()d buffers straight to bios without any memory buffer
alignment checks at all.

> 2) If it is a rule for kmalloc-N slab to return N-byte aligned buffer,
> seems KASAN violates this
> rule?

XFS has been using kmalloc()d memory like this since 2012 and lots
of people use KASAN on XFS systems, including me. From this, it
would seem that the problem of mishandling unaligned memory buffers
is not widespread in the storage subsystem - it's taken years of
developers using slub debug and/or KASAN to find a driver that has
choked on an inappropriately aligned memory buffer....

> 3) If slab can't guarantee to return 512-aligned buffer, how to fix
> this data corruption issue?

I think that the block layer needs to check the alignment of memory
buffers passed to it and take appropriate action rather than
corrupting random memory and returning a sucess status to the bad
bio.

IMO, trusting higher layers of kernel code to get everything right
is somewhat naive. The block layer does not trust userspace to get
everything right for good reason and those same reasons extend to
kernel code. i.e. all software has bugs, we have an impossible
complex kernel config test matrix, and even if correctly written,
proven bug-free software existed, that perfect code can still
misbehave when things like memory corruption from other bad code or
hardware occurs.

From that persepective, I think that if the the receiver of a bio
has specific alignment requirements and the bio does not meet them,
then it needs to either enforce the alignment requirements (i.e.
error out) or make it right by bouncing the bio to an acceptible
alignment. Erroring out will cause things to fail hard until
whatever problem causing the error is fixed, while bouncing them
provides the "everything just works normally" solution...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
