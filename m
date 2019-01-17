Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD55720873
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547767863;
	bh=/cDBbQJIcATuNqWBWi51mumUxjnVIMfVgNh+4Ybt8II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mIegG55tdlsHybzlVRnND2i4KpCMKcS23+WdTuZb10Lh31RqPKLxzS7qMOgausLT6
	 UaW0b/zmg1jLEd4YW4nlNBETYELT9qdCYfl8NuIwJPnihM5rPJe7NOIO97IczLNZa1
	 xTi4LxByQGU0yrTn6lBU+fnawZvX8cHMlear/seM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfAQXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfAQXbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:31:02 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F15D2086D;
        Thu, 17 Jan 2019 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547767861;
        bh=/cDBbQJIcATuNqWBWi51mumUxjnVIMfVgNh+4Ybt8II=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LGzoWrOJASC2/E8kxidhYh8GcO2F273wF+zSub07D6Zjgn7wih9ElM+DoJFM+ippg
         RaHKEVwMJ3gPcarD1/W5TF1ysB19qtqH0OCVDPhj79xzqTQj2ULVOW+jc1Za6I9gEX
         uT/kEpeRnjO/gSRk6uCrHewBM60gs0boJdTltAqg=
Date:   Fri, 18 Jan 2019 08:30:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing: probeevent: Fix probe argument parser and
 handler
Message-Id: <20190118083058.941d5f889c7d0ce7b20a510c@kernel.org>
In-Reply-To: <20190117092302.596b4538@vmware.local.home>
References: <154773287750.2285.5509629487576876823.stgit@devbox>
        <20190117092302.596b4538@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 09:23:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 17 Jan 2019 22:47:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > This series fixes several bugs in probe event argument parser
> > and handler routines.
> 
> Hi Masami,
> 
> Can you resend with a "Fixes:" tag to each of the patches, so that it
> is easy to see what patch needs to be backported to which stable kernel
> (or not any stable release if the patch fixes something in 5.0-rc).

OK, I'll resend it with Fixed tags!
And maybe I also need to enhance ftracetest so that it can catch 
this bug.

Thanks,

> 
> Thanks!
> 
> -- Steve
> 
> > 
> > Recently I got 2 issues reported by Andreas, see
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899098.html
> > 
> > One issue is already fixed by Andreas (Thanks!) but $comm handling
> > issue still exists on uprobe event. [1/3] fixes it.
> > And I found other issues around that, [2/3] is just a trivial cleanup,
> > [3/3] fixes $comm type issue which occurs not only uprobe events but
> > also on kprobe events. Anyway, after this series applied, $comm must
> > be "string" type and not be an array.
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (3):
> >       tracing: uprobes: Re-enable $comm support for uprobe events
> >       tracing: probeevent: Do not accumulate on ret variable
> >       tracing: probeevent: Fix to make the type of $comm string
> > 
> > 
> >  kernel/trace/trace_probe.c      |   13 +++++++------
> >  kernel/trace/trace_probe_tmpl.h |    2 +-
> >  kernel/trace/trace_uprobe.c     |   15 +++++++++++++--
> >  3 files changed, 21 insertions(+), 9 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
