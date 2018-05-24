Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971275AbeEXTuB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971121AbeEXTt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:49:57 -0400
Reply-To: tstellar@redhat.com
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com, Nick Desaulniers <ndesaulniers@google.com>
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <57C635C3-716C-4FC3-90C7-E394AA7242BA@zytor.com>
From: Tom Stellard <tstellar@redhat.com>
Organization: Red Hat
Message-ID: <195ec03a-0ccb-43f2-e455-c61b91aaf9eb@redhat.com>
Date: Thu, 24 May 2018 12:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <57C635C3-716C-4FC3-90C7-E394AA7242BA@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 11:19 AM, hpa@zytor.com wrote:
> On May 23, 2018 3:08:19 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> H. Peter,
>>
>> It was reported [0] that compiling the Linux kernel with Clang +
>> CC_STACKPROTECTOR_STRONG was causing a crash in native_save_fl(), due
>> to
>> how GCC does not emit a stack guard for static inline functions (see
>> Alistair's excellent report in [1]) but Clang does.
>>
>> When working with the LLVM release maintainers, Tom had suggested [2]
>> changing the inline assembly constraint in native_save_fl() from '=rm'
>> to
>> '=r', and Alistair had verified the disassembly:
>>
>> (good) code generated w/o -fstack-protector-strong:
>>
>> native_save_fl:
>>          pushfq
>>          popq    -8(%rsp)
>>          movq    -8(%rsp), %rax
>>          retq
>>
>> (good) code generated w/ =r input constraint:
>>
>> native_save_fl:
>>          pushfq
>>          popq    %rax
>>          retq
>>
>> (bad) code generated with -fstack-protector-strong:
>>
>> native_save_fl:
>>          subq    $24, %rsp
>>          movq    %fs:40, %rax
>>          movq    %rax, 16(%rsp)
>>          pushfq
>>          popq    8(%rsp)
>>          movq    8(%rsp), %rax
>>          movq    %fs:40, %rcx
>>          cmpq    16(%rsp), %rcx
>>          jne     .LBB0_2
>>          addq    $24, %rsp
>>          retq
>> .LBB0_2:
>>          callq   __stack_chk_fail
>>
>> It looks like the sugguestion is actually a revert of your commit:
>> ab94fcf528d127fcb490175512a8910f37e5b346:
>> x86: allow "=rm" in native_save_fl()
>>
>> It seemed like there was a question internally about why worry about
>> pop
>> adjusting the stack if the stack could be avoided altogether.
>>
>> I think Sedat can retest this, but I was curious as well about the
>> commit
>> message in ab94fcf528d: "[ Impact: performance ]", but Alistair's
>> analysis
>> of the disassembly seems to indicate there is no performance impact (in
>> fact, looks better as there's one less mov).
>>
>> Is there a reason we should not revert ab94fcf528d12, or maybe a better
>> approach?
>>
>> [0] https://lkml.org/lkml/2018/5/7/534
>> [1] https://bugs.llvm.org/show_bug.cgi?id=37512#c15
>> [2] https://bugs.llvm.org/show_bug.cgi?id=37512#c22
> 
> A stack canary on an *inlined* function? That's bound to break things elsewhere too sooner or later.
> 
> It feels like *once again* clang is asking for the Linux kernel to change to paper over technical or compatibility problems in clang/LLVM. This is not exactly helping the feeling that we should just rip out any and all clang hacks and call it a loss.
> 

In this case this fix is working-around a bug in the kernel.  The problem
here is that the caller of native_save_fl() assumes that it won't
clobber any of the general purpose register even though the function
is defined as a normal c function which tells the compiler that it's
OK to clobber the registers.

This is something that really needs to be fixed in the kernel.  Relying
on heuristics of internal compiler algorithms in order for code to work
correctly is always going to lead to problems like this.

-Tom
