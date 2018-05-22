Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeEVIti (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:49:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39169 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeEVIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:49:37 -0400
X-Google-Smtp-Source: AB8JxZrUcDsx0T6hZ0lubKcvMXUSPYMeiS81Gux2xDY8wxW6nwFvzVdb5TecIaB23YhrWVTq6wabFHcEuVhQSzxywNU=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUUfmgJPmmjuaVckvdLwWuWOPDAuFFyLq_ZPkc__LZbtSA@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com> <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
 <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
 <CA+icZUVsV=5jvTcXVWqMs6ROhT3mv+7zBOoJ0JkUy5Mf+a4GNw@mail.gmail.com> <CA+icZUUfmgJPmmjuaVckvdLwWuWOPDAuFFyLq_ZPkc__LZbtSA@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 22 May 2018 10:49:35 +0200
Message-ID: <CA+icZUW_wWA9f_obFWOixg2+=W8SN1zPO9KA4u3AXO91uzHEtA@mail.gmail.com>
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

On Tue, May 22, 2018 at 10:04 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Tue, May 22, 2018 at 9:39 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On Sat, May 19, 2018 at 12:54 AM, Nick Desaulniers
>> <nick.desaulniers@gmail.com> wrote:
>>> Sedat,
>>> Thanks for the report.  We have a fix ready in
>>> https://bugs.llvm.org/show_bug.cgi?id=37512.  Can you report what
>>> version of clang you were using and if earlier versions of clang have
>>> this issue?
>>> Thanks,
>>
>> Can you give some advices on how to implement
>> "attribute((no_stack_protector))" for Clang?
>>
>> I looked on how this is done for GCC...
>>
>> [ include/linux/compiler-gcc.h ]
>>
>> #if GCC_VERSION >= 40400
>> #define __optimize(level)       __attribute__((__optimize__(level)))
>> #define __nostackprotector      __optimize("no-stack-protector")
>> #endif /* GCC_VERSION >= 40400 */
>>
>> [ include/linux/compiler_types.h ]
>>
>> #ifndef __nostackprotector
>> # define __nostackprotector
>> #endif
>>
>> LLVM-bug #37512 says:
>>
>> "GCC option for this is: attribute((optimize("no-stack-protector")))
>> and the equivalent clang syntax would be: attribute((no_stack_protector))"
>>
>> So, there should be a define in "include/linux/compiler-clang.h" for this?
>>
>> [ include/linux/compiler-clang.h ]
>>
>> #define __nostackprotector attribute((no_stack_protector))
>>
>> Looks that good to you?
>>
>
> I am trying with the attached files and...
>
> CONFIG_PARAVIRT=y
> CONFIG_CC_STACKPROTECTOR_STRONG=y
>

Hmmm, I get these errors in my build-log...

  mycompiler -Wp,-MD,arch/x86/kernel/.asm-offsets.s.d  -nostdinc
-isystem /usr/lib/llvm-7/lib/clang/7.0.0/include -I./arch/x86/include
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
-I./arch/x86/include/generated/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/kconfig.h
-D__KERNEL__ -Qunused-arguments -Wall -Wundef -Wstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar
-Werror-implicit-function-declaration -Wno-format-security -std=gnu89
-fno-PIE -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64
-mno-80387 -mstack-alignment=8 -mtune=generic -mno-red-zone
-mcmodel=kernel -funit-at-a-time -DCONFIG_AS_CFI=1
-DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1
-DCONFIG_AS_FXSAVEQ=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_CRC32=1
-DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1
-DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -pipe -Wno-sign-compare
-fno-asynchronous-unwind-tables -mretpoline-external-thunk -DRETPOLINE
-O2 -Wframe-larger-than=2048 -fstack-protector-strong
-Wno-unused-variable -Wno-format-invalid-specifier -Wno-gnu
-Wno-address-of-packed-member -Wno-tautological-compare
-mno-global-merge -no-integrated-as -g -pg -mfentry -DCC_USING_FENTRY
-Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
-fno-merge-all-constants -fno-stack-check -Werror=implicit-int
-Werror=strict-prototypes -Werror=date-time
-Werror=incompatible-pointer-types -Wno-initializer-overrides
-Wno-unused-value -Wno-format -Wno-sign-compare
-Wno-format-zero-length -Wno-uninitialized
-DKBUILD_BASENAME='"asm_offsets"'  -DKBUILD_MODNAME='"asm_offsets"'
-fverbose-asm -S -o arch/x86/kernel/asm-offsets.s
arch/x86/kernel/asm-offsets.c
In file included from arch/x86/kernel/asm-offsets.c:9:
In file included from ./include/linux/crypto.h:24:
In file included from ./include/linux/slab.h:15:
In file included from ./include/linux/gfp.h:6:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:51:
In file included from ./include/linux/preempt.h:81:
In file included from ./arch/x86/include/asm/preempt.h:7:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
In file included from ./arch/x86/include/asm/processor.h:33:
In file included from ./include/linux/irqflags.h:16:
./arch/x86/include/asm/irqflags.h:16:29: warning: declaration
specifier missing, defaulting to 'int'
static inline unsigned long __nostackprotector native_save_fl(void)
                            ^
./include/linux/compiler-clang.h:28:39: note: expanded from macro
'__nostackprotector'
#define __nostackprotector attribute((no_stack_protector))
                                      ^
In file included from arch/x86/kernel/asm-offsets.c:9:
In file included from ./include/linux/crypto.h:24:
In file included from ./include/linux/slab.h:15:
In file included from ./include/linux/gfp.h:6:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:51:
In file included from ./include/linux/preempt.h:81:
In file included from ./arch/x86/include/asm/preempt.h:7:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
In file included from ./arch/x86/include/asm/processor.h:33:
In file included from ./include/linux/irqflags.h:16:
./arch/x86/include/asm/irqflags.h:16:48: error: expected function body
after function declarator
static inline unsigned long __nostackprotector native_save_fl(void)
                                               ^
In file included from arch/x86/kernel/asm-offsets.c:9:
In file included from ./include/linux/crypto.h:24:
In file included from ./include/linux/slab.h:15:
In file included from ./include/linux/gfp.h:6:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:51:
In file included from ./include/linux/preempt.h:81:
In file included from ./arch/x86/include/asm/preempt.h:7:
In file included from ./include/linux/thread_info.h:38:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
./arch/x86/include/asm/processor.h:76:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lli_4k[NR_INFO];
                                    ^
./arch/x86/include/asm/processor.h:77:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lli_2m[NR_INFO];
                                    ^
./arch/x86/include/asm/processor.h:78:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lli_4m[NR_INFO];
                                    ^
./arch/x86/include/asm/processor.h:79:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lld_4k[NR_INFO];
                                    ^
./arch/x86/include/asm/processor.h:80:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lld_2m[NR_INFO];
                                    ^
./arch/x86/include/asm/processor.h:81:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lld_4m[NR_INFO];
                                    ^
./arch/x86/include/asm/processor.h:82:37: error: use of undeclared
identifier 'NR_INFO'
extern u16 __read_mostly tlb_lld_1g[NR_INFO];
                                    ^
1 warning and 8 errors generated.
Kbuild:57: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
make[3]: *** [arch/x86/kernel/asm-offsets.s] Error 1
Makefile:1085: recipe for target 'prepare0' failed
make[2]: *** [prepare0] Error 2
scripts/package/Makefile:91: recipe for target 'bindeb-pkg' failed
make[1]: *** [bindeb-pkg] Error 2
Makefile:1367: recipe for target 'bindeb-pkg' failed
make: *** [bindeb-pkg] Error 2

- Sedat -
