Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936596AbeE2P2g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:28:36 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45342 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935040AbeE2P21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:28:27 -0400
X-Google-Smtp-Source: ADUXVKI2rvnBze2QY65gyWyl3sraET3P4BmgbYWdjN/aU6/O2C8jR/QOXcmrGlIDIBVljI27ZW+Fie7BoHXTa8sOCCI=
MIME-Version: 1.0
In-Reply-To: <20180529070719.164626-1-liumartin@google.com>
References: <Pine.LNX.4.44L0.1805241100000.1871-100000@iolanthe.rowland.org> <20180529070719.164626-1-liumartin@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 May 2018 18:28:25 +0300
Message-ID: <CAHp75VejjrmZhEbvV3DEJ88PGnncySdTaWDPFA8Ba5hBy6rmpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] driver core: hold dev's parent lock when needed
To: martin_liu <liumartin@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>, jenhaochen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:07 AM, martin_liu <liumartin@google.com> wrote:
> SOC have internal I/O buses that can't be proved for devices. The
> devices on the buses can be accessed directly without additinal
> configuration required. This type of bus is represented as
> "simple-bus". In some platforms, we name "soc" with "simple-bus"
> attribute and many devices are hooked under it desribed in DT
> (device tree).
>
> In commit 'bf74ad5bc417 introduce ("[PATCH] Hold the device's
> parent's lock during probe and remove")' to solve USB subsystem
> lock sequence since usb device's characteristic. Thus "soc"
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
> in device struct and driver core would lock the parent lock base
> on the flag. For usbsystem, we set this flag when its device and
> driver is matched and to keep original lock behavior in driver
> core.
>
> Async probe could have more benefit after this patch.

> Signed-off-by: martin_liu <liumartin@google.com>

Strange Firstname Lastname format...

> Suggested-by: Alan Stern <stern@rowland.harvard.edu>

I guess your SoB should go last (at least this is how -s works in git commit)

>         /* Some ULPI devices don't have a vendor id so rely on OF match */
> -       if (ulpi->id.vendor == 0)
> -               return of_driver_match_device(dev, driver);
> +       if (ulpi->id.vendor == 0) {
> +               if (of_driver_match_device(dev, driver)) {
> +                       dev->need_parent_lock = 1;
> +                       return 1;
> +               }

> +               return o;

Return what?

> +       }

-- 
With Best Regards,
Andy Shevchenko
