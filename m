Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9968AECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D3E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D3E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbeITHJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeITHJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:09:30 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C45E7821CC;
        Thu, 20 Sep 2018 01:28:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E79B75C158;
        Thu, 20 Sep 2018 01:28:41 +0000 (UTC)
Date:   Thu, 20 Sep 2018 09:28:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180920012836.GA27645@ming.t460p>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <877ejh3jv0.fsf@vitty.brq.redhat.com>
 <20180919100256.GD23172@ming.t460p>
 <8736u53fij.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736u53fij.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 20 Sep 2018 01:28:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:15:00PM +0200, Vitaly Kuznetsov wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > Hi Vitaly,
> >
> > On Wed, Sep 19, 2018 at 11:41:07AM +0200, Vitaly Kuznetsov wrote:
> >> Ming Lei <tom.leiming@gmail.com> writes:
> >> 
> >> > Hi Guys,
> >> >
> >> > Some storage controllers have DMA alignment limit, which is often set via
> >> > blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.
> >> 
> >> While mostly drivers use 512-byte alignment it is not a rule of thumb,
> >> 'git grep' tell me we have:
> >> ide-cd.c with 32-byte alignment
> >> ps3disk.c and rsxx/dev.c with variable alignment.
> >> 
> >> What if our block configuration consists of several devices (in raid
> >> array, for example) with different requirements, e.g. one requiring
> >> 512-byte alignment and the other requiring 256?
> >
> > 512-byte alignment is also 256-byte aligned, and the sector size is 512 byte.
> >
> 
> Yes, but it doesn't work the other way around, e.g. what if some device
> has e.g. PAGE_SIZE alignment requirement (this would likely imply that
> it's sector size is also not 512 I guess)?

Yeah, that can be true if one controller has 4k-byte sector size, also
its DMA alignment is 4K. But there shouldn't be cases in which the two
doesn't match.

> 
> >
> > From the Red Hat BZ, looks I understand this issue is only triggered when
> > KASAN is enabled, or you have figured out how to reproduce it without
> > KASAN involved?
> 
> Yes, any SLUB debug triggers it (e.g. build your kernel with
> SLUB_DEBUG_ON or slub_debug= options (Red zoning, User tracking, ... -
> everything will trigger it)

That means the slab always return 512-byte aligned buffer if the buffer
size is 512byte in case of no any slab debug options enabled.

The question is that if it is one reliable rule in slab. If yes, any
slab debug option does violate the rule.

The same is true for 4k alignment and 4k sector size.

I think we need our MM guys to clarify this point.


Thanks,
Ming
