Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4ACECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A115821479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A115821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJSUIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:08:00 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50096 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeJSUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:07:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 20FB172CC59;
        Fri, 19 Oct 2018 15:02:11 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 05DDD4A4A16;
        Fri, 19 Oct 2018 15:02:11 +0300 (MSK)
Date:   Fri, 19 Oct 2018 15:02:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, Shaohua Li <shli@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: dm: add secdel target
Message-ID: <20181019120209.osicx2v3vebvsxqr@sole.flsd.net>
References: <20181014112439.8119-1-vt@altlinux.org>
 <20181018200124.GA6996@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20181018200124.GA6996@redhat.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 04:01:25PM -0400, Mike Snitzer wrote:
> On Sun, Oct 14 2018 at  7:24am -0400,
> Vitaly Chikunov <vt@altlinux.org> wrote:
> 
> > Report to the upper level ability to discard, and translate arriving
> > discards to the writes of random or zero data to the underlying level.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >   This target is the same as the linear target except that is reports ability to
> >   discard to the upper level and translates arriving discards into sector
> >   overwrites with random (or zero) data.
> 
> There is a fair amount of code duplication between dm-linear.c and this
> new target.
> 
> Something needs to give, ideally you'd factor out methods that are
> shared by both targets, but those methods must _not_ introduce overhead
> to dm-linear.

I see three possible solutions:
 - integrate 'secdel' into dm-linear;
 - export functions like linear_dax_copy_to_iter and fill them into
   secdel's `struct target_type`;
 - call methods of linear's `struct target_type` from secdel's one.

> Could be that dm-linear methods just get called by the wrapper
> dm-sec-erase target (more on the "dm-sec-erase" name below).

> > diff --git a/drivers/md/dm-secdel.c b/drivers/md/dm-secdel.c
> > new file mode 100644
> > index 000000000000..9aeaf3f243c0
> > --- /dev/null
> > +++ b/drivers/md/dm-secdel.c
> ... 
> > +			if (mode == SECDEL_MODE_RAND) {
> > +				page = alloc_page(gfp_mask);
> > +				if (!page) {
> > +					DMERR("%s %lu[%lu]: no memory to allocate page for random data",
> > +					      __func__, sector, nr_sects);
> > +					/* will fallback to zero filling */
> 
> In general, performing memory allocations to service IO is something all
> DM core and DM targets must work to avoid.  This smells bad.
> 
> ...

Yes, but we need to create and write random data, so I don't see other
solution. In zero overwriting mode page is not allocated. And it's fall
back to zero overwriting if page allocation fails for random data.

> Mike

I will address these and other your concerns in v2.

Thanks!

