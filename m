Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D445C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D7326347
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D7326347
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934306AbeFZAYW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:24:22 -0400
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:35037 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933424AbeFZAYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:24:20 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 26 Jun 2018 09:54:18 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fXbmL-0006AB-8j; Tue, 26 Jun 2018 10:24:17 +1000
Date:   Tue, 26 Jun 2018 10:24:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andi Kleen <andi.kleen@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, Jan Kara <jack@suse.cz>,
        Brian Foster <bfoster@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: replace current_kernel_time64 with ktime equivalent
Message-ID: <20180626002417.GH13748@dastard>
References: <20180620150138.49380-1-arnd@arndb.de>
 <20180621202339.GC13748@dastard>
 <CAK8P3a0C4hgu9apX8vE6BrqnrU76dHhafY8J-ppPBdhPbxq26Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0C4hgu9apX8vE6BrqnrU76dHhafY8J-ppPBdhPbxq26Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 03:24:48PM +0200, Arnd Bergmann wrote:
> On Thu, Jun 21, 2018 at 10:23 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Wed, Jun 20, 2018 at 05:01:24PM +0200, Arnd Bergmann wrote:
> 
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index 2c300e981796..e27bd9334939 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -2133,7 +2133,9 @@ EXPORT_SYMBOL(timespec64_trunc);
> >>   */
> >>  struct timespec64 current_time(struct inode *inode)
> >>  {
> >> -     struct timespec64 now = current_kernel_time64();
> >> +     struct timespec64 now;
> >> +
> >> +     ktime_get_coarse_real_ts64(&now);
> >
> > Can I just say as a filesystem dev who has no idea at all about
> > kernel timer implementations: this is an awful API change.  There
> > are hundreds of callers of current_time(), so I'm not going to be
> > the only person looking at this function who has no clue about WTF
> > "ktime_get_coarse_real" actually means or does. Further, this
> > function is not documented, and jumps straight into internal time
> > implementation stuff, so I'm lost straight away if somebody asks me
> > "what does that function do"?. i.e. I have *no clue* what this
> > function returns or why this code uses it.
> 
> You definitely have a point about the documentation. I meant to
> fix that as part of the recent rework of the timekeeping.h header
> but haven't finished it, partly because the header is still being
> changed as we get rid of the older interfaces.

The interface documentation should be introduced with the new
interfaces, not left for later as that leaves people like me with no
fucking clue about what the changes actually mean or why they are
being done.  Perhaps you'd have done better to explain this API as
an internal implementation of clock_gettime(CLOCK_REALTIME_COARSE),
which is clearly documented in the man page as:

"Use when you need very fast, but not fine-grained timestamps."

Put that comment on ktime_get_coarse_real_ts64(), and almost all the
questions about "WTF does this whacky function do?" go away....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
