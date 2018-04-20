Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753758AbeDTGJx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:09:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:36697 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbeDTGJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:09:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,300,1520924400";
   d="scan'208";a="221912321"
Subject: Re: [PATCH v2] mmc: sdhci-cadence: fix logically and structurally
 dead code
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180419155958.GA18593@embeddedor.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d04fd2b0-c1c2-dbe8-2c5f-db36665ffbc2@intel.com>
Date: Fri, 20 Apr 2018 09:08:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419155958.GA18593@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/18 18:59, Gustavo A. R. Silva wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
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
>  		ret = readl_poll_timeout(reg, tmp,
>  					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
>  					 0, 1);
> -
> -		return ret;
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> 
