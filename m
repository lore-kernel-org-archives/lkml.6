Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EACAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E5F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PH3EW00W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfA3Mpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:45:55 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3108 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3Mpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:45:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c519c660000>; Wed, 30 Jan 2019 04:45:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 04:45:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 04:45:54 -0800
Received: from [10.26.11.176] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 12:45:51 +0000
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Sameer Pujar <spujar@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>
CC:     <thierry.reding@gmail.com>, <rlokhande@nvidia.com>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com>
Date:   Wed, 30 Jan 2019 12:45:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548852326; bh=427mXo0QSFtnAza3h6cf9v2fdxJPo7dn1Gt4hSqFLFs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PH3EW00WHx69nJBASQ450mv09jOvx62CjhnEfxIzb3IRQgbp0Dq5aKIRX5MxeyUE2
         YqO17FzFNMFX1T+UkdGqsa5C4n/OMUyVlLxRLj+JS/PVOZMLt/HuRNBkMJi99dcat4
         cdvAcrcSrtj2gbyL2eYmsrpftDMI0qphj3pSk5vy8m6j6pwr4vhRs6MXb8Z7vmB95R
         TiAM2pfpach8LQlND5dTryEW0mr0+sJG3gdDG2oYIov2Bfa0bTQ32DCwvWgNF4wwr8
         1ifidqpW25gK5pISGlQSK/7pqFNbtbEh62lrMJj+dEYEQsuSG2o6NpfKYtfevcmM/B
         DMhGpeaGt6W8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2019 11:06, Sameer Pujar wrote:
> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
> will not be ON. This could cause issue during probe, where hda init
> setup is done. This patch enables clocks unconditionally during probe.
> 
> Along with above, follwoing changes are done.
>   * enable runtime PM before exiting from probe work. This helps to avoid
>     usage of pm_runtime_get_sync/pm_runtime_put() in probe work.
>   * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>   * runtime PM callbacks moved out of CONFIG_PM check
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  sound/pci/hda/hda_tegra.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
> index c8d18dc..ba6175f 100644
> --- a/sound/pci/hda/hda_tegra.c
> +++ b/sound/pci/hda/hda_tegra.c
> @@ -219,7 +219,6 @@ static int hda_tegra_enable_clocks(struct hda_tegra *data)
>  	return rc;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static void hda_tegra_disable_clocks(struct hda_tegra *data)
>  {
>  	clk_disable_unprepare(data->hda2hdmi_clk);
> @@ -227,6 +226,7 @@ static void hda_tegra_disable_clocks(struct hda_tegra *data)
>  	clk_disable_unprepare(data->hda_clk);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  /*
>   * power management
>   */
> @@ -257,7 +257,6 @@ static int hda_tegra_resume(struct device *dev)
>  }
>  #endif /* CONFIG_PM_SLEEP */
>  
> -#ifdef CONFIG_PM
>  static int hda_tegra_runtime_suspend(struct device *dev)
>  {
>  	struct snd_card *card = dev_get_drvdata(dev);
> @@ -283,7 +282,7 @@ static int hda_tegra_runtime_resume(struct device *dev)
>  	int rc;
>  
>  	rc = hda_tegra_enable_clocks(hda);
> -	if (rc != 0)
> +	if (rc)
>  		return rc;
>  	if (chip && chip->running) {
>  		hda_tegra_init(hda);
> @@ -292,7 +291,6 @@ static int hda_tegra_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM */
>  
>  static const struct dev_pm_ops hda_tegra_pm = {
>  	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
> @@ -551,9 +549,9 @@ static int hda_tegra_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, card);
>  
> -	pm_runtime_enable(hda->dev);
> -	if (!azx_has_pm_runtime(chip))
> -		pm_runtime_forbid(hda->dev);
> +	err = hda_tegra_enable_clocks(hda);
> +	if (err)
> +		goto out_free;

We also need to think about power-domains here. Enabling the clocks
might not be enough as the appropriate power-domain needs to be enabled.
For 64-bit Tegra runtime-pm will handle the power-domains (assuming they
are populated in device-tree). So I still think it is better we call
pm_runtime_get_sync() at some point rather than just replying on
enabling the clocks.

Cheers
Jon

-- 
nvpublic
