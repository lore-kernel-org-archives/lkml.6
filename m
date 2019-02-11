Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73841C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfBKRst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:48:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729117AbfBKRss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:48:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83649B11E;
        Mon, 11 Feb 2019 17:48:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 857B41E09A8; Mon, 11 Feb 2019 18:48:46 +0100 (CET)
Date:   Mon, 11 Feb 2019 18:48:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linux Upstream <linux.upstream@oneplus.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Chintan Pandya <chintan.pandya@oneplus.com>,
        "hughd@google.com" <hughd@google.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC 1/2] page-flags: Make page lock operation atomic
Message-ID: <20190211174846.GM19029@quack2.suse.cz>
References: <20190211125337.16099-1-chintan.pandya@oneplus.com>
 <20190211125337.16099-2-chintan.pandya@oneplus.com>
 <20190211134607.GA32511@hirez.programming.kicks-ass.net>
 <364c7595-14f5-7160-d076-35a14c90375a@oneplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364c7595-14f5-7160-d076-35a14c90375a@oneplus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-02-19 13:59:24, Linux Upstream wrote:
> > 
> >> Signed-off-by: Chintan Pandya <chintan.pandya@oneplus.com>
> > 
> > NAK.
> > 
> > This is bound to regress some stuff. Now agreed that using non-atomic
> > ops is tricky, but many are in places where we 'know' there can't be
> > concurrency.
> > 
> > If you can show any single one is wrong, we can fix that one, but we're
> > not going to blanket remove all this just because.
> 
> Not quite familiar with below stack but from crash dump, found that this
> was another stack running on some other CPU at the same time which also
> updates page cache lru and manipulate locks.
> 
> [84415.344577] [20190123_21:27:50.786264]@1 preempt_count_add+0xdc/0x184
> [84415.344588] [20190123_21:27:50.786276]@1 workingset_refault+0xdc/0x268
> [84415.344600] [20190123_21:27:50.786288]@1 add_to_page_cache_lru+0x84/0x11c
> [84415.344612] [20190123_21:27:50.786301]@1 ext4_mpage_readpages+0x178/0x714
> [84415.344625] [20190123_21:27:50.786313]@1 ext4_readpages+0x50/0x60
> [84415.344636] [20190123_21:27:50.786324]@1 
> __do_page_cache_readahead+0x16c/0x280
> [84415.344646] [20190123_21:27:50.786334]@1 filemap_fault+0x41c/0x588
> [84415.344655] [20190123_21:27:50.786343]@1 ext4_filemap_fault+0x34/0x50
> [84415.344664] [20190123_21:27:50.786353]@1 __do_fault+0x28/0x88
> 
> Not entirely sure if it's racing with the crashing stack or it's simply
> overrides the the bit set by case 2 (mentioned in 0/2).

So this is interesting. Looking at __add_to_page_cache_locked() nothing
seems to prevent __SetPageLocked(page) in add_to_page_cache_lru() to get
reordered into __add_to_page_cache_locked() after page is actually added to
the xarray. So that one particular instance might benefit from atomic
SetPageLocked or a barrier somewhere between __SetPageLocked() and the
actual addition of entry into the xarray.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
