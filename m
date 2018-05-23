Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934449AbeEWWId (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:08:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:45119 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933791AbeEWWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:08:31 -0400
X-Google-Smtp-Source: AB8JxZpyEpXqZvVGpn0lZzOGLIfULAdvDu7gDaPNIQhJnUYB81Dfa6Us1N57tYqyo0iIWCQOcfkWNqmniM1378P8HzE=
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 23 May 2018 15:08:19 -0700
Message-ID: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
Subject: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter,

It was reported [0] that compiling the Linux kernel with Clang +
CC_STACKPROTECTOR_STRONG was causing a crash in native_save_fl(), due to
how GCC does not emit a stack guard for static inline functions (see
Alistair's excellent report in [1]) but Clang does.

When working with the LLVM release maintainers, Tom had suggested [2]
changing the inline assembly constraint in native_save_fl() from '=rm' to
'=r', and Alistair had verified the disassembly:

(good) code generated w/o -fstack-protector-strong:

native_save_fl:
          pushfq
          popq    -8(%rsp)
          movq    -8(%rsp), %rax
          retq

(good) code generated w/ =r input constraint:

native_save_fl:
          pushfq
          popq    %rax
          retq

(bad) code generated with -fstack-protector-strong:

native_save_fl:
          subq    $24, %rsp
          movq    %fs:40, %rax
          movq    %rax, 16(%rsp)
          pushfq
          popq    8(%rsp)
          movq    8(%rsp), %rax
          movq    %fs:40, %rcx
          cmpq    16(%rsp), %rcx
          jne     .LBB0_2
          addq    $24, %rsp
          retq
.LBB0_2:
          callq   __stack_chk_fail

It looks like the sugguestion is actually a revert of your commit:
ab94fcf528d127fcb490175512a8910f37e5b346:
x86: allow "=rm" in native_save_fl()

It seemed like there was a question internally about why worry about pop
adjusting the stack if the stack could be avoided altogether.

I think Sedat can retest this, but I was curious as well about the commit
message in ab94fcf528d: "[ Impact: performance ]", but Alistair's analysis
of the disassembly seems to indicate there is no performance impact (in
fact, looks better as there's one less mov).

Is there a reason we should not revert ab94fcf528d12, or maybe a better
approach?

[0] https://lkml.org/lkml/2018/5/7/534
[1] https://bugs.llvm.org/show_bug.cgi?id=37512#c15
[2] https://bugs.llvm.org/show_bug.cgi?id=37512#c22
-- 
Thanks,
~Nick Desaulniers
