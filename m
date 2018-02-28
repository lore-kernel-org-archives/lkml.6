Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeB1N0n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:26:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:23688 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbeB1N0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:26:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="scan'208";a="21428012"
Date: Wed, 28 Feb 2018 05:26:40 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 4/7] x86/microcode: Do not upload microcode if CPUs are
 offline
Message-ID: <20180228132639.GA23235@araj-mobl1.jf.intel.com>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-5-bp@alien8.de>
 <20180228131156.i4y6la7besdflffd@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228131156.i4y6la7besdflffd@khazad-dum.debian.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:11:56AM -0300, Henrique de Moraes Holschuh wrote:
> > Avoid loading microcode if any of the CPUs are offline, and issue a
> > warning. Having different microcode revisions on the system at any time
> > is outright dangerous.
> 
> Even if we update that microcode during CPU early bring-up, before we
> mark it on-line and start using it?
> 
> AFAIK, late-loading or not, this is what should happen in the current
> code: APs that are brought up after a microcode update is loaded (either
> by the early or late driver, it doesn't matter) will be always
> *early-updated* to the new microcode.
> 
> Is it dangerous to have an offline core at an older microcode revision
> than the online cores?

We don't want to leave a system and allow the user to update microcode
when some cpus are offline. Remember cpu_offline in linux is only 
logical offlining.. so the cpu is still in the system.. it can even 
participate in MCE for e.g. It is very much alive. Its not a question
that "Would it not work" but its not worth to leave an open door and 
being paranoid is best!



> 
> I am not against the patch, mind you, but I am curious about why it is
> supposed to be dangerous if we're updating the CPUs before we start
> using them *anyway*.
> 
> Also, if this is really dangerous, does it means safe CPU hotplug isn't
> possible?  AFAICT, the firmware would have to do it for us, but it
> *doesn't* have the up-to-date microcode (*we* had to update it)...

The difference is hot-adding you know you are going to update the current
microcode. But leaving a cpu in offline state is leaving it stale for a long
time without realizing that you have some stale cores.
