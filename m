Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeEVJ2T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:28:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46372 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:28:15 -0400
X-Google-Smtp-Source: AB8JxZpeF7KE0UsZZncjpyhwJmmCNtVVfyv1jjygatBCRBdxZjXechUVn4xWbajpbAPZNpfhP4GHoQ+iPNbR8f1kuqA=
MIME-Version: 1.0
In-Reply-To: <20180513160507.9136-1-ezhi99@gmail.com>
References: <CAHp75VdjYxp7QGYdtY3EXNrLZkgEUvQ8C5XssUeLh=0V6zT1jg@mail.gmail.com>
 <20180513160507.9136-1-ezhi99@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 12:28:14 +0300
Message-ID: <CAHp75Vc++CPqQza43tsy2QYbC4rkJb5c+9tX0+KLFP08c7-6uA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: ideapad-laptop: Add fn-lock setting
To: Oleg Keri <ezhi99@gmail.com>
Cc: Ike Panhc <ike.pan@canonical.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 7:05 PM, Oleg Keri <ezhi99@gmail.com> wrote:
> Some of latest Lenovo ideapad laptops do not have UEFI/BIOS setting for
> switching fn-lock mode. This commit adds related acpi calls to ideapad
> platform driver. However setting is available via sysfs.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Oleg Keri <ezhi99@gmail.com>
> ---
>  .../ABI/testing/sysfs-platform-ideapad-laptop | 13 +++++
>  drivers/platform/x86/ideapad-laptop.c         | 52 +++++++++++++++++--
>  2 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> index 597a2f3d..bc1e712d 100644
> --- a/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> +++ b/Documentation/ABI/testing/sysfs-platform-ideapad-laptop
> @@ -25,3 +25,16 @@ Description:
>                 Control touchpad mode.
>                         * 1 -> Switched On
>                         * 0 -> Switched Off
> +
> +What:          /sys/bus/pci/devices/<bdf>/<device>/VPC2004:00/fn_lock
> +Date:          May 2018
> +KernelVersion: 4.17
> +Contact:       "Oleg Keri <ezhi99@gmail.com>"
> +Description:
> +               Control fn-lock mode.
> +                       * 1 -> Switched On
> +                       * 0 -> Switched Off
> +
> +               For example:
> +               # echo "0" >    \
> +               /sys/bus/pci/devices/0000:00:1f.0/PNP0C09:00/VPC2004:00/fn_lock
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 535199c9..2f4991fb 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -43,6 +43,7 @@
>  #define IDEAPAD_RFKILL_DEV_NUM (3)
>
>  #define BM_CONSERVATION_BIT (5)
> +#define HA_FNLOCK_BIT       (10)
>
>  #define CFG_BT_BIT     (16)
>  #define CFG_3G_BIT     (17)
> @@ -59,6 +60,8 @@ static const char *const ideapad_wmi_fnesc_events[] = {
>  enum {
>         BMCMD_CONSERVATION_ON = 3,
>         BMCMD_CONSERVATION_OFF = 5,
> +       HACMD_FNLOCK_ON = 0xe,
> +       HACMD_FNLOCK_OFF = 0xf,
>  };
>
>  enum {
> @@ -139,11 +142,11 @@ static int method_gbmd(acpi_handle handle, unsigned long *ret)
>         return result;
>  }
>
> -static int method_sbmc(acpi_handle handle, int cmd)
> +static int method_int1(acpi_handle handle, char *method, int cmd)
>  {
>         acpi_status status;
>
> -       status = acpi_execute_simple_method(handle, "SBMC", cmd);
> +       status = acpi_execute_simple_method(handle, method, cmd);
>         return ACPI_FAILURE(status) ? -1 : 0;
>  }
>
> @@ -487,7 +490,7 @@ static ssize_t conservation_mode_store(struct device *dev,
>         if (ret)
>                 return ret;
>
> -       ret = method_sbmc(priv->adev->handle, state ?
> +       ret = method_int1(priv->adev->handle, "SBMC", state ?
>                                               BMCMD_CONSERVATION_ON :
>                                               BMCMD_CONSERVATION_OFF);
>         if (ret < 0)
> @@ -497,11 +500,51 @@ static ssize_t conservation_mode_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(conservation_mode);
>
> +static ssize_t fn_lock_show(struct device *dev,
> +                           struct device_attribute *attr,
> +                           char *buf)
> +{
> +       struct ideapad_private *priv = dev_get_drvdata(dev);
> +       unsigned long result;
> +       int hals;
> +       int fail = read_method_int(priv->adev->handle, "HALS", &hals);
> +
> +       if (fail)
> +               return sprintf(buf, "-1\n");
> +
> +       result = hals;
> +       return sprintf(buf, "%u\n", test_bit(HA_FNLOCK_BIT, &result));
> +}
> +
> +static ssize_t fn_lock_store(struct device *dev,
> +                            struct device_attribute *attr,
> +                            const char *buf, size_t count)
> +{
> +       struct ideapad_private *priv = dev_get_drvdata(dev);
> +       bool state;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &state);
> +       if (ret)
> +               return ret;
> +
> +       ret = method_int1(priv->adev->handle, "SALS", state ?
> +                         HACMD_FNLOCK_ON :
> +                         HACMD_FNLOCK_OFF);
> +       if (ret < 0)
> +               return -EIO;
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RW(fn_lock);
> +
> +
>  static struct attribute *ideapad_attributes[] = {
>         &dev_attr_camera_power.attr,
>         &dev_attr_fan_mode.attr,
>         &dev_attr_touchpad.attr,
>         &dev_attr_conservation_mode.attr,
> +       &dev_attr_fn_lock.attr,
>         NULL
>  };
>
> @@ -522,6 +565,9 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
>         } else if (attr == &dev_attr_conservation_mode.attr) {
>                 supported = acpi_has_method(priv->adev->handle, "GBMD") &&
>                             acpi_has_method(priv->adev->handle, "SBMC");
> +       } else if (attr == &dev_attr_fn_lock.attr) {
> +               supported = acpi_has_method(priv->adev->handle, "HALS") &&
> +                       acpi_has_method(priv->adev->handle, "SALS");
>         } else
>                 supported = true;
>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
