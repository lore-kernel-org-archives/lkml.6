Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeD3Skp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:40:45 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:37449 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeD3Sko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:40:44 -0400
X-Google-Smtp-Source: AB8JxZoudAuybLjYifMlEmsMOFJIkuTiFoxIfPVa2+WZ+tr+PXbHJCkGO2d2tNk9BxlrxJ9QqSsXOH8ZDXBEivRduqc=
MIME-Version: 1.0
In-Reply-To: <e87810b2-db26-ee13-731a-cde53185e977@redhat.com>
References: <1525103946-29526-1-git-send-email-jhugo@codeaurora.org> <e87810b2-db26-ee13-731a-cde53185e977@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 11:40:42 -0700
X-Google-Sender-Auth: a0E9yUOmft--KMTEz5wOskoYXTU
Message-ID: <CAGXu5jJFjH4hiRqovOtaMOuKUQbGYWjBiGGDV-bjWSmTvZp9Pw@mail.gmail.com>
Subject: Re: [PATCH v3] init: Fix false positives in W+X checking
To: Laura Abbott <labbott@redhat.com>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Timur Tabi <timur@codeaurora.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:19 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 04/30/2018 08:59 AM, Jeffrey Hugo wrote:
>>
>> load_module() creates W+X mappings via __vmalloc_node_range() (from
>> layout_and_allocate()->move_module()->module_alloc()) by using
>> PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
>> "call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().
>>
>> This is a problem because call_rcu_sched() queues work, which can be run
>> after debug_checkwx() is run, resulting in a race condition.  If hit, the
>> race results in a nasty splat about insecure W+X mappings, which results
>> in a poor user experience as these are not the mappings that
>> debug_checkwx() is intended to catch.
>>
>> This issue is observed on multiple arm64 platforms, and has been
>> artificially triggered on an x86 platform.
>>
>> Address the race by flushing the queued work before running the
>> arch-defined mark_rodata_ro() which then calls debug_checkwx().
>>
>> Reported-by: Timur Tabi <timur@codeaurora.org>
>> Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
>> Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> ---
>>
>
> Acked-by: Laura Abbott <labbott@redhat.com>
>
> If you don't have a tree for this to go through, I might suggest having
> Kees take it.

akpm has taken the W^X stuff in the past, but I'm happy to do so. Just
let me know either way. :)

-Kees

-- 
Kees Cook
Pixel Security
