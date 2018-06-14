Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 47F10C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0BE208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0BE208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935936AbeFNBwp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:52:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754536AbeFNBwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CF3287AC7;
        Thu, 14 Jun 2018 01:52:42 +0000 (UTC)
Received: from ming.t460p (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC8FD111DD0A;
        Thu, 14 Jun 2018 01:52:27 +0000 (UTC)
Date:   Thu, 14 Jun 2018 09:52:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 13/30] block: introduce rq_for_each_chunk()
Message-ID: <20180614015221.GD19828@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-14-ming.lei@redhat.com>
 <20180613144818.GD4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613144818.GD4693@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 01:52:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 14 Jun 2018 01:52:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 07:48:18AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 09, 2018 at 08:29:57PM +0800, Ming Lei wrote:
> > There are still cases in which rq_for_each_chunk() is required, for
> > example, loop.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  include/linux/blkdev.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index bca3a92eb55f..4eaba73c784a 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -941,6 +941,10 @@ struct req_iterator {
> >  	__rq_for_each_bio(_iter.bio, _rq)			\
> >  		bio_for_each_segment(bvl, _iter.bio, _iter.iter)
> >  
> > +#define rq_for_each_chunk(bvl, _rq, _iter)			\
> > +	__rq_for_each_bio(_iter.bio, _rq)			\
> > +		bio_for_each_chunk(bvl, _iter.bio, _iter.iter)
> 
> We have a single users of this in the loop driver.  I'd rather
> see the obvious loop open coded.

OK.

Thanks,
Ming
