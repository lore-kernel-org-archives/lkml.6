Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965362AbeE2RIQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:08:16 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46812 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965095AbeE2RIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:08:09 -0400
X-Google-Smtp-Source: ADUXVKJEwhXOWngwvdJBQt7deZcGT9pItSAznxVHF87U6MmpZ4czMvcurfmo6+wRlQgSSEh9hKKYw4z1++VGlP4L/1w=
MIME-Version: 1.0
In-Reply-To: <20180529163428.234106-1-liumartin@google.com>
References: <Pine.LNX.4.44L0.1805291003470.1458-100000@iolanthe.rowland.org> <20180529163428.234106-1-liumartin@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 May 2018 20:08:08 +0300
Message-ID: <CAHp75VdSrZU9VozQnLh0YUZVjGHXqfCXkCQMd06y=kST_bhVfg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] driver core: hold dev's parent lock when needed
To: Martin Liu <liumartin@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, jenhaochen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 7:34 PM, Martin Liu <liumartin@google.com> wrote:
> SOC have internal I/O buses that can't be proved for devices. The

Perhaps SoC as a common abbr for system-on-chip.

> devices on the buses can be accessed directly without additinal
> configuration required. This type of bus is represented as
> "simple-bus". In some platforms, we name "soc" with "simple-bus"
> attribute and many devices are hooked under it desribed in DT
> (device tree).

described


>
> In commit 'bf74ad5bc417 introduce ("[PATCH] Hold the device's
> parent's lock during probe and remove")'

The formal commit reference doesn't include '' (surrounding quotes)
and words in square brackets (like [PATCH] here).

> to solve USB subsystem
> lock sequence since usb device's characteristic. Thus "soc"

usb or USB ?

> needs to be locked whenever a device and driver's probing
> happen under "soc" bus. During this period, an async driver
> tries to probe a device which is under the "soc" bus would be
> blocked until previous driver finish the probing and release "soc"
> lock. And the next probing under the "soc" bus need to wait for
> async finish. Because of that, driver's async probe for init
> time improvement will be shadowed.
>
> Since many devices don't have USB devices' characteristic, they
> actually don't need parent's lock. Thus, we introduce a lock flag
> in bus_type struct and driver core would lock the parent lock base
> on the flag. For usbsystem, we set this flag in usb relatvie

USB system

USB

relative

> bus_type struct to keep original lock behavior in driver core.
>
> Async probe could have more benefit after this patch.


> -               if (dev->parent)        /* Needed for USB */
> +               if (dev->parent && dev->bus->need_parent_lock)

So, why not to use bus directly like bus->...?

>                         device_lock(dev->parent);
>                 device_release_driver(dev);
> -               if (dev->parent)
> +               if (dev->parent && dev->bus->need_parent_lock)
>                         device_unlock(dev->parent);

Ditto here and everywhere else in the patch where applicable.

> +       .need_parent_lock = 1,
> +       .need_parent_lock =     1,
> +       .need_parent_lock =     1,

It's boolean, you need to use true or false. Check and fix your code
correspondingly.

> +       bool need_parent_lock;

-- 
With Best Regards,
Andy Shevchenko
