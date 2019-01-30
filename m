Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11513218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfA3KkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:40:24 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:58751 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727555AbfA3KkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:40:24 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 10BE598C20
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:40:22 +0000 (UTC)
Received: (qmail 8889 invoked from network); 30 Jan 2019 10:40:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Jan 2019 10:40:21 -0000
Date:   Wed, 30 Jan 2019 10:40:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     valdis.kletnieks@vt.edu
Cc:     Jan Kara <jack@suse.cz>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20190130104020.GE9565@techsingularity.net>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu>
 <20190128091627.GA27972@quack2.suse.cz>
 <14875.1548810399@turing-police.cc.vt.edu>
 <9618.1548822577@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9618.1548822577@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:29:37PM -0500, valdis.kletnieks@vt.edu wrote:
> On Tue, 29 Jan 2019 20:06:39 -0500, valdis.kletnieks@vt.edu said:
> > On Mon, 28 Jan 2019 10:16:27 +0100, Jan Kara said:
> >
> > > So my buffer_migrate_page_norefs() is certainly buggy in its current
> > > incarnation (as a result block device page cache is not migratable at all).
> > > I've sent Andrew a patch over week ago but so far it got ignored. The patch
> > > is attached, can you give it a try whether it changes something for you?
> > > Thanks!
> >
> > Been running with the patch for about 24 hours, haven't seen kcompactd
> > misbehave.  I even fired up a Chrome with a lot of tabs open, a Firefox, and a
> > kernel build, intentionally drove the system into swapping, and kcompactd
> > didn't make it into the top 10 on 'top'.
> >
> > I'm willing to say put a "tested-by:" on that one,  it looks fixed from here.
> > If there's any remaining bugs, they're ones I can't seem to trigger...
> 
> Spoke too soon.  Sitting here not stressing the laptop at all, plenty of free
> memory, and ka-blam.
> 
> Will keep my eyes open and do the data gathering Mel Gorban wanted - I discovered
> too late that trace-cmd wasn't installed, and things broke free by themselves (probably
> not coincidence that I launched a terminal window and then it cleared....)
> 

That's unfortunate. I also note that linux-next still has not been
updated with the latest version of the compaction series. Nevertheless,
it might be helpful to get the output of

grep -r . /sys/kernel/mm/transparent_hugepage/*

and the trace when the system is in normal use but kcompactd has not
pegged at 100%. At minimum, I'd like to see what the sources of high-order
allocations are and the likely causes of wakeups of kcompactd in case
there are any hints there. Your Kconfig is also potentially useful.

Thanks.

-- 
Mel Gorman
SUSE Labs
