Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF26C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFAD20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z/eIjTPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFAD20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeKKA7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbeKKA7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:59:01 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02FCE20684;
        Sat, 10 Nov 2018 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541862821;
        bh=81qEAnYxUYmY4xkweT2ZaldeaIIY/0vm89kY3Iz6ryc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z/eIjTPVo2Cfh0n4Bq1gMlYAf08kN9p8Qvp9h4lU1yFFV5qPWQHRSoT7SkC3W8GNj
         bdnQGB1VQA9NaZUAOxrfq5m8S17dR3caKTBVUeqE8SZVScjcPgXTkeUOrASJGECBee
         GJVJsvnY1XoG3DbWYfW6CugNrYknUsdhPjPjJeYE=
Date:   Sun, 11 Nov 2018 00:13:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-Id: <20181111001336.a08bcc27faf69cbcaec9b597@kernel.org>
In-Reply-To: <979DB163-EFBD-41BB-8481-155AAF526E72@amacapital.net>
References: <cover.1541711457.git.jpoimboe@redhat.com>
        <20181109072811.GB86700@gmail.com>
        <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
        <20181109152139.zig45f6gp24btfbc@treble>
        <20181109164137.5cngbfrkm4ihj4ra@treble>
        <20181109134241.5f4ce3be@gandalf.local.home>
        <979DB163-EFBD-41BB-8481-155AAF526E72@amacapital.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 11:05:51 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> 
> 
> > On Nov 9, 2018, at 10:42 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > On Fri, 9 Nov 2018 10:41:37 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> >>> On Fri, Nov 09, 2018 at 09:21:39AM -0600, Josh Poimboeuf wrote:
> >>>> On Fri, Nov 09, 2018 at 07:16:17AM -0800, Andy Lutomirski wrote:  
> >>>>> On Thu, Nov 8, 2018 at 11:28 PM Ingo Molnar <mingo@kernel.org> wrote:  
> >>>>> 
> >>>>> 
> >>>>> All other usecases are bonus, but it would certainly be interesting to
> >>>>> investigate the impact of using these APIs for tracing: that too is a
> >>>>> feature enabled everywhere but utilized only by a small fraction of Linux
> >>>>> users - so literally every single cycle or instruction saved or hot-path
> >>>>> shortened is a major win.  
> >>>> 
> >>>> For tracing, we'd want static_call_set_to_nop() or something like that, right?  
> >>> 
> >>> Are we talking about tracepoints?  Or ftrace?  
> >> 
> >> Since ftrace changes calls to nops, and vice versa, I assume you meant
> >> ftrace.  I don't think ftrace is a good candidate for this, as it's
> >> inherently more flexible than this API would reasonably allow.
> >> 
> > 
> > Not sure what Andy was talking about, but I'm currently implementing
> > tracepoints to use this, as tracepoints use indirect calls, and are a
> > prime candidate for static calls, as I showed in my original RFC of
> > this feature.
> > 
> > 
> 
> Indeed.
> 
> Although I had assumed that tracepoints already had appropriate jump label magic.

As far as I know, the jump label magic is for reducing the overhead when the 
tracepoint is OFF (because it can skip function parameter preparation), and this
static call will be good when the tracepoint is ON (enabled) because of this can
avoid retpoline performance degradation.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
