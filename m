Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933572AbeBULkH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:40:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34875 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933558AbeBULkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:40:04 -0500
X-Google-Smtp-Source: AH8x2258y12L5s+hVnZ6tsodId/PyIPHz2rJH7AenBPaHxcv5PJ/P/E+jQpWrOagpNiv64YlVIw8N54ij44MG41OKbA=
MIME-Version: 1.0
In-Reply-To: <1515590259-24304-1-git-send-email-anup@brainfault.org>
References: <1515590259-24304-1-git-send-email-anup@brainfault.org>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 21 Feb 2018 17:10:02 +0530
Message-ID: <CAAhSdy3n-LuubSj+GNFoub3HJp0jap3Bu3f_NVeaYhc1H_7mHw@mail.gmail.com>
Subject: Re: [PATCH RESEND] rpmsg: Add driver_override device attribute for rpmsg_device
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2018 at 6:47 PM, Anup Patel <anup@brainfault.org> wrote:
> This patch adds "driver_override" device attribute for rpmsg_device which
> will allow users to explicitly specify the rpmsg_driver to be used via
> sysfs entry.
>
> The "driver_override" device attribute implemented here is very similar
> to "driver_override" implemented for platform, pci, and amba bus types.
>
> One important use-case of "driver_override" device attribute is to force
> use of rpmsg_chrdev driver for certain rpmsg_device instances.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-rpmsg | 20 ++++++++++++++
>  drivers/rpmsg/rpmsg_core.c                | 46 +++++++++++++++++++++++++++++--
>  2 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-rpmsg b/Documentation/ABI/testing/sysfs-bus-rpmsg
> index 189e419..1c8599e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-rpmsg
> +++ b/Documentation/ABI/testing/sysfs-bus-rpmsg
> @@ -73,3 +73,23 @@ Description:
>                 This sysfs entry tells us whether the channel is a local
>                 server channel that is announced (values are either
>                 true or false).
> +
> +What:          /sys/bus/rpmsg/devices/.../driver_override
> +Date:          January 2018
> +KernelVersion: 4.16
> +Contact:       Ohad Ben-Cohen <ohad@wizery.com>
> +Description:
> +               Every rpmsg device is a communication channel with a remote
> +               processor. Channels are identified by a textual name (see
> +               /sys/bus/rpmsg/devices/.../name above) and have a local
> +               ("source") rpmsg address, and remote ("destination") rpmsg
> +               address.
> +
> +               The listening entity (or client) which communicates with a
> +               remote processor is referred as rpmsg driver. The rpmsg device
> +               and rpmsg driver are matched based on rpmsg device name and
> +               rpmsg driver ID table.
> +
> +               This sysfs entry allows the rpmsg driver for a rpmsg device
> +               to be specified which will override standard OF, ID table
> +               and name matching.
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index dffa3aa..9a25e42 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -321,11 +321,11 @@ struct device *rpmsg_find_device(struct device *parent,
>  }
>  EXPORT_SYMBOL(rpmsg_find_device);
>
> -/* sysfs show configuration fields */
> +/* sysfs configuration fields */
>  #define rpmsg_show_attr(field, path, format_string)                    \
>  static ssize_t                                                         \
>  field##_show(struct device *dev,                                       \
> -                       struct device_attribute *attr, char *buf)       \
> +            struct device_attribute *attr, char *buf)                  \
>  {                                                                      \
>         struct rpmsg_device *rpdev = to_rpmsg_device(dev);              \
>                                                                         \
> @@ -333,11 +333,52 @@ field##_show(struct device *dev,                                  \
>  }                                                                      \
>  static DEVICE_ATTR_RO(field);
>
> +#define rpmsg_string_attr(field, path)                                 \
> +static ssize_t                                                         \
> +field##_store(struct device *dev,                                      \
> +             struct device_attribute *attr, const char *buf, size_t sz)\
> +{                                                                      \
> +       struct rpmsg_device *rpdev = to_rpmsg_device(dev);              \
> +       char *new, *old, *cp;                                           \
> +                                                                       \
> +       new = kstrndup(buf, sz, GFP_KERNEL);                            \
> +       if (!new)                                                       \
> +               return -ENOMEM;                                         \
> +                                                                       \
> +       cp = strchr(new, '\n');                                         \
> +       if (cp)                                                         \
> +               *cp = '\0';                                             \
> +                                                                       \
> +       device_lock(dev);                                               \
> +       old = rpdev->path;                                              \
> +       if (strlen(new)) {                                              \
> +               rpdev->path = new;                                      \
> +       } else {                                                        \
> +               kfree(new);                                             \
> +               rpdev->path = NULL;                                     \
> +       }                                                               \
> +       device_unlock(dev);                                             \
> +                                                                       \
> +       kfree(old);                                                     \
> +                                                                       \
> +       return sz;                                                      \
> +}                                                                      \
> +static ssize_t                                                         \
> +field##_show(struct device *dev,                                       \
> +            struct device_attribute *attr, char *buf)                  \
> +{                                                                      \
> +       struct rpmsg_device *rpdev = to_rpmsg_device(dev);              \
> +                                                                       \
> +       return sprintf(buf, "%s\n", rpdev->path);                       \
> +}                                                                      \
> +static DEVICE_ATTR_RW(field)
> +
>  /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
>  rpmsg_show_attr(name, id.name, "%s\n");
>  rpmsg_show_attr(src, src, "0x%x\n");
>  rpmsg_show_attr(dst, dst, "0x%x\n");
>  rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
> +rpmsg_string_attr(driver_override, driver_override);
>
>  static ssize_t modalias_show(struct device *dev,
>                              struct device_attribute *attr, char *buf)
> @@ -359,6 +400,7 @@ static struct attribute *rpmsg_dev_attrs[] = {
>         &dev_attr_dst.attr,
>         &dev_attr_src.attr,
>         &dev_attr_announce.attr,
> +       &dev_attr_driver_override.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(rpmsg_dev);
> --
> 2.7.4
>

Hi Bjorn,

Can you please review this patch?

Regards,
Anup
