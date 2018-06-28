Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDDF27838
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDDF27838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeF1TGY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:39506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030575AbeF1TDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3187BAD4A;
        Thu, 28 Jun 2018 19:03:39 +0000 (UTC)
Date:   Thu, 28 Jun 2018 11:16:23 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>,
        Michal Kubecek <mkubecek@suse.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Jeff Mahoney <jeffm@suse.com>,
        "Peter Zijlstra," <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org
Subject: Re: due to kconfig changes kernel config file is no longer
 sufficient for configuring the kernel
Message-ID: <20180628111623.3807fe9b@naga.suse.cz>
In-Reply-To: <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 23:07:21 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi.
> 
> 
> 2018-06-27 21:37 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:
> > Hello,
> >
> > in the x86 Kconfig we have this:
> >
> > # Select 32 or 64 bit
> > config 64BIT
> >         bool "64-bit kernel" if "$(ARCH)" = "x86"
> >         default "$(ARCH)" != "i386"
> >         ---help---
> >           Say yes to build a 64-bit kernel - formerly known as
> > x86_64 Say no to build a 32-bit kernel - formerly known as i386
> >
> > Since commit 104daea149c4 ("kconfig: reference environment variables
> > directly and remove 'option env='") the value of ARCH is not saved
> > in the kernel config.  
> 
> I think this commit is unrelated.  It was just a syntax change.

This does not look like syntax only change to me:

diff --git a/init/Kconfig b/init/Kconfig
index 15aae32e0719..1217fc62ca61 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1,20 +1,12 @@
-config ARCH
-       string
-       option env="ARCH"
-
-config KERNELVERSION
-       string
-       option env="KERNELVERSION"
-

> 
> Unless I am missing something,
> we have never saved ARCH in the .config in the past.

There was a config symbol defined for it before the commit removed it.

> 
> 
> > Since commit f467c5640c29 ("kconfig: only write '#
> > CONFIG_FOO is not set' for visible symbols") the value of 64BIT is
> > not saved if the ARCH is set i386 or x86_64 because the symbol is
> > not visible.  
> 
> This is correct.
> 
> It was discussed a few weeks ago.
> 
> https://lkml.org/lkml/2018/6/5/847
> 
> 
> > There is a number of ways to hack this particular case to work.
> >
> > However, there is a more general problem with this. Some config
> > options may depend on the environment, may not be saved, and the
> > environment is not saved either.  
> 
> Which environment variables in particular are in your mind?

Any that is used in Kconfig.

> 
> As for ARCH, you need to pass the same ARCH as you used for building
> the kernel. (For native building, you do not have to pass ARCH
> explicitly, though.)

Except if you do pass it to make config you may need to pass it to to
make later as well.

> 
> As for CC, HOSTCC, etc.
> yes, these are new 'unsaved' environments.
> 
> CONFIG options now depend on the compiler.
> This is the concept suggested by Linus Torvalds.
> 
> 
> > So in the end all the infrastructure with symlinks
> > from module directory pointing to the kernel source and object
> > directory is useless. To interpret the config stored there you need
> > the environment and that is not saved anywhere. So if you try to
> > build out-of-tree module it might end up reconfiguring your kernel
> > and producing useless modules.  
> 
> No. out-of-tree module building never ever re-configures the kernel.

It does implicitly because the config values depend on environment that
is not saved and the values themselves are not saved either. If that
happens to expose a new variable it is even explicitly reconfigured.

> 
> out-of-tree modules are built with exactly the same configuration
> as used for the kernel.

It is not true. And that is the problem. You need the config file and
dump of the environment passed to the make command at configuration
time to get the exact same configuration. The environment is not saved
anywhere, though.

Thanks

Michal
