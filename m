Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754181AbeCVAJs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 20:09:48 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:60380 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753732AbeCVAJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 20:09:47 -0400
Subject: Re: [PATCH] x86/speculation: Fill the RSB on context switch also on
 non-IBPB CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, thomas.lendacky@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
 <757282b8-8b59-bcc6-1f6b-3383ae8a8575@intel.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <4d7cfea4-a86a-c8f2-aaff-c8429fc107b8@maciej.szmigiero.name>
Date: Thu, 22 Mar 2018 01:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <757282b8-8b59-bcc6-1f6b-3383ae8a8575@intel.com>
Content-Type: text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2018 00:30, Dave Hansen wrote:
> On 03/20/2018 04:17 AM, Maciej S. Szmigiero wrote:
>> Since it is unlikely that existing RSB entries from the previous task match
>> the new task call stack we can use the existing unconditional
>> RSB-filling-on-context-switch infrastructure to protect against such
>> userspace-to-userspace attacks.
>>
>> This patch brings a change in behavior only for the following CPU types:
>> * Intel pre-Skylake CPUs without updated microcode,
>> * AMD Family 15h model >60h, Family 17h CPUs without updated microcode.
>>
>> Other CPU types either already do the RSB filling on context switch for
>> other reasons or do support IBPB for more complete userspace-to-userspace
>> protection.
> 
> I think I misunderstood your reasoning a bit.  Let me see if I can
> restate the problem a bit.
> 
> IBPB provides provides userspace-to-userspace protection because it
> prevents all indirect branch predictions after the barrier from being
> controlled by software executed before the barrier.  We only use IBPB
> for KVM and when processes clear their dumpable flag.
> 
> You're saying that, even if we don't have IBPB, we can do *some*
> userspace-to-userspace protection with RSB manipulation.  The RSB
> manipulation obviously only helps 'RET' instructions and not JMP/CALL,
> but it does do *something* useful.
> 
> Is that right?

Yes.

As far as I understand the issue this should provide a good protection
for userspace processes that were recompiled with retpolines as they
won't have any indirect jumps and calls.

> Do you really want this behavior on all context switches?  We don't do
> IBPB on all context switches, only the ones where we are switching *to*
> a non-dumpable process.
> 
> Do you perhaps want to do RSB manipulation in lieu of IBPB when
> switching *to* a non-dumpable process and IBPB is not available?
> 

Is it worth differentiating such processes in this case?
IBPB is supposed to be very expensive so certainly it is worthwhile
to do it only for high-value processes (=non-dumpable).

However, it is unlikely that existing RSB entries from the previous
task match the new task call stack anyway.
We already do unconditional RSB-filling-on-context-switch in many
cases.

Maciej
