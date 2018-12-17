Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33628C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0387120675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbeLQSYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:24:51 -0500
Received: from ms.lwn.net ([45.79.88.28]:54094 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388838AbeLQSYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:24:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F1CF6739;
        Mon, 17 Dec 2018 18:24:48 +0000 (UTC)
Date:   Mon, 17 Dec 2018 11:24:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <20181217112437.5fe868eb@lwn.net>
In-Reply-To: <20181217152043.9989-1-linux@leemhuis.info>
References: <20181217152043.9989-1-linux@leemhuis.info>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 16:20:42 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Hi! Find my first contribution to the kernel documentation in the reply to this
> mail. Hopefully a lot more will follow.

Hopefully!  Looking forward to it.

> Sorry for using the simple table format for the table. I only noticed the
> list table format is preferred after creating the table. Shall I convert
> it for the next submission? Sounds like a downside to me, as for a table
> this small the simple table format seems way easier to parse when reading
> the plain text file.

The thing that matters is readability in the plain-text format.  Your
table here is fine, no reason to redo it.

With regard to the patch itself:

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 28a869c509a0..aabd307a178a 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -1,10 +1,102 @@
>  Tainted kernels
>  ---------------
>  
> -Some oops reports contain the string **'Tainted: '** after the program
> -counter. This indicates that the kernel has been tainted by some
> -mechanism.  The string is followed by a series of position-sensitive
> -characters, each representing a particular tainted value.
> +The kernel will mark itself as 'tainted' when something occurs that
> +might be relevant later when investigating problems. Don't worry
> +yourself too much about this, most of the time it's not a problem to run

s/yourself//

> +a tainted kernel; the information is mainly of interest once someone
> +wants to investigate some problem, as its real cause might be the event
> +that got the kernel tainted. 

While this is true, an oops with a taint flag will often be ignored by
developers.  It's worth saying that, if at all possible, a problem needs
to be reproduced on an untainted kernel.

> That's why the kernel will remain tainted
> +even after you undo what caused the taint (i.e. unload a proprietary
> +kernel module), to indicate the kernel remains not trustworthy. That's
> +also why the kernel will print the tainted state when it noticed
> +ainternal problem (a 'kernel bug'), a recoverable error ('kernel oops')
> +or a nonrecoverable error ('kernel panic') and writes debug information
> +about this to the logs ``dmesg`` outputs. It's also possible to check
> +the tainted state at runtime through a file in ``/proc/``.
> +
> +
> +Tainted flag in bugs, oops or panics messages
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +You find the tainted state near the top after the list of loaded
> +modules.  The state is part of the line that begins with mentioning CPU
> +('CPU:'), Process ID ('PID:'), and a shorted name of the executed
> +command ('Comm:') that triggered the event. 

This seems like a good place for an example.

> When followed by **'Not
> +tainted: '** the kernel was not tainted at the time of the event; if it
> +was, then it will print **'Tainted: '** and characters either letters or
> +blanks. The meaning of those characters is explained in below table. The
> +output for example might state '``Tainted: P   WO``' when the kernel got
> +tainted earlier because a proprietary Module (``P``) was loaded, a
> +warning occurred (``W``), and an externally-built module was loaded
> +(``O``). To decode other letters use below table.
> +
> +
> +Decoding tainted state at runtime
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +At runtime, you can query the tainted state by reading
> +``/proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
> +tainted; any other number indicates the reasons why it is. You might
> +find that number in below table if there was only one reason that got
> +the kernel tainted. If there were multiple reasons you need to decode
> +the number, as it is a bitfield, where each bit indicates the absence or
> +presence of a particular type of taint. You can use the following python
> +command to decode::

Here's an idea if you feel like improving this: rather than putting an
inscrutable program inline, add a taint_status script to scripts/ that
prints out the status in fully human-readable form, with the explanation
for every set bit.

> +
> +	$ python3 -c 'from pprint import pprint; from itertools import zip_longest; pprint(list(zip_longest(range(1,17), reversed(bin(int(open("/proc/sys/kernel/tainted").read()))[2:]),fillvalue="0")))'
> +	[(1, '1'),
> +	 (2, '0'),
> +	 (3, '0'),
> +	 (4, '0'),
> +	 (5, '0'),
> +	 (6, '0'),
> +	 (7, '0'),
> +	 (8, '0'),
> +	 (9, '0'),
> +	 (10, '1'),
> +	 (11, '0'),
> +	 (12, '0'),
> +	 (13, '1'),
> +	 (14, '0'),
> +	 (15, '0'),
> +	 (16, '0')]
> +
> +In this case ``/proc/sys/kernel/tainted`` contained ``4609``, as the
> +kernel got tainted because a proprietary Module (Bit 1) got loaded, a
> +warning occurred (Bit 10), and an externally-built module got loaded
> +(Bit 13). To decode other bits use below table.
> +
> +
> +Table for decoding tainted state
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As noted before, this table is entirely readable and need not be messed
with. 

> +===  ===  ======  ========================================================
> +Bit  Log     Int  Reason that got the kernel tainted
> +===  ===  ======  ========================================================
> + 1)  G/P       0  proprietary module got loaded

I'd s/got/was/ throughout.  Also, this is the kernel, we start counting at
zero! :)

> + 2)  _/F       2  module was force loaded
> + 3)  _/S       4  SMP kernel oops on a officially SMP incapable processor
> + 4)  _/R       8  module was force unloaded
> + 5)  _/M      16  processor reported a Machine Check Exception (MCE)
> + 6)  _/B      32  bad page referenced or some unexpected page flags
> + 7)  _/U      64  taint requested by userspace application
> + 8)  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
> + 9)  _/A     256  ACPI table overridden by user
> +10)  _/W     512  kernel issued warning
> +11)  _/C    1024  staging driver got loaded
> +12)  _/I    2048  workaround for bug in platform firmware in use
> +13)  _/O    4096  externally-built ("out-of-tree") module got loaded
> +14)  _/E    8192  unsigned module was loaded
> +15)  _/L   16384  soft lockup occurred
> +16)  _/K   32768  Kernel live patched

A look at kernel.h shows two more flags.  TAINT_AUX doesn't seem to be
used, but TAINT_RANDSTRUCT is.

> +===  ===  ======  ========================================================
> +
> +Note: To make reading easier ``_`` is representing a blank in this
> +table.
> +
> +More detailed explanation for tainting
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>   1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
>       any proprietary module has been loaded.  Modules without a
> @@ -52,8 +144,3 @@ characters, each representing a particular tainted value.
>  
>   16) ``K`` if the kernel has been live patched.
>  
> -The primary reason for the **'Tainted: '** string is to tell kernel
> -debuggers if this is a clean kernel or if anything unusual has
> -occurred.  Tainting is permanent: even if an offending module is
> -unloaded, the tainted value remains to indicate that the kernel is not
> -trustworthy.
> -- 
> 2.18.1

Thanks,

jon
