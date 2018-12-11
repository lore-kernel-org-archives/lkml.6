Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A0EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7390B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7390B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLKHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:35:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:52632 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbeLKHfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:35:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 23:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="109403539"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2018 23:35:29 -0800
Subject: Re: [PATCH] mmc: sdhci-msm: avoid unused function warning
To:     Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vijay Viswanath <vviswana@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181210204546.2384299-1-arnd@arndb.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <875b5f29-c486-5f49-653e-13cc94b4c16f@intel.com>
Date:   Tue, 11 Dec 2018 09:33:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210204546.2384299-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 10:45 PM, Arnd Bergmann wrote:
> The newly added sdhci_msm_restore_sdr_dll_config() function is only
> called if CONFIG_PM is enabled:
> 
> drivers/mmc/host/sdhci-msm.c:1050:12: error: 'sdhci_msm_restore_sdr_dll_config' defined but not used [-Werror=unused-function]
> 
> Better remove the incorrect #ifdef altogether and just use __maybe_unused,
> which is harder to get wrong.
> 
> Fixes: ec3349733550 ("mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 5497a71abe07..d6c9ebd8d263 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1997,8 +1997,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int sdhci_msm_runtime_suspend(struct device *dev)
> +static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2010,7 +2009,7 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int sdhci_msm_runtime_resume(struct device *dev)
> +static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -2030,7 +2029,6 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> 

