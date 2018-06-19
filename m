Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99792083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99792083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755844AbeFSHE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:04:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:59193 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeFSHE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:04:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 00:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="60355971"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga003.jf.intel.com with ESMTP; 19 Jun 2018 00:04:24 -0700
Subject: Re: [PATCH 1/1] mmc: sdhci-pci: fix eMMC controller issue on Intel
 Baytrail SoCs
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20180619063119.3955-1-kurt@linutronix.de>
 <20180619063119.3955-2-kurt@linutronix.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <293c2771-ea9b-4f0c-bd31-f8844de12dc4@intel.com>
Date:   Tue, 19 Jun 2018 10:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619063119.3955-2-kurt@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 09:31, Kurt Kanzenbach wrote:
> Sometimes the eMMC controller doesn't respond anymore on Intel Baytrail
> SoCs. The resulting error looks like:
> 
> |mmc1: Reset 0x1 never completed.
> |sdhci: =========== REGISTER DUMP (mmc1)===========
> |sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
> |sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
> |sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
> |sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
> |sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
> |sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
> |sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
> |sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
> |sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
> |sdhci: Caps:     0xffffffff | Caps_1:   0xffffffff
> |sdhci: Cmd:      0x0000ffff | Max curr: 0xffffffff
> |sdhci: Host ctl2: 0x0000ffff
> |sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffff
> 
> The behavior was observed on an Intel Atom E3825 performing lots of reboots. The

So you are saying this only happens at boot time?  And only when re-booting?
Can you send all the kernel messages?  Can you send an acpidump?

> issue seems to occur if runtime power management is used. Found by utilizing
> ftrace.
> 
> The erratum VLI10 for the Intel E3825 states, that the eMMC controller
> incorrectly announces that it supports suspend/resume. However, that shouldn't
> be used, as the controller may incorrectly transfer data between memory and the
> SD device.

That erratum is not related to this problem.  The suspend/resume that is
documented is an internal SDHCI feature, not the kernel's suspend/resume.
The SDHCI Suspend/Resume Mechanism is not supported in the driver, so it is
not being used anyway.

> 
> Therefore, disallowing runtime pm resolves the issue. Tested on the E3825.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 77dd3521daae..df89381944cd 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -870,6 +870,21 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
>  	.priv_size	= sizeof(struct intel_host),
>  };
>  
> +/*
> + * See Erratum VLI10 from Errata List for Intel Atom E3825, Link:
> + * https://www.intel.ca/content/dam/www/public/us/en/documents/specification-updates/atom-e3800-family-spec-update.pdf
> + */
> +static const struct sdhci_pci_fixes sdhci_intel_byt_emmc_no_runtime_pm = {
> +	.allow_runtime_pm = false,
> +	.probe_slot	= byt_emmc_probe_slot,
> +	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
> +			  SDHCI_QUIRK2_STOP_WITH_TC,
> +	.ops		= &sdhci_intel_byt_ops,
> +	.priv_size	= sizeof(struct intel_host),
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
>  	.allow_runtime_pm	= true,
>  	.probe_slot		= glk_emmc_probe_slot,
> @@ -1470,7 +1485,7 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_SUBDEVICE(INTEL, BYT_SDIO, NI, 7884, ni_byt_sdio),
>  	SDHCI_PCI_DEVICE(INTEL, BYT_SDIO,  intel_byt_sdio),
>  	SDHCI_PCI_DEVICE(INTEL, BYT_SD,    intel_byt_sd),
> -	SDHCI_PCI_DEVICE(INTEL, BYT_EMMC2, intel_byt_emmc),
> +	SDHCI_PCI_DEVICE(INTEL, BYT_EMMC2, intel_byt_emmc_no_runtime_pm),
>  	SDHCI_PCI_DEVICE(INTEL, BSW_EMMC,  intel_byt_emmc),
>  	SDHCI_PCI_DEVICE(INTEL, BSW_SDIO,  intel_byt_sdio),
>  	SDHCI_PCI_DEVICE(INTEL, BSW_SD,    intel_byt_sd),
> 

