Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522320682; cv=none;
        d=google.com; s=arc-20160816;
        b=eAEEU4W1IGRLLG9skD9b4PABvj/mVFoQ7gvijt/qidjeIq1BxWVc9RAe3Wlc4T8Dyd
         Oh/B8vKjeNBki8lq9ZgwJL+kK0YZbw9WvphjPfmuxM2eDzbZ8nrTjppXGDn57LpkVI8K
         VBGCO+1trbC0GhUDQvv9IcGkUNuu/6pPPze31Yeueu2DyxmYRRyGTFJhG3FwVgJNtoF9
         D2bXI58nse43hHf9Xg4wFUuw48eLF5wuLCVZ9gxLL/Ow9WjUZjBVf/N8EfUWokZyuy19
         +8Pf7mKB6pBOO62h8grDGa8DixEWH4UCDtNwPzAWaW0uM24gI+lgfi7vh04qTrXHOVJD
         bg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=8ktPXAmyxzECf1Kd6X4azAUwyZAx0I32nGYgXYq6/pc=;
        b=qig9SPApRM3zauy9PbzQ5ebn0uozOlnPVijBlQc/5fSuBs96PwQULPT1S2gIqBZk8n
         IJ3KzVWDUwDrZsD2G6sP7IWtQdzWWYHUdDSvW0Rn8rLtn3+jwEe4Mm2NtqQKxnQ1sXo5
         TTFFqM0SW7KbR50UvfsOuuz6Y6sDfFLf0nKa4Ltubzu7rbufVihUKwfNWlDpQqRsQBtO
         rfCEsUvccS7mz+/bq4+8qqh3Snbz4sy9RhNjErXj7vHwzbkMx9sFLO2odLrDy7GHpMQF
         Ufq6cq5y8Kmddw+BKwvsfWC2xmgdCDcQd9ZKfj1ZRzigeF9DgugYwdJutiJlY5Sh4xJG
         CXNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Bh4FAapt;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Bh4FAapt;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AIpwx4+EfAgkFgnLeJakjdfru1RYEqUOVLE8BxqSJacbiVXgAuDGOPiP63m26zQsj+/LBsp5oTHqAngsGUtkdsL7TYU=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1522317660-11080-2-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1522317660-11080-2-git-send-email-dongsheng.wang@hxt-semitech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Mar 2018 12:51:21 +0200
X-Google-Sender-Auth: XW7H5SsMY-41y5Zx1KyIH0VQuVw
Message-ID: <CAJZ5v0g+hQaU5RqsdzZ0XanXis-LqwKc+PxsmFEqo2eziXnkCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] driver core: add new dl device status DL_DEV_PROBE_FAILED
To: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hanjun Guo <hanjun.guo@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, yu.zheng@hxt-semitech.com,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265787893408502?=
X-GMAIL-MSGID: =?utf-8?q?1596268931925754276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 12:00 PM, Wang Dongsheng
<dongsheng.wang@hxt-semitech.com> wrote:
> Currently the initialization state of device is DL_DEV_NO_DRIVER.
> The problem is, after probe failure the state will also be set to
> DL_DEV_NO_DRIVER as well. And the device is not linked, it has no
> supplier or consumer. Thus adding a new state to distinguish
> probe failure and not-probed-yet.
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>

I guess what you want is a cleanup after a failing probe, but after
that the state really is "no driver" again, isn't it?

> ---
>  Documentation/driver-api/device_link.rst |  2 +-
>  drivers/base/base.h                      |  2 +-
>  drivers/base/core.c                      | 22 ++++++++++++++++++++--
>  drivers/base/dd.c                        |  2 +-
>  include/linux/device.h                   |  1 +
>  5 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index 70e328e..9054403 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -247,7 +247,7 @@ State machine
>    :c:func:`device_links_unbind_consumers()`.)
>
>  * If the probe fails, links to suppliers revert back to ``DL_STATE_AVAILABLE``.
> -  (Call to :c:func:`device_links_no_driver()` from :c:func:`really_probe()`.)
> +  (Call to :c:func:`device_links_probe_failed()` from :c:func:`really_probe()`.)
>
>  * If the probe succeeds, links to suppliers progress to ``DL_STATE_ACTIVE``.
>    (Call to :c:func:`device_links_driver_bound()` from :c:func:`driver_bound()`.)
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index d800de6..f9931d9 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -158,6 +158,6 @@ extern void device_links_read_unlock(int idx);
>  extern int device_links_check_suppliers(struct device *dev);
>  extern void device_links_driver_bound(struct device *dev);
>  extern void device_links_driver_cleanup(struct device *dev);
> -extern void device_links_no_driver(struct device *dev);
> +extern void device_links_probe_failed(struct device *dev);
>  extern bool device_links_busy(struct device *dev);
>  extern void device_links_unbind_consumers(struct device *dev);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5847364..31d4f68 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -452,10 +452,28 @@ static void __device_links_no_driver(struct device *dev)
>         dev->links.status = DL_DEV_NO_DRIVER;
>  }
>
> -void device_links_no_driver(struct device *dev)
> +static void __device_links_probe_failed(struct device *dev)
> +{
> +       struct device_link *link, *ln;
> +
> +       list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers,
> +                                        c_node) {
> +               if (link->flags & DL_FLAG_STATELESS)
> +                       continue;
> +
> +               if (link->flags & DL_FLAG_AUTOREMOVE)
> +                       __device_link_del(link);
> +               else if (link->status != DL_STATE_SUPPLIER_UNBIND)
> +                       WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> +       }
> +
> +       dev->links.status = DL_DEV_PROBE_FAILED;
> +}
> +
> +void device_links_probe_failed(struct device *dev)
>  {
>         device_links_write_lock();
> -       __device_links_no_driver(dev);
> +       __device_links_probe_failed(dev);
>         device_links_write_unlock();
>  }
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index de6fd09..90d57e0 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -492,7 +492,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>                                              BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
>  pinctrl_bind_failed:
> -       device_links_no_driver(dev);
> +       device_links_probe_failed(dev);
>         devres_release_all(dev);
>         driver_sysfs_remove(dev);
>         dev->driver = NULL;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405..bf9630a 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -794,6 +794,7 @@ struct device_link {
>  enum dl_dev_state {
>         DL_DEV_NO_DRIVER = 0,
>         DL_DEV_PROBING,
> +       DL_DEV_PROBE_FAILED,
>         DL_DEV_DRIVER_BOUND,
>         DL_DEV_UNBINDING,
>  };
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
