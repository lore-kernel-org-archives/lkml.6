Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbeCFSma (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:42:30 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:56200 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:42:29 -0500
Date: Tue, 6 Mar 2018 19:42:26 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsprintf: distinguish between (null), (err) and
 (invalid) pointer derefs
Message-ID: <20180306184226.ww5uopskejwojeta@angband.pl>
References: <20180306182217.GA3798@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180306182217.GA3798@avx2>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:22:17PM +0300, Alexey Dobriyan wrote:
> > +#define BAD_PTR_STRING(x) (!(x) ? "(null)" : IS_ERR(x) ? "(err)" : "(invalid)")
> 
> This is getting ridiculous.
> 
> Instead of simply printing a pointer as %08lx or %016llx, not only glibc
> (null) stupidity is propagated but expanded and "improved".

This is not about printing a pointer, this is about attempting to print an
object referenced by such a bad pointer.  Which leads to a crash: in
userspace, you get a segfault; in the kernel, at least in the case I tested,
the system is dead without even a squeal on either console or serial.

> I assure you reading 0000000000000000 is just as obvious as (null) and
> reading fffffffffffffffa is just as good as -ENOMEM.
> 
> In fact printing with hex is more information. Maybe it is important
> that buggy pointer is small value but it's value is lost.
>
> Sure don't dereference a pointer for very small or very erry values
> but print it without all the bell and whistles.

That's a reasonable suggestion, but it still needs to be special cased.
Note the difference between printk("%px", 42) and printk("%s", 42).

See this part:
-       if (!ptr && *fmt != 'K' && *fmt != 'x') {
+       if (IS_BAD_PTR(ptr) && *fmt != 'K' && *fmt != 'x') {
Printing the pointer is already excluded; what I'm fixing is:
1. lying that the bad pointer was (null) when it was -ENOMEM (commit 1)
2. crash when some bad code tries to printk("%s", -ENOMEM) (commit 2)

So, if what you propose is applying commit 2, and changing 1 to print the
raw value instead of (null)/(err)/(invalid), that sounds good.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
