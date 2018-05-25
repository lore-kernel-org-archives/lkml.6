Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967418AbeEYQq4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:46:56 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46099 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967398AbeEYQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:46:54 -0400
X-Google-Smtp-Source: AB8JxZrQW+9ACQiZdK7nFmEg5a5gzOISmKoSi5qRabZ9tXZNXLXreJjV+a5GBF6hDacvIEtP2h5D5cl1qqb0vdLKDhw=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com>
In-Reply-To: <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 May 2018 09:46:42 -0700
Message-ID: <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
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

On Fri, May 25, 2018 at 9:33 AM <hpa@zytor.com> wrote:
> On May 25, 2018 9:27:40 AM PDT, Nick Desaulniers <ndesaulniers@google.com>
wrote:
> >On Thu, May 24, 2018 at 3:43 PM <hpa@zytor.com> wrote:
> >> On May 24, 2018 3:31:05 PM PDT, Nick Desaulniers
> ><ndesaulniers@google.com>
> >wrote:
> >> >On Thu, May 24, 2018 at 3:05 PM H. Peter Anvin <hpa@zytor.com>
> >wrote:
> >> >> COMPILER AR: "=rm" should NEVER generate worse code than "=r".
> >That
> >> >is
> >> >> unequivocally a compiler bug.
> >> >
> >> >Filed: https://bugs.llvm.org/show_bug.cgi?id=37583
> >> >
> >> >> >> You are claiming it doesn't buy us anything, but you are only
> >> >looking
> >> >at
> >> >> > the paravirt case which is kind of "special" (in the short bus
> >kind
> >> >of
> >> >way),
> >> >> >
> >> >> > That's fair.  Is another possible solution to have paravirt
> >maybe
> >> >not
> >> >use
> >> >> > native_save_fl() then, but its own
> >> >non-static-inline-without-m-constraint
> >> >> > implementation?
> >> >
> >> >> KERNEL AR: change native_save_fl() to an extern inline with an
> >> >assembly
> >> >> out-of-line implementation, to satisfy the paravirt requirement
> >that
> >> >no
> >> >> GPRs other than %rax are clobbered.
> >> >
> >> >i'm happy to add that, do you have a recommendation if it should go
> >in
> >> >an
> >> >existing .S file or a new one (and if so where/what shall I call
> >it?).
> >
> >> How about irqflags.c since that is what the .h file is called.
> >
> >> It should simply be:
> >
> >> push %rdi
> >> popf
> >> ret
> >
> >> pushf
> >> pop %rax
> >> ret
> >
> >> ... but with all the regular assembly decorations, of course.
> >
> >Something like the following?
> >
> >
> >diff --git a/arch/x86/kernel/irqflags.c b/arch/x86/kernel/irqflags.c
> >new file mode 100644
> >index 000000000000..59dc21bd3327
> >--- /dev/null
> >+++ b/arch/x86/kernel/irqflags.c
> >@@ -0,0 +1,24 @@
> >+#include <asm/asm.h>
> >+
> >+extern unsigned long native_save_fl(void);
> >+extern void native_restore_fl(unsigned long flags);
> >+
> >+asm(
> >+".pushsection .text;"
> >+".global native_save_fl;"
> >+".type native_save_fl, @function;"
> >+"native_save_fl:"
> >+"pushf;"
> >+"pop %" _ASM_AX ";"
> >+"ret;"
> >+".popsection");
> >+
> >+asm(
> >+".pushsection .text;"
> >+".global native_restore_fl;"
> >+".type native_restore_fl, @function;"
> >+"native_restore_fl:"
> >+"push %" _ASM_DI ";"
> >+"popf;"
> >+"ret;"
> >+".popsection");
> >
> >And change the declaration in arch/x86/include/asm/irqflags.h to:
> >+extern inline unsigned long native_save_fl(void);
> >+extern inline void native_restore_fl(unsigned long flags);
> >
> >This seems to work, but
> >1. arch/x86/boot/compressed/misc.o warns that native_save_fl() is never
> >defined (arch_local_save_flags() uses it).  Does that mean
> >arch_local_save_flags(), and friends would also have to move to the
> >newly
> >created .c file as well?
> >2. `extern inline` doesn't inline any instances (from what I can tell
> >from
> >disassembling vmlinux).  I think this is strictly worse. Don't we only
> >want
> >pv_irq_ops.save_fl to be non-inlined in a way that no stack protector
> >can
> >be added? If that's the case, should my assembly based implementation
> >have
> >a different identifier (`native_save_fl_paravirt` or something). That
> >would
> >also fix point #1 above. But now the paravirt code has its own copy of
> >the
> >function.

> Sorry, I meant irqflags.S.

> It still should be available as as inline, however, but now "extern
inline".

Heh, ok I was confused.  But in testing, I had also created:

arch/x86/lib/irqflags.S
/* SPDX-License-Identifier: GPL-2.0 */

#include <asm/asm.h>
#include <asm/export.h>
#include <linux/linkage.h>

/*
  * unsigned long native_save_fl(void)
  */
ENTRY(native_save_fl)
pushf
pop %_ASM_AX
ret
ENDPROC(native_save_fl)
EXPORT_SYMBOL(native_save_fl)

/*
  * void native_restore_fl(unsigned long flags)
  * %rdi: flags
  */
ENTRY(native_restore_fl)
push %_ASM_DI
popf
ret
ENDPROC(native_restore_fl)
EXPORT_SYMBOL(native_restore_fl)

The issue is that this still has issues 1 & 2 listed earlier (and the
disassembly has a lot more trailing nops added).

When you say

> It still should be available as as inline, however, but now "extern
inline".

Am I understanding correctly that native_save_fl should be inlined into all
call sites (modulo the problematic pv_irq_ops.save_fl case)?  Because for
these two assembly implementations, it's not, but maybe there's something
missing in my implementation?
-- 
Thanks,
~Nick Desaulniers
