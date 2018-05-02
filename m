Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBMVB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:21:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53579 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeEBMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:20:56 -0400
Date: Wed, 2 May 2018 14:20:52 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: =?ISO-8859-15?Q?J=F6rg_Otte?= <jrg.otte@gmail.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2
 mitigation.
In-Reply-To: <CADDKRnBn7rNN9UrwtYvNDPeJxqNQ-WHQVyHXAV7RwcVxX7jSDw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805021418550.1560@nanos.tec.linutronix.de>
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com> <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de> <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com> <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
 <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com> <CADDKRnC1V3KUR__PAo_JhMVdaWknQ9x1_XAQNewUWuO3cqFFFg@mail.gmail.com> <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
 <CADDKRnBn7rNN9UrwtYvNDPeJxqNQ-WHQVyHXAV7RwcVxX7jSDw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-528394742-1525263652=:1560"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-528394742-1525263652=:1560
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 2 May 2018, Jörg Otte wrote:
> 2018-05-02 11:02 GMT+02:00 Thomas Gleixner <tglx@linutronix.de>:
> > Ok, I think I know what's going wrong in that steaming pile of horrors of
> > CPUID detection. I need to analyze it down to the roots, but if you have
> > cycles, can you please test the patch below?
> >
> > It's a hack and even if it fixes the problem I'm going to do it differently.
> >
> > Thanks,
> >
> >         tglx
> >
> > 8<-------------------
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -848,6 +848,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
> >                 c->x86_power = edx;
> >         }
> >
> > +       if (c->extended_cpuid_level >= 0x80000008) {
> > +               cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> > +               c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> > +       }
> > +
> >         if (c->extended_cpuid_level >= 0x8000000a)
> >                 c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
> >
> > @@ -871,7 +876,6 @@ static void get_cpu_address_sizes(struct
> >
> >                 c->x86_virt_bits = (eax >> 8) & 0xff;
> >                 c->x86_phys_bits = eax & 0xff;
> > -               c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> >         }
> >  #ifdef CONFIG_X86_32
> >         else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
> >
> 
> OK, that patch works for me!

Thanks for confirming. Still need to find a way which is less fragile, but
that's probably too much of churn for rc4....

At least I know exactly what's happening, so I can write a better changelog.

Thanks for testing!

       tglx
--8323329-528394742-1525263652=:1560--
