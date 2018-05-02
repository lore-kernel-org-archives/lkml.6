Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEBJZf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:25:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54927 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeEBJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:25:31 -0400
X-Google-Smtp-Source: AB8JxZph3WcgMWGz3UnzrjDuCTYa7RGgc7JgAL+AZY2WZC3D96uUvv/yC1hF036tv11OTgUMmNCYr125SRovx7SFEVA=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
 <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
 <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
 <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
 <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
 <CADDKRnC1V3KUR__PAo_JhMVdaWknQ9x1_XAQNewUWuO3cqFFFg@mail.gmail.com> <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Wed, 2 May 2018 11:25:29 +0200
Message-ID: <CADDKRnBn7rNN9UrwtYvNDPeJxqNQ-WHQVyHXAV7RwcVxX7jSDw@mail.gmail.com>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w429PeQu002765

2018-05-02 11:02 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> On Wed, 2 May 2018, Jörg Otte wrote:
>> With revert:
>>
>> jojo@fichte:~$ dmesg | grep -i -e spec -e micro -e "Linux version"
>>
>> [    0.000000] microcode: microcode updated early to revision 0x24,
>> date = 2018-01-21
>> [    0.000000] Linux version 4.17.0-rc3-revert-00001-gcb1069f
>> (jojo@fichte) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubu
>>
>> dmesg | grep -i -e spec -e micro -e "Linux version"
>>
>> [    0.000000] microcode: microcode updated early to revision 0x24,
>> date = 2018-01-21
>> [    0.000000] Linux version 4.17.0-rc3-patch-00001-gdc10603
>> (jojo@fichte) (gcc version 5.4.0 20160609 (Ubuntu
>> 5.4.0-6ubuntu1~16.04.9)) #20 SMP Wed May 2 09:08:07 CEST 2018
>> [    0.028417] Spectre V2 : Mitigation: Full generic retpoline
>> [    0.491803] microcode: sig=0x306c3, pf=0x10, revision=0x24
>> [    0.491831] microcode: Microcode Update Driver: v2.2.ntu1~16.04.9))
>> #21 SMP Wed May 2 09:14:29 CEST 2018
>> [    0.028414] Spectre V2 : Mitigation: Full generic retpoline
>> [    0.028415] Spectre V2 : Spectre v2 mitigation: Enabling Indirect
>> Branch Prediction Barrier
>> [    0.028415] Spectre V2 : Enabling Restricted Speculation for firmware calls
>> [    0.500157] microcode: sig=0x306c3, pf=0x10, revision=0x24
>> [    0.500183] microcode: Microcode Update Driver: v2.2.
>>
>>
>> With patch:
>>
>> dmesg | grep -i -e spec -e micro -e "Linux version"
>>
>> [    0.000000] microcode: microcode updated early to revision 0x24,
>> date = 2018-01-21
>> [    0.000000] Linux version 4.17.0-rc3-patch-00001-gdc10603
>> (jojo@fichte) (gcc version 5.4.0 20160609 (Ubuntu
>> 5.4.0-6ubuntu1~16.04.9)) #20 SMP Wed May 2 09:08:07 CEST 2018
>> [    0.028417] Spectre V2 : Mitigation: Full generic retpoline
>> [    0.491803] microcode: sig=0x306c3, pf=0x10, revision=0x24
>> [    0.491831] microcode: Microcode Update Driver: v2.2.
>
> Ok, I think I know what's going wrong in that steaming pile of horrors of
> CPUID detection. I need to analyze it down to the roots, but if you have
> cycles, can you please test the patch below?
>
> It's a hack and even if it fixes the problem I'm going to do it differently.
>
> Thanks,
>
>         tglx
>
> 8<-------------------
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
> @@ -871,7 +876,6 @@ static void get_cpu_address_sizes(struct
>
>                 c->x86_virt_bits = (eax >> 8) & 0xff;
>                 c->x86_phys_bits = eax & 0xff;
> -               c->x86_capability[CPUID_8000_0008_EBX] = ebx;
>         }
>  #ifdef CONFIG_X86_32
>         else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
>

OK, that patch works for me!

Thanks, Jörg
