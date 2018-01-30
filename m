Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeA3Ric (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:38:32 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:45252 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeA3Ri3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:38:29 -0500
X-Google-Smtp-Source: AH8x2256tsRr6XJX0ZEYx13onmX0b2RJ7wWU1/+XAA1+Tveux6ilTe0NO2lCZ2XY/Y5ooA1W7cmPRsR5BkuyIFIuuFU=
MIME-Version: 1.0
In-Reply-To: <1517332457.18619.132.camel@infradead.org>
References: <20180109120311.27565-10-pbonzini@redhat.com> <6dc02278-7004-1794-3705-69c8cad86be4@oracle.com>
 <CALMp9eSVC=LO-SrPkA3m6eSpgJ6X4rNCRCf3uvtJEdMG_B72cQ@mail.gmail.com>
 <beb9f9b4-7bc0-4a3a-73c2-0828febbd06c@oracle.com> <CALMp9eT6i9bhG005S5sqV-Y1RUhsc+AXE42ww8Ej+TXSjD6tEg@mail.gmail.com>
 <1517332457.18619.132.camel@infradead.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 30 Jan 2018 09:38:27 -0800
Message-ID: <CALMp9eSkyiL7RsiBb75mDNWzhCbfWM_4e9MAais-uTMeRVy8wQ@mail.gmail.com>
Subject: Re: [9/8] KVM: x86: limit MSR_IA32_SPEC_CTRL access based on CPUID availability
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mihai Carabas <mihai.carabas@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0UHcbZv006346

On Tue, Jan 30, 2018 at 9:14 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2018-01-30 at 08:57 -0800, Jim Mattson wrote:
>> It's really hard to tell which patches are being proposed for which
>> repositories, but assuming that everything else is correct, I don't
>> think your condition is adequate. What if the physical CPU and the
>> virtual CPU both have CPUID.(EAX=7H,ECX=0):EDX[26], but only the
>> physical CPU has CPUID.(EAX=7H,ECX=0):EDX[27]? If the guest has write
>> access to MSR_IA32_SPEC_CTRL, it can set MSR_IA32_SPEC_CTRL[1]
>> (STIBP), even though setting that bit in the guest should raise #GP.
>
> Everything we're talking about here is for tip/x86/pti. Which I note
> has just updated to be 4.15-based, although I thought it was going to
> stay on 4.14 for now. So I've updated my tree at
> http://git.infradead.org/linux-retpoline.git/shortlog/refs/heads/ibpb
> accordingly.
>
> You can always write to the STIBP bit without a #GP even when it's not
> advertised/available.

Oops. Yes, you're right. It's writing the IBRS bit when only STIBP is
available that results in a #GP.

> There's a possibility that we'll want to always trap and *prevent*
> that, instead of passing through — because doing so will also have an
> effect on the HT siblings. But as discussed, I wanted to get the basics
> working before exploring the complex IBRS/STIBP interactions. This much
> should be OK to start with.
