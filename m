Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB18C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6103E222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfBPIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:48:04 -0500
Received: from latin.grep.be ([46.4.76.168]:36079 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbfBPIsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:48:03 -0500
X-Greylist: delayed 1889 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Feb 2019 03:48:03 EST
Received: from [197.89.34.44] (helo=gangtai.home.grep.be)
        by latin.grep.be with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <w@uter.be>)
        id 1guv9C-0005bn-Tb; Sat, 16 Feb 2019 09:16:31 +0100
Received: from wouter by gangtai.home.grep.be with local (Exim 4.92-RC6)
        (envelope-from <w@uter.be>)
        id 1guv94-0006Wa-Np; Sat, 16 Feb 2019 09:16:22 +0100
Date:   Sat, 16 Feb 2019 09:16:22 +0100
From:   Wouter Verhelst <w@uter.be>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, nbd@other.debian.org
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190216081622.GA23435@grep.be>
References: <20190215191953.GB17897@amd>
 <20190215224126.GX12500@redhat.com>
 <20190215225332.GA4922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215225332.GA4922@redhat.com>
X-Speed: Gates' Law: Every 18 months, the speed of software halves.
Organization: none
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 15, 2019 at 10:53:32PM +0000, Richard W.M. Jones wrote:
> On Fri, Feb 15, 2019 at 10:41:26PM +0000, Richard W.M. Jones wrote:
> > On Fri, Feb 15, 2019 at 08:19:54PM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I watched fosdem talk about
> > > nbdkit... https://www.youtube.com/watch?v=9E5A608xJG0 . Nice. But word
> > > of warning: I'm not sure using it read-write on localhost is safe.
> > > 
> > > In particular, user application could create a lot of dirty data
> > > quickly. If there's not enough memory for nbdkit (or nbd-client or
> > > nbd-server), you might get a deadlock.
> > 
> > Thanks for the kind words about the talk.  I've added Wouter Verhelst
> > & the NBD mailing list to CC.  Although I did the talk because the
> > subject is interesting, how I actually use nbdkit / NBD is to talk to
> > qemu and that's where I have most experience and where we (Red Hat)
> > use it in production systems.
> > 
> > However in January I spent a lot of time exercising the NBD loop-mount
> > + nbdkit case using fio in order to find contention / bottlenecks in
> > our use of threads and locks.  I didn't notice any particular problems
> > then, but it's possible my testing wasn't thorough enough.  Or that
> > fio only creates small numbers of dirty pages (because of locality in
> > its access patterns I guess?)
> > 
> > When you say it's not safe, what could happen?  What would we observe
> > if it was going wrong?
> 
> Reading more carefully I see you said we'd observe a deadlock.  I
> didn't see that, but again my testing of this wouldn't have been very
> thorough.  When I have some time I'll try creating / spooling huge
> files into an NBD loop mount to see if I can cause a deadlock.

While it's of course impossible to fully exclude the possibility of
deadlock when clearing dirty pages to the network, since Mel Gorman's
work that resulted in commit 7f338fe4540b1d0600b02314c7d885fd358e9eca
this should be extremely unlikely, and swapping over the network (NBD or
NFS or whatnot) should be reasonably safe, as well as clearing dirty
pages etc.

Additionally, nbd-client when called with -s calls memlockall() at an
appropriate moment, so that it should not be swapped out.

That only leaves the server side. Personally I haven't been able to
deadlock a reasonably recent machine using NBD, but of course YMMV.

> > > Also note that nbd.txt in Documentation/blockdev/ points to
> > > sourceforge; it should probably point to
> > > https://github.com/NetworkBlockDevice/nbd ?
> > 
> > Wouter should be able to say what the correct link should be.

The sourceforge project is still active, and is where I do the official
file releases. I also push the git repository there. For people who just
want a released version of the NBD utilities, pointing to sourceforge
isn't wrong, I would say.

GitHub is indeed used mostly for development, though.

It might be nice to rethink all that, now that we don't have a
mailinglist running at sourceforge anymore, but I don't think it's very
urgent.

-- 
To the thief who stole my anti-depressants: I hope you're happy

  -- seen somewhere on the Internet on a photo of a billboard
