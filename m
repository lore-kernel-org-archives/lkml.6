Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8458BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487A52086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="guftr7tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbeKTIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:25:59 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1619 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeKTIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:25:59 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf332790003>; Mon, 19 Nov 2018 14:00:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Nov 2018 14:00:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Nov 2018 14:00:16 -0800
Received: from [10.26.11.92] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 22:00:14 +0000
Subject: Re: [PATCH v1 4/4] ARM: tegra: Clear EMC interrupts on resume from
 LP1 on Tegra30+
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-5-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9c085248-41df-c8be-294d-6bf8b95c1085@nvidia.com>
Date:   Mon, 19 Nov 2018 22:00:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830185404.7224-5-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542664825; bh=MzBx2B/Yx+7wJ0B97M+RZbJ6wstQhmoG2oBl6Gnj+Xs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=guftr7tnIea3OAUUjK7ZheVsMlex6UsJh+3ML+mysdho/wqME5P/5Mbh7MYUPK/Wk
         aJ2v3eeekWi3tbSFIfAaGX8vvGTnHLt6RtmOCJE7nYaCs3kjLIkH0TRmzyfqZfAhVU
         7MdHTjb3aCR3GlciFdoRu8QlMEld/nQHA920gJ+iXl3NcFrZw5T6msERD2BJ/RwsJ1
         2AzUJmqSWLQ8vDSjOYlSiXHLkHQGq2WYmnwqEWLvmaXlcT0dvjxK9vm+o8emRc7rol
         yIqazTX0kTKXMo1gemlLTUDENINvbNJFp4KrofQ6jx2t2Zr77mxxYHc2wk5GWEUafr
         KWzEqSAyGph3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 19:54, Dmitry Osipenko wrote:
> Two interrupts are raised on resume from LP1 on Tegra30+: first is the
> clock change completed interrupt which is set after updating timing
> configuration, second is DLL alarm interrupt which is set when DLL
> starts re-calibration after being reset. Clear these two interrupts
> in the end of exiting from the self-refresh mode for consistency, that
> will also allow to not receive spurious interrupts in the EMC driver
> after resume from suspend.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/sleep-tegra30.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
> index 828f6c37afde..78c6e9fb56e7 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -26,6 +26,7 @@
>  #include "irammap.h"
>  #include "sleep.h"
>  
> +#define EMC_INTSTATUS			0x0
>  #define EMC_CFG				0xc
>  #define EMC_ADR_CFG			0x10
>  #define EMC_TIMING_CONTROL		0x28
> @@ -44,6 +45,9 @@
>  #define EMC_XM2VTTGENPADCTRL		0x310
>  #define EMC_XM2VTTGENPADCTRL2		0x314
>  
> +#define EMC_CLKCHANGE_COMPLETE_INT	(1 << 4)
> +#define EMC_DLL_ALARM_INT		(1 << 7)
> +
>  #define MC_EMEM_ARB_CFG			0x90
>  
>  #define PMC_CTRL			0x0
> @@ -539,6 +543,9 @@ zcal_done:
>  
>  	emc_timing_update r1, r0
>  
> +	mov	r1, #(EMC_CLKCHANGE_COMPLETE_INT | EMC_DLL_ALARM_INT)
> +	str	r1, [r0, #EMC_INTSTATUS]	@ clear interrupts
> +
>  	/* Tegra114 had dual EMC channel, now config the other one */
>  	cmp	r10, #TEGRA114
>  	bne	__no_dual_emc_chanl
> 

Where are these interrupts enabled? I did not see where they are
enabled. I see that the Tegra24 EMC driver does poll these, but it did
not look like they were enabled. If they are enabled, I wondering if
they should be masked on entering self-refresh?

Cheers
Jon

-- 
nvpublic
