Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965456AbeE2RZI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:25:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:36070 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965424AbeE2RZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:25:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60076865"
Date: Tue, 29 May 2018 10:25:13 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180529172511.GA212416@romley-ivt3.sc.intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <f43f6139-7303-b469-a8b9-fe65e1cd9aed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f43f6139-7303-b469-a8b9-fe65e1cd9aed@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:39:01AM -0700, Dave Hansen wrote:
> On 05/27/2018 08:45 AM, Fenghua Yu wrote:
> > ==Detect Split Lock==
> > 
> > To detect split lock, a new control bit (bit 29) in per-core TEST_CTL
> > MSR 0x33 will be introduced in future x86 processors. When the bit 29
> > is set, the processor causes #AC exception for split locked accesses at
> > all CPL.
> > 
> > The bit 29 specification in MSR TEST_CTL is published in the latest
> > Intel Architecture Instruction Set Extensions and Future Features
> > Programming Reference.
> 
> The fact that this is per-core is pretty important, right?  Where does
> that get mentioned?

The fact that TEST_CTL is per-core is NOT mentioned in the Instruction
Set Extensions or SDM.

(By the way, ISE and SDM don't mention other important details, e.g.
the fact that operand is fetched to cache before split lock is checked.
Without the fact, it's hard to explain that only split lock generates bus
lock in chapter 8.1.4 in SDM vol3.)

I was told that TEST_CTL is per-core by the split lock hardware designer.
And I do find that the MSR is per-core on the currently only processor
that has split lock implementation.

As you can see handling per-core TEST_CTL needs consideration of locking
(in patch2).

But the code is supposed to work even if TEST_CTL is per-thread (or even
per-socket) in future.

Maybe I can add "Current TEST_CTL implementation is per-core. The patches
are supposed to work even when TEST_CTL is per-thread (or even per-
socket) in future as well."?

Thanks.

-Fenghua
