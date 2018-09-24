Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24666ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEC620666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BeK/oilc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEC620666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbeIXVT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:19:56 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:56082 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728880AbeIXVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1537802236;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=+QBuj6XrdiWV8lRoyI1QXhMT9WgCuArxoRXSkAT50QE=;
        b=BeK/oilc4LLwaLq3ZvzDm7HaMNAjSQlVF+C3dWRpeh+K32j8NcNk3WmaMkajk5hU
        fjoeFcARD+neLQ/noYa4Zc0SbaMlC9br8MQ+YOZSIe8BUZcqKj52SqMp53ctMX9Lz8/
        vygbtKMl15AcnMQEtk9aGrPUFQOnT8DWH2eX9Wps=
Date:   Mon, 24 Sep 2018 15:17:16 +0000
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
In-Reply-To: <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
Message-ID: <010001660c27f079-7ba54431-6f0c-430a-8db5-2398a8e761f0-000000@email.amazonses.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com> <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com> <20180923224206.GA13618@ming.t460p> <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.24-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Bart Van Assche wrote:

> /*
>  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
>  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
>  * aligned pointers.
>  */

kmalloc alignment is only guaranteed to ARCH_KMALLOC_MINALIGN. That power
of 2 byte caches (without certain options) are aligned to the power of 2
is due to the nature that these objects are stored in SLUB. Other
allocators may behave different and actually different debug options
result in different alignments. You cannot rely on that.

ARCH_KMALLOC minalign shows the mininum alignment guarantees. If that is
not sufficient and you do not want to change the arch guarantees then you
can open you own slab cache with kmem_cache_create() where you can specify
different alignment requirements.
