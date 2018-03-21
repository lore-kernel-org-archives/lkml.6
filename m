Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeCUXaV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:30:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:32097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753980AbeCUXaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:30:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="27773929"
Subject: Re: [PATCH] x86/speculation: Fill the RSB on context switch also on
 non-IBPB CPUs
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
References: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, thomas.lendacky@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <757282b8-8b59-bcc6-1f6b-3383ae8a8575@intel.com>
Date: Wed, 21 Mar 2018 16:30:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 04:17 AM, Maciej S. Szmigiero wrote:
> Since it is unlikely that existing RSB entries from the previous task match
> the new task call stack we can use the existing unconditional
> RSB-filling-on-context-switch infrastructure to protect against such
> userspace-to-userspace attacks.
> 
> This patch brings a change in behavior only for the following CPU types:
> * Intel pre-Skylake CPUs without updated microcode,
> * AMD Family 15h model >60h, Family 17h CPUs without updated microcode.
> 
> Other CPU types either already do the RSB filling on context switch for
> other reasons or do support IBPB for more complete userspace-to-userspace
> protection.

I think I misunderstood your reasoning a bit.  Let me see if I can
restate the problem a bit.

IBPB provides provides userspace-to-userspace protection because it
prevents all indirect branch predictions after the barrier from being
controlled by software executed before the barrier.  We only use IBPB
for KVM and when processes clear their dumpable flag.

You're saying that, even if we don't have IBPB, we can do *some*
userspace-to-userspace protection with RSB manipulation.  The RSB
manipulation obviously only helps 'RET' instructions and not JMP/CALL,
but it does do *something* useful.

Is that right?

Do you really want this behavior on all context switches?  We don't do
IBPB on all context switches, only the ones where we are switching *to*
a non-dumpable process.

Do you perhaps want to do RSB manipulation in lieu of IBPB when
switching *to* a non-dumpable process and IBPB is not available?
