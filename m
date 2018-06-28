Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78EC43149
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C19214DC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C19214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966683AbeF1Oz3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:55:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:43841 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966209AbeF1Oz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:55:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 07:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="241412898"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2018 07:55:19 -0700
Date:   Thu, 28 Jun 2018 07:54:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180628145441.GL18979@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-5-git-send-email-fenghua.yu@intel.com>
 <20180621195540.GC13636@worktop.programming.kicks-ass.net>
 <20180627233504.GJ18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806280945120.1778@nanos.tec.linutronix.de>
 <20180628142322.GK18979@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628142322.GK18979@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 07:23:22AM -0700, Fenghua Yu wrote:
> On Thu, Jun 28, 2018 at 09:53:17AM +0200, Thomas Gleixner wrote:
> > On Wed, 27 Jun 2018, Fenghua Yu wrote:
> > > On Thu, Jun 21, 2018 at 09:55:40PM +0200, Peter Zijlstra wrote:
> > > > On Sun, May 27, 2018 at 08:45:53AM -0700, Fenghua Yu wrote:
> > > > > set_bit() called by set_cpu_cap() is a locked bit set instruction for
> > > > > atomic operation.
> > > > > 
> > > > > Since the c->x86_capability can span two cache lines depending on kernel
> > > > > configuration and building evnironment, the locked bit set instruction may
> > > > > cause #AC exception when #AC exception for split lock is enabled.
> > > > 
> > > > That doesn't make sense. Sure the bitmap may be longer, but depending on
> > > > if the argument is an immediate or not we either use a byte instruction
> > > > (which can never cross a cacheline boundary) or a 'word' aligned BTS.
> > > > And the bitmap really _should_ be 'unsigned long' aligned.
> > > > 
> > > > If it is not aligned, fix that too.
> > > > 
> > > > /me looks at cpuinfo_x86 and finds x86_capability is in fact a __u32
> > > > array.. see that's broken and needs fixing first.
> > > 
> > > Do you mean x86_capability's type should be changed from __u32 to unsigned
> > > long?
> > > 
> > > Changing x86_capability's type won't directly fix the split lock in
> > > set_cpu_cap(), right? BTS still may access x86_capability across cache
> > > line no matter x86_capability's type.
> > 
> > Errm. No.  BTS & al are accessing a single 64bit location which is
> > 
> >    base_address + (bit_offset % 64) * 8
> > 
> > So if the base address is properly aligned then BTS & al will _NEVER_ have
> > to lock more than a single cache line. And it does not matter wheter we fix
> > the type or enforce 64bit alignement of the array by other means.
> > 
> > If that's not true then BTS & al are terminally broken and you can stop
> > working on #AC right away.
> 
> Is the following patch right fix for the x86_capability split lock issue
> (i.e. this patch replace patch 4 and 5)?
> 
> -       __u32                   x86_capability[NCAPINTS + NBUGINTS];
> +       __u32                   x86_capability[NCAPINTS + NBUGINTS]
> +                               __aligned(8);

Should be '__aligned(sizeof(unsigned long))' for both 32-bit and 64-bit.

 
Thanks.
 
-Fenghua
