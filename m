Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeEVMRu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:17:50 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:53597 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbeEVMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:17:46 -0400
X-Google-Smtp-Source: AB8JxZrJ5g24sy29lFwzL8wiTg5HvJSTNYQF2I7fodSVOlfERwDit22Jnl6ZBZqERhnmR565eVRN/DU4R47cgS1GO7c=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUVD8+vRR4uokcuOadjvG99qsHDC6j+Gojemnfo0SXEXNg@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com> <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
 <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
 <CA+icZUVsV=5jvTcXVWqMs6ROhT3mv+7zBOoJ0JkUy5Mf+a4GNw@mail.gmail.com>
 <CA+icZUUfmgJPmmjuaVckvdLwWuWOPDAuFFyLq_ZPkc__LZbtSA@mail.gmail.com>
 <CA+icZUW_wWA9f_obFWOixg2+=W8SN1zPO9KA4u3AXO91uzHEtA@mail.gmail.com>
 <CA+icZUWFskFk6qChPRW6qUdmEAy7r8t=1OKQCuTLyHSczH01vw@mail.gmail.com> <CA+icZUVD8+vRR4uokcuOadjvG99qsHDC6j+Gojemnfo0SXEXNg@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 22 May 2018 14:17:45 +0200
Message-ID: <CA+icZUW14BygHdBC8Ktx1d9Cm3eTcGmmoHH_L1690tjmwATHDA@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Manoj Gupta <manojgupta@chromium.org>,
        AlistairStrachan <astrachan@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of completeness...

[ CLANG VERSION ]

# dpkg -l | grep clang-7
ii  clang-7
1:7~svn332830-1~exp1+0~20180521091322.1776~1.gbp198359 amd64        C,
C++ and Objective-C compiler

[ OBJDUMP native_save_fl() ]

$ objdump -d -S --start-address=0x$(grep native_save_fl System.map |
sed -e "s/ \+.*//") vmlinux | less

vmlinux:     file format elf64-x86-64


Disassembly of section .text:

ffffffff810633a0 <native_save_fl>:
/*
 * Interrupt control:
 */

static inline __nostackprotector unsigned long native_save_fl(void)
{
ffffffff810633a0:       55                      push   %rbp
ffffffff810633a1:       48 89 e5                mov    %rsp,%rbp
ffffffff810633a4:       50                      push   %rax
        /*
         * "=rm" is safe here, because "pop" adjusts the stack before
         * it evaluates its effective address -- this is part of the
         * documented behavior of the "pop" instruction.
         */
        asm volatile("# __raw_save_flags\n\t"
ffffffff810633a5:       9c                      pushfq
ffffffff810633a6:       8f 45 f8                popq   -0x8(%rbp)
                     "pushf ; pop %0"
                     : "=rm" (flags)
                     : /* no input */
                     : "memory");

        return flags;
ffffffff810633a9:       48 8b 45 f8             mov    -0x8(%rbp),%rax
ffffffff810633ad:       48 83 c4 08             add    $0x8,%rsp
ffffffff810633b1:       5d                      pop    %rbp
ffffffff810633b2:       c3                      retq
ffffffff810633b3:       0f 1f 00                nopl   (%rax)
ffffffff810633b6:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
ffffffff810633bd:       00 00 00

ffffffff810633c0 <native_restore_fl>:
}

static inline void native_restore_fl(unsigned long flags)
{
...

- Sedat -
