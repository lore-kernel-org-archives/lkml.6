Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBHBD2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:03:28 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:54292 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBHBD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:03:26 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1813KKs003906
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AH8x227tGLwhI6+zoJaRjtwmvDL5bGL361qK5GAkdinfH4jgehcnKgAFav6DJzaRXl+v6+bkSTUmG1+Z4a5jvdczDFs=
MIME-Version: 1.0
In-Reply-To: <20180207193459.tsmci752idkayjxd@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-13-git-send-email-yamada.masahiro@socionext.com> <20180207193459.tsmci752idkayjxd@ninjato>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 10:02:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbRW+KyX9_h1mSrse5MSC3Zp40qOFVDWhEXG0ig8zkxQ@mail.gmail.com>
Message-ID: <CAK7LNARbRW+KyX9_h1mSrse5MSC3Zp40qOFVDWhEXG0ig8zkxQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] mmc: tmio: support IP-builtin card detection logic
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-08 4:34 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jan 18, 2018 at 01:28:12AM +0900, Masahiro Yamada wrote:
>> A card detect GPIO is set up only for platforms with "cd-gpios"
>> DT property or TMIO_MMC_USE_GPIO_CD flag.  However, the driver
>> core always uses mmc_gpio_get_cd, which just fails with -ENOSYS
>> if ctx->cd_gpio is unset.
>>
>> The bit 5 of the status register provides the current signal level
>> of the CD line.  Allow to use it if the GPIO is unused.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
>> @@ -1095,7 +1103,7 @@ static const struct mmc_host_ops tmio_mmc_ops = {
>
> I just wonder why the diff-tool puts 'const' in the definition. There is
> no const in my version here. And there shouldn't be because we modify
> the struct in this patch.
>

Which kernel version are you seeing?

The following patch was applied and it is in Linus'tree.



commit c055fc75c1757b220108489038cfe60496b13865
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat Nov 25 01:24:41 2017 +0900

    mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data

    Currently, tmio_mmc_ops is static data and tmio_mmc_host_probe()
    updates some hooks in the static data.  This is a problem when
    two or more instances call tmio_mmc_host_probe() and each of them
    requests to use its own card_busy/start_signal_voltage_switch.

    We can borrow a solution from sdhci_alloc_host().  Copy the whole
    ops structure to host->mmc_host_ops, then override the hooks in
    malloc'ed data.  Constify tmio_mmc_ops since it is now a template
    ops used by default.

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>



-- 
Best Regards
Masahiro Yamada
