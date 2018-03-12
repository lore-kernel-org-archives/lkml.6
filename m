Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeCLRAK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:00:10 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37469 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeCLRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:00:08 -0400
X-Google-Smtp-Source: AG47ELsvvPqVlzaVk7jmmz9DIZQCiRIsbKDlW3iQ1iVjLFYTYJqfFOoS1xknGk+vDmmHKAF3taPGOA==
Date: Mon, 12 Mar 2018 13:00:06 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-2-arnd@arndb.de> <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr> <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
 <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Arnd Bergmann wrote:

> On Mon, Mar 12, 2018 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Mar 12, 2018 at 3:40 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
> >
> >>> Obviously we want to make the combination work, no idea why it doesn't.
> >>
> >> Well, it does work regardless of the noise. Here the nm output is piped
> >> into sed, and the later exits early when it finds what it is looking
> >> for, causing nm to complain about the broken pipe.
> >>
> >> Here's a patch silencing this bogus error message and fixing other minor
> >> issues.
> >>
> >> ----- >8
> >> Subject: [PATCH] ARM: deflate_xip_data.sh: minor fixes
> >>
> >> Send nm complaints about broken pipe (when sed exits early) to /dev/null.
> >> All errors should be printed to stderr.
> >> Don't trap on normal exit so the trap can return an error code.
> >>
> >> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> >
> > Ah, that explains it, thanks!
> >
> > Tested-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> Nevermind, I confused it with a different problem that I'm running into
> with randconfig builds:

At least you no longer get the "broken pipe" warning as your initial 
report showed, right?

> arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux':
> No such file

That is weird. The Makefile has:

cmd_mkxip = $(cmd_objcopy) && $(cmd_deflate_xip_data)

$(obj)/xipImage: vmlinux FORCE
        $(call if_changed,mkxip)

So the objcopy must succeed at producing vmlinux for deflate_xip_data 
(where nm is used) to be called.

Do you have a .config for this issue?


Nicolas
