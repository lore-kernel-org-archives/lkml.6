Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1370BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE7C222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550060703;
	bh=iULBgK68v3NhMMC9NOMEci+UMTmUSfm6LIClofyOaoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ihcu0Jc3fTwadKTmhH9yuBDGojAiIBvqXS93JGlML3ny73n7gXwWcVIVxzNXi4cGS
	 OPfx+WIwx1nm1ajtvRXhMh8wtmtNi8T191vBBD8vRwZDEsxKQPMs4k4PuMKvyuCZvN
	 hXtJfaGgolFQthq//YhEgVbuCTqpYPzasxzjJjA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfBMMZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:25:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730020AbfBMMZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:25:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A07F8AC7A;
        Wed, 13 Feb 2019 12:24:59 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:24:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190213122458.GF4525@dhcp22.suse.cz>
References: <20190213112900.33963-1-minchan@kernel.org>
 <20190213120330.GD4525@dhcp22.suse.cz>
 <20190213121200.GA52615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213121200.GA52615@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 21:12:00, Minchan Kim wrote:
> On Wed, Feb 13, 2019 at 01:03:30PM +0100, Michal Hocko wrote:
> > On Wed 13-02-19 20:29:00, Minchan Kim wrote:
> > > [1] was backported to v4.9 stable tree but it introduces pgtable
> > > memory leak because with fault retrial, preallocated pagetable
> > > could be leaked in second iteration.
> > > To fix the problem, this patch backport [2].
> > > 
> > > [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> > > [2] b0b9b3df27d10, mm: stop leaking PageTables
> > > 
> > > Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Cc: Michal Hocko <mhocko@suse.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Liu Bo <bo.liu@linux.alibaba.com>
> > > Cc: <stable@vger.kernel.org> [4.9]
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > Thanks for catching this dependency. Do I assume it correctly that this
> > is stable-4.9 only?
> 
> I have no idea how I could find it automatically that a stable patch of
> linus tree is spread out with several stable trees(Hope Greg has an
> answer). I just checked 4.4 longterm kernel and couldn't find it in there.

See http://lkml.kernel.org/r/20190115174036.GA24149@dhcp22.suse.cz

But my question was more about "this is a stable only thing"? It was not
obvious from the subject so I wanted to be sure that I am not missing
anything.
-- 
Michal Hocko
SUSE Labs
