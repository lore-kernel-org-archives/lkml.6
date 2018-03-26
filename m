Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCZN1l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:27:41 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:35017 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeCZN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:27:39 -0400
X-Google-Smtp-Source: AG47ELtXElXc32z1OTqFMdUeVc3mojbJ+msGb1pr6RgVOi4HHzId9rpQ9ad3rlFl4DbAJkGIjVBhfQ==
Date: Mon, 26 Mar 2018 09:27:32 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] Implement get_multiple for ACCES and PC/104
 drivers
Message-ID: <20180326132732.GA8889@sophia>
References: <cover.1521723192.git.vilhelm.gray@gmail.com>
 <CACRpkdaGO_ThdgDWGrBygO8o=EoKahZj+-NpRfZCOx49GWd87g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdaGO_ThdgDWGrBygO8o=EoKahZj+-NpRfZCOx49GWd87g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:31:41AM +0200, Linus Walleij wrote:
>On Thu, Mar 22, 2018 at 1:59 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> Changes in v4:
>
>I applied the v4 patch set so we get some rotation in linux-next before
>the merge window.
>
>If reviewers still find smallish issues they can certainly be fixed in follow-up
>patches.
>
>> This patchset implements get_multiple callbacks for the PC104 GPIO
>> drivers as well as the PCI-IDIO-16 and PCIe-IDIO-24 GPIO drivers. These
>> devices all acquire the multiple input lines with a single read, so
>> utilizing the get_multiple callback can provide improvement for those
>> users who regularly access multiple input lines.
>
>Did you use the userspace chardev for some interesting experiments
>with your set-ups?
>
>I tend to think of your applications as pretty interesting for industry
>peers, and a good proof-of-concept for the userspace API.

I use these PC104 drivers in several semi-realtime critical
applications, so latency has always been a big concern for me. The
switch from sysfs file I/O to chardev ioctl had a great improvement in
the reduction of latency, which I was very happy to utilize.

Since the next big point of latency in my systems have been port I/O,
taking advantage of the get_multiple/set_multiple functionality is my
next goal in optimization. I have a new system coming out soon that uses
the 104-IDI-48 for input -- it'll be interesting to see the performance
improvements of acquiring the entire input port at a time, rather than
every GPIO line individually.

>
>> While developing this patchset I noticed many of these devices make use
>> of Intel 8255 compatible interfaces for their I/O. I may write a generic
>> 8255 GPIO driver in the future to reduce some of the redundant code I
>> see pop among the drivers for these devices.
>
>Oh!
>This guy?
>https://en.wikipedia.org/wiki/Intel_8255
>
>Yeah that makes all kind of sense. We are living with the legacy
>of the first PCs every day when it comes own to EISA & friends...

That's the one! I see this interface a lot in the GPIO devices I handle.
It's very popular, which I believe is a testament to the popularity of
the IBM PC.

Nowadays, most devices I encounter implement this interface in an FPGA,
but I do occasionally come across the actual Intel 82C55 chip, such as
on the 104-DIO-48E; it's fascinating to see this physical chip still
popping up on circuit boards from time to time.

I would like to make a generic driver for this interface that will allow
it to be used both in the port I/O and memory I/O drivers out there.
Since I don't want to introduce too many changes in a single patchset
I've postponed it for now to get get_multiple support merged in for
these drivers, but I'll hopefully have something like a gpio-i8255
driver submitted soon enough.

William Breathitt Gray

>
>Yours,
>Linus Walleij
