Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335EBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E7120C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="FbEjlp1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E7120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbeIXWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:09:20 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:39652 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbeIXWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1537805188;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=4ghcc2InIqsZQIa27hdEtzuur6dVGVoGu6sUD5wpu9I=;
        b=FbEjlp1T0N7yX4QsWP7s1H99C7Ks5g8EzLA+jYeP5pCyPujjHcNg+RRmxzazgAx2
        vGghH2Sn3eAumt/7Gy0Mfj83MFBE7Onj6IXvInob6vuJyrHCvONYeu4wDVl7/GHxw7w
        ecR2WXQzGMBF5kjeSw4K9DYuz1pbTPWEZnJajKMg=
Date:   Mon, 24 Sep 2018 16:06:28 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Christoph Hellwig <hch@lst.de>
cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
In-Reply-To: <20180921130504.GA22551@lst.de>
Message-ID: <010001660c54fb65-b9d3a770-6678-40d0-8088-4db20af32280-000000@email.amazonses.com>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com> <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com> <20180921130504.GA22551@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.24-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Christoph Hellwig wrote:

> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> >
> > > On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
> > >> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
> > >> yes, is it a stable rule?
> > >
> > > This is the assumption in a lot of the kernel, so I think if somethings
> > > breaks this we are in a lot of pain.
> >
> > It seems that SLUB debug breaks this assumption. Kernel built with
> >
> > CONFIG_SLUB_DEBUG=y
> > CONFIG_SLUB=y
> > CONFIG_SLUB_DEBUG_ON=y
>
> Looks like we should fix SLUB debug then..

Nope. We need to not make unwarranted assumptions. Alignment is guaranteed
to ARCH_KMALLOC_MINALIGN for kmalloc requests. Fantasizing about
alighments and guessing from alignments that result on a particular
hardware and slab configuration that these are general does not work.

