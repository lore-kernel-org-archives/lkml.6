Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06163C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3F6259C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3F6259C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeF0Xfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:35:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:18097 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbeF0Xfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:35:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 16:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,281,1526367600"; 
   d="scan'208";a="240886657"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2018 16:35:42 -0700
Date:   Wed, 27 Jun 2018 16:35:04 -0700
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
Subject: Re: [RFC PATCH 04/16] x86/split_lock: Use non locked bit set
 instruction in set_cpu_cap
Message-ID: <20180627233504.GJ18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-5-git-send-email-fenghua.yu@intel.com>
 <20180621195540.GC13636@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621195540.GC13636@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 09:55:40PM +0200, Peter Zijlstra wrote:
> On Sun, May 27, 2018 at 08:45:53AM -0700, Fenghua Yu wrote:
> > set_bit() called by set_cpu_cap() is a locked bit set instruction for
> > atomic operation.
> > 
> > Since the c->x86_capability can span two cache lines depending on kernel
> > configuration and building evnironment, the locked bit set instruction may
> > cause #AC exception when #AC exception for split lock is enabled.
> 
> That doesn't make sense. Sure the bitmap may be longer, but depending on
> if the argument is an immediate or not we either use a byte instruction
> (which can never cross a cacheline boundary) or a 'word' aligned BTS.
> And the bitmap really _should_ be 'unsigned long' aligned.
> 
> If it is not aligned, fix that too.
> 
> /me looks at cpuinfo_x86 and finds x86_capability is in fact a __u32
> array.. see that's broken and needs fixing first.

Do you mean x86_capability's type should be changed from __u32 to unsigned
long?

Changing x86_capability's type won't directly fix the split lock in
set_cpu_cap(), right? BTS still may access x86_capability across cache
line no matter x86_capability's type.

Thanks.

-Fenghua
