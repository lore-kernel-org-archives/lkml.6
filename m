Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756117AbeDXGOA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:14:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53099 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDXGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:13:58 -0400
X-Google-Smtp-Source: AIpwx4/5BP3sGfzb1WriiRga+MhtVuR0D0OWAGEaPPP97QMjeyYmQ1XF02Rih78EYKMWPNnuhmxIufZ1qjwIdypLjYg=
MIME-Version: 1.0
In-Reply-To: <20180423164317.5a47f3dd9842d533413a1d4b@arm.com>
References: <20180416042240.21528-1-namhyung@kernel.org> <20180416092345.GA23274@krava>
 <20180416135125.GA23802@kernel.org> <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
 <20180416165800.GD3202@kernel.org> <20180416122407.0d90863b69fed80166384850@arm.com>
 <20180416174811.1aca9106364effe435f363c8@arm.com> <20180417022726.GA31947@sejong>
 <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com> <20180419025424.GC13370@sejong>
 <20180419183313.db3e3a105191a7f30b7650b2@arm.com> <CAKv+Gu_sY+Q+kqO1hp6f30WSGNPY1cnW5VJYj9cuVA0hU5YDVw@mail.gmail.com>
 <20180423164317.5a47f3dd9842d533413a1d4b@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 24 Apr 2018 08:13:57 +0200
Message-ID: <CAKv+Gu-u1E9gH7=p5sbiA4k_9mQ13y+056nYKnr2D9BPENNyMg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: set kernel end address properly
To: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2018 at 23:43, Kim Phillips <kim.phillips@arm.com> wrote:
> On Fri, 20 Apr 2018 10:10:32 +0200
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 20 April 2018 at 01:33, Kim Phillips <kim.phillips@arm.com> wrote:
>> > On Thu, 19 Apr 2018 11:54:24 +0900
>> > Namhyung Kim <namhyung@kernel.org> wrote:
>> >
>> >> On Wed, Apr 18, 2018 at 07:37:59PM -0500, Kim Phillips wrote:
>> >> > diff --git a/tools/perf/arch/arm64/util/sym-handling.c b/tools/perf/arch/arm64/util/sym-handling.c
>> >> > index 0051b1ee8450..5c4a2e208bbc 100644
>> >> > --- a/tools/perf/arch/arm64/util/sym-handling.c
>> >> > +++ b/tools/perf/arch/arm64/util/sym-handling.c
>> >> > @@ -20,3 +20,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
>> >> >                ehdr.e_type == ET_DYN;
>> >> >  }
>> >> >  #endif
>> >> > +
>> >> > +const char *arch__normalize_symbol_name(const char *name)
>> >> > +{
>> >> > +       /*
>> >> > +        * arm64 kernels compensating for a CPU erratum can put up a
>> >> > +        * module_emit_adrp_veneer in place of a module_emit_plt_entry
>> >> > +        */
>> >> > +       if (name && strlen(name) >= 23 &&
>> >> > +           !strncmp(name, "module_emit_adrp_veneer", 23))
>> >> > +               return "module_emit_plt_entry";
>> >> > +
>> >> > +       return name;
>> >> > +}
>> >>
>> >> I don't know it's always preferable or just for the test.  It it's the
>> >> latter it may be better to move it to the test code.
>> >
>> > AFACT, the veneer is a moniker and doesn't technically exist, and
>> > shouldn't be being looked-up.  Both chunks of this diff are needed to
>> > pass perf test 1: this chunk above is because in
>> > arch__normalize_symbol_name(), we squash the perf test 1's "<veneer>
>> > not in *kallsyms*" problem, and in the below chunk, we prevent it
>> > coming up when the test code iterates over the *vmlinux* symbols. I.e.
>> > we need to prevent the veneer from coming up in both kallsyms *and*
>> > vmlinux.
>>
>> I don't have all the context here, so I don't know what exactly
>> arch__normalize_symbol_name() is trying to accomplish.
>
> Sorry about that.  The problem is that perf test 1 ("vmlinux
> symtab matches kallsyms") is failing, because
> module_emit_adrp_veneer exists in /boot/vmlinux but doesn't exist
> in /proc/kallsyms, and, sure enough, it's not in the latter.
>
>> What I do know is that module_emit_adrp_veneer() and
>> module_emit_plt_entry() are not part of the veneer themselves: they
>> are ordinary routines that are part of the module loader, and which
>> populate the allocated veneer space on demand when encountering ADRP
>> instructions that need to be rerouted.
> ...
>> > >> rare case we might need to add more paranoid checks.
>> >
>> > It's certainly rare: Adding the authors of the veneer to cc for
>> > comments:
>> >
>> > Will, Ard, how probable are veneer-style symbols such as the
>> > one introduced in commit a257e0257 "arm64/kernel: don't ban ADRP to
>> > work around Cortex-A53 erratum #843419" to happen again in the future?
>> >
>>
>> Distro kernels typically enable full KASLR, so on systems that
>> implement EFI_RNG_PROTOCOL, all function calls from modules into the
>> kernel proper are redirected via veneers. (Note that these are bl
>> instructions not adrp instructions though).
>>
>> > I would have thought WARNing on within-a-pagesize would be OK,
>> > Namhyung.  Are you suggesting checking instead for a hardcoded veneer
>> > symbol string?
>>
>> Veneers don't have symbol strings. Veneers are anonymous sequences of
>> instructions living in a patch of R-X mapped module space somewhere.
>> The only symbol strings are for the routines that generate these
>> veneers, not for the veneers themselves.
>
> OK, thanks, so AFAICT this means the function module_emit_adrp_veneer()
> should still show up in /proc/kallsyms, but it's not.  I'm also seeing
> some weird characters, e.g., here there's a byte with a binary 02 value
> following a weird symbol named 'L14472' (part of the xfs module?):
>
> $ grep L1 /proc/kallsyms | hexdump -C | head
> <snip>
> 00000540  30 30 30 30 30 20 72 20  2e 4c 31 34 34 37 32 02  |00000 r .L14472.|
> <snip>
>
> arch__normalize_symbol_name() is a place where architecture code can
> clean up symbol names in perf, and I thought module_emit_adrp_veneer()
> was a veneer itself, but it seems that's not the case, so the
> literal string check for it shouldn't be needed.  The test is still
> failing though because it doesn't show up in kallsyms...
>

This turns out to be an unintended side effect of the fact that we
(I?) taught kallsyms to disregard symbols ending in "_veneer"

So we should probably rename the function, and everything will be fine.
