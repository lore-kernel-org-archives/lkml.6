Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeCYNYO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 09:24:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51949 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCYNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 09:24:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Mar 2018 15:24:09 +0200
From: Stefan Agner <stefan@agner.ch>
To: Stefan Agner <stefan@agner.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        ard.biesheuvel@linaro.org, arnd@arndb.de, nicolas.pitre@linaro.org,
        marc.zyngier@arm.com, behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ARM: add support for building ARM kernel with clang
In-Reply-To: <20180320231832.GK2743@n2100.armlinux.org.uk>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-6-stefan@agner.ch>
 <20180320231832.GK2743@n2100.armlinux.org.uk>
Message-ID: <83b9fadfc294ef195b6aff54f000d9a6@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 00:18, Russell King - ARM Linux wrote:
> On Wed, Mar 21, 2018 at 12:02:06AM +0100, Stefan Agner wrote:
>> Use cc-options call for compiler options which are not available
>> in clang. With this patch an ARMv7 multi platform kernel can be
>> successfully build using clang (tested with version 5.0.1).
>>
>> Based-on-patches-by: Behan Webster <behanw@converseincode.com>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/Makefile                 | 2 +-
>>  arch/arm/boot/compressed/Makefile | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index e9e3fde3c657..20e9fee1ccc5 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -39,7 +39,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
>>  endif
>>
>>  ifeq ($(CONFIG_FRAME_POINTER),y)
>> -KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
>> +KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)
> 
> Some of these options here are to ensure that we generate the following
> code, so we can backtrace:
> 
> 	mov	ip, sp
> 	stmfd	sp!, {fp, ip, lr, pc}
> 	sub	fp, ip, #4
> 
> If clang isn't producing that code at the start of functions with
> CONFIG_FRAME_POINTER=y, then backtracing will not work, and arguably
> CONFIG_FRAME_POINTER=y is useless there.  In that circumstance, it's
> probably better to fail so the user can configure something more
> debuggable, rather than having the kernel potentially producing
> undebuggable oopses.

Just for the records, compiled with clang, this patchset applied and
CONFIG_FRAME_POINTER=y as expected leads to a non functional backtrace:

[    4.583711] ------------[ cut here ]------------
[    4.588347] WARNING: CPU: 0 PID: 1 at init/main.c:1012
kernel_init+0x60/0x238
[    4.595505] Modules linked in:
[    4.598590] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       
4.16.0-rc5-00019-g686ee524148e-dirty #42
[    4.608514] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    4.614266] Backtrace: 
[    4.616728] [<dc063f34>] (0xdc063f34) from [<00000000>] (  (null))
[    4.622918] Backtrace aborted due to bad frame pointer <8c0165e4>
[    4.629046] ---[ end trace 200951c950497708 ]---

clang with CONFIG_FRAME_POINTER=y should really error out. Without the
cc-option calls building witih clang will print the following errors:

...
  CC      kernel/bounds.s
clang-6.0: error: unknown argument: '-mapcs'
clang-6.0: error: unknown argument: '-mno-sched-prolog'
...

Using CONFIG_ARM_UNWIND=y compiles fine and backtraces do work fine too:

[    4.630877] ------------[ cut here ]------------
[    4.635515] WARNING: CPU: 0 PID: 1 at init/main.c:1012
kernel_init+0x5c/0x234
[    4.642672] Modules linked in:
[    4.645742] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       
4.16.0-rc5-00019-g686ee524148e-dirty #41
[    4.655666] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    4.661437] [<c0110a9c>] (unwind_backtrace) from [<c010ca6c>]
(show_stack+0x10/0x14)
[    4.669200] [<c010ca6c>] (show_stack) from [<c0959ebc>]
(dump_stack+0x9c/0xac)
[    4.676442] [<c0959ebc>] (dump_stack) from [<c01214c4>]
(__warn+0xb4/0x120)
[    4.683419] [<c01214c4>] (__warn) from [<c01215f4>]
(warn_slowpath_null+0x40/0x48)
[    4.691003] [<c01215f4>] (warn_slowpath_null) from [<c096e7b8>]
(kernel_init+0x5c/0x234)
[    4.699111] [<c096e7b8>] (kernel_init) from [<c01010e8>]
(ret_from_fork+0x14/0x2c)
[    4.706691] Exception stack(0xdc063fb0 to 0xdc063ff8)
[    4.711752] 3fa0:                                     00000000
00000000 00000000 00000000
[    4.719943] 3fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    4.728133] 3fe0: 00000000 00000000 00000000 00000000 00000013
00000000
[    4.734792] ---[ end trace 200951c950497708 ]---

--
Stefan
