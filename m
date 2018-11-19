Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65B42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65B42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbeKTHYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:24:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:52310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730755AbeKTHYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:24:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43680B03B;
        Mon, 19 Nov 2018 20:59:08 +0000 (UTC)
Date:   Mon, 19 Nov 2018 21:59:07 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, pifang@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181119205907.GW22247@dhcp22.suse.cz>
References: <20181115133840.GR2653@MiWiFi-R3L-srv>
 <20181115143204.GV23831@dhcp22.suse.cz>
 <20181116012433.GU2653@MiWiFi-R3L-srv>
 <20181116091409.GD14706@dhcp22.suse.cz>
 <20181119105202.GE18471@MiWiFi-R3L-srv>
 <20181119124033.GJ22247@dhcp22.suse.cz>
 <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz>
 <20181119173312.GV22247@dhcp22.suse.cz>
 <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-11-18 12:34:09, Hugh Dickins wrote:
> On Mon, 19 Nov 2018, Michal Hocko wrote:
> > On Mon 19-11-18 15:10:16, Michal Hocko wrote:
> > [...]
> > > In other words. Why cannot we do the following?
> > 
> > Baoquan, this is certainly not the right fix but I would be really
> > curious whether it makes the problem go away.
> > 
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index f7e4bfdc13b7..7ccab29bcf9a 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -324,19 +324,9 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> > >  		goto out;
> > >  
> > >  	page = migration_entry_to_page(entry);
> > > -
> > > -	/*
> > > -	 * Once page cache replacement of page migration started, page_count
> > > -	 * *must* be zero. And, we don't want to call wait_on_page_locked()
> > > -	 * against a page without get_page().
> > > -	 * So, we use get_page_unless_zero(), here. Even failed, page fault
> > > -	 * will occur again.
> > > -	 */
> > > -	if (!get_page_unless_zero(page))
> > > -		goto out;
> > >  	pte_unmap_unlock(ptep, ptl);
> > > -	wait_on_page_locked(page);
> > > -	put_page(page);
> > > +	page_lock(page);
> > > +	page_unlock(page);
> > >  	return;
> > >  out:
> > >  	pte_unmap_unlock(ptep, ptl);
> 
> Thanks for Cc'ing me. I did mention precisely this issue two or three
> times at LSF/MM this year, and claimed then that I would post the fix.

I've had a recollection about some issue I just couldn't remember what
was it exactly. Tried to make Vlastimil to remember but failed there as
well ;)

> I'm glad that I delayed, what I had then (migration_waitqueue instead
> of using page_waitqueue) was not wrong, but what I've been using the
> last couple of months is rather better (and can be put to use to solve
> similar problems in collapsing pages on huge tmpfs. but we don't need
> to get into that at this time): put_and_wait_on_page_locked().
> 
> What I have not yet done is verify it on latest kernel, and research
> the interested Cc list (Linus and Tim Chen come immediately to mind),
> and write the commit comment. I have some testing to do on the latest
> kernel today, so I'll throw put_and_wait_on_page_locked() in too,
> and post tomorrow I hope.

Cool, it seems that Baoquan has a reliable test case to trigger the
pathological case.
-- 
Michal Hocko
SUSE Labs
