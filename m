Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeDTBI4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:08:56 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39936 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753964AbeDTBIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:08:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3K18QWx011824
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AIpwx4++hH5lIdVEwkIwpcyhU7WLyEE2/9EHKIjPEXxexFLHJeikFN6veZtDtH8SYzP1X15oy1NjcONNo7zvQRAFt4s=
MIME-Version: 1.0
In-Reply-To: <20180419155958.GA18593@embeddedor.com>
References: <20180419155958.GA18593@embeddedor.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 20 Apr 2018 10:07:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS49pYegXFzDkGMBt_pUhkRK9hzTBmz40Ds4QnnTzAdaw@mail.gmail.com>
Message-ID: <CAK7LNAS49pYegXFzDkGMBt_pUhkRK9hzTBmz40Ds4QnnTzAdaw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-cadence: fix logically and structurally
 dead code
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-20 0:59 GMT+09:00 Gustavo A. R. Silva <gustavo@embeddedor.com>:
> Currently, the code block inside the for loop will never execute
> more than once, because the function returns inmediately after
> the first iteration, hence the execution of the code at the second
> iteration is structurally dead and, code at line 281: return 0; is
> never reached.
>
> Fix this by checking _ret_ before return.
>
> Addresses-Coverity-ID: 1468009 ("Logically dead code")
> Addresses-Coverity-ID: 1468002 ("Structurally dead code")
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Looks good to me except the typo in the log

inmediately -> immediately


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Changes in v2:
>  - Update changelog.
>  - Drop the 'Fixes' tag.
>  - Add check on ret instead of removing the "return ret;" line.
>  - Thanks to Masahiro Yamada for the feedback provided.
>
>  drivers/mmc/host/sdhci-cadence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index bc30d16..7a343b8 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -274,8 +274,8 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>                 ret = readl_poll_timeout(reg, tmp,
>                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>                                          0, 1);
> -
> -               return ret;
> +               if (ret)
> +                       return ret;
>         }
>
>         return 0;
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
