Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E5EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD6320894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDn0kxVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD6320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeGaAiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeGaAiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:38:17 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0AB20857;
        Mon, 30 Jul 2018 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532991662;
        bh=tiwP4lReZ8TSnrX668rpTS713acX/8BuOKAyEXyHJ5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uDn0kxVSDHv3qebQ6GLCnfQKVBBorfhPSTWOLJeDgG4TbVkggSsKAsuUq0JZsyQdx
         vIwAyfKeIAbzIlPPqfcAaiEnjIhE7YB1tCA6QNrgHx4WkLQfBcO0RJ7Vplk7MB1qX7
         lVhvO0udK74Q5rPV0CaBBYJAh88+iKjRRYJMaz3Q=
Date:   Tue, 31 Jul 2018 08:00:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Francis Deslauriers <francis.deslauriers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, shuah@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/3] tracing: kprobes: Prohibit probing on notrace
 functions
Message-Id: <20180731080059.be34e021d6758925c70dbc6b@kernel.org>
In-Reply-To: <CADcCL0hWtn=r-AjpKgB_JKeL1aTbeZPpoKeVXH8Z_FnJYyaTbA@mail.gmail.com>
References: <153294598465.32740.17737878083872427008.stgit@devbox>
        <CADcCL0hWtn=r-AjpKgB_JKeL1aTbeZPpoKeVXH8Z_FnJYyaTbA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 12:06:17 -0400
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> Hi Masami,
> I just tested the patch-set and it still prevents the crash I was witnessing.
> You can add my tested-by.
> Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>

Thanks Francis!


> 
> Thank you for pushing this forward!
> Francis
> Le lun. 30 juill. 2018, à 06 h 20, Masami Hiramatsu
> <mhiramat@kernel.org> a écrit :
> >
> > Hi,
> >
> > This is the 5th version of the series to prohibit kprobe
> > on notrace functions.
> >
> > This fixes a build error when CONFIG_FUNCTION_TRACER=y but
> > DYNAMIC_FTRACE=n. Finally I decided to recover the approach
> > in the 1st version, made it depends on CONFIG_KPROBES_ON_FTRACE=y.
> > It is the simplest and enough to prohibiting kernel crash.
> >
> > So, in summary, if CONFIG_KPROBES_ON_FTRACE=y (which depends
> > on CONFIG_DYNAMIC_FTRACE=y, so ftrace_location_range must be
> > there) && CONFIG_KPROBE_EVENTS_ON_NOTRACE=n (default),
> > kprobe events can not be defined on notrace function.
> > Otherwides (means CONFIG_KPROBES_ON_FTRACE=n or
> > CONFIG_KPROBE_EVENTS_ON_NOTRACE=y), we can put kprobe events
> > on notrace functions.
> >
> > Francis, I dropped your tested-by because I got many kbuild
> > errors and fixed it. If you can, could you test it again?
> >
> > Thank you,
> >
> > ---
> >
> > Francis Deslauriers (1):
> >       selftest/ftrace: Move kprobe selftest function to separate compile unit
> >
> > Masami Hiramatsu (2):
> >       tracing: kprobes: Prohibit probing on notrace function
> >       selftests/ftrace: Fix kprobe string testcase to not probe notrace function
> >
> >
> >  kernel/trace/Kconfig                               |   20 +++++++
> >  kernel/trace/Makefile                              |    5 ++
> >  kernel/trace/trace_kprobe.c                        |   59 +++++++++++++-------
> >  kernel/trace/trace_kprobe_selftest.c               |   10 +++
> >  kernel/trace/trace_kprobe_selftest.h               |    7 ++
> >  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++------
> >  .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 -
> >  7 files changed, 94 insertions(+), 39 deletions(-)
> >  create mode 100644 kernel/trace/trace_kprobe_selftest.c
> >  create mode 100644 kernel/trace/trace_kprobe_selftest.h
> >
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> 
> 
> --
> Francis Deslauriers
> Software developer
> EfficiOS inc.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
