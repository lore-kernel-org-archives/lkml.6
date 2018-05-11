Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeEKJlR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:41:17 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33106 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeEKJlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:41:15 -0400
X-Google-Smtp-Source: AB8JxZpwKquXBHOQ4dnjecAiiF14d+0aClzYARZwlItvkhgSbpSC0Nx1xns0+zBMZTOelG0r3+ZE2snv6cZ2Xz0ZQp4=
MIME-Version: 1.0
In-Reply-To: <20180509181650.13687-1-ezhi99@gmail.com>
References: <20180509181650.13687-1-ezhi99@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 May 2018 12:41:14 +0300
Message-ID: <CAHp75VdjYxp7QGYdtY3EXNrLZkgEUvQ8C5XssUeLh=0V6zT1jg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Add fn-lock setting Some of
 latest Lenovo ideapad laptops do not have UEFI/BIOS setting for switching
 fn-lock mode. This commit adds related acpi calls to ideapad platfrom driver.
 However setting is available via sysfs.
To: Oleg Keri <ezhi99@gmail.com>
Cc: Ike Panhc <ike.pan@canonical.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 9:16 PM, Oleg Keri <ezhi99@gmail.com> wrote:

Oleg, thank you for the patch, thoiugh it contains two issues, i.e.
 - each new attribute in sysfs is ABI, *must* be documented; if there
is no such file present at all, you may start a new one;
 - the commit message is formatted rather as in SVN style, in Git we
have a separate line for subject followed by empty line that followed
by body of commit message.

The code itself, assuming it's tested, looks good.

> Signed-off-by: Oleg Keri <ezhi99@gmail.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 52 +++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 3 deletions(-)
>
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
