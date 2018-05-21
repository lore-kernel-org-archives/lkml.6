Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeEUQ6H (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:58:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:2467 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbeEUQ6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:58:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="56238336"
Date: Mon, 21 May 2018 09:58:03 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: mce: [Hardware Error] from dmesg -l emerg
Message-ID: <20180521165803.GA15717@agluck-desk>
References: <CAG=yYwmnHgAvauZLxfFcUEACF_J+qh4d2tvYY=AdjHvyeSFK_A@mail.gmail.com>
 <20180514162752.GG23049@pd.tnic>
 <CAG=yYwk-dbMF_7eS9bUraAru8b4fyCosxp+MpQA=1ZYH0nd_hg@mail.gmail.com>
 <20180520204032.GA19845@pd.tnic>
 <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG=yYw=bdgsTSW80R1Wt9uUTtXeMwX5macbjrPBNzVLihk-Ufw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:31:52PM +0530, Jeffrin Thalakkottoor wrote:
> > Ok, but please do not top-post.
> 
> Ok
> 
> > Looks like mcelog has trouble decoding this. Have you updated mcelog to
> > the latest version in your distro?
> .
> mcelog                               153+dfsg-1

So this is looking like another case where an error is
logged during BIOS bringup, and Linux finds the error
when it scans all machine check banks during boot.

The earlier logs you sent showed a value of ee0000000040110b
in the machine check bank status register. Not sure why
mcelog had trouble with this(*).

Upper bits say: VALID OVER UC MISCV ADDRV

Low 16 (MCACOD) bits say: FILTER CACHE ERR GENERIC LEVEL=3

So BIOS did something to trigger some issues in the L3
cache (more than once since the overflow and filter bits
are both set).

I think (but am not 100% sure because I don't have an
internal decoder that knows about this specific CPU model)
that the error was a write-back to MMIO (this matches other
cases where we've seen BIOS trigger some error and left the
logs for Linux to find at boot).  It's not quite the same
because the address logged for you is 160000080, where the
previous cases has addresses below 4GB. But some platforms
include MMIO above 4GB, so this is still plausible.

Advice we have given before is to attempt to log a bug
against the BIOS with the vendor of your system. But the
last person to try this reported no success.

Or, you could ignore it. It appears to not have any
side effects.

-Tony

(*) Can you send a snip from the raw dmesg output that starts
a couple of lines before:


	... [Hardware Error]: CPU 0: Machine Check: 0 Bank: 5 ...

and continues a couple of lines past

	... [Hardware Error]: PROCESSOR 0:306d4 ...

and I'll take a look at why mcelog choked.
