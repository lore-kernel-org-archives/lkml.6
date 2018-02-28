Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeB1QOB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:14:01 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35192 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbeB1QN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:13:57 -0500
X-Google-Smtp-Source: AG47ELvYeFC3kd7mv20jUPWODAN6aQudi00ryJn4ELELFS3x7IFaHeicJFkoC3XDVWdRRddMd1fASNUgzhWtHnwA8Cc=
MIME-Version: 1.0
In-Reply-To: <20180227211539.5708-7-kernel@kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl> <20180227211539.5708-7-kernel@kempniu.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 18:13:55 +0200
Message-ID: <CAHp75VeANKg+L7GsA=onScQ6mBeWzhthd0cP6=36rFB4KHWr7w@mail.gmail.com>
Subject: Re: [PATCH 6/7] platform/x86: fujitsu-laptop: More accurately
 represent the hotkey ring buffer managed by firmware
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1SGE4Xi003821

On Tue, Feb 27, 2018 at 11:15 PM, Michał Kępień <kernel@kempniu.pl> wrote:
> The MAX_HOTKEY_RINGBUFFER_SIZE constant is set to 100, which allows up
> to 100 hotkey events to be drained from the firmware ring buffer upon
> module load.  However, no known firmware is capable of holding more than
> 16 hotkey events in its internal ring buffer:

> The RINGBUFFERSIZE constant is set to 40, which allows the module to
> queue up to 40 hotkey events for delivery to user space.  As this value
> seems arbitrarily chosen and 16 should be more than enough for any
> practical use case, merge the two aforementioned constants into one
> (HOTKEY_RINGBUFFER_SIZE) in order to simplify code and more accurately
> represent the underlying data structure.

> +#define HOTKEY_RINGBUFFER_SIZE         16

This need the comment or a

BUILD_BUG_ON(!is_power_of_2(...));


> -       ret = kfifo_alloc(&priv->fifo, RINGBUFFERSIZE * sizeof(int),
> +       ret = kfifo_alloc(&priv->fifo, HOTKEY_RINGBUFFER_SIZE * sizeof(int),
>                           GFP_KERNEL);

>         while (call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
>                               0x0, 0x0) != 0 &&
> -              i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
> +              i++ < HOTKEY_RINGBUFFER_SIZE)
>                 ; /* No action, result is discarded */

This looks horrible.
Can it be redone

do {
 if (call...() == 0)
  break;
} while (i++ < ...);

?

>         while ((irb = call_fext_func(device, FUNC_BUTTONS, OP_GET_EVENTS,
>                                      0x0, 0x0)) != 0 &&
> -              i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
> +              i++ < HOTKEY_RINGBUFFER_SIZE) {

Ditto.

>                 scancode = irb & 0x4ff;
>                 if (sparse_keymap_entry_from_scancode(priv->input, scancode))
>                         acpi_fujitsu_laptop_press(device, scancode);


-- 
With Best Regards,
Andy Shevchenko
