Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032554AbeEXSUK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:20:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60321 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030261AbeEXSUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:20:08 -0400
Date: Thu, 24 May 2018 11:19:55 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
CC: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <57C635C3-716C-4FC3-90C7-E394AA7242BA@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2018 3:08:19 PM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>H. Peter,
>
>It was reported [0] that compiling the Linux kernel with Clang +
>CC_STACKPROTECTOR_STRONG was causing a crash in native_save_fl(), due
>to
>how GCC does not emit a stack guard for static inline functions (see
>Alistair's excellent report in [1]) but Clang does.
>
>When working with the LLVM release maintainers, Tom had suggested [2]
>changing the inline assembly constraint in native_save_fl() from '=rm'
>to
>'=r', and Alistair had verified the disassembly:
>
>(good) code generated w/o -fstack-protector-strong:
>
>native_save_fl:
>          pushfq
>          popq    -8(%rsp)
>          movq    -8(%rsp), %rax
>          retq
>
>(good) code generated w/ =r input constraint:
>
>native_save_fl:
>          pushfq
>          popq    %rax
>          retq
>
>(bad) code generated with -fstack-protector-strong:
>
>native_save_fl:
>          subq    $24, %rsp
>          movq    %fs:40, %rax
>          movq    %rax, 16(%rsp)
>          pushfq
>          popq    8(%rsp)
>          movq    8(%rsp), %rax
>          movq    %fs:40, %rcx
>          cmpq    16(%rsp), %rcx
>          jne     .LBB0_2
>          addq    $24, %rsp
>          retq
>.LBB0_2:
>          callq   __stack_chk_fail
>
>It looks like the sugguestion is actually a revert of your commit:
>ab94fcf528d127fcb490175512a8910f37e5b346:
>x86: allow "=rm" in native_save_fl()
>
>It seemed like there was a question internally about why worry about
>pop
>adjusting the stack if the stack could be avoided altogether.
>
>I think Sedat can retest this, but I was curious as well about the
>commit
>message in ab94fcf528d: "[ Impact: performance ]", but Alistair's
>analysis
>of the disassembly seems to indicate there is no performance impact (in
>fact, looks better as there's one less mov).
>
>Is there a reason we should not revert ab94fcf528d12, or maybe a better
>approach?
>
>[0] https://lkml.org/lkml/2018/5/7/534
>[1] https://bugs.llvm.org/show_bug.cgi?id=37512#c15
>[2] https://bugs.llvm.org/show_bug.cgi?id=37512#c22

A stack canary on an *inlined* function? That's bound to break things elsewhere too sooner or later.

It feels like *once again* clang is asking for the Linux kernel to change to paper over technical or compatibility problems in clang/LLVM. This is not exactly helping the feeling that we should just rip out any and all clang hacks and call it a loss.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
