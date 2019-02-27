Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457820863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fqFsLpMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfB0VeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:34:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43407 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0VeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:34:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so21068095qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UP64yaeA8gJTRJSchFp7dwB/Ki09TszpubmwezuuqWk=;
        b=fqFsLpMlW/CPI8o7HQlvo4E0Eh/rFu2g7VeuNHn6TXm9zEuG9tGtw1iP/wGpd4umVQ
         lGRdwdxlI9NwYnM3/zHo2IciVWjg/psGAmxcwDh+JXCRg9tS+L80J4+l6Q3FdkPD4W4k
         Nirno6+IUnAgxs6dfd1SvhGmz5fuPLpTBW4uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UP64yaeA8gJTRJSchFp7dwB/Ki09TszpubmwezuuqWk=;
        b=cAw7aUSStth4rzZi51cszZb+VT0/LhivHZ6PZPkrS5pDw9hFP8A0RNVsfiwBwqhNqj
         8wcgqgqkCaBzAw/oReMOZLOQt3M94mi5HisFqJPkkiFtkK1fGqh+Lz2VlvPFNrTkcY4A
         dw4obhefzWmwI+sKaEyDS5An7YJYAaBD18ZtygA6Q+4Cg/dszQRy2pB9Qa6PgoBeQdFR
         Kow6ZmAm5vqBgZTCiQiPf5prD7lYBxaPhvxjJuqrFPnylUG/wnA6sy6tjP8VGiJOeIbw
         tFqcHDOuFwZJmVeI/nsrzpAVupcptfn6rpqbtgfLhZoRjz7bSWRLajDyElR+9qIclWBU
         FXhg==
X-Gm-Message-State: AHQUAuZXAOHVDsCxTnzXXHTQsjJCuW0/GMTMgCxboS9qcjEdFbDyCr9m
        kinpVPp5l7+R+KMDX9r1PTqEew==
X-Google-Smtp-Source: APXvYqyWKlnDV6bDFZejBFCDz8xfWYVrRCWwVswoj1gRRDH3G3rNV/b4nUxOsCc4C0TX2Ns3aWrRMQ==
X-Received: by 2002:aed:3b92:: with SMTP id r18mr3481607qte.7.1551303241436;
        Wed, 27 Feb 2019 13:34:01 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id f7sm5361376qtb.35.2019.02.27.13.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 13:34:00 -0800 (PST)
Date:   Wed, 27 Feb 2019 16:33:59 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/4] tracing/probes: uaccess: Add support user-space
 access
Message-ID: <20190227213359.GA152884@google.com>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
 <20190226213850.GA219025@google.com>
 <20190227164104.5f53f029a7fec898204e9b67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227164104.5f53f029a7fec898204e9b67@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 04:41:04PM +0900, Masami Hiramatsu wrote:
> On Tue, 26 Feb 2019 16:38:50 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Mon, Feb 25, 2019 at 11:04:42PM +0900, Masami Hiramatsu wrote:
> 
> > > Note that kprobe event provides these methods, but it doesn't
> > > change it from kernel to user automatically because we do not
> > > know whether the given address is in userspace or kernel on
> > > some arch.
> > > Moreover, from perf-probe, at this moment it is not able to
> > > switch. Since __user is not for compiler but checker, we have
> > > no clue which data structure is in user-space, in debuginfo.
> > > 
> > > BTW, according to Linus's comment, I implemented probe_user_read()
> > > and strncpy_from_unsafe_user() APIs. And since those use
> > > "access_ok()" inside it, if CONFIG_DEBUG_ATOMIC_SLEEP=y on x86,
> > > it will get a warn message at once. It should be solved before
> > > merging this series.
> > 
> > I was wondering why access_ok() can sleep. In the arm64 and x86
> > implementation, I don't see access_ok() itself causing a user pointer
> > dereference access that can cause a page fault. It seems to just be checking
> > the validity of the ranges.
> > 
> > Any idea why the access_ok() code has these comments?
> > "Context: User context only. This function may sleep if pagefaults are
> > enabled."
> 
> Because access_ok() is used only for preparing accessing user-space,
> and the user-space access may cause page-fault and sleep.

Pedantically speaking, the access_ok() function itself in x86 implementation
does not sleep so the comment on the function saying "This function may
sleep" is odd to the code reader (and it confused someone else too so I'm not
the only one :)), but it could be that for some architectures it does sleep...

> IMHO, checking in access_ok() inside it is reasonable, but as it
> commented, it is for "if pagefaults are enabled.". What we need another 
> access_ok() for the case when pagefaults are disabled, that is what PeterZ
> suggested in below mail.
> 
> https://lore.kernel.org/lkml/20190225150603.GE32494@hirez.programming.kicks-ass.net/T/#u

Makes sense, thanks.

- Joel


> 
> 
> Thank you,
> 
> > 
> > My _guess_ is this is because whatever calls access_ok() may also call
> > something else that *does* fault next, if that's the case then that
> > WARN_ON_IN_IRQ() in access_ok() is fine, but at least I guess the comments
> > should be more clear that it is not access_ok() itself that sleeps.
> > 
> > thanks for any help on understanding this,
> > 
> >  - Joel
> > 
> > 
> > > 
> > > Thank you,
> > > 
> > > ---
> > > 
> > > Masami Hiramatsu (4):
> > >       uaccess: Make sure kernel_uaccess_faults_ok is updated before pagefault
> > >       uaccess: Add non-pagefault user-space read functions
> > >       tracing/probe: Add ustring type for user-space string
> > >       tracing/probe: Support user-space dereference
> > > 
> > > 
> > >  Documentation/trace/kprobetrace.rst  |   13 ++-
> > >  Documentation/trace/uprobetracer.rst |    9 +-
> > >  fs/namespace.c                       |    2 
> > >  include/linux/uaccess.h              |   13 +++
> > >  kernel/trace/trace.c                 |    7 +-
> > >  kernel/trace/trace_kprobe.c          |   65 ++++++++++++++++
> > >  kernel/trace/trace_probe.c           |   39 ++++++++--
> > >  kernel/trace/trace_probe.h           |    3 +
> > >  kernel/trace/trace_probe_tmpl.h      |   36 +++++++--
> > >  kernel/trace/trace_uprobe.c          |   19 +++++
> > >  mm/maccess.c                         |  138 ++++++++++++++++++++++++++++++----
> > >  11 files changed, 302 insertions(+), 42 deletions(-)
> > > 
> > > --
> > > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
