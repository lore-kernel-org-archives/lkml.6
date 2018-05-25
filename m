Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967542AbeEYR4V convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:56:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42671 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967386AbeEYR4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:56:20 -0400
Date: Fri, 25 May 2018 10:56:10 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com> <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com> <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com> <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com> <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com> <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
CC: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
From: hpa@zytor.com
Message-ID: <A042BB2E-FACF-4AE0-8B1E-716061666C5F@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 25, 2018 10:31:51 AM PDT, Nick Desaulniers <ndesaulniers@google.com> wrote:
>On Fri, May 25, 2018 at 9:53 AM <hpa@zytor.com> wrote:
>> On May 25, 2018 9:46:42 AM PDT, Nick Desaulniers
><ndesaulniers@google.com>
>wrote:
>> >On Fri, May 25, 2018 at 9:33 AM <hpa@zytor.com> wrote:
>> >> On May 25, 2018 9:27:40 AM PDT, Nick Desaulniers
>> ><ndesaulniers@google.com> wrote:
>> >When you say
>> >
>> >> It still should be available as as inline, however, but now
>"extern
>> >inline".
>> >
>> >Am I understanding correctly that native_save_fl should be inlined
>into
>> >all
>> >call sites (modulo the problematic pv_irq_ops.save_fl case)? 
>Because
>> >for
>> >these two assembly implementations, it's not, but maybe there's
>> >something
>> >missing in my implementation?
>
>> Yes, that's what "extern inline" means. Maybe it needs a must inline
>annotation, but that's really messed up.
>
>I don't think it's possible to inline a function from an external
>translation unit without something like LTO.
>
>If I move the implementation of native_save_fl() to a separate .c (with
>out
>of line assembly) or .S, neither clang nor gcc will inline that
>assembly to
>any call sites, whether the declaration of native_save_fl() looks like:
>
>extern inline unsigned long native_save_fl(void);
>
>or
>
>__attribute__((always_inline))
>
>extern inline unsigned long native_save_fl(void);
>
>I think an external copy is the best approach for the paravirt code:
>
>diff --git a/arch/x86/kernel/irqflags.c b/arch/x86/kernel/irqflags.c
>new file mode 100644
>index 000000000000..e173ba8bee7b
>--- /dev/null
>+++ b/arch/x86/kernel/irqflags.c
>@@ -0,0 +1,24 @@
>+#include <asm/asm.h>
>+
>+extern unsigned long native_save_fl_no_stack_protector(void);
>+extern void native_restore_fl_no_stack_protector(unsigned long flags);
>+
>+asm(
>+".pushsection .text;"
>+".global native_save_fl_no_stack_protector;"
>+".type native_save_fl_no_stack_protector, @function;"
>+"native_save_fl_no_stack_protector:"
>+"pushf;"
>+"pop %" _ASM_AX ";"
>+"ret;"
>+".popsection");
>+
>+asm(
>+".pushsection .text;"
>+".global native_restore_fl_no_stack_protector;"
>+".type native_restore_fl_no_stack_protector, @function;"
>+"native_restore_fl_no_stack_protector:"
>+"push %" _ASM_DI ";"
>+"popf;"
>+"ret;"
>+".popsection");
>diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>index 02d6f5cf4e70..8824d01c0c35 100644
>--- a/arch/x86/kernel/Makefile
>+++ b/arch/x86/kernel/Makefile
>@@ -61,6 +61,7 @@ obj-y                 += alternative.o i8253.o
>hw_breakpoint.o
>  obj-y                  += tsc.o tsc_msr.o io_delay.o rtc.o
>  obj-y                  += pci-iommu_table.o
>  obj-y                  += resource.o
>+obj-y                  += irqflags.o
>
>  obj-y                          += process.o
>  obj-y                          += fpu/
>--- a/arch/x86/kernel/paravirt.c
>+++ b/arch/x86/kernel/paravirt.c
>@@ -322,9 +322,12 @@ struct pv_time_ops pv_time_ops = {
>         .steal_clock = native_steal_clock,
>  };
>
>+extern unsigned long native_save_fl_no_stack_protector(void);
>+extern void native_restore_fl_no_stack_protector(unsigned long flags);
>+
>  __visible struct pv_irq_ops pv_irq_ops = {
>-       .save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
>-       .restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
>+       .save_fl =
>__PV_IS_CALLEE_SAVE(native_save_fl_no_stack_protector),
>+       .restore_fl =
>__PV_IS_CALLEE_SAVE(native_restore_fl_no_stack_protector),
>         .irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
>         .irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
>         .safe_halt = native_safe_halt,
>
>Thoughts?

You need the extern inline in the .h file and the out-of-line .S file both.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
