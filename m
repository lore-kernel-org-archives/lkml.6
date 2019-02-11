Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F066C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA88D222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfBKTXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:23:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:63072 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfBKTXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:23:07 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 11:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="143362916"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2019 11:23:05 -0800
Date:   Mon, 11 Feb 2019 11:16:43 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Message-ID: <20190211191643.GB103371@romley-ivt3.sc.intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1902041745370.3006@nanos.tec.linutronix.de>
 <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net>
 <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
 <20190205170415.GG17550@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 08:20:20PM +0100, Thomas Gleixner wrote:
> On Tue, 5 Feb 2019, Peter Zijlstra wrote:
> > On Tue, Feb 05, 2019 at 07:19:16AM -0800, Dave Hansen wrote:
> > > On 2/5/19 12:48 AM, Peter Zijlstra wrote:
> > > This isn't something we want everybody and their grandma to turn on;
> > > it's a rather specialized feature.  It's really only for folks that care
> > > about the latency incurred across the entire system on split lock
> > > operations.
> > 
> > That really should be everyone. That split lock stuff is horrible. There
> > is no real down-side to having it always enabled. Code that breaks is
> > bad code you want fixed anyway.
> > 
> > Like I said elsewhere, I wish it would #AC for any unaligned LOCK
> > prefix, not just cross-line. I see why we'd not want to traditional RISC
> > #AC for every load/store, but atomics really had better be aligned.
> 
> Right, we should really make this default enabled.

Yes, I agree.

> 
> > > > Is this some transient state; where a few (early) models will not have
> > > > the enumeration sorted but all later models will have it all neat and
> > > > tidy?
> > > 
> > > From my understanding, it's not just an early stepping.  It's a
> > > generational thing.  The current generation lacks the enumeration and
> > > the next generation will get it.  Both have the silicon to implement the
> > > feature itself.
> > 
> > I never said stepping, in fact I explicitly said model.
> > 
> > > > If so, we can easily do the FMS solution for this.
> > > 
> > > Yeah, we can.  I honestly forget why we didn't do FMS. :)
> > 
> > Right so FMS is fairly horrible; but when it is a stop-gap for a limited
> > number of models it's waaay better than dodgy cmdline things.
> 
> One or two is fine. And _IF_ we get the enumeration sorted before we merge
> that, then we can declare the FM list as immutable :)

There will be about 8 models that have the split lock feature but
don't have the IA32_CORE_CAPABILITY enumeration. The models will NOT
have the IA32_CORE_CAPABILITY enumerate in the future as planned. All
of other models than these ones will have the IA32_CORE_CAPABILITY
enumeration.

I don't see any of the model numbers are public yet as of now.

In the next version of patches, I will do the following changes from
v3:

1. Remove patch #11 that implements "setcpuid=".
2. But I will not implement the patch that enables the split lock feature
based on FMS because there is no public FMS numbers of those models. The
patch/patches will be implemented only after the FMS numbers are public.
3. The new patches enables the feature once it enumerates the feature
by bit 5 in IA32_CORE_CAPABILITY.
4. The feature can be disabled by kernel option
"clearcpuid=split_lock_detection" during early boot time.
5. The feature can be disabled/enabled during run time by
sysfs interface "/sys/kernel/split_lock_detection"

Does that make sense?

Thanks.

-Fenghua
