Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B033C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AA42083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGLDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:40112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbeLGLDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:03:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53C4BB004;
        Fri,  7 Dec 2018 11:03:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0EF641E0D9D; Fri,  7 Dec 2018 12:03:17 +0100 (CET)
Date:   Fri, 7 Dec 2018 12:03:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: Re: [PATCH 4/4] mm: use the cached page for filemap_fault
Message-ID: <20181207110317.GF13008@quack2.suse.cz>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-5-josef@toxicpanda.com>
 <20181204145034.4b69bdea36506be45946f8c9@linux-foundation.org>
 <20181205145808.kzsro4a7vqaxx3cu@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205145808.kzsro4a7vqaxx3cu@MacBook-Pro-91.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-12-18 09:58:10, Josef Bacik wrote:
> On Tue, Dec 04, 2018 at 02:50:34PM -0800, Andrew Morton wrote:
> > On Fri, 30 Nov 2018 14:58:12 -0500 Josef Bacik <josef@toxicpanda.com> wrote:
> > 
> > > If we drop the mmap_sem we have to redo the vma lookup which requires
> > > redoing the fault handler.  Chances are we will just come back to the
> > > same page, so save this page in our vmf->cached_page and reuse it in the
> > > next loop through the fault handler.
> > > 
> > 
> > Is this really worthwhile?  Rerunning the fault handler is rare (we
> > hope) and a single pagecache lookup is fast.
> > 
> > Some performance testing results would be helpful here.  It's
> > practically obligatory when claiming a performance improvement.
> > 
> > 
> 
> Honestly the big thing is just not doing IO under the mmap_sem.  I had this
> infrastructure originally for the mkwrite portion of these patches that I
> dropped, because I was worried about the page being messed with after we did all
> the mkwrite work.  However since I'm not doing that anymore there's less of a
> need for it.  I have no performance numbers for this, just seemed like a good
> idea since we are likely to just have the page again, and this keeps us from
> evicting the page right away and causing more thrashing.
> 
> I'll try and set something up to see if there's a difference.  If there's no
> difference do you want me to drop this?  Thanks,

If there's no difference, I'd like to drop this as well. It just
complicates the fault state handling which is already complex enough.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
