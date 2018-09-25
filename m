Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A054C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C70206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nroUKVu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C70206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeIZDNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:13:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZDNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UL6vSq6uo7Ub5HHWmuf35DIpSCMpQo4sCDmJqipXjgc=; b=nroUKVu0OHh+1/A8yuXTWEjm6
        pYtsiivGjypw5uoAOisAOKFBzAOARsC9DijxxsumB/MDUJQJLVIr7o3pBWKMrSTvyISH9Eb9iGew3
        Iytuyhcnbxa1Lxmt+AEstu95X/5v6HLR67mJcmjjLyC0svic2rvbQH/PD3SD0587W7beDWP4HFIye
        0qzPwTXtwZuLL3hPCwxGoFW3X9uCdR9LhzZOHTZCQdqmOopxF3TcQM6/0B/xUZ7H+1usuq+gy2F0q
        rA1dA3LqScKw/kSCR9mIEL8zUtrcJilzh+lCBdkyAbHp6NhW7qartee99yBGgSzw0y9FVWKNn+5gJ
        EdaFhRd/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4uVH-0007rR-3d; Tue, 25 Sep 2018 21:04:19 +0000
Date:   Tue, 25 Sep 2018 14:04:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christopher Lameter <cl@linux.com>,
        Christoph Hellwig <hch@lst.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180925210418.GA9854@bombadil.infradead.org>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de>
 <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180921130504.GA22551@lst.de>
 <010001660c54fb65-b9d3a770-6678-40d0-8088-4db20af32280-000000@email.amazonses.com>
 <1f88f59a-2cac-e899-4c2e-402e919b1034@kernel.dk>
 <010001660cbd51ea-56e96208-564d-4f5d-a5fb-119a938762a9-000000@email.amazonses.com>
 <1a5b255f-682e-783a-7f99-9d02e39c4af2@kernel.dk>
 <20180925074910.GB31060@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925074910.GB31060@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 05:49:10PM +1000, Dave Chinner wrote:
> On Mon, Sep 24, 2018 at 12:09:37PM -0600, Jens Axboe wrote:
> > On 9/24/18 12:00 PM, Christopher Lameter wrote:
> > > On Mon, 24 Sep 2018, Jens Axboe wrote:
> > > 
> > >> The situation is making me a little uncomfortable, though. If we export
> > >> such a setting, we really should be honoring it...
> 
> That's what I said up front, but you replied to this with:
> 
> | I think this is all crazy talk. We've never done this, [...]
> 
> Now I'm not sure what you are saying we should do....
> 
> > > Various subsystems create custom slab arrays with their particular
> > > alignment requirement for these allocations.
> > 
> > Oh yeah, I think the solution is basic enough for XFS, for instance.
> > They just have to error on the side of being cautious, by going full
> > sector alignment for memory...
> 
> How does the filesystem find out about hardware alignment
> requirements? Isn't probing through the block device to find out
> about the request queue configurations considered a layering
> violation?
> 
> What if sector alignment is not sufficient?  And how would this work
> if we start supporting sector sizes larger than page size? (which the
> XFS buffer cache supports just fine, even if nothing else in
> Linux does).

I've never quite understood the O_DIRECT sector size alignment
restriction.  The sector size has literally nothing to do with the
limitations of the controller that's doing the DMA.  OK, NVMe smooshes the
two components into one, but back in the SCSI era, the DMA abilities were
the HBA's responsibility and the sector size was a property of the LUN!

Heck, with a sufficiently advanced HBA (eg supporting scatterlists with
bitbuckets), you could even ask for sub-sector-*sized* IOs.  Not terribly
useful since the bytes still had to be transferred over the SCSI cable,
but you'd save transferring them across the PCI bus.

Anyway, why would we require *larger* than 512 byte alignment for
in-kernel users?  I doubt there are any remaining HBAs that can't do
8-byte aligned I/Os (for the record, NVMe requires controllers to be
able to do 4-byte aligned I/Os).
