Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeCVPqW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:46:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:47844 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeCVPqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:46:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="210462241"
Subject: Re: [PATCH] x86/speculation: Fill the RSB on context switch also on
 non-IBPB CPUs
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
References: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
 <757282b8-8b59-bcc6-1f6b-3383ae8a8575@intel.com>
 <4d7cfea4-a86a-c8f2-aaff-c8429fc107b8@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, thomas.lendacky@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9f9d0c1f-a889-d2bc-e9d9-d4ef9d99770b@intel.com>
Date: Thu, 22 Mar 2018 08:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4d7cfea4-a86a-c8f2-aaff-c8429fc107b8@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 05:09 PM, Maciej S. Szmigiero wrote:
> As far as I understand the issue this should provide a good protection
> for userspace processes that were recompiled with retpolines as they
> won't have any indirect jumps and calls.

Instead of saying "good protection", let's just say that it could
mitigate attacks that require consumption of attacker-placed RSB entries.

>> Do you perhaps want to do RSB manipulation in lieu of IBPB when
>> switching *to* a non-dumpable process and IBPB is not available?
> 
> Is it worth differentiating such processes in this case?
> IBPB is supposed to be very expensive so certainly it is worthwhile
> to do it only for high-value processes (=non-dumpable).
> 
> However, it is unlikely that existing RSB entries from the previous
> task match the new task call stack anyway.
> We already do unconditional RSB-filling-on-context-switch in many
> cases.

I think this case is a bit too obscure and theoretical to complicate the
kernel with it.  You need an unmitigated processor, a
userspace-to-userspace attack that manages to satisfy the five "exploit
composition" steps of Spectre/V2[1], and an application that has been
retpoline-mitigated.

While RSB manipulation is almost certainly less onerous than IBPB, it's
still going to hurt context-switch rates, especially if applied
indiscriminately like this patch does.

So, I totally agree with your analysis about the theoretical potential
for an issue, I'm just not really convinced the fix is worth it.

1.
https://software.intel.com/sites/default/files/managed/1d/46/Retpoline-A-Branch-Target-Injection-Mitigation.pdf
