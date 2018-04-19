Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeDSPnY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:43:24 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:34258 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeDSPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:43:23 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w3JFhHVa017379
X-Nifty-SrcIP: [209.85.217.172]
X-Google-Smtp-Source: AIpwx48+hmNDxouTT3yT9ERgP+iONoC5sXPMI9grdTYRTchtoRQtEs42TjB7WaVNzNb1AIVJlpQOrdfsX6naAPoJbq0=
MIME-Version: 1.0
In-Reply-To: <20180419135316.GA14790@embeddedor.com>
References: <20180419135316.GA14790@embeddedor.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 20 Apr 2018 00:42:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQSOtJs6xcYXyRqXdAL-x-CBLVmfAozEEZGnZpzURR8g@mail.gmail.com>
Message-ID: <CAK7LNATQSOtJs6xcYXyRqXdAL-x-CBLVmfAozEEZGnZpzURR8g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: fix logically and structurally dead code
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


2018-04-19 22:53 GMT+09:00 Gustavo A. R. Silva <gustavo@embeddedor.com>:
> Currently, the code block inside the for loop will never execute
> more than once, because the function returns inmediately after
> the first iteration, hence the execution of the code at the second
> iteration is structurally dead and, code at line 281: return 0; is
> never reached.
>
> Based on the code comments, it seems that the actual intention is
> to execute the code inside the for loop twice instead of once.

Thanks for the report.

> So, fix this issue by removing the return statement inside the for
> loop and replace the "return 0" with "return ret".
>
> Addresses-Coverity-ID: 1468009 ("Logically dead code")
> Addresses-Coverity-ID: 1468002 ("Structurally dead code")
> Fixes: 213fae74318b ("mmc: sdhci-cadence: send tune request twice to
> work around errata")


Probably, this Fixes tag will dangle.

Ulf usually repeats git-rebase to build-up his pull-request.

The addressed commit was already rebased,
and its commit ID will change a few more times
since it is now -rc1.


A clean solution would be, to squash a fix-up into the original patch.
(This patch is not what I want, though.)

If you want to claim contribution in a separate patch,
please rewrite the code as I suggested,
and drop the Fixes tag.



> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index bc30d16..facbad8 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>                                          0, 1);
>
> -               return ret;
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
> --

No.
I want to confirm that the operation succeeds twice.

Your code hides any error in the first loop.



My intention is like follows:



 --- a/drivers/mmc/host/sdhci-cadence.c
 +++ b/drivers/mmc/host/sdhci-cadence.c
 @@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct
sdhci_host *host, unsigned int val)
                                          !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
                                          0, 1);
 -
 -               return ret;
 +               if (ret)
 +                       return ret;
         }

         return 0;
  }

  static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)



-- 
Best Regards
Masahiro Yamada
