Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D5ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E5B2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E5B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJ3Qri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:47:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:43354 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeJ3Qri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:47:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 00:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,443,1534834800"; 
   d="scan'208";a="275599471"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2018 00:55:12 -0700
Subject: Re: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Rajat Jain <rajatja@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
 <20181029221701.51376-1-rajatja@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <79f9fb1f-9318-6265-d642-11d57719f287@intel.com>
Date:   Tue, 30 Oct 2018 09:53:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029221701.51376-1-rajatja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/18 12:17 AM, Rajat Jain wrote:
> Problem:
> 
> The card detect IRQ does not work with modern BIOS (that want
> to use _DSD to provide the card detect GPIO to the driver).
> 
> Details:
> 
> The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> request the gpio descriptor for the "card detect" pin.
> This pin is specified in the ACPI for the SDHC device:
> 
>  * Either as a resource using _CRS. This is a method used by legacy BIOS.
>    (The driver needs to tell which resource index).
> 
>  * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
>    points to an entry in _CRS). This way, the driver can lookup using a
>    string. This is what modern BIOS prefer to use.
> 
> This API finally results in a call to the following code:
> 
> struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> {
> ...
>    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> ...
>    if (!acpi_can_fallback_to_crs(adev, con_id))
>           return ERR_PTR(-ENOENT);
> ...
>    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> ...
> }
> 
> Note that this means that if the ACPI has _DSD properties, the kernel
> will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> will always be false for any device hat has _DSD entries).
> 
> The SDHCI driver is thus currently broken on a modern BIOS, even if
> BIOS provides both _CRS (for index based lookup) and _DSD entries (for
> string based lookup). Ironically, none of these will be used for the
> lookup currently because:
> 
> * Since the con_id is NULL, acpi_find_gpio() does not find a matching
>   entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")
> 
> * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
>   returns false (because device properties have been populated from
>   _DSD), thus the _CRS is never used for the lookup.
> 
> Fix:
> 
> Try "cd" for lookup in the _DSD before falling back to using NULL so
> as to try looking up in the _CRS.
> 
> I've tested this patch successfully with both Legacy BIOS (that
> provide only _CRS method) as well as modern BIOS (that provide both
> _CRS and _DSD). Also the use of "cd" appears to be fairly consistent
> across other users of this API (other MMC host controller drivers).
> 
> Link: https://lkml.org/lkml/2018/9/25/1113
> Signed-off-by: Rajat Jain <rajatja@google.com>

This is good enough for a fix.  An ACPI GPIO mappings table can be done later.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2: Fix the commit log to take care of Andy's comments.
> 
>  drivers/mmc/host/sdhci-pci-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 7bfd366d970d..e53333c695b3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1762,8 +1762,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  		device_init_wakeup(&pdev->dev, true);
>  
>  	if (slot->cd_idx >= 0) {
> -		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> +		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>  					   slot->cd_override_level, 0, NULL);
> +		if (ret && ret != -EPROBE_DEFER)
> +			ret = mmc_gpiod_request_cd(host->mmc, NULL,
> +						   slot->cd_idx,
> +						   slot->cd_override_level,
> +						   0, NULL);
>  		if (ret == -EPROBE_DEFER)
>  			goto remove;
>  
> 

