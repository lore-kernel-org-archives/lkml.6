Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeBUTQo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:16:44 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46653 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeBUTQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:16:27 -0500
X-Google-Smtp-Source: AH8x225xYihXnmGgwJohi5qvRS4b86//RysdyKzUGo5+8AHYneq7qOPSxv3hoZTylY4QOaYIUKhvI940kbSN2ObYprY=
MIME-Version: 1.0
In-Reply-To: <20180221175734.39114-1-Evgeniy.Didin@synopsys.com>
References: <20180221175734.39114-1-Evgeniy.Didin@synopsys.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:16:26 +0200
Message-ID: <CAHp75VfyQz-W7DLJ4KvFRCPkOUnP3YQjSzn+Zsbx92Xb-x4GqA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix the DTO timeout overflow calculation for
 32-bit systems
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: linux-mmc@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 7:57 PM, Evgeniy Didin
<Evgeniy.Didin@synopsys.com> wrote:
> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") have been made
> changes which can cause multiply overflow for 32-bit systems. It was caught on arc/hsdk board
> when "drto_ms" should be 671, but it was 70 and that caused a flow of stack-traces just copying
> file from mmc.
>
> Lets cast this multiply to long long int which prevents overflow.
>
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org

> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1944,7 +1944,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
>         drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>         if (drto_div == 0)
>                 drto_div = 1;
> -       drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +       drto_ms = DIV_ROUND_UP((uint64_t)MSEC_PER_SEC * drto_clks * drto_div,
>                                host->bus_hz);

Does the driver use uint64_t elsewhere?
Or simple u64?

-- 
With Best Regards,
Andy Shevchenko
