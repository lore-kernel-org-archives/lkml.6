Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C501CECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8119C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8119C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbeISQwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731358AbeISQwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2B428831D;
        Wed, 19 Sep 2018 11:15:08 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B48E5FC24;
        Wed, 19 Sep 2018 11:15:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list\:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
        <877ejh3jv0.fsf@vitty.brq.redhat.com>
        <20180919100256.GD23172@ming.t460p>
Date:   Wed, 19 Sep 2018 13:15:00 +0200
In-Reply-To: <20180919100256.GD23172@ming.t460p> (Ming Lei's message of "Wed,
        19 Sep 2018 18:02:57 +0800")
Message-ID: <8736u53fij.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Sep 2018 11:15:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> Hi Vitaly,
>
> On Wed, Sep 19, 2018 at 11:41:07AM +0200, Vitaly Kuznetsov wrote:
>> Ming Lei <tom.leiming@gmail.com> writes:
>> 
>> > Hi Guys,
>> >
>> > Some storage controllers have DMA alignment limit, which is often set via
>> > blk_queue_dma_alignment(), such as 512-byte alignment for IO buffer.
>> 
>> While mostly drivers use 512-byte alignment it is not a rule of thumb,
>> 'git grep' tell me we have:
>> ide-cd.c with 32-byte alignment
>> ps3disk.c and rsxx/dev.c with variable alignment.
>> 
>> What if our block configuration consists of several devices (in raid
>> array, for example) with different requirements, e.g. one requiring
>> 512-byte alignment and the other requiring 256?
>
> 512-byte alignment is also 256-byte aligned, and the sector size is 512 byte.
>

Yes, but it doesn't work the other way around, e.g. what if some device
has e.g. PAGE_SIZE alignment requirement (this would likely imply that
it's sector size is also not 512 I guess)?

>
> From the Red Hat BZ, looks I understand this issue is only triggered when
> KASAN is enabled, or you have figured out how to reproduce it without
> KASAN involved?

Yes, any SLUB debug triggers it (e.g. build your kernel with
SLUB_DEBUG_ON or slub_debug= options (Red zoning, User tracking, ... -
everything will trigger it)

>
>> 
>> >
>> > 3) If slab can't guarantee to return 512-aligned buffer, how to fix
>> > this data corruption issue?
>> 
>> I'm no expert in block layer but in case of complex block device
>> configurations when bio submitter can't know all the requirements I see
>> no other choice than bouncing.
>
> I guess that might be the last straw, given the current way without
> bouncing works for decades, and seems no one complains before.

Not many drivers have alignment requirements and not many filesystems
do requests of this kind. Another option would be to give an API to
figure out alignment requirements for the whole block stack (returning
which alignment would work for _all_ devices in the stack, not just for
one of them) and mandating that all users have to use this while
allocating buffers.

-- 
  Vitaly
