Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6113C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54631208AC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54631208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeHVUDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:03:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbeHVUDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:03:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 387EA4021FC2;
        Wed, 22 Aug 2018 16:38:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF73A9E74;
        Wed, 22 Aug 2018 16:38:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w7MGc9vq001749;
        Wed, 22 Aug 2018 12:38:09 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w7MGc9U5001745;
        Wed, 22 Aug 2018 12:38:09 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 22 Aug 2018 12:38:09 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "Xiao, Jin" <jin.xiao@intel.com>
cc:     Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Subject: Re: dm-bufio: adjust the reserved buffer for dm-verify-target.
In-Reply-To: <3995084e-4250-9c28-2fa1-b61add5fb2e9@intel.com>
Message-ID: <alpine.LRH.2.02.1808221236230.30929@file01.intranet.prod.int.rdu2.redhat.com>
References: <1533710457-6411-1-git-send-email-jin.xiao@intel.com> <20180814203245.GA15636@redhat.com> <3995084e-4250-9c28-2fa1-b61add5fb2e9@intel.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 22 Aug 2018 16:38:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 22 Aug 2018 16:38:13 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Aug 2018, Xiao, Jin wrote:

> 
> On 8/15/2018 4:32 AM, Mike Snitzer wrote:
> > On Wed, Aug 08 2018 at  2:40am -0400,
> > xiao jin <jin.xiao@intel.com> wrote:
> > 
> > > We hit the BUG() report at include/linux/scatterlist.h:144!
> > > The callback is as bellow:
> > >    => verity_work
> > >    => verity_hash_for_block
> > >    => verity_verify_level
> > >    => verity_hash
> > >    => verity_hash_update
> > >    => sg_init_one
> > >    => sg_set_buf
> > > 
> > > More debug shows the root cause. When creating dufio client it
> > > uses the __vmalloc() to allocate the buffer data for the reserved
> > > dm_buffer. The buffer that allocated by the __vmalloc() is invalid
> > > according to the __virt_addr_valid().
> > > 
> > > Mostly the reserved dm_buffer is not touched. But occasionally
> > > it might fail to allocate the dm_buffer data when we try to
> > > allocate in the __alloc_buffer_wait_no_callback(). Then it has
> > > to take the reserved dm_buffer for usage. Finally it reports the
> > > BUG() as virt_addr_valid() detects the buffer data address is invalid.
> > > 
> > > The patch is to adjust the reserved buffer for dm-verity-target. We
> > > allocated two dm_buffers into the reserved buffers list when creating
> > > the buffer interface. The first dm_buffer in the reserved buffer list
> > > is allocated by the __vmalloc(), it's not used after that. The second
> > > dm_buffer in the reserved buffer list is allocated by the
> > > __get_free_pages() which can be consumed after that.
> > > 
> > > Signed-off-by: xiao jin <jin.xiao@intel.com>
> > > ---
> > >   drivers/md/dm-bufio.c         | 4 ++--
> > >   drivers/md/dm-verity-target.c | 2 +-
> > >   2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> > > index dc385b7..3b7ca5e 100644
> > > --- a/drivers/md/dm-bufio.c
> > > +++ b/drivers/md/dm-bufio.c
> > > @@ -841,7 +841,7 @@ static struct dm_buffer
> > > *__alloc_buffer_wait_no_callback(struct dm_bufio_client
> > >   			tried_noio_alloc = true;
> > >   		}
> > >   -		if (!list_empty(&c->reserved_buffers)) {
> > > +		if (!c->need_reserved_buffers) {
> > >   			b = list_entry(c->reserved_buffers.next,
> > >   				       struct dm_buffer, lru_list);
> > >   			list_del(&b->lru_list);
> > > @@ -1701,7 +1701,7 @@ struct dm_bufio_client
> > > *dm_bufio_client_create(struct block_device *bdev, unsign
> > >   		goto bad;
> > >   	}
> > >   -	while (c->need_reserved_buffers) {
> > > +	if (list_empty(&c->reserved_buffers)) {
> > >   		struct dm_buffer *b = alloc_buffer(c, GFP_KERNEL);
> > >     		if (!b) {
> > Point was to allocate N buffers (as accounted in
> > c->need_reserved_buffers).  This change just allocates a single one.
> > Why?
> > 
> > Your header isn't clear on this at all.
> 
> Hi Mike,
> 
> Currently alloc_buffer() when creating the client will use the __vmalloc() to
> 
> get the buffer data for c->reserved_buffers. If the c->reserved_buffers is
> read to
> 
> use in the failures case of buffer allocation in the
> __alloc_buffer_wait_no_callback(),
> 
> and the CONFIG_DEBUG_SG is enabled, we will hit the BUG() report.
> 
> That's the problem I find in reality.
> 
> 
> I have some thinking to solve such issue. I think to keep the initial buffer
> with the
> 
> data from __vmalloc() in the c->reserved_buffers. But the reserved buffer with
> the data
> 
> from __vmalloc() can't be read to use. We can allocate more buffers with the
> 
> data mode of DATA_MODE_SLAB or DATA_MODE_GET_FREE_PAGES for
> c->reserved_buffers.

The problem is that allocating large blocks of memory (more than 32kB) is 
unreliable and may fail any time. That's why dm-bufio uses vmalloc.

The proper fix is to fix dm-verity so that it works on vmallocated memory. 
I'll send a patch for that.

Mikulas

> Such reserved buffers can be used in the failures case of buffer allocation
> 
> in the __alloc_buffer_wait_no_callback().
> 
> 
> I test the code on my device. I never see the BUG() report again. Feel free to
> correct me.
> 
> 
> Thanks.
> 
> 
> Jin
> 
> > > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > > index 12decdbd7..40c66fc 100644
> > > --- a/drivers/md/dm-verity-target.c
> > > +++ b/drivers/md/dm-verity-target.c
> > > @@ -1107,7 +1107,7 @@ static int verity_ctr(struct dm_target *ti, unsigned
> > > argc, char **argv)
> > >   	v->hash_blocks = hash_position;
> > >     	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
> > > -		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
> > > +		1 << v->hash_dev_block_bits, 2, sizeof(struct buffer_aux),
> > >   		dm_bufio_alloc_callback, NULL);
> > >   	if (IS_ERR(v->bufio)) {
> > >   		ti->error = "Cannot initialize dm-bufio";
> > > -- 
> > > 2.7.4
> > > 
> > > --
> > > dm-devel mailing list
> > > dm-devel@redhat.com
> > > https://www.redhat.com/mailman/listinfo/dm-devel
> > It isn't at all clear from my initial review that what you're doing
> > makes any sense.
> > 
> > Seems like you're just papering over bufio's use of !__virt_addr_valid()
> > memory in unintuitive ways.
> > 
> > Mikulas, can you see a better way forward?
> > 
> > Mike
> 
