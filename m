Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE2C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E124CCB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 18:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8E124CCB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFWSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 14:48:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:13275 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751804AbeFWSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 14:48:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2018 11:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,262,1526367600"; 
   d="scan'208";a="59635053"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2018 11:48:27 -0700
Date:   Sat, 23 Jun 2018 11:47:55 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180623184755.GH18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
 <20180621221337.GE2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621221337.GE2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:13:37AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> > For example, on a consolidated real-time machine, some cores are running
> 
> > Another example, in a public cloud deployed in the field, a user process
> 
> In either case a single split-lock shouldn't be a real problem, if you
> program the event with a count of 1 and have the NMI handler kill the
> offending task, you should be good.
> 
> Not saying the #AC isn't nicer, just saying the PMU based thing can
> still work.

The difference between perf event and #AC for split lock is perf event
is after the fact while #AC is before the fact.

In the examples (esp. the first example), hard real time cannot afforrd
a split lock/bus lock. Perf captures the event and kill the task; but
the split lock has been issued and harm has been done. #AC for split lock
kills the task before the task generates split lock or bus lock to hurt
real time tasks.

Thanks.

-Fenghua
