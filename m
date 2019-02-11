Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A051C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2201820823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfBKV1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:27:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:41049 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfBKV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:27:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 13:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="121657772"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2019 13:27:03 -0800
Date:   Mon, 11 Feb 2019 13:26:52 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Davidlohr Bueso <dave@stgolabs.net>, netdev@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] mm/gup: Introduce get_user_pages_fast_longterm()
Message-ID: <20190211212652.GA7790@iweiny-DESK2.sc.intel.com>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211201643.7599-3-ira.weiny@intel.com>
 <20190211203916.GA2771@ziepe.ca>
 <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc03ee1-4c42-48c3-bc67-942c0f04875e@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:13:56PM -0800, John Hubbard wrote:
> On 2/11/19 12:39 PM, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 12:16:42PM -0800, ira.weiny@intel.com wrote:
> >> From: Ira Weiny <ira.weiny@intel.com>
> [...]
> >> +static inline int get_user_pages_fast_longterm(unsigned long start, int nr_pages,
> >> +					       bool write, struct page **pages)
> >> +{
> >> +	return get_user_pages_fast(start, nr_pages, write, pages);
> >> +}
> >>  #endif /* CONFIG_FS_DAX */
> >>  
> >>  int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >> @@ -2615,6 +2622,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
> >>  #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
> >>  #define FOLL_COW	0x4000	/* internal GUP flag */
> >>  #define FOLL_ANON	0x8000	/* don't do file mappings */
> >> +#define FOLL_LONGTERM	0x10000	/* mapping is intended for a long term pin */
> > 
> > If we are adding a new flag, maybe we should get rid of the 'longterm'
> > entry points and just rely on the callers to pass the flag?
> > 
> > Jason
> > 
> 
> +1, I agree that the overall get_user_pages*() API family will be cleaner
> *without* get_user_pages_longterm*() calls. And this new flag makes that possible.
> So I'd like to see the "longerm" call replaced with just passing this flag. Maybe
> even as part of this patchset, but either way.

Yes I've thought about this as well.  I have a couple of different versions of
this series which I've been mulling over and this was one of the other
variations.  But see below...

> 
> Taking a moment to reflect on where I think this might go eventually (the notes
> below do not need to affect your patchset here, but this seems like a good place
> to mention this):
> 
> It seems to me that the longterm vs. short-term is of questionable value.

This is exactly why I did not post this before.  I've been waiting our other
discussions on how GUP pins are going to be handled to play out.  But with the
netdev thread today[1] it seems like we need to make sure we have a "safe" fast
variant for a while.  Introducing FOLL_LONGTERM seemed like the cleanest way to
do that even if we will not need the distinction in the future...  :-(

> It's actually better to just call get_user_pages(), and then if it really is
> long-term enough to matter internally, we'll see the pages marked as gup-pinned.
> If the gup pages are released before anyone (filesystem, that is) notices, then
> it must have been short term.
> 
> Doing it that way is self-maintaining. Of course, this assumes that we end up with
> a design that doesn't require being told, by the call sites, that a given gup
> call is intended for "long term" use. So I could be wrong about this direction, but
> let's please consider the possibility.

This is why I've been holding these patches.  I'm also not 100% sure if we will
need the longterm flag in the future.

This is also why I did not change the get_user_pages_longterm because we could
be ripping this all out by the end of the year...  (I hope. :-)

So while this does "pollute" the GUP family of calls I'm hoping it is not
forever.

Ira

[1] https://lkml.org/lkml/2019/2/11/1789

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
