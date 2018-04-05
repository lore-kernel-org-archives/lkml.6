Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754112AbeDEW1a (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 18:27:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59432 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDEW13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 18:27:29 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: jikos@suse.cz, mawilcox@microsoft.com, raven@themaw.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: update-binfmts breaking suspend was Re: x32 suspend failuer in Re: linux-next: Tree for Apr 4
Date: Fri, 06 Apr 2018 00:27:39 +0200
Message-ID: <9416653.6IxviOAG69@aspire.rjw.lan>
In-Reply-To: <20180405203045.GA23313@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au> <20180405122503.GA28446@amd> <20180405203045.GA23313@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 5, 2018 10:30:45 PM CEST Pavel Machek wrote:
> Hi!
> 
> > > Well, v4.16-rc4 is parent of v4.16-rc6, but next-20180304 is not
> > > parent of next-20180307.
> > > 
> > > But you are right that if I do bisect between -linus and -next, it
> > > should work.
> > > 
> > > Anyway, does s2ram work for you in -next? Are you testing 32bit?
> > 
> > Hmm. I tested on T40p. That works ok, so at least some 32bit machines
> > do work.
> > 
> > Hmm, and my test scripts were wrong.
> > 
> > Failure is not a hang, as they expect, but... machine locks up, but
> > does not suspend, and then continues running after a delay..
> > 
> > [   35.038766] PM: Syncing filesystems ... done.
> > [   35.051246] Freezing user space processes ...
> > [   55.060528] Freezing of tasks failed after 20.009 seconds (1 tasks
> > refusing to freeze, wq_busy
> > =0):
> > [   55.060552] update-binfmts  D    0  2727      1 0x80000004
> > [   55.060576] Call Trace:
> > [   55.060600]  __schedule+0x37a/0x7e0
> > [   55.060618]  schedule+0x29/0x70
> > [   55.060635]  autofs4_wait+0x359/0x7a0
> > [   55.060653]  ? wait_woken+0x70/0x70
> > [   55.060668]  autofs4_mount_wait+0x4a/0xe0
> > [   55.060684]  ? autofs4_mount_wait+0x4a/0xe0
> > [   55.060699]  autofs4_d_automount+0xe0/0x200
> > [   55.060715]  ? autofs4_d_automount+0xe0/0x200
> > 
> > Did the rework of freezing start already in -next?
> 
> Hmm, so I did git bisect, and it pointed to:
> 
> commit 7cb03edf112fea6ead2fcd3c5fd639756d6d114b
> Author: Matthew Wilcox <mawilcox@microsoft.com>
> Date:   Thu Mar 29 10:15:17 2018 +1100
> 
>     autofs4: use wait_event_killable
> 
>     This playing with signals to allow only fatal signals appears to
>     predate
>         the introduction of wait_event_killable(), and I'm fairly sure
>     that
>         wait_event_killable is what was meant to happen here.
> 
>     Link:
>     http://lkml.kernel.org/r/20180319191609.23880-1-willy@infradead.org
>         Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 	    Acked-by: Ian Kent <raven@themaw.net>
> 	        Signed-off-by: Andrew Morton
>     <akpm@linux-foundation.org>
>         Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Well, let's tell Thorsten about this (CCed).
