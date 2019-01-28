Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C68CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB8820844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548687209;
	bh=lGLZVG+f7EZBmfQBEiPTT/jK/mGZYs8zbAqPTeh1CDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yKw+tJx3k6CR2knDximmlSJCQcK62+fkLF3tLXnCG98ybn6EebuTI5pP7SUK0Y3Rj
	 Amrev2lmnkj/uMKzSvn6huROBXzV0EBKWgyjfMLBBpOm81EV9MAxfnKKskFjIdwsbU
	 5XVF4GaJd8tXNK+c2szGsvvFf5FHA2ZM1AmFPx7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfA1Ox1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:53:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:57880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbfA1Ox0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:53:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7BDFAF0C;
        Mon, 28 Jan 2019 14:53:24 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:53:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH RFC] mm: migrate: don't rely on PageMovable() of newpage
 after unlocking it
Message-ID: <20190128145323.GN18811@dhcp22.suse.cz>
References: <20190128121609.9528-1-david@redhat.com>
 <20190128130709.GJ18811@dhcp22.suse.cz>
 <b03cae19-d02a-0ba2-69a1-010ee76748e7@redhat.com>
 <20190128132146.GK18811@dhcp22.suse.cz>
 <17e7d7e4-f4ca-a681-93e5-92a0c285be14@redhat.com>
 <20190128133514.GL18811@dhcp22.suse.cz>
 <cb3eccaf-0fbf-f3b8-dbbe-070acb9837be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb3eccaf-0fbf-f3b8-dbbe-070acb9837be@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 15:38:38, David Hildenbrand wrote:
> On 28.01.19 14:35, Michal Hocko wrote:
> > On Mon 28-01-19 14:22:52, David Hildenbrand wrote:
> >> On 28.01.19 14:21, Michal Hocko wrote:
> >>> On Mon 28-01-19 14:14:28, David Hildenbrand wrote:
> >>>> On 28.01.19 14:07, Michal Hocko wrote:
> >>>>> On Mon 28-01-19 13:16:09, David Hildenbrand wrote:
> >>>>> [...]
> >>>>>> My theory:
> >>>>>>
> >>>>>> In __unmap_and_move(), we lock the old and newpage and perform the
> >>>>>> migration. In case of vitio-balloon, the new page will become
> >>>>>> movable, the old page will no longer be movable.
> >>>>>>
> >>>>>> However, after unlocking newpage, I think there is nothing stopping
> >>>>>> the newpage from getting dequeued and freed by virtio-balloon. This
> >>>>>> will result in the newpage
> >>>>>> 1. No longer having PageMovable()
> >>>>>> 2. Getting moved to the local list before finally freeing it (using
> >>>>>>    page->lru)
> >>>>>
> >>>>> Does that mean that the virtio-balloon can change the Movable state
> >>>>> while there are other users of the page? Can you point to the code that
> >>>>> does it? How come this can be safe at all? Or is the PageMovable stable
> >>>>> only under the page lock?
> >>>>>
> >>>>
> >>>> PageMovable is stable under the lock. The relevant instructions are in
> >>>>
> >>>> mm/balloon_compaction.c and include/linux/balloon_compaction.h
> >>>
> >>> OK, I have just checked __ClearPageMovable and it indeed requires
> >>> PageLock. Then we also have to move is_lru = __PageMovable(page) after
> >>> the page lock.
> >>>
> >>
> >> I assume that is fine as is as the page is isolated? (yes, it will be
> >> modified later when moving but we are interested in the original state)
> > 
> > OK, I've missed that the page is indeed isolated. Then the patch makes
> > sense to me.
> > 
> 
> Thanks Michal. I assume this has broken ever since balloon compaction
> was introduced. I'll wait a little more and then resend as !RFC with a
> cc-stable tag.

Please make sure to CC Minchan when reposting.

Btw.
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
