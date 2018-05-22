Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeEVAGR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:06:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:56270 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbeEVAGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:06:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="201298417"
Date: Mon, 21 May 2018 17:06:14 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180522000614.GA21542@agluck-desk>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
 <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
 <20180520204032.GA19845@pd.tnic>
 <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
 <20180521165803.GA15717@agluck-desk>
 <CAG=yYw=OQ7zpyK-5iqg7uQvcykTvuhQfX=RFg3GpQGvCRowd=Q@mail.gmail.com>
 <20180521205751.GA19282@agluck-desk>
 <CAG=yYwmgceOCf3TeefFN-i54Z4Qxsp7asD0uhqah5P7md94kWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYwmgceOCf3TeefFN-i54Z4Qxsp7asD0uhqah5P7md94kWw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 02:43:37AM +0530, Jeffrin Thalakkottoor wrote:
> mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 5: ee0000000040110b
> mce: [Hardware Error]: TSC 0 ADDR 160000080 MISC 5040008086
> mce: [Hardware Error]: PROCESSOR 0:306d4 TIME 1526932210 SOCKET 0 APIC
> 0 microcode 2a

The problem is that "mcelog --ascii" is expecting the first line to
look like:

	CPU 0: Machine Check Exception: 0 Bank 5: ee0000000040110b

This seems to have been broken by commit:

	cd9c57cad3fe ("x86/MCE: Dump MCE to dmesg if no consumers")

relevent part is this ... where we now conditionally include the
word "Exception".

-static void print_mce(struct mce *m)
+static void __print_mce(struct mce *m)
 {
-       int ret = 0;
-
-       pr_emerg(HW_ERR "CPU %d: Machine Check Exception: %Lx Bank %d: %016Lx\n",
-              m->extcpu, m->mcgstatus, m->bank, m->status);
+       pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
+                m->extcpu,
+                (m->mcgstatus & MCG_STATUS_MCIP ? " Exception" : ""),
+                m->mcgstatus, m->bank, m->status);

While this is a bit easier to read, no new information is included as we
do print the value of m->mcgstatus.

Sadly, the change was made back in v4.10 ... so reverting it won't
help all the people running kernels built in the last fifteen months :-(

I'll see if I can get Andi to take a patch for mcelog to accept the
line with or without the " Exception".

Oh ... one more thing. Did your e-mail client line wrap that last line?

> mce: [Hardware Error]: PROCESSOR 0:306d4 TIME 1526932210 SOCKET 0 APIC
> 0 microcode 2a

That should all be on one line.

-Tony
