Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932152AbeBVLz6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:55:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:6880 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932073AbeBVLz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:55:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="20246429"
Date: Thu, 22 Feb 2018 03:55:54 -0800
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
Message-ID: <20180222115554.GA3797@araj-mobl1.jf.intel.com>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222110056.GA27489@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:00:57PM +0100, Borislav Petkov wrote:
> > 
> > Updates:
> > v2: Address Boris's to cleanup apply_microcode_intel
> > v3: Fixups per Ingo: Spell Checks
> 
> That changelog...
> 
> > ---
> 
> ... comes under this line so that it can be ignored by tools.

Oops! using stg, and try to not remember too many things and write it up here.
Will remember to move things next time around.

> 
> >  arch/x86/kernel/cpu/microcode/intel.c | 28 +++++++++++++++++++++++++---
> >  1 file changed, 25 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> > index 09b95a7..137c9f5 100644
> > --- a/arch/x86/kernel/cpu/microcode/intel.c
> > +++ b/arch/x86/kernel/cpu/microcode/intel.c
> > @@ -589,6 +589,18 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
> >  	if (!mc)
> >  		return 0;
> >  
> > +	rev = intel_get_microcode_revision();
> 
> Ok, so I'm still wondering what this patch is trying to achieve.
> 
> intel_get_microcode_revision() does already *two* MSR reads and a CPUID.
> So it is not speed improvements - it actually makes loading slower due to that
> checking.

Not a speed improvement.. Hopefully i didn't mislead somewhere :-(
> 
> So why are we doing this again?

When you have two HT threads of the same core. Updating microcode on one of the threads
is just good enough. The recommendation for HT siblings is as follows.

Core C0 has two threads C0T0, and C0T1

- Not to simultaneously load microcode on both threads.
- (NEW) not to perform ucode load when the other HT thread is active. 
  Its safe to spin on a cached variable (like what the patch3 is trying to achieve)

The current code wasn't trying to enforce checking the loaded microcode revision on a thread
before attempting to load the microcode. While you comeback from resume, if C0T0 already
is up, and we loaded the early microcode, then when handling C0T1 there is no need to 
do a wrmsrl to reapply microcode since its already loaded as part of C0T0. 

This way we don't need any quiese of C0T0 while bringing up C0T1. We need to skip 
the loading process avoid doing the ucode load in this case.

Hope this helps.. and if you need this as part of the file/commit log, we should
add that.

        rev = intel_get_microcode_revision();                                         

        /*
         * Its possible the microcode got updated
         * because its sibling update was done earlier.
         * Skip the update in that case.
         */
        if (rev >= mc->hdr.rev) {
                uci->cpu_sig.rev = rev;<----- Maybe we can avoid this in early load?
                return UCODE_OK;
        }

        /*
         * Microcode updates can be safer if the caches are clean.
         * Some of the issues around in certain Broadwell parts
         * can be addressed by doing a full cache flush.
         */
        native_wbinvd();

        /* write microcode via MSR 0x79 */
        native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
