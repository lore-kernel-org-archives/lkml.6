Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C95C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D032146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoJeBvZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D032146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLKS7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:59:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45164 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeLKS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:59:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so5886432ywd.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VR8+oGGol/C9scwrZog004Cous9JPAyn2pHbqUI7h4=;
        b=EoJeBvZTNwcSACd1Swoz1RVEAYZ9L1sFngQHN5fE7P6du1FxCnnMGcjASNBPX5KSB0
         zyqOwlvMSRwzzckT3npIx62Q9XHq4O37QaC9EJY+mZB9Xsk4TlJW+xwkTsj/qBQrjYyd
         5d/XbOVqsvu0GS/lrMXaoOD/N/c4fZuiVnrL6tgehlH/caDTNaHwR2jxmdqakBXWEott
         E2gRf4+zfluragAK91hV3NPPzlrEiwWr/D1gnkNGMjq6ZYFwi/wjDSGPrcMdrkbuox+N
         pQZUhD0ZiV1vg98jaNsza2Y4UVPUSdNb8xecRjRQhe4JZPeYArlVOGZbn4MyGw8Esffk
         oAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VR8+oGGol/C9scwrZog004Cous9JPAyn2pHbqUI7h4=;
        b=uPzZFws2ZFLKzd1/NNpRRETVvG27W3oieuw9GPBLIzw3YLGcUzxqlVc7GUukoBHzQ3
         QlsHDHU+RHft2x+vUQ7prgbtshn7WtIuFtHMP8Y5F/VIFf4utYhZ7A6cGj4Qi8KaKuPw
         3wpI0oxpqXnsa3lDfN4vijgV+akXZYISVoy/jkLCUTklQX5zbNiBHLA5UwJN2Kxiz24Y
         qGThHjPB2CLJEn+hqyWggIeVxviTddaaRAntZufahb74FV0ajwJoocoy3hSikOgdvhZM
         7nw8B0ra6BGVsL7+z2McEdA4uCsUc08rjk2uQ/bQeN9yIKcSFwsrIqtaUsTXxtjUtPay
         uRdQ==
X-Gm-Message-State: AA+aEWaSzLm2KcvaZwgiw9aiKaJNApv6qfD/wiwF6rmp5ANhWtqan9cP
        v/uvZUIhBjblybsn59X2ye6U4klou7zjHGyR4PVORg==
X-Google-Smtp-Source: AFSGD/UCfO9OmdNBcPyzDpV0nEhZOLMxVsK17MdAfwVZYgsK7IjsCjFGGnBlqNXfZS8gqP4asLchonHyKTuIgCy/Ldw=
X-Received: by 2002:a81:ec12:: with SMTP id j18mr4158254ywm.17.1544554781203;
 Tue, 11 Dec 2018 10:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20181211175934.10238-1-enric.balletbo@collabora.com> <20181211175934.10238-6-enric.balletbo@collabora.com>
In-Reply-To: <20181211175934.10238-6-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 11 Dec 2018 10:59:29 -0800
Message-ID: <CABXOdTdHQGm1nLp_7nh2KGdqKvpJ8UpPf6C=GXvXUuSJjrk1Aw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] mfd / platform: cros_ec: move device sysfs
 attributes to its own driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 9:59 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The entire way how cros debugfs attibutes are created is broken.
> cros_ec_sysfs should be its own driver and its attributes should be
> associated with the sysfs driver not the mfd driver.
>
> The patch also adds the sysfs documentation.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Sorry, one more nitpick I just realized. Other than that,

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v4:
> - Use <ec-device-name> instead of <cros-ec> in documentation.
> - Use default MFD_CROS_EC_CHARDEV in Kconfig.
>
> Changes in v3:
> - Do not print ec_platform name as is with dev_err is enough.
>
> Changes in v2:
> - Create the attributes directly instead of use the attach/detach callbacks.
>
>  .../ABI/testing/sysfs-class-chromeos          | 32 +++++++++++++++++
>  drivers/mfd/Kconfig                           |  1 -
>  drivers/mfd/cros_ec_dev.c                     |  7 +---
>  drivers/platform/chrome/Kconfig               | 14 ++++++--
>  drivers/platform/chrome/Makefile              |  3 +-
>  drivers/platform/chrome/cros_ec_sysfs.c       | 36 ++++++++++++++++++-
>  include/linux/mfd/cros_ec.h                   |  3 --
>  7 files changed, 80 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos
>
> diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
> new file mode 100644
> index 000000000000..5819699d66ec
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-chromeos
> @@ -0,0 +1,32 @@
> +What:          /sys/class/chromeos/<ec-device-name>/flashinfo
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               Show the EC flash information.
> +
> +What:          /sys/class/chromeos/<ec-device-name>/kb_wake_angle
> +Date:          March 2018
> +KernelVersion: 4.17
> +Description:
> +               Control the keyboard wake lid angle. Values are between
> +               0 and 360. This file will also show the keyboard wake lid
> +               angle by querying the hardware.
> +
> +What:          /sys/class/chromeos/<ec-device-name>/reboot
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               Tell the EC to reboot in various ways. Options are:
> +               "cancel": Cancel a pending reboot.
> +               "ro": Jump to RO without rebooting.
> +               "rw": Jump to RW without rebooting.
> +               "cold": Cold reboot.
> +               "disable-jump": Disable jump until next reboot.
> +               "hibernate": Hibernate the EC.
> +               "at-shutdown": Reboot after an AP shutdown.
> +
> +What:          /sys/class/chromeos/<ec-device-name>/version
> +Date:          August 2015
> +KernelVersion: 4.2
> +Description:
> +               Show the information about the EC software and hardware.
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8c5dfdce4326..089ffb408918 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -214,7 +214,6 @@ config MFD_CROS_EC
>  config MFD_CROS_EC_CHARDEV
>          tristate "Chrome OS Embedded Controller userspace device interface"
>          depends on MFD_CROS_EC
> -        select CROS_EC_CTL
>          ---help---
>            This driver adds support to talk with the ChromeOS EC from userspace.
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 9955937b821d..b9ec2a798dbb 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -34,15 +34,9 @@
>  #define CROS_MAX_DEV 128
>  static int ec_major;
>
> -static const struct attribute_group *cros_ec_groups[] = {
> -       &cros_ec_attr_group,
> -       NULL,
> -};
> -
>  static struct class cros_class = {
>         .owner          = THIS_MODULE,
>         .name           = "chromeos",
> -       .dev_groups     = cros_ec_groups,
>  };
>
>  /* Basic communication */
> @@ -396,6 +390,7 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  static const struct mfd_cell cros_ec_platform_cells[] = {
>         { .name = "cros-ec-debugfs" },
>         { .name = "cros-ec-lightbar" },
> +       { .name = "cros-ec-sysfs" },
>         { .name = "cros-ec-vbc" },
>  };
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 6cbf5b69d156..5e2fde5ff63d 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -49,9 +49,6 @@ config CHROMEOS_TBMC
>           To compile this driver as a module, choose M here: the
>           module will be called chromeos_tbmc.
>
> -config CROS_EC_CTL
> -        tristate
> -
>  config CROS_EC_I2C
>         tristate "ChromeOS Embedded Controller (I2C)"
>         depends on MFD_CROS_EC && I2C
> @@ -144,4 +141,15 @@ config CROS_EC_DEBUGFS
>           To compile this driver as a module, choose M here: the
>           module will be called cros_ec_debugfs.
>
> +config CROS_EC_SYSFS
> +       tristate "ChromeOS EC control and information through sysfs"
> +       depends on MFD_CROS_EC_CHARDEV && SYSFS
> +       default MFD_CROS_EC_CHARDEV
> +       help
> +         This option exposes some sysfs attributes to control and get
> +         information from ChromeOS EC.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called cros_ec_sysfs.
> +
>  endif # CHROMEOS_PLATFORMS
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 12a5c4d18c17..fdbee501931b 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -3,8 +3,6 @@
>  obj-$(CONFIG_CHROMEOS_LAPTOP)          += chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)          += chromeos_pstore.o
>  obj-$(CONFIG_CHROMEOS_TBMC)            += chromeos_tbmc.o
> -cros_ec_ctl-objs                       := cros_ec_sysfs.o
> -obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
>  obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
> @@ -15,3 +13,4 @@ obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)  += cros_kbd_led_backlight.o
>  obj-$(CONFIG_CROS_EC_LIGHTBAR)         += cros_ec_lightbar.o
>  obj-$(CONFIG_CROS_EC_VBC)              += cros_ec_vbc.o
>  obj-$(CONFIG_CROS_EC_DEBUGFS)          += cros_ec_debugfs.o
> +obj-$(CONFIG_CROS_EC_SYSFS)            += cros_ec_sysfs.o
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index f34a50121064..0ff5aa30c070 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -34,6 +34,8 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>
> +#define DRV_NAME "cros-ec-sysfs"
> +
>  /* Accessor functions */
>
>  static ssize_t reboot_show(struct device *dev,
> @@ -353,7 +355,39 @@ struct attribute_group cros_ec_attr_group = {

I think this should now be static.

>         .attrs = __ec_attrs,
>         .is_visible = cros_ec_ctrl_visible,
>  };
> -EXPORT_SYMBOL(cros_ec_attr_group);
> +
> +static int cros_ec_sysfs_probe(struct platform_device *pd)
> +{
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> +       struct device *dev = &pd->dev;
> +       int ret;
> +
> +       ret = sysfs_create_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> +       if (ret < 0)
> +               dev_err(dev, "failed to create attributes. err=%d\n", ret);
> +
> +       return ret;
> +}
> +
> +static int cros_ec_sysfs_remove(struct platform_device *pd)
> +{
> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> +
> +       sysfs_remove_group(&ec_dev->class_dev.kobj, &cros_ec_attr_group);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver cros_ec_sysfs_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +       },
> +       .probe = cros_ec_sysfs_probe,
> +       .remove = cros_ec_sysfs_remove,
> +};
> +
> +module_platform_driver(cros_ec_sysfs_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("ChromeOS EC control driver");
> +MODULE_ALIAS("platform:" DRV_NAME);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 3e4401e2ceea..f718ad9c2132 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -323,7 +323,4 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>   */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>
> -/* sysfs stuff */
> -extern struct attribute_group cros_ec_attr_group;
> -
>  #endif /* __LINUX_MFD_CROS_EC_H */
> --
> 2.19.2
>
