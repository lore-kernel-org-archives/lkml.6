Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90A6222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404744AbfBOWxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404684AbfBOWxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6F3AC073D6F;
        Fri, 15 Feb 2019 22:53:33 +0000 (UTC)
Received: from localhost (ovpn-117-203.ams2.redhat.com [10.36.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A77560C69;
        Fri, 15 Feb 2019 22:53:33 +0000 (UTC)
Date:   Fri, 15 Feb 2019 22:53:32 +0000
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, Wouter Verhelst <w@uter.be>,
        nbd@other.debian.org
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190215225332.GA4922@redhat.com>
References: <20190215191953.GB17897@amd>
 <20190215224126.GX12500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215224126.GX12500@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 15 Feb 2019 22:53:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:41:26PM +0000, Richard W.M. Jones wrote:
> On Fri, Feb 15, 2019 at 08:19:54PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > I watched fosdem talk about
> > nbdkit... https://www.youtube.com/watch?v=9E5A608xJG0 . Nice. But word
> > of warning: I'm not sure using it read-write on localhost is safe.
> > 
> > In particular, user application could create a lot of dirty data
> > quickly. If there's not enough memory for nbdkit (or nbd-client or
> > nbd-server), you might get a deadlock.
> 
> Thanks for the kind words about the talk.  I've added Wouter Verhelst
> & the NBD mailing list to CC.  Although I did the talk because the
> subject is interesting, how I actually use nbdkit / NBD is to talk to
> qemu and that's where I have most experience and where we (Red Hat)
> use it in production systems.
> 
> However in January I spent a lot of time exercising the NBD loop-mount
> + nbdkit case using fio in order to find contention / bottlenecks in
> our use of threads and locks.  I didn't notice any particular problems
> then, but it's possible my testing wasn't thorough enough.  Or that
> fio only creates small numbers of dirty pages (because of locality in
> its access patterns I guess?)
> 
> When you say it's not safe, what could happen?  What would we observe
> if it was going wrong?

Reading more carefully I see you said we'd observe a deadlock.  I
didn't see that, but again my testing of this wouldn't have been very
thorough.  When I have some time I'll try creating / spooling huge
files into an NBD loop mount to see if I can cause a deadlock.

Thanks, Rich.

> > Also note that nbd.txt in Documentation/blockdev/ points to
> > sourceforge; it should probably point to
> > https://github.com/NetworkBlockDevice/nbd ?
> 
> Wouter should be able to say what the correct link should be.
> 
> Rich.
> 
> -- 
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> libguestfs lets you edit virtual machines.  Supports shell scripting,
> bindings from many languages.  http://libguestfs.org

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
