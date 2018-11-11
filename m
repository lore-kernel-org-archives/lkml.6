Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77D4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EE6208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EE6208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeKKV5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:57:47 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:41874 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKKV5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:57:47 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wABC9AUU004450;
        Sun, 11 Nov 2018 13:09:10 +0100
Date:   Sun, 11 Nov 2018 13:09:10 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181111120910.GA4425@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <20181111081725.GA30248@1wt.eu>
 <3664a508-ca74-4ff0-39a6-34543194a24e@gmail.com>
 <20181111111143.GB4189@1wt.eu>
 <87zhufvntw.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhufvntw.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:46:35PM +0100, Florian Weimer wrote:
> > In practice we all know (believe?) that both statements above are
> > true but in practice 99% of the time there's a 1:1 relation between
> > these two components.
> 
> Eh.  Most Linux systems do not run glibc at all (and use cryptography
> and other tricks to prevent users from installing it).

Good point on this one. I could even have thought that most syscalls
are added with glibc in mind but your counter-example above could
remain valid.

> > What we'd really need would be to have the libc
> > interface as part of the operating system itself. I'm perfectly fine
> > with glibc providing all the "high-level" stuff like strcpy(), FILE*
> > operations etc, and all this probably is mostly system-independent.
> 
> That's a bit messy, unfortunately.
> 
> The kernel does not know about TCB layout, so a lot of low-level
> threading aspects are defined by userspace.
> 
> The kernel does not know about POSIX cancellation.  Directly calling
> system calls breaks support for that.
> 
> A lot of multi-threaded applications assume that most high-level
> functionality remains usable even after fork in a multi-threaded
> process.  (This is increasingly a problem today with all those direct
> calls to clone.)  Unfortunately, this introduces rather tricky
> low-level/high-level cross-subsystem issues, too.

But don't you think that moving a bit of this into the kernel
repository could improve the situation ? The corner cases could then
be detected when the feature is developed and be addressed either by
adapting the kernel side of the syscall or even by changing the design
before it's committed. Maybe a few extra syscalls are missing to
retrieve some critial info that would make things more reliable or
easier between userland and kernel, and that would become more obvious
with all the relevant parts at the same place ?

> > But the system interface could possibly be handled easier in the
> > system itself, which would also provide a smoother adoption of new
> > syscalls and API updates. It would also limit the hassle required to
> > provide new syscalls, as if you start to have to contribute to two
> > projects at once for a single syscall, it becomes really painful.
> 
> Sure, the duplication is unfortunate.
> 
> Several glibc contributors deeply care about standards compliance for
> header files.

For having suffered a lot from the libc-4 to libc-5 then libc-5 to glibc,
I certainly can understand their concerns about standards compliance.

> The kernel developers care not, and the result is that we
> copy definitions and declarations from the kernel header files, creating
> additional problems.

Probably that these standard compatibility issues should be addressed at
their root in the kernel header definitions in fact. Working around issues
always leads to a stall at some point, and it encourages the process not
to change.

> We also want to use old kernel headers to compile glibc and still
> implement features which are only defined by newer (upstream) kernels,
> so that leads to more duplication.

This one could possibly be got rid of. When I build glibc, I specify the
oldest supported kernel, which usually is older than or equal to the
headers used to build, but I don't expect that newer features will
magically work at all. Thus I normally build with the most recent
headers covering my needs.

Thanks,
Willy
