Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8881C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B744214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B744214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbeKTDKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:35580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388421AbeKTDKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 472CAAF4F;
        Mon, 19 Nov 2018 16:46:19 +0000 (UTC)
Date:   Mon, 19 Nov 2018 17:46:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org, pifang@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com, Mel Gorman <mgorman@suse.de>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181119164618.GQ22247@dhcp22.suse.cz>
References: <20181115131927.GT23831@dhcp22.suse.cz>
 <20181115133840.GR2653@MiWiFi-R3L-srv>
 <20181115143204.GV23831@dhcp22.suse.cz>
 <20181116012433.GU2653@MiWiFi-R3L-srv>
 <20181116091409.GD14706@dhcp22.suse.cz>
 <20181119105202.GE18471@MiWiFi-R3L-srv>
 <20181119124033.GJ22247@dhcp22.suse.cz>
 <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz>
 <eb979e1e-e0fc-b1a3-b6cc-70b503a74a20@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb979e1e-e0fc-b1a3-b6cc-70b503a74a20@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-11-18 17:36:21, Vlastimil Babka wrote:
> On 11/19/18 3:10 PM, Michal Hocko wrote:
> > On Mon 19-11-18 13:51:21, Michal Hocko wrote:
> >> On Mon 19-11-18 13:40:33, Michal Hocko wrote:
> >>> How are
> >>> we supposed to converge when the swapin code waits for the migration to
> >>> finish with the reference count elevated?
> 
> Indeed this looks wrong. How comes we only found this out now? I guess
> the race window where refcounts matter is only a part of the whole
> migration, where we update the mapping (migrate_page_move_mapping()).
> That's before copying contents, flags etc.

I guess we simply never found out because most migration callers simply
fail after few attempts. The notable exception is memory offline which
tries retries until it suceeds or the caller terminates the process by a
fatal signal

> >> Just to clarify. This is not only about swapin obviously. Any caller of
> >> __migration_entry_wait is affected the same way AFAICS.
> > 
> > In other words. Why cannot we do the following?
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index f7e4bfdc13b7..7ccab29bcf9a 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -324,19 +324,9 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
> >  		goto out;
> >  
> >  	page = migration_entry_to_page(entry);
> > -
> > -	/*
> > -	 * Once page cache replacement of page migration started, page_count
> > -	 * *must* be zero. And, we don't want to call wait_on_page_locked()
> > -	 * against a page without get_page().
> > -	 * So, we use get_page_unless_zero(), here. Even failed, page fault
> > -	 * will occur again.
> > -	 */
> > -	if (!get_page_unless_zero(page))
> > -		goto out;
> >  	pte_unmap_unlock(ptep, ptl);
> > -	wait_on_page_locked(page);
> > -	put_page(page);
> > +	page_lock(page);
> > +	page_unlock(page);
> 
> So what protects us from locking a page whose refcount dropped to zero?
> and is being freed? The checks in freeing path won't be happy about a
> stray lock.

Nothing really prevents that. But does it matter. The worst that might
happen is that we lock a freed or reused page. Who would complain?

-- 
Michal Hocko
SUSE Labs
