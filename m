Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeERQCf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:02:35 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:56239 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeERQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:02:27 -0400
Date: Fri, 18 May 2018 18:02:23 +0200
From: Guillaume Nault <g.nault@alphalink.fr>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-ppp@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com>,
        viro@zeniv.linux.org.uk
Subject: Re: KASAN: use-after-free Read in remove_wait_queue (2)
Message-ID: <20180518160223.GF1534@alphalink.fr>
References: <f403043d0f18f879cc056648a875@google.com>
 <20180514061155.GL677@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514061155.GL677@sol.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 11:11:55PM -0700, Eric Biggers wrote:
> [+ppp list and maintainer]
> 
> This is a bug in ppp_generic.c; it still happens on Linus' tree and it's easily
> reproducible, see program below.  The bug is that the PPPIOCDETACH ioctl doesn't
> consider that the file can still be attached to epoll instances even when
> ->f_count == 1.

Right. What would it take to remove the file for the epoll instances?
Sorry for the naive question, but I'm not familiar with VFS and didn't
find a helper function we could call.

> Also, the reproducer doesn't test this but I think ppp_poll(),
> ppp_read(), and ppp_write() can all race with PPPIOCDETACH, causing
> use-after-frees as well.

I also believe so. ppp_release() resets ->private_data, and even though
functions like ppp_read() test ->private_data before executing, there's
no synchronisation mechanism to ensure that the update is visible
before the unit or channel is destroyed. Is that the kind of race you
had in mind?

> Any chance that PPPIOCDETACH can simply be removed,
> given that it's apparently been "deprecated" for 16 years?
> Does anyone use it?

The only users I'm aware of are pppd versions older than ppp-2.4.2
(released in November 2003). But even at that time, there were issues
with PPPIOCDETACH as pppd didn't seem to react properly when this call
failed. An Internet search on the "PPPIOCDETACH file->f_count=" kernel
log string, or on the "Couldn't release PPP unit: Invalid argument"
error message of pppd, returns several related bug reports.

Originally, PPPIOCDETACH never failed, but testing ->f_count was
later introduced to fix crashes when the file descriptor had been
duplicated. It seems that this was motivated by polling issues too.

Long story short, it looks like PPPIOCDETACH never has worked well
and we have at least two more bugs to fix. Given how it has proven
fragile, I wouldn't be surprised if there were even more lurking
around. I'd say that it's probably safer to drop it than to add more
workarounds and playing wack-a-mole with those bugs.
