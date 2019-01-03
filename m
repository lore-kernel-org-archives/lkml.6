Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64054C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8D2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfACSMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:12:15 -0500
Received: from ms.lwn.net ([45.79.88.28]:57560 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfACSMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:12:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B696B97D;
        Thu,  3 Jan 2019 18:12:12 +0000 (UTC)
Date:   Thu, 3 Jan 2019 11:12:11 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
Message-ID: <20190103111211.14a81d95@lwn.net>
In-Reply-To: <9260c3aa-5c52-c35d-7a6a-ef5c58b82b10@leemhuis.info>
References: <20181217152043.9989-1-linux@leemhuis.info>
        <20181217112437.5fe868eb@lwn.net>
        <9260c3aa-5c52-c35d-7a6a-ef5c58b82b10@leemhuis.info>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay in responding to this ... $EXCUSES ... 

On Fri, 21 Dec 2018 16:26:31 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> > Here's an idea if you feel like improving this: rather than putting an
> > inscrutable program inline, add a taint_status script to scripts/ that
> > prints out the status in fully human-readable form, with the explanation
> > for every set bit.  
> 
> I posted the script earlier today and noticed now that it prints only
> the fully human-readable form, not if a bit it set or unset. Would you
> prefer if it did that as well?

Not sure I have an opinion; perhaps if it can be done in a readable way
putting more information is better than less.

> >> +===  ===  ======  ========================================================
> >> +Bit  Log     Int  Reason that got the kernel tainted
> >> +===  ===  ======  ========================================================
> >> + 1)  G/P       0  proprietary module got loaded  
> > I'd s/got/was/ throughout.  Also, this is the kernel, we start counting at
> > zero! :)  
> 
> Hehe, yeah :-D At first I actually started at zero, but that looked
> odd as the old explanations (those already in the file) start to could at one.
> Having a off-by-one within one document is just confusing, that's why I
> decided against starting at zero here.
> 
> Another reason that came to my mind when reading your comment: Yes, this
> is the kernel, but the document should be easy to understand even for
> inexperienced users (e.g. people that know how to open and use command
> line tools, but never learned programming). That's why I leaning towards
> starting with one everywhere. But yes, that can be confusing, that's
> why I added a note, albeit I'm not really happy with it yet:
> 
> """
> Note: This document is aimed at users and thus starts to count at one here and
> in other places.  Use ``seq 0 17`` instead to start counting at zero, as it's
> normal for developers.
> """
> 
> See below for full context. Anyway: I can change the text to start at zero if
> you prefer it.

This is a kernel document in the end, so I do really think that we should
be consistent with kernel conventions.  

> Tainted kernels
> ---------------
> 
> The kernel will mark itself as 'tainted' when something occurs that might be
> relevant later when investigating problems. Don't worry too much about this,
> most of the time it's not a problem to run a tainted kernel; the information is
> mainly of interest once someone wants to investigate some problem, as its real
> cause might be the event that got the kernel tainted. That's why bug reports
> from tainted kernels will often be ignored by developers, hence try to reproduce
> problems with an untainted kernel.
> 
> Note the kernel will remain tainted even after you undo what caused the taint
> (i.e. unload a proprietary kernel module), to indicate the kernel remains not
> trustworthy. That's also why the kernel will print the tainted state when it
> notices an internal problem (a 'kernel bug'), a recoverable error
> ('kernel oops') or a non-recoverable error ('kernel panic') and writes debug
> information about this to the logs ``dmesg`` outputs. It's also possible to
> check the tainted state at runtime through a file in ``/proc/``.
> 
> 
> Tainted flag in bugs, oops or panics messages
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> You find the tainted state near the top in a line starting with 'CPU:'; if or
> why the kernel is shown after the Process ID ('PID:') and a shortened name of
> the command ('Comm:') that triggered the event:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> Oops: 0002 [#1] SMP PTI
> CPU: 0 PID: 4424 Comm: insmod Tainted: P        W  O      4.20.0-0.rc6.fc30 #1
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> RIP: 0010:my_oops_init+0x13/0x1000 [kpanic]
> [...]
> 
> You'll find a **'Not tainted: '** there if the kernel was not tainted at the
> time of the event; if it was, then it will print **'Tainted: '** and characters
> either letters or blanks. The meaning of those characters is explained in the
> table below. In above example it's '``Tainted: P        W  O     ``' as as the

A seriously minor nit, but I would format this as:

  In the above example it's::

	Tainted: P        W  O

  as the kernel got tainted...

That will keep the text from being broken in unfortunate places in the
formatted docs.

(One "as" is also sufficient :)

> kernel got tainted earlier because a proprietary Module (``P``) was loaded, a
> warning occurred (``W``), and an externally-built module was loaded (``O``).
> To decode other letters use the table below.
> 
> 
> Decoding tainted state at runtime
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> At runtime, you can query the tainted state by reading
> ``cat /proc/sys/kernel/tainted``. If that returns ``0``, the kernel is not
> tainted; any other number indicates the reasons why it is. The easiest way to
> decode that number is the script ``tools/debugging/kernel-chktaint``, which your
> distribution might ship as part of a package called ``linux-tools`` or
> ``kernel-tools``; if it doesn't you can download the script from
> `git.kernel.org <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/debugging/kernel-chktaint>`_.
> and execute it with ``sh kernel-chktaint``
> 
> If you do not want to run that script you can try to decode the number yourself.
> That's easy if there was only one reason that got your kernel tainted, as in
> this case you can find the number with the table below. If there were multiple
> reasons you need to decode the number, as it is a bitfield, where each bit
> indicates the absence or presence of a particular type of taint. It's best to
> leave that to the aforementioned script, but if you need something quick you can
> use this shell command to check which bits are set:
> 
> 	$ for i in $(seq 18); do echo $i $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
> 
> Note: This document is aimed at users and thus starts to count at one here and
> in other places.  Use ``seq 0 17`` instead to start counting at zero, as it's
> normal for developers.

Again, just zero-base it and keep things simple and consistent.

> Table for decoding tainted state
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ====  ===  ======  ========================================================
> Pos.  Log  Number  Reason that got the kernel tainted
> ====  ===  ======  ========================================================
>   1)  G/P       0  proprietary module was loaded
>   2)  _/F       2  module was force loaded
>   3)  _/S       4  SMP kernel oops on an officially SMP incapable processor
>   4)  _/R       8  module was force unloaded
>   5)  _/M      16  processor reported a Machine Check Exception (MCE)
>   6)  _/B      32  bad page referenced or some unexpected page flags
>   7)  _/U      64  taint requested by userspace application
>   8)  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
>   9)  _/A     256  ACPI table overridden by user
>  10)  _/W     512  kernel issued warning
>  11)  _/C    1024  staging driver was loaded
>  12)  _/I    2048  workaround for bug in platform firmware applied
>  13)  _/O    4096  externally-built ("out-of-tree") module was loaded
>  14)  _/E    8192  unsigned module was loaded
>  15)  _/L   16384  soft lockup occurred
>  16)  _/K   32768  Kernel live patched
>  17)  _/K   65536  Auxiliary taint, defined for and used by distros
>  18)  _/K  131072  Kernel was built with the struct randomization plugin
> ====  ===  ======  ========================================================
> 
> Note: To make reading easier ``_`` is representing a blank in this
> table.
> 
> More detailed explanation for tainting
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  1)  ``G`` if all modules loaded have a GPL or compatible license, ``P`` if
>      any proprietary module has been loaded.  Modules without a
>      MODULE_LICENSE or with a MODULE_LICENSE that is not recognised by
>      insmod as GPL compatible are assumed to be proprietary.
> 
>  2)  ``F`` if any module was force loaded by ``insmod -f``, ``' '`` if all
>      modules were loaded normally.
> 
>  3)  ``S`` if the oops occurred on an SMP kernel running on hardware that
>      hasn't been certified as safe to run multiprocessor.
>      Currently this occurs only on various Athlons that are not
>      SMP capable.

I wonder if any such hardware has ever run anything remotely resembling a
current kernel.  In any case, a quick grep suggests that this taint can be
set in a number of other places as well.

>  4)  ``R`` if a module was force unloaded by ``rmmod -f``, ``' '`` if all
>      modules were unloaded normally.
> 
>  5)  ``M`` if any processor has reported a Machine Check Exception,
>      ``' '`` if no Machine Check Exceptions have occurred.
> 
>  6)  ``B`` if a page-release function has found a bad page reference or
>      some unexpected page flags.

I'd be tempted to add something like: "This taint indicates a hardware
problem or a kernel bug; there should be other information in the log
indicating why this bit was set."

>  7)  ``U`` if a user or user application specifically requested that the
>      Tainted flag be set, ``' '`` otherwise.
> 
>  8)  ``D`` if the kernel has died recently, i.e. there was an OOPS or BUG.
> 
>  9)  ``A`` if the ACPI table has been overridden.
> 
>  10) ``W`` if a warning has previously been issued by the kernel.
>      (Though some warnings may set more specific taint flags.)
> 
>  11) ``C`` if a staging driver has been loaded.

There's a couple of other situations where this one is set as well; not
sure if it's worth the trouble to try to describe them.

>  12) ``I`` if the kernel is working around a severe bug in the platform
>      firmware (BIOS or similar).
> 
>  13) ``O`` if an externally-built ("out-of-tree") module has been loaded.
> 
>  14) ``E`` if an unsigned module has been loaded in a kernel supporting
>      module signature.
> 
>  15) ``L`` if a soft lockup has previously occurred on the system.
> 
>  16) ``K`` if the kernel has been live patched.
> 
>  17) ``X`` Auxiliary taint, defined for and used by Linux distributors.

Do we know anything about whether anybody uses this?

>  18) ``T`` Kernel was build with randstruct plugin, which can intentionally
>      produce extremely unusual kernel structure layouts (even performance
>      pathological ones), which is important to know when debugging. Set at
>      build time.

with *the* randstruct plugin

Overall, just nits except for the start-with-zero thing.

Thanks,

jon
