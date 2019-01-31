Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E3C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39D92075D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548930232;
	bh=q31fqADB2XqHYhQxy+W9kqv1qG2N+Mmssvwo7ert4Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m7/vQNieJ84XWtbGNtKFfin6xNl0Hc/zs6TlSMah8FJ23N+8ZN+danzA9EyxJLcKJ
	 mSX5OMRk24Bd1RAcvfXU6/VOL+p/UohaUnQVGe1E5ak5KNs6hiMEFssKQXiizV/m6l
	 VxceR0w6iFSusYabdudF3MD/SmH4CN3OiWENI4Jo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbfAaKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:23:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:53104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbfAaKXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:23:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7619CB049;
        Thu, 31 Jan 2019 10:23:49 +0000 (UTC)
Date:   Thu, 31 Jan 2019 11:23:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT
 is set for the I/O
Message-ID: <20190131102348.GT18811@dhcp22.suse.cz>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz>
 <20190130124420.1834-3-vbabka@suse.cz>
 <20190131095644.GR18811@dhcp22.suse.cz>
 <nycvar.YFH.7.76.1901311114260.6626@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1901311114260.6626@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 11:15:28, Jiri Kosina wrote:
> On Thu, 31 Jan 2019, Michal Hocko wrote:
> 
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index 9f5e323e883e..7bcdd36e629d 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -2075,8 +2075,6 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
> > >  
> > >  		page = find_get_page(mapping, index);
> > >  		if (!page) {
> > > -			if (iocb->ki_flags & IOCB_NOWAIT)
> > > -				goto would_block;
> > >  			page_cache_sync_readahead(mapping,
> > >  					ra, filp,
> > >  					index, last_index - index);
> > 
> > Maybe a stupid question but I am not really familiar with this path but
> > what exactly does prevent a sync read down page_cache_sync_readahead
> > path?
> 
> page_cache_sync_readahead() only submits the read ahead request(s), it 
> doesn't wait for it to finish.

OK, I guess my question was not precise. What does prevent taking fs
locks down the path?
-- 
Michal Hocko
SUSE Labs
