Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEAUOt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:14:49 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:44814 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbeEAUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:14:48 -0400
X-Google-Smtp-Source: AB8JxZryJZJvyRt2uCcCFdPENppn66gOKHHYK0KD8gZC0jbX5w/opTT7ID1nwMgiD+X2G/0t7/tS1533VEHbzVkbc28=
MIME-Version: 1.0
References: <CADDKRnBD=cgptLmDMu0YiaUThO-1ydKaAD4X3sTWfLuP5M5BEw@mail.gmail.com>
 <alpine.DEB.2.21.1804302151530.1596@nanos.tec.linutronix.de>
 <CADDKRnAi69PFNH-hyxCTLckJ5UU6-DKWvzGNzxZZhD0sA215qg@mail.gmail.com> <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1805011458390.1596@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 01 May 2018 20:14:37 +0000
Message-ID: <CA+55aFxKbPDrMQssyEtOnYZqE8HcOo=Zx6ASty6CybhwPfT9_g@mail.gmail.com>
Subject: Re: [v4.17-rcx] Lost IBPB, IBRS_FW support for spectre_v2 mitigation.
To: Thomas Gleixner <tglx@linutronix.de>
Cc: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w41KEuY9014597

On Tue, May 1, 2018 at 5:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> Then I really have no idea how reverting the patch you pointed out would
> fix it.

So I do think that the original patch is buggy.

What I think *may* be going on is:

  - first we do that

                 get_cpu_cap(c);
                 get_cpu_address_sizes(c);

     but at that point, CPU levels may be masked, and that 0x80000008 leaf
isn't seen

  - then we do

                 if (this_cpu->c_early_init)
                         this_cpu->c_early_init(c);

    which calls early_init_intel(), which does that

                 if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
                                   MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) >
0) {

    which now raises the cpuid_level.

  - then we do

                         get_cpu_cap(c);

    again, because the cpuid level has been raised, and _now_ it used to get
that 0x80000008 leaf information.

But with the change, that second call to get_cpu_cap() didn't do anything,
because the 0x80000008 leaf handling had been moved away.

However, I agree that your patch to just do that CPUID_8000_0008_EBX in
get_cpu_cap() should have fixed it, and it's possible that Jörg mis-tested
it.

Jörg, are you sure you didn't somehow get the wrong microcode? Because
another way for those bits to be cleared again is if
bad_spectre_microcode() triggers. That should show up in dmesg as "Intel
Spectre v2 broken microcode detected" though.

            Linus
