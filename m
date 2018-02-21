Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeBUVPX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:15:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:54170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeBUVPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:15:20 -0500
Date: Wed, 21 Feb 2018 22:15:03 +0100
From: Borislav Petkov <bp@suse.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH 3/3] x86/microcode: Quiesce all threads before a
 microcode update.
Message-ID: <20180221211503.GF16888@pd.tnic>
References: <1519231784-9941-1-git-send-email-ashok.raj@intel.com>
 <1519231784-9941-4-git-send-email-ashok.raj@intel.com>
 <20180221190611.GE16888@pd.tnic>
 <20180221201308.GB14170@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180221201308.GB14170@araj-mobl1.jf.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 12:13:08PM -0800, Raj, Ashok wrote:
> This is ensuring no 2 cpus do ucode update at the same time.

And that is a problem?

We don't do any of that mutual exclusion for early loading. Why isn't it
there a problem?

> That's what we are doing here, but simply returning number of cpus
> that encountered failure instead of a per-cpu retval
> like before.

You still don't need ->errors.

> When we online any of the offline cpu's we do a microcode load again right?

That doesn't make any sense. First you say:

"the Intel microcode team asked us to make sure the system is in a quiet
state during these updates."

When you've updated the microcode on a subset of the cores and then the
other cores come up and you do that in the hotplug notifier, the system
is far from quiet. On the contrary, it is busy bootstrapping cores.

Which makes me wonder if that "quiet" argument even means anything.

Because if you wanna do that in the notifiers, you can just as well
offline all the cores but the BSP, update the microcode there and then
online the rest again ---> no need for that patch at all.

> Not sure what you mean by jumping through hoops need to be extracted away.. 

Take that code:

+       memset(&uc_data, 0, sizeof(struct ucode_update_param));
+       spin_lock_init(&uc_data.ucode_lock);
+       atomic_set(&uc_data.enter, num_online_cpus());
+       /*
+        * Wait for a 1 sec
+        */
+       uc_data.timeout = USEC_PER_SEC;
+       stop_machine(ucode_load_rendezvous, &uc_data, cpu_online_mask);
+
+       pr_debug("Total CPUS = %d uperrors = %d\n",
+               atomic_read(&uc_data.count), atomic_read(&uc_data.errors));
+
+       if (atomic_read(&uc_data.errors))

and put it in a separate function which you call in reload_store().

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
