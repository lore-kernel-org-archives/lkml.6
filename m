Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967202AbeCAJpa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:45:30 -0500
Received: from foss.arm.com ([217.140.101.70]:34342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967187AbeCAJp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:45:27 -0500
Subject: Re: Clang build of arm64 kernel fails
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, ard.biesheuvel@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d601e0ca-dd91-3dd4-c610-dd2ae49aa1b6@arm.com>
Date: Thu, 1 Mar 2018 09:45:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 28/02/18 19:32, Andrey Konovalov wrote:
> Hi Marc!
> 
> I've tried to pull in new upstream commits and the kernel build
> started failing for me with the following errors (see below).
> 
> It seems that the reason is your commit "arm64: Add
> ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
> doesn't like 32 bits registers being used in 64 bits build.

I'd say this is really a bug in Clang. Architecturally, the register in 
AArch64 state is still named "r0"; "x0"/"w0" are assembler operands 
which additionally encode the size of the corresponding *access* to r0.

I note that GCC's documentation on register variables[1] does just say 
"the name of the register", which implies this code is not incorrect. 
Given that Clang already likes to infer the operand size from the 
argument type in actual inline asms, it seems funny that its register 
allocator should care in this non-instruction context.

> Would you mind sending a fix?

That said, I guess it's a bug we might have to work around anyway. Oh well.

Robin.

[1] 
https://gcc.gnu.org/onlinedocs/gcc/Global-Register-Variables.html#Global-Register-Variables

> 
> Thanks!
> 
> arch/arm64/kernel/cpu_errata.c:156:2: error: unknown register name 'r0' in asm
>          arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
>          ^
> ./include/linux/arm-smccc.h:276:32: note: expanded from macro
> 'arm_smccc_1_1_smc'
> #define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
>                                  ^
> ./include/linux/arm-smccc.h:255:3: note: expanded from macro '__arm_smccc_1_1'
>                  __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
>                  ^
> ./include/linux/arm-smccc.h:240:37: note: expanded from macro '__declare_args'
> #define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
>                                      ^
> ./include/linux/arm-smccc.h:239:37: note: expanded from macro '___declare_args'
> #define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
>                                      ^
> <scratch space>:136:1: note: expanded from here
> __declare_arg_0
> ^
> ./include/linux/arm-smccc.h:197:32: note: expanded from macro '__declare_arg_0'
>          register u32           r0 asm("r0") = a0;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
