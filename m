Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67B2C282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9307218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548930633;
	bh=Y2q2CGTr8DC8b5sUaWln1mdflBI54lRZC+oK9+sq4fg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=QtzGHMzAPfAvH5ufkgwF787LNu9uHy9PECCdT4FI9PLe6gNv5XglRyzkM0HPQF7ak
	 P2BwMAjLaIRw4Hfb/en/G7xQfppSjpa6YJ7u5vcZJYpLYjexemFwP1UTG42XfPv3C5
	 kXpMLUfKgJSC62X/YS8xm8WLUiG2E/bBCTLx+T/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfAaKac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfAaKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:30:30 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01DA0218AC;
        Thu, 31 Jan 2019 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548930629;
        bh=Y2q2CGTr8DC8b5sUaWln1mdflBI54lRZC+oK9+sq4fg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RJwgaBs8AwKSAgm+Pqtpv5rDpOa/DdLevBF/0L1uyrwGGr3bMPou4mxv/Katajwu9
         tw9/N/B0Jm9pmTP2tL7DqioyGhCkyQPaJ2Hcph7WIzpSCxIkHZ/kGNWUs4q3Ve/3j4
         9b4MsooLv8MXcQ3kEoyWvgANTMXXXOdarH1dJqqU=
Date:   Thu, 31 Jan 2019 11:30:24 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
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
In-Reply-To: <20190131102348.GT18811@dhcp22.suse.cz>
Message-ID: <nycvar.YFH.7.76.1901311129420.3281@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm> <20190130124420.1834-1-vbabka@suse.cz> <20190130124420.1834-3-vbabka@suse.cz> <20190131095644.GR18811@dhcp22.suse.cz> <nycvar.YFH.7.76.1901311114260.6626@cbobk.fhfr.pm>
 <20190131102348.GT18811@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019, Michal Hocko wrote:

> > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > index 9f5e323e883e..7bcdd36e629d 100644
> > > > --- a/mm/filemap.c
> > > > +++ b/mm/filemap.c
> > > > @@ -2075,8 +2075,6 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
> > > >  
> > > >  		page = find_get_page(mapping, index);
> > > >  		if (!page) {
> > > > -			if (iocb->ki_flags & IOCB_NOWAIT)
> > > > -				goto would_block;
> > > >  			page_cache_sync_readahead(mapping,
> > > >  					ra, filp,
> > > >  					index, last_index - index);
> > > 
> > > Maybe a stupid question but I am not really familiar with this path but
> > > what exactly does prevent a sync read down page_cache_sync_readahead
> > > path?
> > 
> > page_cache_sync_readahead() only submits the read ahead request(s), it 
> > doesn't wait for it to finish.
> 
> OK, I guess my question was not precise. What does prevent taking fs
> locks down the path?

Well, RWF_NOWAIT doesn't mean the kernel can't reschedule while executing 
preadv2(), right? It just means it will not wait for the arrival of the 
whole data blob into pagecache in case it's not there.

-- 
Jiri Kosina
SUSE Labs

