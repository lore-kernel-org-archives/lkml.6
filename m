Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeFEQoV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:44:21 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46767 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFEQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:44:19 -0400
X-Google-Smtp-Source: ADUXVKLtFVlFqfooEfRPa6DfqjPa5MRVVG2UrF1tLevW8qhP717loZKdpnX9vBqXQQMzeicG6LY1Qrw+jewSz5RF6XQ=
MIME-Version: 1.0
In-Reply-To: <20180516024004.28977-2-pasha.tatashin@oracle.com>
References: <20180516024004.28977-1-pasha.tatashin@oracle.com> <20180516024004.28977-2-pasha.tatashin@oracle.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 19:44:18 +0300
Message-ID: <CAHp75Vduh4FG=K56-8bhoDPic_BXcV3UfV8Mxp_UZOeqeJ6F8w@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drivers core: refactor device_shutdown
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>, tobin@apporbit.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 5:40 AM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> device_shutdown() traverses through the list of devices, and calls
> dev->{bug/driver}->shutdown() for each entry in the list.
>
> Refactor the function by keeping device_shutdown() to do the logic of
> traversing the list of devices, and device_shutdown_one() to perform the
> actual shutdown operation on one device.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/base/core.c | 50 +++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b610816eb887..ed189f6d1a2f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2765,6 +2765,35 @@ int device_move(struct device *dev, struct device *new_parent,
>  }
>  EXPORT_SYMBOL_GPL(device_move);
>
> +/*
> + * device_shutdown_one - call ->shutdown() for the device passed as
> + * argument.
> + */
> +static void device_shutdown_one(struct device *dev)
> +{
> +       /* Don't allow any more runtime suspends */
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_barrier(dev);
> +
> +       if (dev->class && dev->class->shutdown_pre) {
> +               if (initcall_debug)
> +                       dev_info(dev, "shutdown_pre\n");
> +               dev->class->shutdown_pre(dev);
> +       }
> +       if (dev->bus && dev->bus->shutdown) {
> +               if (initcall_debug)
> +                       dev_info(dev, "shutdown\n");
> +               dev->bus->shutdown(dev);
> +       } else if (dev->driver && dev->driver->shutdown) {
> +               if (initcall_debug)
> +                       dev_info(dev, "shutdown\n");
> +               dev->driver->shutdown(dev);
> +       }
> +
> +       /* decrement the reference counter */
> +       put_device(dev);
> +}
> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
> @@ -2801,30 +2830,11 @@ void device_shutdown(void)
>                         device_lock(parent);
>                 device_lock(dev);
>
> -               /* Don't allow any more runtime suspends */
> -               pm_runtime_get_noresume(dev);
> -               pm_runtime_barrier(dev);
> -
> -               if (dev->class && dev->class->shutdown_pre) {
> -                       if (initcall_debug)
> -                               dev_info(dev, "shutdown_pre\n");
> -                       dev->class->shutdown_pre(dev);
> -               }
> -               if (dev->bus && dev->bus->shutdown) {
> -                       if (initcall_debug)
> -                               dev_info(dev, "shutdown\n");
> -                       dev->bus->shutdown(dev);
> -               } else if (dev->driver && dev->driver->shutdown) {
> -                       if (initcall_debug)
> -                               dev_info(dev, "shutdown\n");
> -                       dev->driver->shutdown(dev);
> -               }
> -
> +               device_shutdown_one(dev);
>                 device_unlock(dev);
>                 if (parent)
>                         device_unlock(parent);
>
> -               put_device(dev);
>                 put_device(parent);
>
>                 spin_lock(&devices_kset->list_lock);
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
