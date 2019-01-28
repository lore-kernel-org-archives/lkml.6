Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5705C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8329E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548682518;
	bh=ThV8zaiDoRORDOQgNK58MhtDRSznnSy8HqC2DbKcuyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hCiHVCU92OpZfsjCJHPaycHBiJvPFeQ8Ah/GxkA3u9UKc2bRkJv4vOGhrM+ijAhRh
	 x1ugqqCCVWQSVvzuihKzqEvQMlUscqZbyFQ3JfdSmIzuJGHTYdA7NQIYsrrXHsxVXv
	 hPf0H7gZzhd7gUd2zuDLKyrokPGVWVDJNYK3Z2Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA1NfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:35:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfA1NfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:35:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 436DFABB1;
        Mon, 28 Jan 2019 13:35:15 +0000 (UTC)
Date:   Mon, 28 Jan 2019 14:35:14 +0100
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
Message-ID: <20190128133514.GL18811@dhcp22.suse.cz>
References: <20190128121609.9528-1-david@redhat.com>
 <20190128130709.GJ18811@dhcp22.suse.cz>
 <b03cae19-d02a-0ba2-69a1-010ee76748e7@redhat.com>
 <20190128132146.GK18811@dhcp22.suse.cz>
 <17e7d7e4-f4ca-a681-93e5-92a0c285be14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e7d7e4-f4ca-a681-93e5-92a0c285be14@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 14:22:52, David Hildenbrand wrote:
> On 28.01.19 14:21, Michal Hocko wrote:
> > On Mon 28-01-19 14:14:28, David Hildenbrand wrote:
> >> On 28.01.19 14:07, Michal Hocko wrote:
> >>> On Mon 28-01-19 13:16:09, David Hildenbrand wrote:
> >>> [...]
> >>>> My theory:
> >>>>
> >>>> In __unmap_and_move(), we lock the old and newpage and perform the
> >>>> migration. In case of vitio-balloon, the new page will become
> >>>> movable, the old page will no longer be movable.
> >>>>
> >>>> However, after unlocking newpage, I think there is nothing stopping
> >>>> the newpage from getting dequeued and freed by virtio-balloon. This
> >>>> will result in the newpage
> >>>> 1. No longer having PageMovable()
> >>>> 2. Getting moved to the local list before finally freeing it (using
> >>>>    page->lru)
> >>>
> >>> Does that mean that the virtio-balloon can change the Movable state
> >>> while there are other users of the page? Can you point to the code that
> >>> does it? How come this can be safe at all? Or is the PageMovable stable
> >>> only under the page lock?
> >>>
> >>
> >> PageMovable is stable under the lock. The relevant instructions are in
> >>
> >> mm/balloon_compaction.c and include/linux/balloon_compaction.h
> > 
> > OK, I have just checked __ClearPageMovable and it indeed requires
> > PageLock. Then we also have to move is_lru = __PageMovable(page) after
> > the page lock.
> > 
> 
> I assume that is fine as is as the page is isolated? (yes, it will be
> modified later when moving but we are interested in the original state)

OK, I've missed that the page is indeed isolated. Then the patch makes
sense to me.
-- 
Michal Hocko
SUSE Labs
