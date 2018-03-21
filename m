Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeCUW5R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:57:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:53862 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753715AbeCUW5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:57:16 -0400
Subject: Re: [PATCH] x86/speculation: Fill the RSB on context switch also on
 non-IBPB CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, thomas.lendacky@amd.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <9eb945bd-f77e-0301-d977-d1acf931b19d@maciej.szmigiero.name>
 <f9e5bb98-a211-c220-8a70-6febbcba371d@intel.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <b5092e2d-42c8-16ca-d164-239b0b045b51@maciej.szmigiero.name>
Date: Wed, 21 Mar 2018 23:57:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f9e5bb98-a211-c220-8a70-6febbcba371d@intel.com>
Content-Type: text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 15:05, Dave Hansen wrote:
> On 03/20/2018 04:17 AM, Maciej S. Szmigiero wrote:
>> If we run on a CPU that does not have IBPB support RSB entries from one
>> userspace process can influence 'ret' target prediction in another
>> userspace process after a context switch.
>>
>> Since it is unlikely that existing RSB entries from the previous task match
>> the new task call stack we can use the existing unconditional
>> RSB-filling-on-context-switch infrastructure to protect against such
>> userspace-to-userspace attacks.
>>
>> This patch brings a change in behavior only for the following CPU types:
>> * Intel pre-Skylake CPUs without updated microcode,
> 
> The assumption thus far (good or bad) is that everything will get a
> microcode update.  I actually don't know for sure if RSB manipulation is
> effective on old microcode before Skylake.  I'm pretty sure it has not
> been documented publicly.
> 
> How did you decide that this is an effective mitigation?
> 
A RSB overwrite is already being done even on pre-Skylake Intel CPUs on
VMEXIT to protect the host from the guest, regardless of the microcode
version.

But I see that an Intel guidance document published last month about
retpolines says that "RET has this [predictable speculative] behavior on
all processors (...) microarchitecture codename Broadwell and earlier
when updated with the latest microcode".
This suggests that updated microcode may be needed for protection anyway
on such CPUs - as you say.  Such update (hopefully) brings IBPB
support, too, so I agree that the change introduced by this patch can be
skipped on Intel CPUs.

Maciej
