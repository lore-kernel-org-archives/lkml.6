Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E77C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BB420849
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BB420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbeGFVyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:54:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:62473 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753631AbeGFVyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:54:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 14:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,318,1526367600"; 
   d="scan'208";a="65001556"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2018 14:54:37 -0700
Date:   Fri, 6 Jul 2018 15:54:37 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        pasha.tatashin@oracle.com, linux-nvdimm@lists.01.org,
        bhe@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        osalvador@suse.de
Subject: Re: [PATCH] mm/sparse.c: fix error path in sparse_add_one_section
Message-ID: <20180706215437.GB21639@linux.intel.com>
References: <CAOxpaSVkLh23jN_=0GpZ77EhKdAYaiWKkppnxWwf_MRa5FvopA@mail.gmail.com>
 <20180706190658.6873-1-ross.zwisler@linux.intel.com>
 <20180706212327.GA10824@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706212327.GA10824@techadventures.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:23:27PM +0200, Oscar Salvador wrote:
> On Fri, Jul 06, 2018 at 01:06:58PM -0600, Ross Zwisler wrote:
> > The following commit in -next:
> > 
> > commit 054620849110 ("mm/sparse.c: make sparse_init_one_section void and
> > remove check")
> > 
> > changed how the error handling in sparse_add_one_section() works.
> > 
> > Previously sparse_index_init() could return -EEXIST, and the function would
> > continue on happily.  'ret' would get unconditionally overwritten by the
> > result from sparse_init_one_section() and the error code after the 'out:'
> > label wouldn't be triggered.
> 
> My bad, I missed that.
> 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 9574113fc745..d254bd2d3289 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -753,8 +753,12 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
> >  	 * plus, it does a kmalloc
> >  	 */
> >  	ret = sparse_index_init(section_nr, pgdat->node_id);
> > -	if (ret < 0 && ret != -EEXIST)
> > -		return ret;
> > +	if (ret < 0) {
> > +		if (ret == -EEXIST)
> > +			ret = 0;
> > +		else
> > +			return ret;
> > +	}
> 
> sparse_index_init() can return:
> 
> -ENOMEM, -EEXIST or 0.
> 
> So what about this?:
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f55e79fda03e..eb188eb6b82d 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -770,6 +770,7 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
>         ret = sparse_index_init(section_nr, pgdat->node_id);
>         if (ret < 0 && ret != -EEXIST)
>                 return ret;
> +       ret = 0;
> 
> Does this look more clean?

Sure, that's probably better.

Andrew, what's the easiest way forward?  I can send out a v2, you can fold
this into his previous patch, or something else?
