Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB794C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D67A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D67A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeLJMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:21:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:33800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbeLJMVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:21:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 16906AF63;
        Mon, 10 Dec 2018 12:21:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC3741E13F8; Mon, 10 Dec 2018 13:21:08 +0100 (CET)
Date:   Mon, 10 Dec 2018 13:21:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] dax fixes for 4.20-rc6
Message-ID: <20181210122108.GF29289@quack2.suse.cz>
References: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
 <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com>
 <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-12-18 10:26:54, Dan Williams wrote:
> [ add Willy and Jan ]
> 
> On Sun, Dec 9, 2018 at 10:02 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, Dec 8, 2018 at 10:26 PM Williams, Dan J
> > <dan.j.williams@intel.com> wrote:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6
> >
> > What's going on with the odd non-exclusive exclusive wait?
> >
> >         prepare_to_wait_exclusive(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
> >         ...
> >         /*
> >          * Entry lock waits are exclusive. Wake up the next waiter since
> >          * we aren't sure we will acquire the entry lock and thus wake
> >          * the next waiter up on unlock.
> >          */
> >         if (waitqueue_active(wq))
> >                 __wake_up(wq, TASK_NORMAL, 1, &ewait.key);
> >
> > that seems to make little or no sense.
> >
> > Why isn't that prepare_to_wait_exclusive() just a regular
> > prepare_to_wait(), and then the whole "let's wake up anybody else" can
> > be removed?
> >
> > I've pulled it, but am awaiting explanation of what looks like some
> > pretty crazy code. I *suspect* it's a copy-and-paste situation where
> > you took the exclusive wait from somewhere else.
> 
> Yes, I believe that's true. In the other instances of waiting for an
> entry to be in unlocked there is a guarantee that the waiter will
> attain the lock and perform an unlock + wakeup. In the dax_lock_page()
> path there is the possibility that the inode dies before the lock is
> attained and a subsequent unlock sequence is not guaranteed. So, I
> believe the intent, Willy correct me if I am wrong, was to keep all
> waits "exclusive" for some sense of symmetry, but this one can and
> should be a non-exclusive wait.

Agreed. I didn't realize this when reviewing Matthew's patch and
misunderstood his comment to this end.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
