Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62191C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A542064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A542064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeGZJtr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:49:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeGZJtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:49:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DC05AEB1;
        Thu, 26 Jul 2018 08:33:58 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:33:54 +0200
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
        linux-um@lists.infradead.org, jslaby@suse.com
Subject: Re: due to kconfig changes kernel config file is no longer
 sufficient for configuring the kernel
Message-ID: <20180726103354.111f2d61@naga.suse.cz>
In-Reply-To: <20180628111623.3807fe9b@naga.suse.cz>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
        <20180628111623.3807fe9b@naga.suse.cz>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 11:16:23 +0200
Michal Suchánek <msuchanek@suse.de> wrote:

> On Wed, 27 Jun 2018 23:07:21 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > Hi.
> > 
> > 
> > 2018-06-27 21:37 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:  
> > > Hello,
> > >
> > > in the x86 Kconfig we have this:
> > >
> > > # Select 32 or 64 bit
> > > config 64BIT
> > >         bool "64-bit kernel" if "$(ARCH)" = "x86"
> > >         default "$(ARCH)" != "i386"
> > >         ---help---
> > >           Say yes to build a 64-bit kernel - formerly known as
> > > x86_64 Say no to build a 32-bit kernel - formerly known as i386
> > >
> > > Since commit 104daea149c4 ("kconfig: reference environment
> > > variables directly and remove 'option env='") the value of ARCH
> > > is not saved in the kernel config.    
> > 
> > I think this commit is unrelated.  It was just a syntax change.  
> 
> This does not look like syntax only change to me:
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 15aae32e0719..1217fc62ca61 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1,20 +1,12 @@
> -config ARCH
> -       string
> -       option env="ARCH"
> -
> -config KERNELVERSION
> -       string
> -       option env="KERNELVERSION"
> -
> 
> > 
> > Unless I am missing something,
> > we have never saved ARCH in the .config in the past.  
> 
> There was a config symbol defined for it before the commit removed it.

nonetheless its value was not saved anyway.
> 
> > 
> >   
> > > Since commit f467c5640c29 ("kconfig: only write '#
> > > CONFIG_FOO is not set' for visible symbols") the value of 64BIT is
> > > not saved if the ARCH is set i386 or x86_64 because the symbol is
> > > not visible.    
> > 
> > This is correct.
> > 
> > It was discussed a few weeks ago.
> > 
> > https://lkml.org/lkml/2018/6/5/847

And it went nowhere.

Anyway, the observed issue with CONFIG_64BIT on x86 is the tip of a
larger problem which was unnoticed for ages. The .config simply does
not contain the whole kernel configuration. ie. make oldconfig (and
make syncconfig) is *not* expected to just work. It used to work just by
luck until f467c5640c29 ("kconfig: only write '# CONFIG_FOO is not set'
for visible symbols") finally exposed the problem.

So is .config supposed to contain the kernel configuration or is it
just some byproduct of the kernel build which is meaningless outside of
your build environment (the object tree, shell environment, etc).

Thanks

Michal
