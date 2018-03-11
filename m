Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeCKUgB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 16:36:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45490 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbeCKUgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 16:36:00 -0400
X-Google-Smtp-Source: AG47ELuefH+Lpk7kwtilQmykholBD2hjrfmWnpCAKeAWB2xfxaS2sF4QMTP/JWbD79bIiAkKiGTPC4uw/crEn53qX8M=
MIME-Version: 1.0
In-Reply-To: <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-2-ard.biesheuvel@linaro.org> <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 11 Mar 2018 20:35:58 +0000
Message-ID: <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 March 2018 at 20:20, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, Mar 11, 2018 at 5:38 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Before updating certain subsystems to use place relative 32-bit
>> relocations in special sections, to save space and reduce the
>> number of absolute relocations that need to be processed at runtime
>> by relocatable kernels, introduce the Kconfig symbol and define it
>> for some architectures that should be able to support and benefit
>> from it.
>
> Are there actually architectures hat _don't_ support those relative
> 32-bit relocations? That really feels pretty fundamental.
>

I started out doing all of them, and I don't remember the exact list,
but there are quite a few architectures that don't support these
relocations in their module loaders, and in fact, not even ARM does
(as one of the 'big' architectures).

This is not really surprising, given that the C compiler never emits
such relative references.

> I would have expected all of them to do it - is your selection of
> arm64/powerpc/x86 perhaps more about "I have tested these" than about
> anything else?
>
> Because I'd almost prefer to just do the switch-over unconditionally
> if that is at all possible?
>

arm64, powerpc and x86 implement CONFIG_RELOCATABLE, and so they
benefit more than other architectures, because of the fact that the
relocation metadata for these data structures can be dropped entirely.
Other 64-bit architectures only have the 50% size reduction benefit,
and 32-bit architectures have no benefit at all.

I'm sure all of these architectures define some kind of 32-bit place
relative relocation in their ELF psABI, and I see how it would be
cleaner to change everything at once, but I anticipate a long tail of
issues with toolchains for niche architectures that I have no way to
test.
