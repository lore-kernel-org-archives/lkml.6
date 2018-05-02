Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeEBHne (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:43:34 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46875 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeEBHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:43:33 -0400
X-Google-Smtp-Source: AB8JxZp42qRzCccLonmCSkM7IN66zSqhc3emis87tuP2qgVDVb/pjZpz7OplvWqT0BwzE2R9VTYJLH2TsDyc7J9dg2o=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
 <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
 <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com>
 <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de> <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date: Wed, 2 May 2018 09:43:31 +0200
Message-ID: <CADDKRnC1V3KUR__PAo_JhMVdaWknQ9x1_XAQNewUWuO3cqFFFg@mail.gmail.com>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w427hfA1027833

2018-05-01 22:14 GMT+02:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Tue, May 1, 2018 at 5:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Then I really have no idea how reverting the patch you pointed out would
>> fix it.
>
> So I do think that the original patch is buggy.
>
> What I think *may* be going on is:
>
>   - first we do that
>
>                  get_cpu_cap(c);
>                  get_cpu_address_sizes(c);
>
>      but at that point, CPU levels may be masked, and that 0x80000008 leaf
> isn't seen
>
>   - then we do
>
>                  if (this_cpu->c_early_init)
>                          this_cpu->c_early_init(c);
>
>     which calls early_init_intel(), which does that
>
>                  if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
>                                    MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) >
> 0) {
>
>     which now raises the cpuid_level.
>
>   - then we do
>
>                          get_cpu_cap(c);
>
>     again, because the cpuid level has been raised, and _now_ it used to get
> that 0x80000008 leaf information.
>
> But with the change, that second call to get_cpu_cap() didn't do anything,
> because the 0x80000008 leaf handling had been moved away.
>
> However, I agree that your patch to just do that CPUID_8000_0008_EBX in
> get_cpu_cap() should have fixed it, and it's possible that Jörg mis-tested
> it.
>
> Jörg, are you sure you didn't somehow get the wrong microcode? Because
> another way for those bits to be cleared again is if
> bad_spectre_microcode() triggers. That should show up in dmesg as "Intel
> Spectre v2 broken microcode detected" though.
>
>             Linus

I downloaded microcode from Intel.
Here are the excerpts from dmesg:

With revert:

jojo@fichte:~$ dmesg | grep -i -e spec -e micro -e "Linux version"

[    0.000000] microcode: microcode updated early to revision 0x24,
date = 2018-01-21
[    0.000000] Linux version 4.17.0-rc3-revert-00001-gcb1069f
(jojo@fichte) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubu

dmesg | grep -i -e spec -e micro -e "Linux version"

[    0.000000] microcode: microcode updated early to revision 0x24,
date = 2018-01-21
[    0.000000] Linux version 4.17.0-rc3-patch-00001-gdc10603
(jojo@fichte) (gcc version 5.4.0 20160609 (Ubuntu
5.4.0-6ubuntu1~16.04.9)) #20 SMP Wed May 2 09:08:07 CEST 2018
[    0.028417] Spectre V2 : Mitigation: Full generic retpoline
[    0.491803] microcode: sig=0x306c3, pf=0x10, revision=0x24
[    0.491831] microcode: Microcode Update Driver: v2.2.ntu1~16.04.9))
#21 SMP Wed May 2 09:14:29 CEST 2018
[    0.028414] Spectre V2 : Mitigation: Full generic retpoline
[    0.028415] Spectre V2 : Spectre v2 mitigation: Enabling Indirect
Branch Prediction Barrier
[    0.028415] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.500157] microcode: sig=0x306c3, pf=0x10, revision=0x24
[    0.500183] microcode: Microcode Update Driver: v2.2.


With patch:

dmesg | grep -i -e spec -e micro -e "Linux version"

[    0.000000] microcode: microcode updated early to revision 0x24,
date = 2018-01-21
[    0.000000] Linux version 4.17.0-rc3-patch-00001-gdc10603
(jojo@fichte) (gcc version 5.4.0 20160609 (Ubuntu
5.4.0-6ubuntu1~16.04.9)) #20 SMP Wed May 2 09:08:07 CEST 2018
[    0.028417] Spectre V2 : Mitigation: Full generic retpoline
[    0.491803] microcode: sig=0x306c3, pf=0x10, revision=0x24
[    0.491831] microcode: Microcode Update Driver: v2.2.

Thanks, Jörg
