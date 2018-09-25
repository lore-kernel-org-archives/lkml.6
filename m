Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EED3206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EED3206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbeIYGZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeIYGZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C3CE308A963;
        Tue, 25 Sep 2018 00:21:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B788D8379E;
        Tue, 25 Sep 2018 00:21:02 +0000 (UTC)
Date:   Tue, 25 Sep 2018 08:20:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christopher Lameter <cl@linux.com>
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
        Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180925002057.GB14386@ming.t460p>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de>
 <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180923224206.GA13618@ming.t460p>
 <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
 <010001660c27f079-7ba54431-6f0c-430a-8db5-2398a8e761f0-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001660c27f079-7ba54431-6f0c-430a-8db5-2398a8e761f0-000000@email.amazonses.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 25 Sep 2018 00:21:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:17:16PM +0000, Christopher Lameter wrote:
> On Mon, 24 Sep 2018, Bart Van Assche wrote:
> 
> > /*
> >  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
> >  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
> >  * aligned pointers.
> >  */
> 
> kmalloc alignment is only guaranteed to ARCH_KMALLOC_MINALIGN. That power
> of 2 byte caches (without certain options) are aligned to the power of 2
> is due to the nature that these objects are stored in SLUB. Other
> allocators may behave different and actually different debug options
> result in different alignments. You cannot rely on that.
> 
> ARCH_KMALLOC minalign shows the mininum alignment guarantees. If that is
> not sufficient and you do not want to change the arch guarantees then you
> can open you own slab cache with kmem_cache_create() where you can specify
> different alignment requirements.

Christopher, thank you for clarifying the point!

Then looks it should be reasonable for XFS to switch to kmem_cache_create()
for addressing this issue.

Thanks,
Ming
