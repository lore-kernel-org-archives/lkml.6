Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeCUJD2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:03:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48568 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeCUJDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:03:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 21 Mar 2018 10:03:22 +0100
From: Stefan Agner <stefan@agner.ch>
To: Matthias Kaehlcke <mka@chromium.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: add support for building ARM kernel with clang
In-Reply-To: <20180321002022.GH37438@google.com>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-6-stefan@agner.ch>
 <20180320231832.GK2743@n2100.armlinux.org.uk>
 <20180321002022.GH37438@google.com>
Message-ID: <602b427702af61a503d9ffe38c35075c@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 01:20, Matthias Kaehlcke wrote:
> El Tue, Mar 20, 2018 at 11:18:33PM +0000 Russell King - ARM Linux ha dit:
> 
>> On Wed, Mar 21, 2018 at 12:02:06AM +0100, Stefan Agner wrote:
>> > Use cc-options call for compiler options which are not available
>> > in clang. With this patch an ARMv7 multi platform kernel can be
>> > successfully build using clang (tested with version 5.0.1).
>> >
>> > Based-on-patches-by: Behan Webster <behanw@converseincode.com>
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Great to see your work on bringing clang support for 32-bit ARM
> upstream!
> 
>> > ---
>> >  arch/arm/Makefile                 | 2 +-
>> >  arch/arm/boot/compressed/Makefile | 2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> > index e9e3fde3c657..20e9fee1ccc5 100644
>> > --- a/arch/arm/Makefile
>> > +++ b/arch/arm/Makefile
>> > @@ -39,7 +39,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
>> >  endif
>> >
>> >  ifeq ($(CONFIG_FRAME_POINTER),y)
>> > -KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
>> > +KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
>>
>> Some of these options here are to ensure that we generate the following
>> code, so we can backtrace:
>>
>> 	mov	ip, sp
>> 	stmfd	sp!, {fp, ip, lr, pc}
>> 	sub	fp, ip, #4
>>
>> If clang isn't producing that code at the start of functions with
>> CONFIG_FRAME_POINTER=y, then backtracing will not work, and arguably
>> CONFIG_FRAME_POINTER=y is useless there.  In that circumstance, it's
>> probably better to fail so the user can configure something more
>> debuggable, rather than having the kernel potentially producing
>> undebuggable oopses.

With clang and -fno-omit-frame-pointer function prologue looks something
like this:

   0:   e92d4ff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, lr}    
                                                                   
   4:   e28db01c        add     fp, sp, #28
...

This bug seems to be related:
https://bugs.llvm.org/show_bug.cgi?id=18505 

It seems that LLVM/clang does not plan to add APCS format/gcc
interoperability for the same frame layout.

I guess it would be possible to support the LLVM/clang frame layout?

But until then, I am with Russel here: Better just let clang fail on
CONFIG_FRAME_POINTER=y.

Most configs probably anyway use CONFIG_ARM_UNWIND. At least
multi_v7_defconfig does.

> 
> Which option in particular is important to generate the above code for
> backstracing?

For gcc, I guess really all of them.

--
Stefan

> 
> According to the gcc doc -mapcs(-frame) is deprecated.
> 
> For -mno-sched-prolog the doc says:
> 
> "Prevent the reordering of instructions in the function prologue, or
> the merging of those instruction with the instructions in the
> function’s body. This means that all functions start with a
> recognizable set of instructions (or in fact one of a choice from a
> small set of different function prologues), and this information can
> be used to locate the start of functions inside an executable piece of
> code. The default is -msched-prolog."
> 
> Thanks
> 
> Matthias
