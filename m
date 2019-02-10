Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1EFC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8FD213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBJVI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:08:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37376 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBJVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:08:58 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gswLO-0001LZ-7G; Sun, 10 Feb 2019 22:08:54 +0100
Date:   Sun, 10 Feb 2019 22:08:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>, kin.cho@oracle.com
Subject: Re: [PATCH] acpi_pm: Reduce PMTMR counter read contention
In-Reply-To: <853e8cf6-aba9-0200-8e39-e362848399ba@oracle.com>
Message-ID: <alpine.DEB.2.21.1902102159070.8784@nanos.tec.linutronix.de>
References: <1548141807-25825-1-git-send-email-zhenzhong.duan@oracle.com> <alpine.DEB.2.21.1901300903350.1950@nanos.tec.linutronix.de> <019e583c-7bcb-c234-200c-fcdb6c49fbb0@oracle.com> <alpine.DEB.2.21.1901311525360.8200@nanos.tec.linutronix.de>
 <853e8cf6-aba9-0200-8e39-e362848399ba@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019, Zhenzhong Duan wrote:
> On 2019/1/31 22:26, Thomas Gleixner wrote:

> > > > I'm not against the change per se, but I really want to understand
> > > > why we need all the complexity for something which should never be
> > > > used in a real world deployment.
> > > >
> > > Hmm, it's a strong word of "never be used". Customers may happen to
> > > use nohpet(sanity test?) and report bug to us. Sometimes they does
> > > report a bug that reproduce with their customed config. There may
> > > also be BIOS setting HPET disabled.
> > 
> > And because the customer MAY do completely nonsensical things (and there
> > are a lot more than the HPET) the kernel has to handle all of them?
> 
> Ok, then. I don't have more suggestion to convince you.

You give up too fast :)

The point is, that we really want proper justifications for changes like
this. Some 'may, could and more handwaving' simply does not cut it.

So if you can just describe a realistic scenario, which does not involve
thoughtless flipping of BIOS options, then this becomes way more palatable.

> I just think of a simple fix as below. I think it will work for both hpet
> and pmtmr. We will test it when the env is available.

> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1353,6 +1353,7 @@ static int change_clocksource(void *data)
> 
>         write_seqcount_end(&tk_core.seq);
>         raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
> +       tick_clock_notify();
> 
>         return 0;
>  }
> @@ -1371,7 +1372,6 @@ int timekeeping_notify(struct clocksource *clock)
>         if (tk->tkr_mono.clock == clock)
>                 return 0;
>         stop_machine(change_clocksource, clock, NULL);
> -       tick_clock_notify();
>         return tk->tkr_mono.clock == clock ? 0 : -1;
>  }

This won't resolve the concurrency issues of HPET or PMTIMER in any
way. Instead it breaks the careful orchestrated mechanism of clocksource
change.

Thanks,

	tglx

