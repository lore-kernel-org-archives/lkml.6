Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D87C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304AA23C81
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304AA23C81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeF1B2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:28:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751723AbeF1B2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E40D814F0B8;
        Thu, 28 Jun 2018 01:28:39 +0000 (UTC)
Received: from ming.t460p (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB86E111CA17;
        Thu, 28 Jun 2018 01:28:22 +0000 (UTC)
Date:   Thu, 28 Jun 2018 09:28:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Coly Li <colyli@suse.de>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH V7 20/24] bcache: avoid to use bio_for_each_segment_all()
 in bch_bio_alloc_pages()
Message-ID: <20180628012816.GH7583@ming.t460p>
References: <20180627124548.3456-1-ming.lei@redhat.com>
 <20180627124548.3456-21-ming.lei@redhat.com>
 <e1499d87-62b8-40a8-75a5-d9d1d81ce9c5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1499d87-62b8-40a8-75a5-d9d1d81ce9c5@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 28 Jun 2018 01:28:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 28 Jun 2018 01:28:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:55:33PM +0800, Coly Li wrote:
> On 2018/6/27 8:45 PM, Ming Lei wrote:
> > bch_bio_alloc_pages() is always called on one new bio, so it is safe
> > to access the bvec table directly. Given it is the only kind of this
> > case, open code the bvec table access since bio_for_each_segment_all()
> > will be changed to support for iterating over multipage bvec.
> > 
> > Cc: Coly Li <colyli@suse.de>
> > Cc: linux-bcache@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/md/bcache/util.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
> > index fc479b026d6d..9f2a6fd5dfc9 100644
> > --- a/drivers/md/bcache/util.c
> > +++ b/drivers/md/bcache/util.c
> > @@ -268,7 +268,7 @@ int bch_bio_alloc_pages(struct bio *bio, gfp_t gfp_mask)
> >  	int i;
> >  	struct bio_vec *bv;
> > 
> 
> Hi Ming,
> 
> > -	bio_for_each_segment_all(bv, bio, i) {
> > +	for (i = 0, bv = bio->bi_io_vec; i < bio->bi_vcnt; bv++) {
> 
> 
> Is it possible to treat this as a special condition of
> bio_for_each_segement_all() ? I mean only iterate one time in
> bvec_for_each_segment(). I hope the above change is not our last choice
> before I reply an Acked-by :-)

Now the bvec from bio_for_each_segement_all() can't be changed any more
since the referenced 'bvec' is generated in-flight given we store
real multipage bvec.

BTW, this way is actually suggested by Christoph for saving one new
helper of bio_for_each_bvec_all() as done in V6, and per previous discussion,
seems both Kent and Christoph agrees to convert bcache into bio_add_page()
finally.

So I guess this open code style should be fine.

Thanks,
Ming
