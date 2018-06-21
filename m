Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B6C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0207221EF9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0207221EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeFUUTX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:19:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:2722 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932686AbeFUUTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:19:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 13:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="61180329"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2018 13:19:21 -0700
Date:   Thu, 21 Jun 2018 13:18:52 -0700
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
Message-ID: <20180621201851.GC114883@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621193738.GA13636@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:37:38PM +0200, Peter Zijlstra wrote:
> On Sun, May 27, 2018 at 08:45:49AM -0700, Fenghua Yu wrote:
> > Currently we can trace split lock event counter for debug purpose. But
> 
> How? A while ago I actually tried that, but I could not find a suitable
> perf event.

The event name is called sq_misc.split_lock. It's been supported in perf
already.

> 
> > Intel introduces mechanism to detect split lock via alignment
> > check exception in Tremont and other future processors. If split lock is
> > from user process, #AC handler can kill the process or re-execute faulting
> > instruction depending on configuration. 
> 
> Ideally it would #AC any unaligned (implied) LOCK prefix instruction,
> not just across lines.

This feature only triggers #AC for unaligned cache line access, not for
other aligned (4 bytes, 8 bytes, etc). This is not explicitly said in
ISE. I can add this info in next version of patches.

> 
> > To detect split lock, a new control bit (bit 29) in per-core TEST_CTL
> > MSR 0x33 will be introduced in future x86 processors. When the bit 29
> > is set, the processor causes #AC exception for split locked accesses at
> > all CPL.
> 
> Per-Core is really unfortunate, but better than nothing.

Agree with you! Per-core is at least for current hardware implementation.
The code and locking in the code are supposed to work in the future on
potential per-thread or even per-socket implmentation.

Thanks.

-Fenghua
