Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D8C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48E92086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 21:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OvVZbedR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfALVMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:12:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52240 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfALVMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 16:12:51 -0500
Received: from zn.tnic (p200300EC2BD30C00FC7F8B8F8D7AFDB3.dip0.t-ipconnect.de [IPv6:2003:ec:2bd3:c00:fc7f:8b8f:8d7a:fdb3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7B2431EC034F;
        Sat, 12 Jan 2019 22:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547327569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZWsTlyndiG2G+7rDMLl0qehg4sNFWeHdixsSM9i9BXk=;
        b=OvVZbedRNJnP4Ew9H0Bkm5Nbr14V2eg7nP21fTeTI07ncpK6s4B2N6r9XnaSyB8obCn2+q
        oSYQork4koAmZwsX1XxnbOendnFSkgGRCXG3R9ZNtbe6lKBd3Pgfa3LIVySEUgjDUAwBR7
        r/pPrCxGYLPt6GiwzXFPIphOSZeITPo=
Date:   Sat, 12 Jan 2019 22:12:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com, j-keerthy@ti.com,
        edubezval@gmail.com, olof@lixom.net
Subject: Re: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
Message-ID: <20190112211242.GA4512@zn.tnic>
References: <20190109124312.10154-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109124312.10154-1-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 06:13:12PM +0530, Faiz Abbas wrote:
> Commit 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)") added a select on TI_SOC_THERMAL
> for the driver to get temperature for tuning.
> 
> However, this causes the following warning on keystone_defconfig because
> keystone does not support TI_SOC_THERMAL:
> 
> "WARNING: unmet direct dependencies detected for TI_SOC_THERMAL"
> 
> Fix this by changing the select to imply.
> 
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..bc61eefcb695 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
>  	tristate "TI SDHCI Controller Support"
>  	depends on MMC_SDHCI_PLTFM && OF
>  	select THERMAL
> -	select TI_SOC_THERMAL
> +	imply TI_SOC_THERMAL
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  support present in TI's DRA7 SOCs. The controller supports
> -- 

Fixes the warnings I'm seeing with randconfig builds.

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
