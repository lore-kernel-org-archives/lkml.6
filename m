Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbeBPKIz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:08:55 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55298 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeBPKIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:08:52 -0500
X-Google-Smtp-Source: AH8x226Ey9Q0aXEmPPHD9JEBMRfwEB8a4M8HdpAH9iD4+DW1EQNl9nlw4bo2Y5RbwNIoRE69Bz3kbw==
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
To: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Cc: Ingo Molnar <mingo@kernel.org>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
 <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
 <1518509708.12890.33.camel@infradead.org>
 <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
 <1518517262.12890.43.camel@infradead.org>
 <1518518198.12890.48.camel@infradead.org>
 <02bd3fdd-1b73-6cab-fb09-38ba933396bd@redhat.com>
 <1518775136.7876.13.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75287047-77a0-e0ff-c2e8-61c81641251e@redhat.com>
Date: Fri, 16 Feb 2018 11:08:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518775136.7876.13.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2018 10:58, David Woodhouse wrote:
> On Tue, 2018-02-13 at 11:41 +0100, Paolo Bonzini wrote:
> 
>> On 13/02/2018 11:36, David Woodhouse wrote:
>>>>> - if the VM has IBRS_ALL, pass through the MSR when it is zero and
>>>>> intercept writes when it is one (no writes should happen)
>>>>>  
>>>>> - if the VM doesn't have IBRS_ALL, do as we are doing now, independent
>>>>> of what the host spectre_v2_ibrs_all() setting is.
>>>>
>>>> We end up having to turn IBRS on again on vmexit then, taking care that
>>>> no conditional branch can go round it. So that becomes an
>>>> *unconditional* wrmsr or lfence in the vmexit path. We really don't
>>>> want that.
>>>>
>>> Note that being able to keep it simple in KVM was basically what made
>>> the difference between me tolerating IBRS_ALL as Intel currently define
>>> it, and throwing my toys out of the pram (as I had done in the first
>>> iterations of this patch).
>>  
>> You have my vote. :) 
> 
> I was taking that as assent to the patch... could I trouble you for an
> explicit ack, please?

No, it's a vote for throwing the toys out of the pram (or running away
with the ball, if you prefer).

Unfortunately, if you want to have a higher-performance mode for
IBRS_ALL that avoids rdmsr on vmexit, you have to do it as sketched above.

Alternatively, if IBRS_ALL is 1, and you don't care about migration
between machines that have IBRS_ALL and those that don't, the host can
simply not enable the SPEC_CTRL CPUID bit in the guest, and instead use
the AMD IBPB flag only.  Need to check if Windows obeys the AMD flag on
Intel machines (or in general) though.

Paolo
