Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeEaGup (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:50:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36510 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbeEaGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:50:41 -0400
X-Google-Smtp-Source: ADUXVKJHQQc2wtasyHz7NnRRZbXmbzwGiDrBFAycT64jNeSDOKmSe/o8Qj0KSdb1EgFktBGKaeiCfqyPpxHrnB0Xekw=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
 <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
 <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com> <CAKwvOdkWsxoyXCnQz+Xwh0RQ0yPPVD3iCqVaWAimW_Z4QU0XiA@mail.gmail.com>
 <38f21c66-fa34-3a77-33bc-d15065c15af9@zytor.com> <CAKwvOdkurUGcSAGjR8_nDRgHLFLj93E1wAA3+O0A+pKPHvzwRA@mail.gmail.com>
In-Reply-To: <CAKwvOdkurUGcSAGjR8_nDRgHLFLj93E1wAA3+O0A+pKPHvzwRA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 30 May 2018 23:50:28 -0700
Message-ID: <CAKwvOd=FN0G-zs-DMF3ubs8y9-PDEamfi__P_iv_JgN3bH6qFw@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 3:38 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, May 25, 2018 at 2:06 PM H. Peter Anvin <hpa@zytor.com> wrote:
> > On 05/25/18 13:36, Nick Desaulniers wrote:
> > > On Fri, May 25, 2018 at 10:56 AM <hpa@zytor.com> wrote:
> > >> You need the extern inline in the .h file and the out-of-line .S file
> > > I don't see how you can specify to the linker from assembly source that
> > > this function should be treated as `extern inline`?
> > "extern inline" is a C directive. In the header file you should provide
> > the inlinable implementation (which is already there.) It means that "if
> > you don't want to inline this there is an external implementation
> > available."
>
> oh you put `extern inline` on the definition, not the declaration?! What?!
>
> http://m68hc11.serveftp.org/inline-1.php
>
> in fact documents that trick.  Wow, I've never seen that before.  Seems
> like there's not too many instances in the kernel.
>
> This seems to inline native_save_fl() properly into the call sites, but the
> boot code now fails to link due to multiple definitions when trying link
> the objects from arch/x86/boot/compressed/ into vmlinux.
>
> When disassembling the the arch/x86/boot/compressed/ objects, I can see
> they're pulling in the `extern inline` c versions, but still outlining
> them! (gcc and clang).
>
> That seems to contradict the statement from the above link:
> "In no case is the function compiled on its own, not even if you refer to
> its address explicitly"
>
> This is kind of funny; first we were wondering why native_save_fl was
> getting outlined as a static inline function, which Alistair tracked down
> to the incorrect use as a function pointer. Now I'm playing why is
> native_save_fl getting outlined as an extern inline function.
>
> If I move the .S file to be in arch/x86/kernel/boot/compressed, the boot
> code now links but then paravirt.o fails to link.  Referring to the .S from
> both Makefiles results in multiple definitions that the linker doesn't
> like. (and the boot code still containing outlines).
>
> I don't understand how `extern inline` signals to the linker that "this
> version should be taken if you find no others".  From what I can tell with
> `readelf -a` and `objdump -d`, a function marked `extern inline` vs not
> look similar.
>
> Then again, arch/x86/boot/compressed/Makefile completely resets
> KBUILD_CFLAGS and KBUILD_AFLAGS, which may be problematic (if there's some
> kind of command line flag that affects `extern inline` linkage).

Aha! This (wiping away CFLAGS) was it!  The rules for `extern inline`
for gnu89 and c99 are exactly the opposite! [0][1]

c99: "a function defined extern inline will always, emit an externally
visible function."

but then

gnu89: "gnu89 semantics of inline and extern inline are essentially
the exact opposite of those in C99"

This is elaborated more concisely in [2].

If I add `-std=gnu89` to the KBUILD_CFLAGS for compilation units that
are missing that flag but include irqflags.h, I stop getting multiple
definition linkage errors and link the expected kernel image!

This is something to seriously consider for whoever might ever want to
change the kernel's C standard: that you'll end up flipping the
semantics of `extern inline`.  Sounds like `-fgnu89-inline` compiler
flag or `gnu_inline` attribute could be used to correct such a
situation.

+ KBUILD maintainers and mailing list.

Completely overwriting the KBUILD_CFLAGS from sub directory Makefiles
(using the := operator) has been making me feel uneasy, since we very
carefully try to set the necessary flags for Clang in the top level
Makefile.  In this case, the C standard is different for at least 2
subdirectories, which has implications for at least the above case
with the linkage of `extern inline` functions.

Will do further testing and cut a patch set tomorrow.

[0] https://en.wikipedia.org/wiki/Inline_function#C99
[1] https://en.wikipedia.org/wiki/Inline_function#gnu89
[2] http://blahg.josefsipek.net/?p=529
-- 
Thanks,
~Nick Desaulniers
