Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeD3Uty (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:49:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754872AbeD3Utw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:49:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CD2E60271
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3] init: Fix false positives in W+X checking
To: Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Timur Tabi <timur@codeaurora.org>, Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <1525103946-29526-1-git-send-email-jhugo@codeaurora.org>
 <e87810b2-db26-ee13-731a-cde53185e977@redhat.com>
 <CAGXu5jJFjH4hiRqovOtaMOuKUQbGYWjBiGGDV-bjWSmTvZp9Pw@mail.gmail.com>
From: Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <2fd6b503-17b9-4e4c-e3ea-44eb34d209e9@codeaurora.org>
Date: Mon, 30 Apr 2018 14:49:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJFjH4hiRqovOtaMOuKUQbGYWjBiGGDV-bjWSmTvZp9Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/2018 12:40 PM, Kees Cook wrote:
> On Mon, Apr 30, 2018 at 10:19 AM, Laura Abbott <labbott@redhat.com> wrote:
>> On 04/30/2018 08:59 AM, Jeffrey Hugo wrote:
>>>
>>> load_module() creates W+X mappings via __vmalloc_node_range() (from
>>> layout_and_allocate()->move_module()->module_alloc()) by using
>>> PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
>>> "call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().
>>>
>>> This is a problem because call_rcu_sched() queues work, which can be run
>>> after debug_checkwx() is run, resulting in a race condition.  If hit, the
>>> race results in a nasty splat about insecure W+X mappings, which results
>>> in a poor user experience as these are not the mappings that
>>> debug_checkwx() is intended to catch.
>>>
>>> This issue is observed on multiple arm64 platforms, and has been
>>> artificially triggered on an x86 platform.
>>>
>>> Address the race by flushing the queued work before running the
>>> arch-defined mark_rodata_ro() which then calls debug_checkwx().
>>>
>>> Reported-by: Timur Tabi <timur@codeaurora.org>
>>> Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
>>> Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>> Acked-by: Kees Cook <keescook@chromium.org>
>>> Acked-by: Ingo Molnar <mingo@kernel.org>
>>> Acked-by: Will Deacon <will.deacon@arm.com>
>>> ---
>>>
>>
>> Acked-by: Laura Abbott <labbott@redhat.com>
>>
>> If you don't have a tree for this to go through, I might suggest having
>> Kees take it.
> 
> akpm has taken the W^X stuff in the past, but I'm happy to do so. Just
> let me know either way. :)
> 
> -Kees
> 

That sounds fine to me.  Is that agreeable to you, Andrew?

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
