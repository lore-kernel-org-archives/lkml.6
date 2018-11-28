Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A03F208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A03F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeK1XGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:06:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37218 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeK1XGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:06:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1003137D0;
        Wed, 28 Nov 2018 04:04:45 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D46623F59C;
        Wed, 28 Nov 2018 04:04:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0133E1AE0808; Wed, 28 Nov 2018 12:05:02 +0000 (GMT)
Date:   Wed, 28 Nov 2018 12:05:02 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] arm64: ftrace: Fix to enable syscall events on arm64
Message-ID: <20181128120502.GC24868@arm.com>
References: <CAA93ih1-xpm1P0suT6SNCc_ARvAfyBEwb0-uKFikM5k4CvG8jg@mail.gmail.com>
 <154333618522.27355.8094935453351562295.stgit@devbox>
 <20181127165848.GA19569@arm.com>
 <20181127131859.79ce7da9@gandalf.local.home>
 <20181128085555.a8987cbe18aa6d1d1f0a827e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128085555.a8987cbe18aa6d1d1f0a827e@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, Nov 28, 2018 at 08:55:55AM +0900, Masami Hiramatsu wrote:
> On Tue, 27 Nov 2018 13:18:59 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 27 Nov 2018 16:58:49 +0000
> > Will Deacon <will.deacon@arm.com> wrote:
> > 
> > > This looks fine to me, but I'm curious about whether this is supposed to
> > > work with compat syscalls as well, where the prefix is "__arm64_compat_".
> > > 
> > > If we broadly follow the x86 lead, we'd have:
> > > 
> > > 	return (!strncmp(sym, "__arm64_", 8) && !strcmp(sym + 8, name)) ||
> > > 		(!strncmp(sym, "__arm64_compat_", 15) && !strcmp(sym + 15, name));
> > > 
> > > Do we need to handle compat (i.e. 32-bit) tasks here?
> > 
> > Only if you want to trace compat syscalls as well ;-)
> 
> Actually I thought about that, but I found below comment in
> arch/arm64/include/asm/ftrace.h
> 
>  * Because AArch32 mode does not share the same syscall table with AArch64,
>  * tracing compat syscalls may result in reporting bogus syscalls or even
>  * hang-up, so just do not trace them.
> 
> That's why I dropped compat syscall support.

Ok! Then please add a comment to arch_syscall_match_sym_name() along those
lines, and you can add my ack:

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
