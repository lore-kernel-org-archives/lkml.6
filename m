Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeCFOVD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:21:03 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41306 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeCFOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:21:01 -0500
X-Google-Smtp-Source: AG47ELsRdlBoYkru8kC7Iz3nL6t4dl0UezKUOoTl0j6zuw5/YzRfKpdkE97re3qPwn5gBTU+TgR0qrnxvqRNMatJCFY=
MIME-Version: 1.0
In-Reply-To: <20171208142944.15695-1-benjamin.tissoires@redhat.com>
References: <20171208142944.15695-1-benjamin.tissoires@redhat.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 6 Mar 2018 15:21:00 +0100
Message-ID: <CAO-hwJJGvaT5_5NW9u0zgJ=d+s0vHF6TOiNN--PzHq5e281Frw@mail.gmail.com>
Subject: Re: [PATCH 1/1] HID: core: rewrite the hid-generic automatic unbind
To: Jiri Kosina <jikos@kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Fri, Dec 8, 2017 at 3:29 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> We actually can have the unbind/rebind logic in hid-core.c, leaving
> only the match function in hid-generic.
> This makes hid-generic simpler and the whole logic simpler too.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> Hi Jiri,
>
> while trying to find out a local bug, I figured out we don't really
> need the bus_add_driver and bus_removed_driver callbacks.
>
> This makes the code simpler and also allows other drivers to remove
> themself if other conditions are met. They just need to implement a smart
> enough .matchcallback and they are done.
>

Looks like you are reviewing HID patches right now :)
I just wanted to dig this one out from your mailbox. I still think
it's valuable.
IIRC it should still apply on your tree, but if not, I can quickly
update the patch.

Cheers,
Benjamin

>  drivers/hid/hid-core.c    | 35 ++++++++++++++++++++++++-----------
>  drivers/hid/hid-generic.c | 33 ---------------------------------
>  include/linux/hid.h       |  4 ----
>  3 files changed, 24 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c2560aae5542..c058bb911ca1 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2197,31 +2197,40 @@ void hid_destroy_device(struct hid_device *hdev)
>  EXPORT_SYMBOL_GPL(hid_destroy_device);
>
>
> -static int __bus_add_driver(struct device_driver *drv, void *data)
> +static int __hid_bus_reprobe_drivers(struct device *dev, void *data)
>  {
> -       struct hid_driver *added_hdrv = data;
> -       struct hid_driver *hdrv = to_hid_driver(drv);
> +       struct hid_driver *hdrv = data;
> +       struct hid_device *hdev = to_hid_device(dev);
>
> -       if (hdrv->bus_add_driver)
> -               hdrv->bus_add_driver(added_hdrv);
> +       if (hdev->driver == hdrv &&
> +           !hdrv->match(hdev, hid_ignore_special_drivers))
> +               return device_reprobe(dev);
>
>         return 0;
>  }
>
> -static int __bus_removed_driver(struct device_driver *drv, void *data)
> +static int __hid_bus_driver_added(struct device_driver *drv, void *data)
>  {
> -       struct hid_driver *removed_hdrv = data;
>         struct hid_driver *hdrv = to_hid_driver(drv);
>
> -       if (hdrv->bus_removed_driver)
> -               hdrv->bus_removed_driver(removed_hdrv);
> +       if (hdrv->match) {
> +               bus_for_each_dev(&hid_bus_type, NULL, hdrv,
> +                                __hid_bus_reprobe_drivers);
> +       }
>
>         return 0;
>  }
>
> +static int __bus_removed_driver(struct device_driver *drv, void *data)
> +{
> +       return bus_rescan_devices(&hid_bus_type);
> +}
> +
>  int __hid_register_driver(struct hid_driver *hdrv, struct module *owner,
>                 const char *mod_name)
>  {
> +       int ret;
> +
>         hdrv->driver.name = hdrv->name;
>         hdrv->driver.bus = &hid_bus_type;
>         hdrv->driver.owner = owner;
> @@ -2230,9 +2239,13 @@ int __hid_register_driver(struct hid_driver *hdrv, struct module *owner,
>         INIT_LIST_HEAD(&hdrv->dyn_list);
>         spin_lock_init(&hdrv->dyn_lock);
>
> -       bus_for_each_drv(&hid_bus_type, NULL, hdrv, __bus_add_driver);
> +       ret = driver_register(&hdrv->driver);
> +
> +       if (ret == 0)
> +               bus_for_each_drv(&hid_bus_type, NULL, NULL,
> +                                __hid_bus_driver_added);
>
> -       return driver_register(&hdrv->driver);
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(__hid_register_driver);
>
> diff --git a/drivers/hid/hid-generic.c b/drivers/hid/hid-generic.c
> index 3c0a1bf433d7..c25b4718de44 100644
> --- a/drivers/hid/hid-generic.c
> +++ b/drivers/hid/hid-generic.c
> @@ -26,37 +26,6 @@
>
>  static struct hid_driver hid_generic;
>
> -static int __unmap_hid_generic(struct device *dev, void *data)
> -{
> -       struct hid_driver *hdrv = data;
> -       struct hid_device *hdev = to_hid_device(dev);
> -
> -       /* only unbind matching devices already bound to hid-generic */
> -       if (hdev->driver != &hid_generic ||
> -           hid_match_device(hdev, hdrv) == NULL)
> -               return 0;
> -
> -       if (dev->parent)        /* Needed for USB */
> -               device_lock(dev->parent);
> -       device_release_driver(dev);
> -       if (dev->parent)
> -               device_unlock(dev->parent);
> -
> -       return 0;
> -}
> -
> -static void hid_generic_add_driver(struct hid_driver *hdrv)
> -{
> -       bus_for_each_dev(&hid_bus_type, NULL, hdrv, __unmap_hid_generic);
> -}
> -
> -static void hid_generic_removed_driver(struct hid_driver *hdrv)
> -{
> -       int ret;
> -
> -       ret = driver_attach(&hid_generic.driver);
> -}
> -
>  static int __check_hid_generic(struct device_driver *drv, void *data)
>  {
>         struct hid_driver *hdrv = to_hid_driver(drv);
> @@ -97,8 +66,6 @@ static struct hid_driver hid_generic = {
>         .name = "hid-generic",
>         .id_table = hid_table,
>         .match = hid_generic_match,
> -       .bus_add_driver = hid_generic_add_driver,
> -       .bus_removed_driver = hid_generic_removed_driver,
>  };
>  module_hid_driver(hid_generic);
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 091a81cf330f..a62ee4a609ac 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -686,8 +686,6 @@ struct hid_usage_id {
>   * @input_mapped: invoked on input registering after mapping an usage
>   * @input_configured: invoked just before the device is registered
>   * @feature_mapping: invoked on feature registering
> - * @bus_add_driver: invoked when a HID driver is about to be added
> - * @bus_removed_driver: invoked when a HID driver has been removed
>   * @suspend: invoked on suspend (NULL means nop)
>   * @resume: invoked on resume if device was not reset (NULL means nop)
>   * @reset_resume: invoked on resume if device was reset (NULL means nop)
> @@ -742,8 +740,6 @@ struct hid_driver {
>         void (*feature_mapping)(struct hid_device *hdev,
>                         struct hid_field *field,
>                         struct hid_usage *usage);
> -       void (*bus_add_driver)(struct hid_driver *driver);
> -       void (*bus_removed_driver)(struct hid_driver *driver);
>  #ifdef CONFIG_PM
>         int (*suspend)(struct hid_device *hdev, pm_message_t message);
>         int (*resume)(struct hid_device *hdev);
> --
> 2.14.3
>
