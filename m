Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52031C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F9E20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbeGKQMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:12:44 -0400
Received: from foss.arm.com ([217.140.101.70]:39476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732433AbeGKQMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:12:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185557A9;
        Wed, 11 Jul 2018 09:07:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DF2B3F5B1;
        Wed, 11 Jul 2018 09:07:41 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:07:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        "Yandong.Zhao" <yandong77520@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        zhaoyd@thundersoft.com, zhaoxb@thundersoft.com,
        fanlc0801@thundersoft.com
Subject: Re: [PATCH] arm64: neon: Fix function may_use_simd() return error
 status
Message-ID: <20180711160738.okzpxenezq52etol@lakrids.cambridge.arm.com>
References: <1531271399-1768-1-git-send-email-yandong77520@gmail.com>
 <CAKv+Gu-PLsWZLPM-OfXHLGKs7PojRB4jFsyp+X_5OW6ryi7gRQ@mail.gmail.com>
 <20180711154758.4k2phfrzl2r5m34o@lakrids.cambridge.arm.com>
 <20180711160315.GD18477@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711160315.GD18477@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:03:15PM +0100, Will Deacon wrote:
> On Wed, Jul 11, 2018 at 04:47:58PM +0100, Mark Rutland wrote:
> > On Wed, Jul 11, 2018 at 09:20:03AM +0200, Ard Biesheuvel wrote:
> > > On 11 July 2018 at 03:09, Yandong.Zhao <yandong77520@gmail.com> wrote:
> > > > diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
> > > > index fa8b3fe..784a8c2 100644
> > > > --- a/arch/arm64/include/asm/simd.h
> > > > +++ b/arch/arm64/include/asm/simd.h
> > > > @@ -29,7 +29,8 @@
> > > >  static __must_check inline bool may_use_simd(void)
> > > >  {
> > > >         /*
> > > > -        * The raw_cpu_read() is racy if called with preemption enabled.
> > > > +        * The this_cpu_read() is racy if called with preemption enabled,
> > > > +        * since the task may subsequently migrate to another CPU.
> > > >          * This is not a bug: kernel_neon_busy is only set when
> > > >          * preemption is disabled, so we cannot migrate to another CPU
> > > >          * while it is set, nor can we migrate to a CPU where it is set.
> > 
> > It would be nice if we could clarify the "is racy" part here.
> > 
> > How about:
> > 
> > 	/*
> > 	 * kernel_neon_busy is only set while preemption is disabled,
> > 	 * and is clear whenever preemption is enabled. Since
> > 	 * this_cpu_read() is atomic w.r.t. preemption, kernel_neon_busy
> > 	 * cannot change under our feet -- if it's set we cannot be
> > 	 * migrated, and if it's clear we cannot be migrated to a CPU
> > 	 * where it is set.
> > 	 */
> > 
> > With that:
> > 
> > Reviewed-by: Mark Rutland <mark.rutland@arm..com>
> 
> Thanks. Applied with the updated comment and your tag..

Cheer!

Mar.
