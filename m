Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16087C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C816820C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C816820C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbeGKPxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:53:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39118 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732935AbeGKPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:52:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0695B7A9;
        Wed, 11 Jul 2018 08:48:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD5D3F5B1;
        Wed, 11 Jul 2018 08:48:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:47:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     "Yandong.Zhao" <yandong77520@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        zhaoyd@thundersoft.com, zhaoxb@thundersoft.com,
        fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180711154758.4k2phfrzl2r5m34o@lakrids.cambridge.arm.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
 <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:20:03AM +0200, Ard Biesheuvel wrote:
> On 11 July 2018 at 03:09, Yandong.Zhao <yandong77520@gmail.com> wrote:
> > From: Yandong Zhao <yandong77520@gmail.com>
> >
> > It does not matter if the caller of may_use_simd() migrates to
> > another cpu after the call, but it is still important that the
> > kernel_neon_busy percpu instance that is read matches the cpu the
> > task is running on at the time of the read.
> >
> > This means that raw_cpu_read() is not sufficient.  kernel_neon_busy
> > may appear true if the caller migrates during the execution of
> > raw_cpu_read() and the next task to be scheduled in on the initial
> > cpu calls kernel_neon_begin().
> >
> > This patch replaces raw_cpu_read() with this_cpu_read() to protect
> > against this race.
> >
> > Signed-off-by: Yandong Zhao <yandong77520@gmail.com>
> 
> I had a bit of trouble disentangling the per-cpu spaghetti to decide
> whether this may trigger warnings when CONFIG_DEBUG_PREEMPT=y, but I
> don't think so. So assuming this is *not* the case:

It shouldn't, since:

* this_cpu_*() are prempt-safe

* __this_cpu_*() are not preempt-safe (and warn when preemptible)

* raw_cpu_*() are not preempt safe (but don't warn when preemptible)

> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> 
> > ---
> >  arch/arm64/include/asm/simd.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> > index fa8b3fe..784a8c2 100644
> > --- a/arch/arm64/include/asm/simd.h
> > +++ b/arch/arm64/include/asm/simd.h
> > @@ -29,7 +29,8 @@
> >  static __must_check inline bool may_use_simd(void)
> >  {
> >         /*
> > -        * The raw_cpu_read() is racy if called with preemption enabled.
> > +        * The this_cpu_read() is racy if called with preemption enabled,
> > +        * since the task may subsequently migrate to another CPU.
> >          * This is not a bug: kernel_neon_busy is only set when
> >          * preemption is disabled, so we cannot migrate to another CPU
> >          * while it is set, nor can we migrate to a CPU where it is set.

It would be nice if we could clarify the "is racy" part here.

How about:

	/*
	 * kernel_neon_busy is only set while preemption is disabled,
	 * and is clear whenever preemption is enabled. Since
	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
	 * cannot change under our feet -- if it's set we cannot be
	 * migrated, and if it's clear we cannot be migrated to a CPU
	 * where it is set.
	 */

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm..com>

Thanks,
Mark.

> > @@ -42,7 +43,7 @@ static __must_check inline bool may_use_simd(void)
> >          * false.
> >          */
> >         return !in_irq() && !irqs_disabled() && !in_nmi() &&
> > -               !raw_cpu_read(kernel_neon_busy);
> > +               !this_cpu_read(kernel_neon_busy);
> >  }
> >
> >  #else /* ! CONFIG_KERNEL_MODE_NEON */
> > --
> > 1.9.1
> >
