Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbeBVNTV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:19:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:42673 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeBVNTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:19:19 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="36634696"
Date: Thu, 22 Feb 2018 05:19:18 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180222131918.GB3797@araj-mobl1.jf.intel.com>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
 <20180222115554.GA3797@araj-mobl1.jf.intel.com>
 <20180222121506.GC27489@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222121506.GC27489@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 01:15:06PM +0100, Borislav Petkov wrote:
> On Thu, Feb 22, 2018 at 03:55:54AM -0800, Raj, Ashok wrote:
> > The current code wasn't trying to enforce checking the loaded microcode revision on a thread
> > before attempting to load the microcode. While you comeback from resume, if C0T0 already
> > is up, and we loaded the early microcode, then when handling C0T1 there is no need to 
> > do a wrmsrl to reapply microcode since its already loaded as part of C0T0. 
> 
> And I'm asking exactly this: is it simply "we don't need to do WRMSR" or
> "we should not"?
> 
> Because avoiding the WRMSR costs more than simply doing it and letting
> the HT thread ignore the supplied microcode.

This isn't a simple WRMSR like others. Microcode engine needs to do 
a bunch of validation.

> 
> If it is "we don't need to but there's nothing wrong when we do it" then
> we don't need this patch. And I'm pretty sure "nothing wrong when we do
> it" would be the answer. Otherwise we have bigger problems.

In the past the only guidance was to not load microcode at the same time to the 
thread siblings of a core. We now have new guidance that the sibling must be 
spinning and not doing other things that can introduce instability around loading 
microcode.

I think its safer to not load when its not required vs forcing a load and depending
on the microcode interface to not interfere. If the rules change in future we don't
have to adapt again.
