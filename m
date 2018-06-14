Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 32D68C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DFA208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 09:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DFA208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeFNJxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 05:53:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:22425 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754915AbeFNJxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 05:53:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 02:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="48932440"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga007.jf.intel.com with ESMTP; 14 Jun 2018 02:53:46 -0700
Date:   Thu, 14 Jun 2018 17:55:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, alek.du@intel.com,
        len.brown@intel.com, feng.tang@intel.com
Subject: Re: [RFC 1/2] printk: Enable platform to provide a early boot clock
Message-ID: <20180614095548.5lbnpm3db2bu2gov@shbuild888>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <20180614083851.m6euwwl3xkdtjakd@shbuild888>
 <alpine.DEB.2.21.1806141107260.1581@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806141107260.1581@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jun 14, 2018 at 11:08:04AM +0200, Thomas Gleixner wrote:
> On Thu, 14 Jun 2018, Feng Tang wrote:
> > On Wed, May 30, 2018 at 05:20:58PM +0800, Feng Tang wrote:
> > > Currently printk timestamp mostly come from the sched_clock which
> > > depends on the clock setup, so there are many kernel logs started
> > > with "[    0.000000]   " before the clock is calibrated.
> > > 
> > > This patch will provide an debug option for specific platform to
> > > provide a early boot time clock, so that we can have time info in
> > > kernel log much earlier, which can show the time info for the early
> > > kernel boot, and make boottime tuning/optimization easier (boot time
> > > is critical for phone/tablet and embedded devices).
> > > 
> > > Capable platform only need to setup the "boot_printk_clock_fn"
> > > which could return time in nano seconds.
> > > 
> > > Together with a TSC patch on x86 system, we have easily captured
> > > some early boottime killer like unwind_init() which takes about
> > > 300ms in boot phase.
> > 
> > Hi Petr and all,
> > 
> > As the 2/2 tsc related patch is still under review/discussion, can
> > we consider taking this first? As this may benefit other archs.
> > For example, Intel Curie platform has an always-on 32KHz osc clock,
> > which is accurate but low frequency, and it could be used as
> > early printk timestamp until the high-resolution timer is initialized
> > and used as sched_clock. Don't know if ARM or other platforms
> > have similar use case.
> 
> Can we please _NOT_ add half sorted core stuff in a hurry?

Got it.

The status for the 2/2 tsc patch is Peter suggested to bring the tsc_init()
earlier, with that this 1/2 is not needed for x86. I followed Peter's
suggestion and worked out a hack version with which the tsc inits fine
and printk timestamp works much earlier (detail is in the 2/2 thread).

But there is one blocker, the native_sched_clock()(tsc.c) use one staic key
__use_tsc and sched_clock_cpu()(clock.c) use another "__sched_clock_stable",
which cannot be used so early, one problem is the static_branch_enable()
will use pageing related code while the paging is not setup ready yet.
I haven't got idea to solve this first problem regarding static key.

Thanks,
Feng

