Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0286EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EF521480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EXDNbKa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EF521480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeIXWu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:50:56 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:58040 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728006AbeIXWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1537807673;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=0mzsxHIVM4CkekhvHVvw2d24wgk7W5TUwSrQKfCvH2A=;
        b=EXDNbKa/hgEdfsnQ27z42aRCBao6L070aNTUbxijBUpLIT7wy6dXcdpfiFYbOGZI
        LAS8ADUfbQRKq7ZmaKPjESUDq8g/qi4nDTCaY4jOXMu6qJ9y8cVwfGcqtuC3EpSXmWj
        sSkWAlG97OMcbX5OED5DJ4Yjy8hnvtKpHNHw2V3Q=
Date:   Mon, 24 Sep 2018 16:47:53 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Bart Van Assche <bvanassche@acm.org>
cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
        Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
In-Reply-To: <1537805984.195115.14.camel@acm.org>
Message-ID: <010001660c7ae798-2c446e83-392a-40bd-a89d-8da2f20dd1b8-000000@email.amazonses.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com> <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com> <20180923224206.GA13618@ming.t460p> <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org> <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com> <1537801706.195115.7.camel@acm.org> <c844c598-be1d-bef4-fb99-09cf99571fd7@virtuozzo.com> <1537804720.195115.9.camel@acm.org> <10c706fd-2252-f11b-312e-ae0d97d9a538@virtuozzo.com>
 <1537805984.195115.14.camel@acm.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-SES-Outgoing: 2018.09.24-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Bart Van Assche wrote:

> That means that two buffers allocated with kmalloc() may share a cache line on
> x86-64. Since it is allowed to use a buffer allocated by kmalloc() for DMA, can
> this lead to data corruption, e.g. if the CPU writes into one buffer allocated
> with kmalloc() and a device performs a DMA write to another kmalloc() buffer and
> both write operations affect the same cache line?

The devices writes to the cacheline through the processor which serializes
access appropriately.

The DMA device cannot write directly to memory after all on current Intel
processors. Other architectures have bus protocols that prevent situations
like that.



