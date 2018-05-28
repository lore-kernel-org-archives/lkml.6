Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938666AbeE1MMG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:12:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39042 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423022AbeE1LER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:17 -0400
X-Google-Smtp-Source: ADUXVKI2j4klq+ddujC73WNgWHWeBcluH3zE8JpkjaE7x7L4c3mHPlsQeb8aRx1jtEVLbN1HsISDmlknTH8CDvxb3Xo=
MIME-Version: 1.0
In-Reply-To: <20180525210752.1794502-1-arnd@arndb.de>
References: <20180525210752.1794502-1-arnd@arndb.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 May 2018 13:04:16 +0200
Message-ID: <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
To: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 May 2018 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added runtime-pm functions cause a harmless warning
> when CONFIG_PM is disabled:
>
> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>  static int sunxi_mmc_runtime_resume(struct device *dev)
>
> This marks them as __maybe_unused to shut up the warning.

Most mmc drivers uses #ifdef CONFIG_PM instead of the __maybe_unused() option.

It's not a big deal, but consistency is always good. Would you mind changing?

Br
Uffe

>
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 97c6b79b7d6f..837888b96bd3 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1432,7 +1432,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int sunxi_mmc_runtime_resume(struct device *dev)
> +static int __maybe_unused sunxi_mmc_runtime_resume(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> @@ -1449,7 +1449,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static int sunxi_mmc_runtime_suspend(struct device *dev)
> +static int __maybe_unused sunxi_mmc_runtime_suspend(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> --
> 2.9.0
>
