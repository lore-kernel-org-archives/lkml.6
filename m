Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5peXlm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DE7760290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeFFSzp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:55:45 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46705 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932473AbeFFSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:55:43 -0400
X-Google-Smtp-Source: ADUXVKJmUSVv3Rq8mN4HoKC3DL1lCIrJQZXgUPiEWLyhcsVg5XDioY83yoBmhJVeG0dl7snc8zzWEAFeYDI8Po+NoL0=
MIME-Version: 1.0
In-Reply-To: <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com> <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
 <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
 <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com> <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Wed, 6 Jun 2018 21:55:22 +0300
Message-ID: <CAJs94EZx2ZdEL14SCEBomEfXLRPN4FfOp4yE44kfpnE+5+Ze-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-06 16:11 GMT+03:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Wed, 2018-06-06 at 14:15 +0200, Giulio Benetti wrote:
>> Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
>> > On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
>> > > em485 gets lost during
>> > >
>> > > Copy em485 to final uart port.
>> > >
>> >
>> > Is it needed at all?
>> >
>> > The individual driver decides either to use software emulation (and
>> > calls explicitly serial8250_em485_init() for that) or do HW assisted
>> > stuff.
>>
>> In 8250_dw.c, during probe(), I need to call dw8250_rs485_config()
>> against local struct uart_8250_port uart = {};
>> Inside serial8250_register_8250_port() not all uart fields are
>> copied(em485 too).
>> So after probe, em485 is NULL.
>>
>> Another way could be to call dw8250_rs485_config() against real uart
>> port, after calling serial8250_register_8250_port(),
>> would it make sense?
>
> Look at OMAP case closely. They have a callback to configure RS485 which
> is called in uart_set_rs485_config()  which is called whenever user
> space does TIOCGRS485 IOCTL.
>
> So, it's completely driven by user space which makes sense by my
> opinion.

AFAIU, Giulio wants to add support for rs485-enabled-at-boot-time
device tree option (see bindings/serial/rs485.txt for reference).
I suppose it is only important for use-case when rs485 used as slave
(peripheral role).

>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy



-- 
With best regards,
Matwey V. Kornilov
