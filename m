Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeCWXLg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:11:36 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39920 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbeCWXLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:11:35 -0400
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
 <4d7cfea4-a86a-c8f2-aaff-c8429fc107b8@maciej.szmigiero.name>
 <9f9d0c1f-a889-d2bc-e9d9-d4ef9d99770b@intel.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <50fb8735-2d79-6515-8e96-acb56f3ec8f3@maciej.szmigiero.name>
Date: Sat, 24 Mar 2018 00:11:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9f9d0c1f-a889-d2bc-e9d9-d4ef9d99770b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2018 16:46, Dave Hansen wrote:
> On 03/21/2018 05:09 PM, Maciej S. Szmigiero wrote:
>> As far as I understand the issue this should provide a good protection
>> for userspace processes that were recompiled with retpolines as they
>> won't have any indirect jumps and calls.
> 
> Instead of saying "good protection", let's just say that it could
> mitigate attacks that require consumption of attacker-placed RSB entries.

All right.

>>> Do you perhaps want to do RSB manipulation in lieu of IBPB when
>>> switching *to* a non-dumpable process and IBPB is not available?
>>
>> Is it worth differentiating such processes in this case?
>> IBPB is supposed to be very expensive so certainly it is worthwhile
>> to do it only for high-value processes (=non-dumpable).
>>
>> However, it is unlikely that existing RSB entries from the previous
>> task match the new task call stack anyway.
>> We already do unconditional RSB-filling-on-context-switch in many
>> cases.
> 
> I think this case is a bit too obscure and theoretical to complicate the
> kernel with it.  You need an unmitigated processor, a
> userspace-to-userspace attack that manages to satisfy the five "exploit
> composition" steps of Spectre/V2[1], and an application that has been
> retpoline-mitigated.
> 
> While RSB manipulation is almost certainly less onerous than IBPB, it's
> still going to hurt context-switch rates, especially if applied
> indiscriminately like this patch does.
> 
> So, I totally agree with your analysis about the theoretical potential
> for an issue, I'm just not really convinced the fix is worth it.

Yes, Spectre v2 looks really hard to exploit, but this doesn't mean the
kernel shouldn't do its best to mitigate it.

As I wrote two messages ago, basing on the Intel guidance document you
linked above as "[1]" I think that the mitigation introduced by this
patch should not be done on Intel CPUs, however, since that document
clearly suggests that this may not be enough to cover the issue.
And I think we shouldn't give people a false sense of security.

Maciej
