Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030699AbeEYWi0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:38:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45629 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeEYWiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:38:24 -0400
X-Google-Smtp-Source: AB8JxZozxzgv4AfSsFctsiQPMaSSp+3LEv4G7JrkdJ5dDx8XAiSaWyUs+WTq1ifPblmfjkX7KdvRASnSyaiImqaUXxk=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
 <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
 <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com> <CAKwvOdkWsxoyXCnQz+Xwh0RQ0yPPVD3iCqVaWAimW_Z4QU0XiA@mail.gmail.com>
 <38f21c66-fa34-3a77-33bc-d15065c15af9@zytor.com>
In-Reply-To: <38f21c66-fa34-3a77-33bc-d15065c15af9@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 May 2018 15:38:11 -0700
Message-ID: <CAKwvOdkurUGcSAGjR8_nDRgHLFLj93E1wAA3+O0A+pKPHvzwRA@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 2:06 PM H. Peter Anvin <hpa@zytor.com> wrote:
> On 05/25/18 13:36, Nick Desaulniers wrote:
> > On Fri, May 25, 2018 at 10:56 AM <hpa@zytor.com> wrote:
> >> You need the extern inline in the .h file and the out-of-line .S file
> > I don't see how you can specify to the linker from assembly source that
> > this function should be treated as `extern inline`?
> "extern inline" is a C directive. In the header file you should provide
> the inlinable implementation (which is already there.) It means that "if
> you don't want to inline this there is an external implementation
> available."

oh you put `extern inline` on the definition, not the declaration?! What?!

http://m68hc11.serveftp.org/inline-1.php

in fact documents that trick.  Wow, I've never seen that before.  Seems
like there's not too many instances in the kernel.

This seems to inline native_save_fl() properly into the call sites, but the
boot code now fails to link due to multiple definitions when trying link
the objects from arch/x86/boot/compressed/ into vmlinux.

When disassembling the the arch/x86/boot/compressed/ objects, I can see
they're pulling in the `extern inline` c versions, but still outlining
them! (gcc and clang).

That seems to contradict the statement from the above link:
"In no case is the function compiled on its own, not even if you refer to
its address explicitly"

This is kind of funny; first we were wondering why native_save_fl was
getting outlined as a static inline function, which Alistair tracked down
to the incorrect use as a function pointer. Now I'm playing why is
native_save_fl getting outlined as an extern inline function.

If I move the .S file to be in arch/x86/kernel/boot/compressed, the boot
code now links but then paravirt.o fails to link.  Referring to the .S from
both Makefiles results in multiple definitions that the linker doesn't
like. (and the boot code still containing outlines).

I don't understand how `extern inline` signals to the linker that "this
version should be taken if you find no others".  From what I can tell with
`readelf -a` and `objdump -d`, a function marked `extern inline` vs not
look similar.

Then again, arch/x86/boot/compressed/Makefile completely resets
KBUILD_CFLAGS and KBUILD_AFLAGS, which may be problematic (if there's some
kind of command line flag that affects `extern inline` linkage).
--
Thanks,
~Nick Desaulniers
