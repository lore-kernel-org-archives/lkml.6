Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B847C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3A12087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeLDM0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:26:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:57213 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeLDM0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:26:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 04:26:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="97924067"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by orsmga006.jf.intel.com with ESMTP; 04 Dec 2018 04:26:20 -0800
Subject: Re: [PATCH V2] sdhci: fix the timeout check window for clock and
 reset
To:     "Du, Alek" <alek.du@intel.com>
Cc:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org
References: <20181130150028.732896d8@xdu1-mobl>
 <81ba3745-8277-d16e-3aad-48324f51dc8a@intel.com>
 <20181130221300.4ef2956c@xdu1-mobl>
 <c580be57-8a49-59f3-791e-c605d892266b@intel.com>
 <20181201134251.26573207@xdu1-mobl> <20181204090120.63b5f0a4@xdu1-mobl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <229dc468-1155-b81f-9fda-b71402387e3f@intel.com>
Date:   Tue, 4 Dec 2018 14:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204090120.63b5f0a4@xdu1-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/18 3:01 AM, Du, Alek wrote:
>>From 87692fc090978bde8fe872f02d0023a57af6b492 Mon Sep 17 00:00:00 2001
> From: Alek Du <alek.du@intel.com>
> Date: Fri, 30 Nov 2018 14:02:28 +0800
> Subject: [PATCH] sdhci: fix the timeout check window for clock and reset
> 
> We observed some fake timeouts on some devices, the log is like this:

Please change "fake timeouts" to "premature timeouts".  Also I think it is
worth mentioning that this was with a virtualized environment.

> 
> case 1:
> [159525.255629] mmc1: Internal clock never stabilised.
> [159525.255818] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [159525.256049] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
> [159525.256277] mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> [159525.256523] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
> [159525.256752] mmc1: sdhci: Present:   0x1fff0000 | Host ctl: 0x00000000
> [159525.256979] mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> [159525.257205] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
>>From the clock control register dump, we are pretty sure the clock was
> stablized.
> 
> case 2:
> [  914.550127] mmc1: Reset 0x2 never completed.
> [  914.550321] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  914.550608] mmc1: sdhci: Sys addr:  0x00000010 | Version:  0x00001002
> 
> After checking the sdhci code, we found the timeout check actually has a
> little window that the CPU can be scheduled out and when it comes back,
> the original time set or check is not valid.
> 
> Signed-off-by: Alek Du <alek.du@intel.com>

Please add fixes tag:

Fixes: 5a436cc0af62 ("mmc: sdhci: Optimize delay loops")

And also a stable tag:

Cc: stable@vger.kernel.org      # v4.12+

> ---
>  drivers/mmc/host/sdhci.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae53fa2e..af01f7d16eae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -218,12 +218,17 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
>  	/* hw clears the bit when it's done */
>  	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
>  		if (ktime_after(ktime_get(), timeout)) {
> +			/* check it again, since there is a window between
> +			   bit check and time check */
> +			if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
> +				break;

It would be neater like:

	while (1) {
		bool timedout = ktime_after(ktime_get(), timeout);

		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
			break;
		if (timedout) {


>  			pr_err("%s: Reset 0x%x never completed.\n",
>  				mmc_hostname(host->mmc), (int)mask);
>  			sdhci_dumpregs(host);
>  			return;
> +		} else {

The if-clause does a 'return', so the 'else' is not needed

> +			udelay(10);
>  		}
> -		udelay(10);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset);
> @@ -1611,12 +1616,19 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
>  	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>  		& SDHCI_CLOCK_INT_STABLE)) {
>  		if (ktime_after(ktime_get(), timeout)) {
> +			/* check it again since there is a window between
> +			   status check and time check */
> +			if ((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +					& SDHCI_CLOCK_INT_STABLE)
> +				break;

Similarly:

	while (1) {
		bool timedout = ktime_after(ktime_get(), timeout);

		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
		if (clk & SDHCI_CLOCK_INT_STABLE)
			break;
		if (timedout) {


>  			pr_err("%s: Internal clock never stabilised.\n",
>  			       mmc_hostname(host->mmc));
>  			sdhci_dumpregs(host);
>  			return;
>  		}
> -		udelay(10);
> +		else {

The if-clause does a 'return', so the 'else' is not needed

> +			udelay(10);
> +		}
>  	}
>  
>  	clk |= SDHCI_CLOCK_CARD_EN;
> 

