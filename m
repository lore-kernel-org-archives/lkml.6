Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C10C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71D420685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfAISC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:02:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfAISC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:02:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D799804EB;
        Wed,  9 Jan 2019 18:02:28 +0000 (UTC)
Received: from sky.random (ovpn-123-111.rdu2.redhat.com [10.10.123.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C61D817AE4;
        Wed,  9 Jan 2019 18:02:27 +0000 (UTC)
Date:   Wed, 9 Jan 2019 13:02:25 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: sched/fair: skip select_idle_sibling() in
 presence of sync wakeups
Message-ID: <20190109180225.GA28624@redhat.com>
References: <20190109034941.28759-1-aarcange@redhat.com>
 <1547007588.17100.17.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547007588.17100.17.camel@gmx.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 09 Jan 2019 18:02:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Wed, Jan 09, 2019 at 05:19:48AM +0100, Mike Galbraith wrote:
> On Tue, 2019-01-08 at 22:49 -0500, Andrea Arcangeli wrote:
> > Hello,
> > 
> > we noticed some unexpected performance regressions in the scheduler by
> > switching the guest CPU topology from "-smp 2,sockets=2,cores=1" to
> > "-smp 2,sockets=1,cores=2".
*snip*
> > To test I used this trivial program.
> 
> Which highlights the problem.  That proggy really is synchronous, but

Note that I wrote the program only after the guest scheduler
regression was reported, purely in order to test the patch and to
reproduce the customer issue more easily (so I could see the effect by
just running top). The regression was reported by a real life customer
workload AFIK and it was caused by the idle balancing dropping the
sync information.

If it was just the lat_ctx type of workload like the program I
attached I wouldn't care either, but this was a localhost udp and tcp
(both bandwidth and latency) test that showed improvement by not
dropping to the sync information through idle core balancing during
wakeups.

There is no tuning to allow people to test the sync information with
real workloads, the only way is to rebuild the kernel with SCHED_MC=n
(which nobody should be doing because it has other drawbacks) or by
altering the vCPU topology. So for now we're working to restore the
standard only-sockets topology to shut off the idle balancing without
having to patch the guest scheduler, but this looked like a more
general problem that has room for improvement.

Ideally we should detect when the sync information is worth keeping
instead of always dropping it. Alternatively a sched_feat could be
added to achieve it manually.

Thanks,
Andrea
