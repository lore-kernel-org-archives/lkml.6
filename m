Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC5CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5025121736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfA1LD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:03:59 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:33025 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbfA1LD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:03:59 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id DB1CF98B0D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:03:56 +0000 (UTC)
Received: (qmail 32514 invoked from network); 28 Jan 2019 11:03:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2019 11:03:56 -0000
Date:   Mon, 28 Jan 2019 11:03:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     valdis.kletnieks@vt.edu, Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, vbabka@suse.cz,
        aarcange@redhat.com, rientjes@google.com, mhocko@kernel.org,
        zi.yan@cs.rutgers.edu, hannes@cmpxchg.org, Jan Kara <jack@suse.cz>
Subject: Re: [regression -next0117] What is kcompactd and why is he eating
 100% of my cpu?
Message-ID: <20190128110355.GC9565@techsingularity.net>
References: <20190126200005.GB27513@amd>
 <12171.1548557813@turing-police.cc.vt.edu>
 <20190127141556.GB9565@techsingularity.net>
 <20190127160027.GA9340@amd>
 <13417.1548624994@turing-police.cc.vt.edu>
 <20190128091627.GA27972@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190128091627.GA27972@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:16:27AM +0100, Jan Kara wrote:
> On Sun 27-01-19 16:36:34, valdis.kletnieks@vt.edu wrote:
> > On Sun, 27 Jan 2019 17:00:27 +0100, Pavel Machek said:
> > > > > I've noticed this as well on earlier kernels (next-20181224 to 20190115)
> > > > > Some more info:
> > > > > 1) echo 3 > /proc/sys/vm/drop_caches  unwedges kcompactd in 1-3 seconds.
> > > > This aspect is curious as it indicates that kcompactd could potentially
> > > > be infinite looping but it's not something I've experienced myself. By
> > > > any chance is there a preditable reproduction case for this?
> > >
> > > I seen it exactly once, so not sure how reproducible this is. x86-32
> > > machine, running chromium browser, so yes, there was some swapping
> > > involved.
> > 
> > I don't have a surefire replicator, but my laptop (x86_64, so it's not a 32-bit
> > only issue) triggers it fairly often, up to multiple times a day. Doesn't seem to
> > be just the Chrome browser that triggers it - usually I'm doing other stuff as
> > well, like a compile or similar.  The fact that 'drop_caches' clears it  makes me
> > wonder if we're hitting a corner case where cache data isn't being automatically
> > cleared and clogging something up.
> 
> So my buffer_migrate_page_norefs() is certainly buggy in its current
> incarnation (as a result block device page cache is not migratable at all).
> I've sent Andrew a patch over week ago but so far it got ignored. The patch
> is attached, can you give it a try whether it changes something for you?
> Thanks!
> 

Definetly worth trying and hopefully both the migration and compaction
patches sync up soon. In the event this patch does not help, I would
appreciate the following

1) A trace while kcompactd is pegged at 100%

	trace-cmd record -a -e compaction -e migrate -e kmem:mm_page_alloc -e vmscan:mm_vmscan_kswapd_wake -e vmscan:mm_vmscan_kswapd_sleep sleep 10

   Compress the resulting trace.dat and email it to me. If it's too big
   for a reasonable email, drop "-e kmem:mm_page_alloc" from the command
   line and it should be a more reasonable size. If not, reduce the sleep
   time to gather a shorter inverval.

2) Sample stack traces of kcompact while pegged at 100%

   echo -n > /tmp/kcompactd-stack; for i in `seq 1 100`; do echo sample $i >> /tmp/kcompactd-stack; cat /proc/`pidof kcompactd0`/stack >> /tmp/kcompactd-stack; done; gzip -f /tmp/kcompactd-stack

   And mail me the resulting /tmp/kcompactd-stack.gz

Thanks.

-- 
Mel Gorman
SUSE Labs
