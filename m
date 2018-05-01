Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEAHjH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 03:39:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34902 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeEAHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 03:39:05 -0400
X-Google-Smtp-Source: AB8JxZp7gxDnRB/BRZz6BGdzL1izYhNsQcpQB9I+ffu0pwUUzZbLaITwTd37WEr9EHYFY76AoefLMm5W/afxks26AiE=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
 <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Tue, 1 May 2018 09:39:04 +0200
Message-ID: <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kirill.shutemov@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w417dDhv027102

2018-04-30 21:53 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> Jörg,
>
> On Mon, 30 Apr 2018, Jörg Otte wrote:
>
>> In v4.16 I already had support for BPB, IBRS_FW for spectre_v2 mitigation.
>> But this went away in v17-rcx.
>>
>> With 4.16 I have:
>> jojo@fichte:~$ cd /sys/devices/system/cpu/vulnerabilities; grep ".*" *
>> meltdown:Mitigation: PTI
>> spectre_v1:Mitigation: __user pointer sanitization
>> spectre_v2:Mitigation: Full generic retpoline, IBPB, IBRS_FW
>>
>> With 4.17-rcx I have:
>> meltdown:Mitigation: PTI
>> spectre_v1:Mitigation: __user pointer sanitization
>> spectre_v2:Mitigation: Full generic retpoline
>>
>> Processor is
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 60
>> model name      : Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
>> stepping        : 3
>> microcode       : 0x24
>>
>>
>> The problem goes away if I revert:
>> d94a155 x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption
>
> Does the patch below fix the problem for you?
>
> Thanks,
>
>         tglx
>
> 8<------------------
> Subject: x86/cpu: Restore CPUID_8000_0008_EBX reload
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 30 Apr 2018 21:47:46 +0200
>
> The recent commt which addresses the x86_phys_bits corruption with
> encrypted memory on CPUID reload after a microcode update lost the reload
> of CPUID_8000_0008_EBX as well.
>
> As a consequence IBRS and IBRS_FW are not longer detected
>
> Restore the behaviour by bringing the reload of CPUID_8000_0008_EBX back,.
>
> Fixes: d94a155c59c9 ("x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption")
> Reported-by: Jörg Otte <jrg.otte@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: kirill.shutemov@linux.intel.com
> ---
>  arch/x86/kernel/cpu/common.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -848,6 +848,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>                 c->x86_power = edx;
>         }
>
> +       if (c->extended_cpuid_level >= 0x80000008) {
> +               cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> +               c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> +       }
> +
>         if (c->extended_cpuid_level >= 0x8000000a)
>                 c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
>

No, does not fix it.

Thanks, Jörg
