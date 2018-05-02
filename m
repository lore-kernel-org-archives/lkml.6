Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeEBXiC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:38:02 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42311 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeEBXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:38:00 -0400
X-Google-Smtp-Source: AB8JxZryL0nwgWE1/SpeswmuwuqNlQR4RnFUCBj/RfZndvb+Vcc3nW8HV550ynfVPYvQgUHI5U/NsijH/kX18r0aTSw=
MIME-Version: 1.0
In-Reply-To: <4b7e94c1-79c9-0380-25c6-762762ed595f@redhat.com>
References: <20180502203326.9491-1-labbott@redhat.com> <20180502203326.9491-3-labbott@redhat.com>
 <CAGXu5jK1_--omGSqz03sfB8twQVzy9ZQR9Xzi-uxseekp+r1jQ@mail.gmail.com> <4b7e94c1-79c9-0380-25c6-762762ed595f@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 16:37:58 -0700
X-Google-Sender-Auth: V9OVJKwiw_c1OB5aX4DXWKnuBn0
Message-ID: <CAGXu5j+LP8Yq8R=FUUA1TX2gD5G5xaYNVkt56aezZ_GLpxn69g@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Clear the stack
To: Laura Abbott <labbott@redhat.com>
Cc: Alexander Popov <alex.popov@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 4:07 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 05/02/2018 02:31 PM, Kees Cook wrote:
>> struct stackleak {
>> #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>         unsigned long           lowest;
>> #ifdef CONFIG_STACKLEAK_METRICS
>>         unsigned long           prev_lowest;
>> #endif
>> #endif
>> };
>>
>
> Is this well defined across all compilers if the plugin is off?
> This seems to compile with gcc at least but 0 sized structs
> make me a little uneasy.

Yup! Or at least, there have been no problems with this and the
seccomp struct, which is empty when !CONFIG_SECCOMP.

>> This is the only difference between x86 and arm64 in this code. What
>> do you think about implementing on_thread_stack() to match x86:
>>
>>          if (on_thread_stack())
>>                  boundary = current_stack_pointer;
>>          else
>>                  boundary = current_top_of_stack();
>>
>> then we could make this common code too instead of having two copies in
>> arch/?
>>
>
> The issue isn't on_thread_stack, it's current_top_of_stack which isn't
> defined on arm64. I agree it would be good if the code would be common
> but I'm not sure how much we want to start trying to force APIs.

Ah, gotcha. Well, I'd rather we had an #ifdef here that two copies of
the code. ;)

>>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>>> +void __used check_alloca(unsigned long size)
>>> +{
>>> +       unsigned long sp, stack_left;
>>> +
>>> +       sp = current_stack_pointer;
>>> +
>>> +       stack_left = sp & (THREAD_SIZE - 1);
>>> +       BUG_ON(stack_left < 256 || size >= stack_left - 256);
>>> +}
>>> +EXPORT_SYMBOL(check_alloca);
>>
>>
>> This is pretty different from x86. Is this just an artifact of ORC, or
>> something else?
>>
>
> This was based on the earlier version of x86. I'll confess to
> not seeing how the current x86 version ended up with get_stack_info
> but I suspect it's either related to ORC unwinding or it's best
> practice.

Alexander, what was the history here?

-Kees

-- 
Kees Cook
Pixel Security
