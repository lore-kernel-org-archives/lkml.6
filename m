Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8321CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BE82087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pF/LrQ/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfAGVdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:33:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42396 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O26H17LH+2EZaZkE/Gv1udkC7WkJ5WAzErBfQFSJ7rk=; b=pF/LrQ/OXKYO4Yk275iLmRpFx
        IwWumaqn1ldekhNqa81mbEOVYw3s4S0w8zHXkBCBeHsYFHF5DMT+z3ERY8i0YvQvWfUCs8E0BWRGg
        9+gVYy9Gn0mOfYbF0xbkh57GdxadUqzKpzheYIHNZngoEg0MVgVVExzgl9AwvIHDuJNK0YSl69T3q
        J0Kc694CEXzCjH2vNCw2+/DYt0o4QC0lZ1WAaqxWl19vqV1ddUMvGHKcsmcmhsgucWrHLrVCulcPO
        zu06uldIu18K0YczWG//pcwKC6LknYLHPmjDl+MKBwY47CappYzMT5QuazwwQN3Jw4kWKkyuL/HcQ
        qc0PyHA5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggcWE-0008JU-Ue; Mon, 07 Jan 2019 21:33:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9059521A79DB9; Mon,  7 Jan 2019 22:33:08 +0100 (CET)
Date:   Mon, 7 Jan 2019 22:33:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: possible deadlock in __wake_up_common_lock
Message-ID: <20190107213308.GE16284@hirez.programming.kicks-ass.net>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190107095217.GB2861@worktop.programming.kicks-ass.net>
 <20190107204627.GA25526@cmpxchg.org>
 <20190107212921.GK14122@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107212921.GK14122@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:29:21PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 07, 2019 at 03:46:27PM -0500, Johannes Weiner wrote:
> > Hm, so the splat says this:
> > 
> > wakeups take the pi lock
> > pi lock holders take the rq lock
> > rq lock holders take the timer base lock (thanks psi)
> > timer base lock holders take the zone lock (thanks kasan)

That's not kasan, that's debugobjects, and that would be equally true
for the hrtimer usage we already have in the scheduler.

With that, I'm not entirely sure we're responsible for this splat.. I'll
try and have another look tomorrow.
