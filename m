Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032413AbeBOAqu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 19:46:50 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:36992 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032298AbeBOAqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 19:46:48 -0500
X-Google-Smtp-Source: AH8x227CGP903BnJnRyZmrYWn/47NqjCmTEXR3qA3Sp+oFDVxWC6UlbWl/9DBKpx/spqgcoZwtwml7+XejpLbFpp+nI=
MIME-Version: 1.0
In-Reply-To: <1518650958-550-2-git-send-email-dwmw@amazon.co.uk>
References: <1518650958-550-1-git-send-email-dwmw@amazon.co.uk> <1518650958-550-2-git-send-email-dwmw@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Feb 2018 16:46:46 -0800
Message-ID: <CALMp9eRk8WvcALB4wHKo+P=dv2Xs9os6=15g_bL2Uy5+4uPTJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/speculation: Use IBRS if available before
 calling into firmware
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 3:29 PM, David Woodhouse <dwmw@amazon.co.uk> wrote:

> +#define alternative_msr_write(_msr, _val, _feature)            \
> +       asm volatile(ALTERNATIVE("",                            \
> +                                "movl %[msr], %%ecx\n\t"       \
> +                                "movl %[val], %%eax\n\t"       \
> +                                "movl $0, %%edx\n\t"           \
> +                                "wrmsr",                       \
> +                                _feature)                      \
> +                    : : [msr] "i" (_msr), [val] "i" (_val)     \
> +                    : "eax", "ecx", "edx", "memory")
> +

It's not needed now, but this would be more generally useful if the
high 32 bits of the MSR value could also be specified.
