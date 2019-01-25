Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F0C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72E221915
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548404996;
	bh=gqI36ZqPjbxvIVgQMjDpYNmAQVK3xLn9snWa606MXHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ftNWnz3I5gbEQt+cU2crRN5UOqEhb+9pY1dsWygspJ+SXRqpvvHRLG9RBJSqTYGl
	 3BqqSMo4kyb2j/MqMsnw96S2H8fsshOGI7VEgIgbkUxwAS1xYijRMnGCp3GBrYGMmz
	 FjvDePnQAi7Qm4KS7dtmk+8aWw+aYbRchltGo+Ic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfAYI3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:29:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:49918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfAYI3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:29:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 71423B04B;
        Fri, 25 Jan 2019 08:29:53 +0000 (UTC)
Date:   Fri, 25 Jan 2019 09:29:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Subject: Re: kernel panic due to
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
Message-ID: <20190125082952.GG3560@dhcp22.suse.cz>
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz>
 <20190125081924.GF3560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125081924.GF3560@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 09:19:24, Michal Hocko wrote:
> On Fri 25-01-19 08:37:04, Michal Hocko wrote:
> > On Fri 25-01-19 17:48:32, Linus Torvalds wrote:
> > > [ Just adding a lot of other people to the cc ]
> > > 
> > > Robert, could you add a dmesg of a successful boot to that bugzilla,
> > > or just as an attachement in email to this group of people..
> > > 
> > > This looks to be with the Fedora kernel config. Two people reporting
> > > it, it looks like similar machines.
> > > 
> > > I assume it's some odd memory sizing detail that happens to trigger a
> > > particular case.
> > 
> > Quite possible.
> 
> Forgot to ask. Can we get a dmesg with 2830bf6f05fb ("mm,
> memory_hotplug: initialize struct pages for the full memory section")
> reverted and memblock=debug kernel command line parameter?

And one more thing which I have overlook until now and it is not really
clear to me. One of th comments says
: The relevant part was:
: kernel bug at mm/page_alloc.c=790

I suppose this is 4.19 stable kernel because that would be
VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);

in __free_one_page. I do not really see how 2830bf6f05fb could make any
difference here. It simply zeroes out the rest of the mem section and
that is guaranteed to be allocated because we do not do subsections. The
above VM_BUG_ON says that we start allocating an unaligned pfn for its
order.

Or are there two issues reported in that bug?
-- 
Michal Hocko
SUSE Labs
