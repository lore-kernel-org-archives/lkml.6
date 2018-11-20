Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D90C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D183C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D183C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeKUA1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:27:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeKUA1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:27:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E530CC04959A;
        Tue, 20 Nov 2018 13:58:14 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 655475D9C8;
        Tue, 20 Nov 2018 13:58:09 +0000 (UTC)
Date:   Tue, 20 Nov 2018 21:58:03 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, pifang@redhat.com
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        pifang@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aarcange@redhat.com,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181120135803.GA3369@MiWiFi-R3L-srv>
References: <20181119105202.GE18471@MiWiFi-R3L-srv>
 <20181119124033.GJ22247@dhcp22.suse.cz>
 <20181119125121.GK22247@dhcp22.suse.cz>
 <20181119141016.GO22247@dhcp22.suse.cz>
 <20181119173312.GV22247@dhcp22.suse.cz>
 <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
 <20181119205907.GW22247@dhcp22.suse.cz>
 <20181120015644.GA5727@MiWiFi-R3L-srv>
 <alpine.LSU.2.11.1811192127130.2848@eggly.anvils>
 <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 20 Nov 2018 13:58:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/20/18 at 02:38pm, Vlastimil Babka wrote:
> On 11/20/18 6:44 AM, Hugh Dickins wrote:
> > [PATCH] mm: put_and_wait_on_page_locked() while page is migrated
> > 
> > We have all assumed that it is essential to hold a page reference while
> > waiting on a page lock: partly to guarantee that there is still a struct
> > page when MEMORY_HOTREMOVE is configured, but also to protect against
> > reuse of the struct page going to someone who then holds the page locked
> > indefinitely, when the waiter can reasonably expect timely unlocking.
> > 
> > But in fact, so long as wait_on_page_bit_common() does the put_page(),
> > and is careful not to rely on struct page contents thereafter, there is
> > no need to hold a reference to the page while waiting on it.  That does
> 
> So there's still a moment where refcount is elevated, but hopefully
> short enough, right? Let's see if it survives Baoquan's stress testing.

Yes, I applied Hugh's patch 8 hours ago, then our QE Ping operated on
that machine, after many times of hot removing/adding, the endless
looping during mirgrating is not seen any more. The test result for
Hugh's patch is positive. I even suggested Ping increasing the memory
pressure to "stress -m 250", it still succeeded to offline and remove.

So I think this patch works to solve the issue. Thanks a lot for your
help, all of you. 

High, will you post a formal patch in a separate thread?

Meanwhile we found sometime onlining page may not add back all memory
blocks on one memory board, then hot removing/adding them will cause
kernel panic. I will investigate further and collect information, see if
it's a kernel issue or udev issue.

Thanks
Baoquan

> 
> > mean that this case cannot go back through the loop: but that's fine for
> > the page migration case, and even if used more widely, is limited by the
> > "Stop walking if it's locked" optimization in wake_page_function().
> > 
> > Add interface put_and_wait_on_page_locked() to do this, using negative
> > value of the lock arg to wait_on_page_bit_common() to implement it.
> > No interruptible or killable variant needed yet, but they might follow:
> > I have a vague notion that reporting -EINTR should take precedence over
> > return from wait_on_page_bit_common() without knowing the page state,
> > so arrange it accordingly - but that may be nothing but pedantic.
> > 
> > shrink_page_list()'s __ClearPageLocked(): that was a surprise! this
> > survived a lot of testing before that showed up.  It does raise the
> > question: should is_page_cache_freeable() and __remove_mapping() now
> > treat a PG_waiters page as if an extra reference were held?  Perhaps,
> > but I don't think it matters much, since shrink_page_list() already
> > had to win its trylock_page(), so waiters are not very common there: I
> > noticed no difference when trying the bigger change, and it's surely not
> > needed while put_and_wait_on_page_locked() is only for page migration.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> 
> ...
> 
> > @@ -1100,6 +1111,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
> >  			ret = -EINTR;
> >  			break;
> >  		}
> > +
> > +		if (lock < 0) {
> > +			/*
> > +			 * We can no longer safely access page->flags:
> 
> Hmm...
> 
> > +			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
> > +			 * there is a risk of waiting forever on a page reused
> > +			 * for something that keeps it locked indefinitely.
> > +			 * But best check for -EINTR above before breaking.
> > +			 */
> > +			break;
> > +		}
> >  	}
> >  
> >  	finish_wait(q, wait);
> 
> ... the code continues by:
> 
>         if (thrashing) {
>                 if (!PageSwapBacked(page))
> 
> So maybe we should not set 'thrashing' true when lock < 0?
> 
> Thanks!
> Vlastimil
