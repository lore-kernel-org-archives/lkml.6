Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05280C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B950B208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B950B208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeFNJIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:08:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46963 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754571AbeFNJI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:08:29 -0400
Received: from p4fea5fc6.dip0.t-ipconnect.de ([79.234.95.198] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fTOEe-0007rE-NV; Thu, 14 Jun 2018 11:08:05 +0200
Date:   Thu, 14 Jun 2018 11:08:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, alek.du@intel.com
Subject: Re: [RFC 1/2] printk: Enable platform to provide a early boot
 clock
In-Reply-To: <20180614083851.m6euwwl3xkdtjakd@shbuild888>
Message-ID: <alpine.DEB.2.21.1806141107260.1581@nanos.tec.linutronix.de>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com> <20180614083851.m6euwwl3xkdtjakd@shbuild888>
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

On Thu, 14 Jun 2018, Feng Tang wrote:
> On Wed, May 30, 2018 at 05:20:58PM +0800, Feng Tang wrote:
> > Currently printk timestamp mostly come from the sched_clock which
> > depends on the clock setup, so there are many kernel logs started
> > with "[    0.000000]   " before the clock is calibrated.
> > 
> > This patch will provide an debug option for specific platform to
> > provide a early boot time clock, so that we can have time info in
> > kernel log much earlier, which can show the time info for the early
> > kernel boot, and make boottime tuning/optimization easier (boot time
> > is critical for phone/tablet and embedded devices).
> > 
> > Capable platform only need to setup the "boot_printk_clock_fn"
> > which could return time in nano seconds.
> > 
> > Together with a TSC patch on x86 system, we have easily captured
> > some early boottime killer like unwind_init() which takes about
> > 300ms in boot phase.
> 
> Hi Petr and all,
> 
> As the 2/2 tsc related patch is still under review/discussion, can
> we consider taking this first? As this may benefit other archs.
> For example, Intel Curie platform has an always-on 32KHz osc clock,
> which is accurate but low frequency, and it could be used as
> early printk timestamp until the high-resolution timer is initialized
> and used as sched_clock. Don't know if ARM or other platforms
> have similar use case.

Can we please _NOT_ add half sorted core stuff in a hurry?

Thanks,

	tglx
