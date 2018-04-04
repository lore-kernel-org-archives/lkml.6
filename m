Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDDNVb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:21:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42375 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeDDNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:21:29 -0400
X-Google-Smtp-Source: AIpwx4/zBRkp1jqEI23eZfJHTFLCC6X/RtML0i8VNB6Brdyf1uMuN93A8upiF+yInkdtw+OtR4YPzw==
Date: Wed, 4 Apr 2018 09:21:21 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [GIT PULL] Bulk GPIO changes for v4.17
Message-ID: <20180404132121.GA28103@sophia>
References: <CACRpkdaKWTAz=VLz9W8wWwQEvOLLw4jPWcAKrjJ+KW5FK5ZvMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdaKWTAz=VLz9W8wWwQEvOLLw4jPWcAKrjJ+KW5FK5ZvMw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 01:19:29PM +0200, Linus Walleij wrote:
>- There is a series of ISA_BUS_API changes that ended up
>  getting queued in my tree. Most of them have proper ACKs
>  and they have been tested throughly in linux-next.
>  These patches finally split ISA_BUS and ISA_BUS_API
>  apart as I understand it, as there are devices using
>  port-mapped I/O but not strictly speaking using any ISA
>  bus. So the ISA_BUS and the ISA_BUS_API are two
>  things. The most notable effect of ISA_BUS_API is that
>  it compiles drivers/base/isa.c so that we get device driver
>  core infrastructure for these devices. The ISA bus was merged
>  in 2006 (a5117ba7da37) and was used for sound cards and
>  watchdog, but only recently William started
>  to use it for his industrial data acquisition cards and he's found
>  a bit of problems that are now (hopefully) finally fixed up.
>  Any questions: William Breathitt Gray is on the CC for this
>  pull request to answer them.

Some background on the impetus and rationale of the ISA_BUS_API Kconfig
changes:

During submission of the Winbond GPIO driver (a0d65009411c), an attempt
to select ISA_BUS_API revealed a recursive dependency bug:
https://lkml.org/lkml/2017/12/26/235

The recursive dependency could be avoided if ISA_BUS_API was selected by
drivers where needed rather than depended on. A select semantic makes
sense as well for these drivers because ISA_BUS_API is simply used to
compile the drivers/base/isa.c file, which is just a thin wrapper to
allow these ISA-style I/O port drivers to fit the device driver model.

ISA_BUS_API is decoupled from the ISA_BUS so that it can be selected
independent of the legacy ISA_BUS drivers, which do not necessary make
use of drivers/base/isa.c functionality. Thus there is a clean
separation between the modern drivers for ISA-style devices which select
ISA_BUS_API, and the legacy drivers for true ISA cards which utilize the
legacy ISA_BUS Kconfig option.

The reason these changes are coming in through the GPIO tree is to avoid
a similar recursive dependency error if the STX104 IIO driver attempts
to select ISA_BUS_API separate from the other patches (due to its
GPIOLIB selection): https://lkml.org/lkml/2017/12/29/384

These updates missed the last merge window, so the Winbond GPIO driver
was merged in at that time with a "depends on ISA_BUS_API" line patch to
pacify the recursive dependency error. Now that these updates were
picked up in the GPIO tree, the revert patch was merged to revert the
"depends on ISA_BUS_API" line to the originally intended
"select ISA_BUS_API" line.

Finally, an explicit EXPERT dependency is added to the PC104 Kconfig
option to keep the PC/104 drivers masked as they have been -- the
PC/104 interface is somewhat niche and unlikely to be a concern for
regular users, so let's keep it tucked away.

William Breathitt Gray
