Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1775EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AF7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2zcFkdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AF7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeIFBGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:06:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37218 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIFBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:06:31 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so11248259itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yOGyaIGwqy0AdkYo8vtvmu4UdJyK2Td46M8SiZ+QjQk=;
        b=R2zcFkdKiCFZqtOAiGcvFEBRF5hIAJMtEHkAV3WZjDGCCaqfLAQ/wPxrCz+ruSy8PG
         +/uaExHXyLCQQr4JdTjb9oTxkLcHfR+MwKxJe9uzAPCCUQgTo5EeQBWatdJ4gxyGsP0E
         V8k2ObuIRz7H2ZnDjpLZaudF/npUhnZTTNBX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOGyaIGwqy0AdkYo8vtvmu4UdJyK2Td46M8SiZ+QjQk=;
        b=A+R0qXSxcSmJ4NaVqXW11DAbnHYkl+5yDrz4zLiLh4cPGHVXrm72/rGl+WsGIkLCH9
         NfvojOIcgikHzbZ91mtdQH8ygSu2R1lv1Q4C5/ccjtmtMC0rGMdGHkVR9aW/XYp7ShJx
         34YtFkPs/6TRanNF7tFh72K3gRA/QZ/hJsynYKyu2BC199bYDO3WfErXkM37WSDAeIte
         F6Wbdah8dE1h4yzKthozwzBtulDWl4gMFNTiGoQRFJmh+BQMnH34YWbYYAY03Ul03qGq
         EWhOxyfwsG9jxyBkWlPhPRyPkqISkvDFl82yt8zg4kAO/NwCVXTtEwnX9mi/zdltLAaY
         pueg==
X-Gm-Message-State: APzg51Djd5uxhj00h69ArV8hG69SLkiJ8tJR00GxcvtQbyJnDO71ISgl
        XHKDtDhYfE6FBYdmWgy8SlKtcg==
X-Google-Smtp-Source: ANB0VdaOGiYgaGYleLM/FidtazWkkeck11FzXRLR1eXdyaz9Spnu/l5804JWHGb+fmzBGDUQW2sd3Q==
X-Received: by 2002:a02:98f4:: with SMTP id c49-v6mr28507043jak.114.1536179679843;
        Wed, 05 Sep 2018 13:34:39 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m5-v6sm1620321itb.6.2018.09.05.13.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:34:38 -0700 (PDT)
Date:   Wed, 5 Sep 2018 14:34:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tomasz Nowicki <tnowicki@caviumnetworks.com>
Cc:     alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, Jayachandran.Nair@cavium.com,
        linux@armlinux.org.uk
Subject: Re: [PATCH 1/1] coresight: etm4x: Configure EL2 exception level when
 kernel is running in HYP
Message-ID: <20180905203436.GA16793@xps15>
References: <20180904142034.19116-1-tnowicki@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904142034.19116-1-tnowicki@caviumnetworks.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Tue, Sep 04, 2018 at 04:20:34PM +0200, Tomasz Nowicki wrote:
> For non-VHE systems host kernel runs at EL1 and jumps to EL2 whenever
> hypervisor code should be executed. In this case ETM4x driver must
> restrict configuration to EL1 when it setups kernel tracing.
> However, there is no separate hypervisor privilege level when VHE
> is enabled, the host kernel runs at EL2.
> 
> This patch fixes configuration of TRCACATRn register for VHE systems
> so that ETM_EXLEVEL_NS_HYP bit is used instead of ETM_EXLEVEL_NS_OS
> to on/off kernel tracing. At the same time, it moves common code
> to new helper.
> 
> Signed-off-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++---------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index f79b0ea85d76..5f495c942f99 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <asm/sections.h>
>  #include <asm/local.h>
> +#include <asm/virt.h>
>  
>  #include "coresight-etm4x.h"
>  #include "coresight-etm-perf.h"
> @@ -606,7 +607,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
>  	config->vinst_ctrl |= BIT(0);
>  }
>  
> -static u64 etm4_get_access_type(struct etmv4_config *config)
> +static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>  {
>  	u64 access_type = 0;
>  
> @@ -617,17 +618,27 @@ static u64 etm4_get_access_type(struct etmv4_config *config)
>  	 *   Bit[13] Exception level 1 - OS
>  	 *   Bit[14] Exception level 2 - Hypervisor
>  	 *   Bit[15] Never implemented
> -	 *
> -	 * Always stay away from hypervisor mode.
>  	 */
> -	access_type = ETM_EXLEVEL_NS_HYP;
>  

Extra space 

> -	if (config->mode & ETM_MODE_EXCL_KERN)
> -		access_type |= ETM_EXLEVEL_NS_OS;
> +	if (!is_kernel_in_hyp_mode()) {
> +		/* Stay away from hypervisor mode for non-VHE */
> +		access_type =  ETM_EXLEVEL_NS_HYP;
> +		if (config->mode & ETM_MODE_EXCL_KERN)
> +			access_type |= ETM_EXLEVEL_NS_OS;
> +	} else if (config->mode & ETM_MODE_EXCL_KERN) {
> +		access_type = ETM_EXLEVEL_NS_HYP;
> +	}
>  
>  	if (config->mode & ETM_MODE_EXCL_USER)
>  		access_type |= ETM_EXLEVEL_NS_APP;
>  
> +	return access_type;
> +}
> +
> +static u64 etm4_get_access_type(struct etmv4_config *config)
> +{
> +	u64 access_type = etm4_get_ns_access_type(config);
> +
>  	/*
>  	 * EXLEVEL_S, bits[11:8], don't trace anything happening
>  	 * in secure state.
> @@ -881,20 +892,10 @@ void etm4_config_trace_mode(struct etmv4_config *config)
>  
>  	addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
>  	/* clear default config */
> -	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS);
> +	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS |
> +			ETM_EXLEVEL_NS_HYP);

Indentation problems

>  
> -	/*
> -	 * EXLEVEL_NS, bits[15:12]
> -	 * The Exception levels are:
> -	 *   Bit[12] Exception level 0 - Application
> -	 *   Bit[13] Exception level 1 - OS
> -	 *   Bit[14] Exception level 2 - Hypervisor
> -	 *   Bit[15] Never implemented
> -	 */
> -	if (mode & ETM_MODE_EXCL_KERN)
> -		addr_acc |= ETM_EXLEVEL_NS_OS;
> -	else
> -		addr_acc |= ETM_EXLEVEL_NS_APP;
> +	addr_acc |= etm4_get_ns_access_type(config);
>  
>  	config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
>  	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;

I tested your patch on my side and it didn't break kernel space decoding.

Since it would have taken longer to ask you to respin than to make the changes
myself, I applied your patch with the above modifications.

Thanks,
Mathieu

> -- 
> 2.17.1
> 
