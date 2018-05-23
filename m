Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbeEWDaD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:30:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40813 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbeEWDaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:30:01 -0400
X-Google-Smtp-Source: AB8JxZrTHvuXKbJENmAYejSE0FgrEegO3wS5UjUizM8itjULsgEfWna8Jlu1FMuKqvg4GVSvchuY3w==
Date: Tue, 22 May 2018 20:29:58 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Guillaume Nault <g.nault@alphalink.fr>
Cc: linux-ppp@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com>,
        viro@zeniv.linux.org.uk
Subject: Re: KASAN: use-after-free Read in remove_wait_queue (2)
Message-ID: <20180523032958.GE658@sol.localdomain>
References: <f403043d0f18f879cc056648a875@google.com>
 <20180514061155.GL677@sol.localdomain>
 <20180518160223.GF1534@alphalink.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518160223.GF1534@alphalink.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 06:02:23PM +0200, Guillaume Nault wrote:
> On Sun, May 13, 2018 at 11:11:55PM -0700, Eric Biggers wrote:
> > [+ppp list and maintainer]
> > 
> > This is a bug in ppp_generic.c; it still happens on Linus' tree and it's easily
> > reproducible, see program below.  The bug is that the PPPIOCDETACH ioctl doesn't
> > consider that the file can still be attached to epoll instances even when
> > ->f_count == 1.
> 
> Right. What would it take to remove the file for the epoll instances?
> Sorry for the naive question, but I'm not familiar with VFS and didn't
> find a helper function we could call.
> 

There is eventpoll_release_file(), but it's not exported to modules.  It might
work to call it, but it seems like a hack.

> > Also, the reproducer doesn't test this but I think ppp_poll(),
> > ppp_read(), and ppp_write() can all race with PPPIOCDETACH, causing
> > use-after-frees as well.
> 
> I also believe so. ppp_release() resets ->private_data, and even though
> functions like ppp_read() test ->private_data before executing, there's
> no synchronisation mechanism to ensure that the update is visible
> before the unit or channel is destroyed. Is that the kind of race you
> had in mind?

Yes, though after looking into it more I *think* these additional races aren't
actually possible, due to the 'f_count < 2' check.  These races could only
happen with a shared fd table, but in that case fdget() would increment f_count
for the duration of each operation, resulting in 'f_count >= 2' if both ioctl()
and something else is running on the same file concurrently.

Note that this also means PPPIOCDETACH doesn't work at all if called from a
multithreaded application...

> 
> > Any chance that PPPIOCDETACH can simply be removed,
> > given that it's apparently been "deprecated" for 16 years?
> > Does anyone use it?
> 
> The only users I'm aware of are pppd versions older than ppp-2.4.2
> (released in November 2003). But even at that time, there were issues
> with PPPIOCDETACH as pppd didn't seem to react properly when this call
> failed. An Internet search on the "PPPIOCDETACH file->f_count=" kernel
> log string, or on the "Couldn't release PPP unit: Invalid argument"
> error message of pppd, returns several related bug reports.
> 
> Originally, PPPIOCDETACH never failed, but testing ->f_count was
> later introduced to fix crashes when the file descriptor had been
> duplicated. It seems that this was motivated by polling issues too.
> 
> Long story short, it looks like PPPIOCDETACH never has worked well
> and we have at least two more bugs to fix. Given how it has proven
> fragile, I wouldn't be surprised if there were even more lurking
> around. I'd say that it's probably safer to drop it than to add more
> workarounds and playing wack-a-mole with those bugs.

IMO, if we can get away with removing it without any users noticing, that would
be much better than trying to fix it with a VFS-level hack, and probably missing
some cases.  I'll send a patch to get things started...

- Eric
