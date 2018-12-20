Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B462186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbeLTN6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbeLTN6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:58:06 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D383F217D8;
        Thu, 20 Dec 2018 13:58:04 +0000 (UTC)
Date:   Thu, 20 Dec 2018 08:58:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] printk: increase devkmsg write() ratelimit
Message-ID: <20181220085803.4c5853e8@gandalf.local.home>
In-Reply-To: <20181220113537.GA701@jagdpanzerIV>
References: <20181218114709.GF7485@zn.tnic>
        <20181218130750.GA665@tigerII.localdomain>
        <20181218142623.GH7485@zn.tnic>
        <20181218145558.GD665@tigerII.localdomain>
        <20181218150313.GI7485@zn.tnic>
        <20181218151455.GE665@tigerII.localdomain>
        <20181218152413.GJ7485@zn.tnic>
        <20181218165217.GA534@tigerII.localdomain>
        <20181218172109.GK15430@hirez.programming.kicks-ass.net>
        <20181218123748.3aadd16c@gandalf.local.home>
        <20181220113537.GA701@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 20:35:37 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (12/18/18 12:37), Steven Rostedt wrote:
> > > 
> > > Again, complain to system-doofus for printing so much crap to somewhere
> > > it should not print to begin with.  
> > 
> > I've been saying that it would be good to make the kmsg be a separate
> > buffer that just gets interleaved with the kernel buffer.  
> 
> Hmm, this is interesting.
> 
> > Userspace processes should never be able to overwrite messages
> > from the kernel.  
> 
> I would agree.
> 
> It's a bit funny that kernel people first take the patch in and then,
> when user-space begins to use the feature, start to object and ratelimit.

Please note the "kernel people" to first take it in, were also systemd
developers. And there was a bit of objections to what they wanted to
have to what they got. It wasn't until later when systemd started
abusing the buffer (taking it as its own, making the kernel use of it a
second class citizen) that other kernel developers (that now need to
deal with the fallout) started to object and ratelimit it.

Honestly, it should have been a separate buffer to begin with, and I
wish I pushed for that when it was first added. It's not too late. We
can still make it a separate buffer.

> 
> By the way, systemd seems to be OK with alternative logging targets
> 
> /etc/systemd/system.conf
> 
> ---
> 	[Manager]
> 	#LogLevel=info
> 	LogTarget=syslog console journal

When the system is up and running, it works. But I believe systemd can
still only use ksmsg for initial boot up messages before it does the
chroot.

> ---
> 
> Everything looks fine with read-only devkmsg (running the patched
> kernel). "journalctl -f -b" gives a nice system log:
> 
> ...
>  kernel: r8169 0000:04:00.0 enp4s0: renamed from eth0
>  kernel: snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
>  systemd-udevd[180]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
>  systemd[1]: Started Flush Journal to Persistent Storage.
>  kernel: input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
> ...
> 

Do you get systemd messages before chroot with this patch compared to
what you get without it?

-- Steve

> 
> Given how often systemd hits ratelimits (I googled some bug reports),
> I wonder if systemd people are still interested in /dev/kmsg logging
> at all.
> 
