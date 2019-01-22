Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C397FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86C218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="HkYybDJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAVJbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:31:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34818 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfAVJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:31:51 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so18758782edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=87TipmxmLFoyLhevJWO3h2Re5TNBq6ylv92ZG6fH3Ys=;
        b=HkYybDJNf47fatjDiC/+43MAu0N8naRHzzlrooj6JtB5ObBnAgSVOqlLr21Cyj6ygM
         PfsOpOVWKm8prclWJT12dhOC4m5rNa/x49iKPQMLbkXe+JFZVau2as0hfSB5Hwy+UcxK
         4ch8qeXhFebwOjtT9jI9ogYpT0JLqiJdlTzeV1534k4MICj/ZorXJqjak/9oUzqtunOs
         ha0Gdb2SEvOoojwdxS/5myXIxYRCD7TIcLScch+1RALcj4P5q2F05ZovWM82o3hBXomO
         diixt3Zy8bGiNyy4r6QYnc10L0QZ7XfKFn8AXyyK3TMOn9luq/bXqwfVeJPoTp88X+Pn
         xobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=87TipmxmLFoyLhevJWO3h2Re5TNBq6ylv92ZG6fH3Ys=;
        b=od8EvFW9xV7AtGEeCxsGUu5pUq9QOUdYjWJGUlWaOzpDwyvwPqE1BTlW12TSPTRZVv
         bMGNWVNHFSoxUerBw9IjZb068QyA9AwfmkK56QMzs8QyQlenhBcNvh+J8rQWkkTXIVJ8
         N009wzl/ueo2NXKKYpDf8bvR+LqdaR/n/FYbbNL20IJQLsVhMne0/r6SvgYCD71jCTDW
         aDrFhhu5TJmepIsxyVZa5k6ity8KBiVfi4JIKqWkm9j+zDpMfgXxmEr8BVZvnQrb6cgy
         8JpFW8QKkzkyk/jgRKqgzWjg2PakLz9Hfqq3lDQBSkUo8btZ7Q7Y5vnXoftrLNbAMpry
         cytA==
X-Gm-Message-State: AJcUukcT0meseMbv180C1Tw/0fxUSpO/vMhIPD4wW7CtjEuaFM5CPCXT
        Fqrau3nTGOoCQYhtAp15YklSlQ==
X-Google-Smtp-Source: ALg8bN6JMys2HgyZSg33YEIEzCvMODFWCDV77UWB+ZexYY1R/46N4CgE89On4dKnZtB0CGQZD6ty3w==
X-Received: by 2002:a50:a246:: with SMTP id 64mr30515705edl.43.1548149508688;
        Tue, 22 Jan 2019 01:31:48 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id v20-v6sm5180207ejr.46.2019.01.22.01.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 01:31:48 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:31:47 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
Message-ID: <20190122093146.kmckcgdbvo2e7v3c@brauner.io>
References: <20190121143951.68956db3@canb.auug.org.au>
 <CAK8P3a0Yth+f8AANE6g8c_zE0Zt1CvCdzMDFK=pr8eNqmrBV0Q@mail.gmail.com>
 <20190121191306.ifga5aw5atu2vvb7@brauner.io>
 <CAK8P3a2CkXJ=giXQgxEcQAeH1Wt8jKc_P+YTOLJpUPVKYU8m9g@mail.gmail.com>
 <20190121202328.rgrv54lybilsvitu@brauner.io>
 <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io>
 <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:26:56AM +0100, Arnd Bergmann wrote:
> On Mon, Jan 21, 2019 at 11:48 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Mon, Jan 21, 2019 at 03:44:17PM -0700, Jens Axboe wrote:
> > > On 1/21/19 1:23 PM, Christian Brauner wrote:
> > > > On Mon, Jan 21, 2019 at 09:15:27PM +0100, Arnd Bergmann wrote:
> > > >> On Mon, Jan 21, 2019 at 8:13 PM Christian Brauner <christian@brauner.io> wrote:
> > > >>> On Mon, Jan 21, 2019 at 06:16:22PM +0100, Arnd Bergmann wrote:
> > > >>>> On Mon, Jan 21, 2019 at 4:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >>>
> > > >>> I plan on sending the pidfd branch with the new pidfd_send_signal()
> > > >>> syscall for the 5.1 window. Should we somehow coordinate so that our
> > > >>> branches don't conflict? Any suggestions?
> > > >>
> > > >> A conflict can't be avoided, but if you pick system call number 427
> > > >> for pidfd_send_signal, and Jens picks numbers 424 through 426 for
> > > >
> > > > That sounds good to me. Since it's only one syscall for the pidfd branch
> > > > is there anything that speaks against me using 424? Given that the other
> > > > patchset has 4 new syscalls. :)
> > > > Jens, any objections?
> > >
> > > I'm fine with either one, I'll have to renumber in any case. But it's 3
> > > new syscalls (424, 425, 426), not 4.
> > >
> > > Arnd, what's the best way to make this switch now, in my tree? Would be
> >
> > Yeah, I'd like to know that as well.
> >
> > > great if I didn't have to change it again once I make the change.
> 
> I'd suggest that you each just take the numbers we talked about and
> add them in your respective git trees, at the end of the current tables.

Great! Will do that today before Stephen does a new merge for -next.

> 
> Stephen and Linus can then do a trivial add/add merge between the
> three trees that does not involve changing any of the lines besides
> keeping them in the right order. The result should then be
> 
> == arch/x86/entry/syscalls/syscall_32.tbl
> 422    i386    futex_time64        sys_futex            __ia32_sys_futex
> 423    i386    sched_rr_get_interval_time64
> sys_sched_rr_get_interval    __ia32_sys_sched_rr_get_interval
> 424    i386    pidfd_send_signal     sys_pidfd_send_signal
> __ia32_sys_pidfd_send_signal
> 425    i386    io_uring_setup          sys_io_uring_setup
> __ia32_compat_sys_io_uring_setup
> 426    i386    io_uring_enter          sys_io_uring_enter
>  __ia32_sys_io_uring_enter
> 427    i386    io_uring_register       sys_io_uring_register
> __ia32_sys_io_uring_register
> 
> == arch/x86/entry/syscalls/syscall_64.tbl
> ...
> 334    common  rseq                    __x64_sys_rseq
> # don't use numbers 387 through 423, add new calls after the last
> # 'common' entry
> 424    common    pidfd_send_signal      __x64_sys_pidfd_send_signal
> 425    common    io_uring_setup           __x64_sys_io_uring_setup
> 426    common    io_uring_enter           __x64_sys_io_uring_enter
> 427    common    io_uring_register        __x64_sys_io_uring_register
> #
> # x32-specific system call numbers start at 512 to avoid cache impact
> # for native 64-bit operation. The __x32_compat_sys stubs are created
> # on-the-fly for compat_sys_*() compatibility system calls if X86_X32
> # is defined.
> #
> 512     x32     rt_sigaction            __x32_compat_sys_rt_sigaction
> ...
> 
> My hope is that in the future, any new system call will get added to
> all 16 syscall.tbl files at once, but let's maybe not do this for 5.1
> yet, since that only causes more conflicts. I can simply follow up
> with a patch to add pidfd_send_signal and io_uring_* everywhere
> during the merge window.

Sounds good to me.

Thanks Arnd!
Christian
