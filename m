Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeDWKFN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:05:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60495 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754404AbeDWKFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:05:10 -0400
Date: Mon, 23 Apr 2018 12:04:59 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH] m68k: Remove read_persistent_clock()
Message-ID: <20180423100459.GB7218@piout.net>
References: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
 <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com>
 <CAMuHMdVQea-tQ4vQF=SrkCCqaRCRyo=aBiAuyv7p0z0FEi3r2g@mail.gmail.com>
 <CAK8P3a2FNU2k=nzE=FCt=2GL2x=-UdhkFGUJQqFe-h8FfMZRdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2FNU2k=nzE=FCt=2GL2x=-UdhkFGUJQqFe-h8FfMZRdw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2018 11:28:38+0200, Arnd Bergmann wrote:
> Some extra background on this:
> 
> read_persistent_clock64/read_persistent_clock is primarily needed when you
> have a real time source that is better than the one exposed in the RTC class
> driver.  For platforms doing suspend/resume, the timekeeping code will
> first try calling read_persistent_clock64() but fall back to the RTC
> if that fails.
> On only a few architectures like m68k, read_persistent_clock64() falls
> back to reading the RTC hardware, which means it will still work even if
> the RTC_DRV_GENERIC driver is not loaded. Removing that code will
> still work correctly as long as the generic RTC driver does get loaded
> before suspend. On platforms without suspend/resume, none of this matters.
> 
> The other user of read_persistent_clock() is to set the initial time at boot.
> This again can be done by the RTC subsystem if the correct RTC driver
> is built-in and CONFIG_RTC_HCTOSYS is set. Alexandre is planning
> to remove that option and instead force early user space to load the
> RTC driver and then sync it manually using the sysfs knob for it.
> 

There is still one use case that could require CONFIG_RTC_HCTOSYS, that's
when the rootfs is on a network fs that requires the time to be roughly
set before being accessed. This could be solved with an initramfs though
(and that initramfs would be required if the RTC driver is a module
anyway).

I still need to check the 'avoid unnecessary fsck runs at boot time'
claim but having the kernel modules and fsck on separate FS seems to be
a very very specific use case to me.

But yes, my plan is at least to get distros to stop enabling it by
default on all their kernels because this led to multiple reports of
systemd entering a loop and this not so nice workaround (still way
better than having each driver have its own version though):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/rtc/hctosys.c?id=b3a5ac42ab18b7d1a8f2f072ca0ee76a3b754a43

> If you have ancient user space that doesn't do this, you might still
> rely on read_persistent_clock() to set the boot time.
> 

Last time I checked a default debian install on x86 would set the system
time 2 times from the kernel and then 2 times from userspace.

I'm pretty sure we could do without read_persistent_clock and
CONFIG_RTC_HCTOSYS and let userspace handle system time. For example, on
ARM, only omap and tegra are defining a read_persistent_clock callback.
All the other platforms are just working fine without it. As you pointed
out on IRC a while ago, s390 seems to be the only user where this is
actually useful.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
