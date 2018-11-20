Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBFBC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7090206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7090206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeKUBWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:22:50 -0500
Received: from foss.arm.com ([217.140.101.70]:50278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeKUBWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:22:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F2FEBD;
        Tue, 20 Nov 2018 06:53:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D283F3F5A0;
        Tue, 20 Nov 2018 06:53:17 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:53:16 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] arm64: Early boot time stamps
Message-ID: <20181120145315.GA42987@e119886-lin.cambridge.arm.com>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
 <20181119214443.25175-2-pasha.tatashin@soleen.com>
 <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
 <CA+CK2bAKcdZRRMwhcQ0QnBJ3_6bg=zhaeM7v74f+QFwkw9h17A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAKcdZRRMwhcQ0QnBJ3_6bg=zhaeM7v74f+QFwkw9h17A@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:40:10AM -0500, Pavel Tatashin wrote:
> > > +static __init void sched_clock_early_init(void)
> > > +{
> > > +     u64 freq = arch_timer_get_cntfrq();
> > > +     u64 (*read_time)(void) = arch_counter_get_cntvct;
> >
> > We already have arch_timer_read_counter which is exposed from
> > arm_arch_timer.h.
> 
> OK
> 
> >
> > > +
> > > +     /* Early clock is available only on platforms with known freqs */
> >
> > This comment is misleading. It should read something like:
> >
> >         /*
> >          * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
> >          * the timer frequency. To avoid breakage on misconfigured
> >          * systems, do not register the early sched_clock if the
> >          * programmed value if zero. Other random values will just
> >          * result in random output.
> >          */
> >
> 
> OK
> 
> > > +     if (!freq)
> > > +             return;
> > > +
> > > +     sched_clock_register(read_time, BITS_PER_LONG, freq);
> >
> > This doesn't seem right. The counter has an architected minimum of 56
> > bits, and you can't assume that it is going to be more than that.
> 
> Yeah, I saw 56 is used in arm_arch_timer.c, but I could not find where
> this minimum is defined in aarch64 specs. I will change it to 56.

See section G5.1.2 of the ARM ARM for details.

Thanks,

Andrew Murray

> 
> I will send v2 soon.
> 
> Thank you,
> Pasha
