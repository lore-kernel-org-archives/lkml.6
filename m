Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72426205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72426205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:19:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:4836 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeJPQTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:19:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 01:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,387,1534834800"; 
   d="scan'208";a="79094323"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2018 01:30:30 -0700
Subject: Re: [PATCH] mmc: sdhci: use goto rather than return directly
To:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
References: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <88801a36-44cf-237f-a762-985bb215c104@intel.com>
Date:   Tue, 16 Oct 2018 11:28:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/18 11:19 AM, Chunyan Zhang wrote:
> The driver should clean resources requested in the function before
> unnormal return.
> 
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b3fbd9..f6b57e1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		/* This may alter mmc->*_blk_* parameters */
>  		ret = sdhci_allocate_bounce_buffer(host);

Do we need the error return?  It seems to be zero always.

>  		if (ret)
> -			return ret;
> +			goto unreg;
>  	}
>  
>  	return 0;
> 

