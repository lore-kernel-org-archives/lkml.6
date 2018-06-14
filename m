Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D54E6C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B5208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962B5208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754935AbeFNIgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:36:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:25568 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754540AbeFNIgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:36:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 01:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="49819201"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2018 01:36:49 -0700
Date:   Thu, 14 Jun 2018 16:38:51 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     alek.du@intel.com, feng.tang@intel.com
Subject: Re: [RFC 1/2] printk: Enable platform to provide a early boot clock
Message-ID: <20180614083851.m6euwwl3xkdtjakd@shbuild888>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 05:20:58PM +0800, Feng Tang wrote:
> Currently printk timestamp mostly come from the sched_clock which
> depends on the clock setup, so there are many kernel logs started
> with "[    0.000000]   " before the clock is calibrated.
> 
> This patch will provide an debug option for specific platform to
> provide a early boot time clock, so that we can have time info in
> kernel log much earlier, which can show the time info for the early
> kernel boot, and make boottime tuning/optimization easier (boot time
> is critical for phone/tablet and embedded devices).
> 
> Capable platform only need to setup the "boot_printk_clock_fn"
> which could return time in nano seconds.
> 
> Together with a TSC patch on x86 system, we have easily captured
> some early boottime killer like unwind_init() which takes about
> 300ms in boot phase.

Hi Petr and all,

As the 2/2 tsc related patch is still under review/discussion, can
we consider taking this first? As this may benefit other archs.
For example, Intel Curie platform has an always-on 32KHz osc clock,
which is accurate but low frequency, and it could be used as
early printk timestamp until the high-resolution timer is initialized
and used as sched_clock. Don't know if ARM or other platforms
have similar use case.

Thanks,
Feng
