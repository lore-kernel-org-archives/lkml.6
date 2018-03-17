Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeCQKTP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 06:19:15 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:51732 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeCQKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 06:19:13 -0400
X-Google-Smtp-Source: AG47ELuzjB9qfG7sD5Tw1X6DQAicYUObRYFgeMX2oku1rISGgTuvpESbfGrDSs2yC3AwvoAx96l2QGrGo2x/LtMBivo=
MIME-Version: 1.0
In-Reply-To: <20180316171349.fodlraapz2sq2hhs@lakrids.cambridge.arm.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com> <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
 <2e84a842-96e8-aec4-8b85-9ee879bb323a@arm.com> <CAKwvOd=-TeLJn9=V_Dmj-X+qcRBcfH8tcktbm33xAx671VCYUw@mail.gmail.com>
 <20180316171349.fodlraapz2sq2hhs@lakrids.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 17 Mar 2018 10:19:12 +0000
Message-ID: <CAKv+Gu-eBHaoyqO_Vs0ZWahj9pkWWo6kP+9svtMoqcFMjKVd7A@mail.gmail.com>
Subject: Re: arm64 kvm built with clang doesn't boot
To: Mark Rutland <mark.rutland@arm.com>,
        Thomas Garnier <thgarnie@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        kernel-dynamic-tools <kernel-dynamic-tools@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
        Greg Hackmann <ghackmann@google.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stephen Hines <srhines@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Christoffer Dall <christoffer.dall@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Thomas)

On 16 March 2018 at 17:13, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Mar 16, 2018 at 04:52:08PM +0000, Nick Desaulniers wrote:
>> + Sami (Google), Takahiro (Linaro)
>>
>> Just so I fully understand the problem enough to articulate it, we'd be
>> looking for the compiler to keep the jump tables for speed (I would guess
>> -fno-jump-tables would emit an if-else chain) but only emit relative jumps
>> (not absolute jumps)?
>
> Our main concern is that there is no absolute addressing. If that rules
> out using a relative jump table, that's ok.
>
> We want to avoid the fragility of collecting -f-no-* options as future
> compiler transformations end up introducing absolute addressing.
>

This all comes back to the assumptions made by the compiler when
building PIC/PIE code, i.e., that symbols should be preemptible and
thus all references should be indirected via GOT entries, and that
text relocations should be avoided.

If we had a way to tell the compiler that these concerns do not apply
for us, we could use -fpic/-fpie in the kernel and be done with it.
-fvisibility=hidden *almost* gives us what we need, but in practice,
only the #pragma variant (#pragma GCC visibility push (hidden)) makes
-fpic behave in a sensible way for freestanding builds, and gets rid
of absolute references where possible (note that statically
initialized pointer variables always involve absolute relocations)
