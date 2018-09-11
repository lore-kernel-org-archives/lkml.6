Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DC8C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AD020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AD020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeIKULH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:11:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbeIKULH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:11:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E18E18A;
        Tue, 11 Sep 2018 08:11:23 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2F1A13F614;
        Tue, 11 Sep 2018 08:11:23 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B891E1AE3231; Tue, 11 Sep 2018 16:11:39 +0100 (BST)
Date:   Tue, 11 Sep 2018 16:11:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Zhizhou Zhang <zhizhou.zh@gmail.com>
Cc:     Zhizhou Zhang <zhizhouzhang@asrmicro.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        julien.thierry@arm.com, dave.martin@arm.com,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: don't account for cpu offline time with irqsoff
 tracer
Message-ID: <20180911151139.GG2651@arm.com>
References: <1536135583-6607-1-git-send-email-zhizhouzhang@asrmicro.com>
 <20180905122905.GI20186@arm.com>
 <CAN1e=SF8ij0080wd55_v1Eu+Qo+2iGpWgWf4ELnTZa+zUBhjkw@mail.gmail.com>
 <20180906100510.GC3592@arm.com>
 <CAN1e=SFPEbkawnamDObNZjXb3z-7d2Fk+g91buSAFgNoYq7R3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN1e=SFPEbkawnamDObNZjXb3z-7d2Fk+g91buSAFgNoYq7R3Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:09:23PM +0800, Zhizhou Zhang wrote:
> 
> On Thu, Sep 6, 2018 at 6:04 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Wed, Sep 05, 2018 at 09:14:17PM +0800, Zhizhou Zhang wrote:
> > >
> > >
> > > On Wed, Sep 5, 2018 at 8:29 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > >     On Wed, Sep 05, 2018 at 04:19:43PM +0800, Zhizhou Zhang wrote:
> > >     > This is no need to account for cpu offline time with irqsoff tracer.
> > >     > We can trigger a large irqsoff latency with below commands:
> > >     >
> > >     > $ echo irqsoff > /sys/kernel/debug/tracing/current_tracer
> > >     > $ echo 0 > /sys/kernel/debug/tracing/options/function-trace
> > >     > $ echo 1 > /sys/kernel/debug/tracing/tracing_on
> > >     > $ echo 0 > /sys/devices/system/cpu/cpu1/online
> > >     > $ # wait a while ...
> > >     > $ echo 1 > /sys/devices/system/cpu/cpu1/online
> > >     > $ cat /sys/kernel/debug/tracing/trace
> > >     >
> > >     > Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> > >     > ---
> > >     >  arch/arm64/kernel/smp.c | 1 +
> > >     >  1 file changed, 1 insertion(+)
> > >     >
> > >     > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > >     > index 25fcd22..faed8f6 100644
> > >     > --- a/arch/arm64/kernel/smp.c
> > >     > +++ b/arch/arm64/kernel/smp.c
> > >     > @@ -346,6 +346,7 @@ void cpu_die(void)
> > >     >       idle_task_exit();
> > >     >
> > >     >       local_daif_mask();
> > >     > +     stop_critical_timings();
> > >     >
> > >     >       /* Tell __cpu_die() that this CPU is now safe to dispose of */
> > >     >       (void)cpu_report_death();
> > >     > --
> > >     > 1.9.1
> > >
> > >     Hmm, so there are only a handful of other callers of
> stop_critical_timings
> > >     ()
> > >     which suggests that we probably shouldn't be calling this from deep in
> the
> > >     arch code. Do other architectures have the same problem? If not, how do
> > >     they
> > >     avoid it?
> > >
> > >
> > > I read mips just now, it use raw irq turn-off primitive without calling
> > > trace_hardirqs_off().
> > > So mips can get rid of this problem. Maybe same other architectures have
> the
> > > same
> > > problem. As I can see, X86 may also be influenced, but I didn't test that.
> For
> > > this patch, the reason
> > > I put this in architecture specific folder is irq turn-off code is placed
> here.
> > > I think stop_critical_timings()
> > > should be placed nearby local_daif_mask().
> >
> > I'm not so sure. local_daif_mask() just toggles a bit in a register, whereas
> > stop_critical_timings() does a lot more, including locking. Calling this
> > from a CPU which is no longer online feels fragile to me.
> >
> That's reasonable. So I think we can mask daif without calling
> trace_hardirqs_off() which started this tracer.
> 
> > Anyway, my strong preference here is that either we address this in the
> > core code, or we follow the example of other architectures.
> >
> I made a V2 patch as below, please kindly review and comment. Thanks!
> 
> From 0367a9a2d6eeda65257879cb29551673f9c61bd9 Mon Sep 17 00:00:00 2001
> From: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> Date: Wed, 5 Sep 2018 15:57:17 +0800
> Subject: [PATCH] arm64: don't account for cpu offline time with irqsoff tracer
> 
> This is no need to account for cpu offline time with irqsoff tracer.
> We can trigger a large irqsoff latency with below commands:
> 
> $ echo irqsoff > /sys/kernel/debug/tracing/current_tracer
> $ echo 0 > /sys/kernel/debug/tracing/options/function-trace
> $ echo 1 > /sys/kernel/debug/tracing/tracing_on
> $ echo 0 > /sys/devices/system/cpu/cpu1/online
> $ # wait a while ...
> $ echo 1 > /sys/devices/system/cpu/cpu1/online
> $ cat /sys/kernel/debug/tracing/trace
> 
> This patch introduced raw_local_daif_mask()/raw_local_daif_unmask().
> We can use raw_local_daif_mask() if we don't want to trace hardirqs on/off.
> 
> Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> ---
>  arch/arm64/include/asm/daifflags.h | 24 +++++++++++++++++-------
>  arch/arm64/kernel/smp.c            |  2 +-
>  2 files changed, 18 insertions(+), 8 deletions(-)

I still think this is the wrong place to fix this. My x86 laptop appears to
exhibit the same behaviour, so this should be addressed in the core hotplug
code rather than individually in each architecture.

Will
