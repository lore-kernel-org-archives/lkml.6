Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF6BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795392070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfAHIvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:51:05 -0500
Received: from aws.guarana.org ([13.237.110.252]:35572 "EHLO aws.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfAHIvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:51:04 -0500
Received: by aws.guarana.org (Postfix, from userid 1006)
        id 960DDA18B4; Tue,  8 Jan 2019 08:50:58 +0000 (UTC)
Date:   Tue, 8 Jan 2019 08:50:58 +0000
From:   Kevin Easton <kevin@guarana.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Masatake YAMATO <yamato@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190108085058.GA23237@ip-172-31-15-78>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAHk-=wicks2BEwm1BhdvEj_P3yawmvQuG3NOnjhdrUDEtTGizw@mail.gmail.com>
 <nycvar.YFH.7.76.1901052108390.16954@cbobk.fhfr.pm>
 <CAHk-=whGmE4QVr6NbgHnrVGVENfM3s1y6GNbsfh8PcOg=6bpqw@mail.gmail.com>
 <nycvar.YFH.7.76.1901052131480.16954@cbobk.fhfr.pm>
 <CAHk-=wgrSKyN23yp-npq6+J-4pGqbzxb3mJ183PryjHw7PWDyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgrSKyN23yp-npq6+J-4pGqbzxb3mJ183PryjHw7PWDyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 01:54:03PM -0800, Linus Torvalds wrote:
> On Sat, Jan 5, 2019 at 12:43 PM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > > Who actually _uses_ mincore()? That's probably the best guide to what
> > > we should do. Maybe they open the file read-only even if they are the
> > > owner, and we really should look at file ownership instead.
> >
> > Yeah, well
> >
> >         https://codesearch.debian.net/search?q=mincore
> >
> > is a bit too much mess to get some idea quickly I am afraid.
> 
> Yeah, heh.
> 
> And the first hit is 'fincore', which probably nobody cares about
> anyway, but it does
> 
>     fd = open (name, O_RDONLY)
>     ..
>     mmap(window, len, PROT_NONE, MAP_PRIVATE, ..
> 
> so if we want to keep that working, we'd really need to actually check
> file ownership rather than just looking at f_mode.
> 
> But I don't know if anybody *uses* and cares about fincore, and it's
> particularly questionable for non-root users.
> 
...
> I didn't find anything that seems to really care, but I gave up after
> a few pages of really boring stuff.

I've gone through everything in the Debian code search, and this is the
stuff that seems like it would be affected at all by the current patch:

util-linux
    Contains 'fincore' as already noted above.

e2fsprogs
    e4defrag tries to drop pages that it caused to be loaded into the
    page cache, but it's not clear that this ever worked as designed 
    anyway (it calls mincore() before ioctl(fd, EXT4_IOC_MOVE_EXT ..)
    but then after the sync_file_range it drops the pages that *were*
    in the page cache at the time of mincore()).

pgfincore
    postgresql extension used to try to dump/restore page cache status
    of database backing files across reboots.  It uses a fresh mapping
    with mincore() to try to determine the current page cache status of
    a file.

nocache
    LD_PRELOAD library that tries to drop any pages that the victim
    program has caused to be loaded into the page cache, uses mincore
    on a fresh mapping to see what was resident beforehand.  Also 
    includes 'cachestats' command that's basically another 'fincore'.

xfsprogs
    xfs_io has a 'mincore' sub-command that is roughly equivalent to
    'fincore'.

vmtouch
    vmtouch is "Portable file system cache diagnostics and control",
    among other things it implements 'fincore' type functionality, and
    one of its touted use-cases is "Preserving virtual memory profile
    when failing over servers".

qemu
    qemu uses mincore() with a fresh PROT_NONE, MAP_PRIVATE mapping to
    implement the "x-check-cache-dropped" option.  
    ( https://patchwork.kernel.org/patch/10395865/ )

(Everything else I could see was either looking at anonymous VMAs, its
own existing mapping that it's been using for actual IO, or was just
using mincore() to see if an address was part of any mapping at all).

    - Kevin
