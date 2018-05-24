Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034380AbeEXS5C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032744AbeEXS45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:56:57 -0400
Date: Thu, 24 May 2018 20:56:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
Message-ID: <20180524185639.GA31019@kroah.com>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-2-robh@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
> 
> Subsystems or drivers may opt-in to this behavior by calling
> driver_deferred_probe_check_init_done() instead of just returning
> -EPROBE_DEFER. They may use additional information from DT or kernel's
> config to decide whether to continue to defer probe or not.
> 
> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/base/dd.c      | 17 +++++++++++++++++
>  include/linux/device.h |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index c9f54089429b..d6034718da6f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -226,6 +226,16 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +int driver_deferred_probe_check_init_done(struct device *dev, bool optional)
> +{
> +	if (optional && initcalls_done) {
> +		dev_WARN(dev, "ignoring dependency for device, assuming no driver");

You really only need dev_warn(), here, right?

thanks,

greg k-h
