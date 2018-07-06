Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109ECC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A8922ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A8922ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeGFV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:58:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754338AbeGFV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:58:34 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36F1FDB1;
        Fri,  6 Jul 2018 21:58:34 +0000 (UTC)
Date:   Fri, 6 Jul 2018 14:58:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     Oscar Salvador <osalvador@techadventures.net>,
        pasha.tatashin@oracle.com, linux-nvdimm@lists.01.org,
        bhe@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        osalvador@suse.de
Subject: Re: [PATCH] mm/sparse.c: fix error path in sparse_add_one_section
Message-Id: <20180706145833.87c73a9c39b59cec253f8a82@linux-foundation.org>
In-Reply-To: <20180706215437.GB21639@linux.intel.com>
References: <CAOxpaSVkLh23jN_=0GpZ77EhKdAYaiWKkppnxWwf_MRa5FvopA@mail.gmail.com>
        <20180706190658.6873-1-ross.zwisler@linux.intel.com>
        <20180706212327.GA10824@techadventures.net>
        <20180706215437.GB21639@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 15:54:37 -0600 Ross Zwisler <ross.zwisler@linux.intel.com> wrote:

> On Fri, Jul 06, 2018 at 11:23:27PM +0200, Oscar Salvador wrote:
> > On Fri, Jul 06, 2018 at 01:06:58PM -0600, Ross Zwisler wrote:
> > > The following commit in -next:
> > > 
> > > commit 054620849110 ("mm/sparse.c: make sparse_init_one_section void and
> > > remove check")
> > > 
> > > changed how the error handling in sparse_add_one_section() works.
> > > 
> > > Previously sparse_index_init() could return -EEXIST, and the function would
> > > continue on happily.  'ret' would get unconditionally overwritten by the
> > > result from sparse_init_one_section() and the error code after the 'out:'
> > > label wouldn't be triggered.
> > 
> > My bad, I missed that.
> > 
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index 9574113fc745..d254bd2d3289 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -753,8 +753,12 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
> > >  	 * plus, it does a kmalloc
> > >  	 */
> > >  	ret = sparse_index_init(section_nr, pgdat->node_id);
> > > -	if (ret < 0 && ret != -EEXIST)
> > > -		return ret;
> > > +	if (ret < 0) {
> > > +		if (ret == -EEXIST)
> > > +			ret = 0;
> > > +		else
> > > +			return ret;
> > > +	}
> > 
> > sparse_index_init() can return:
> > 
> > -ENOMEM, -EEXIST or 0.
> > 
> > So what about this?:
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index f55e79fda03e..eb188eb6b82d 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -770,6 +770,7 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
> >         ret = sparse_index_init(section_nr, pgdat->node_id);
> >         if (ret < 0 && ret != -EEXIST)
> >                 return ret;
> > +       ret = 0;
> > 
> > Does this look more clean?
> 
> Sure, that's probably better.
> 
> Andrew, what's the easiest way forward?  I can send out a v2, you can fold
> this into his previous patch, or something else?

Whatever ;)  v2 works.
