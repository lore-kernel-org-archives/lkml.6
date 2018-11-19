Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7F320685
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ewSYLsQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7F320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeKTHxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:53:09 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18469 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKTHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:53:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf32ad10000>; Mon, 19 Nov 2018 13:27:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Nov 2018 13:27:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Nov 2018 13:27:36 -0800
Received: from [10.26.11.92] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 21:27:34 +0000
Subject: Re: [PATCH v1 1/4] ARM: tegra: Fix missed EMC registers latching on
 resume from LP1 on Tegra30+
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-2-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3c7e275e-c833-cfbf-813e-d71858bbef63@nvidia.com>
Date:   Mon, 19 Nov 2018 21:27:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830185404.7224-2-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542662865; bh=QxGf6kMVKfK+AKmgaqRuMikIAnAW0JO4r6WVfW7TMTY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ewSYLsQTN5bJDUcW8Sh9RnkVtayJ5GtuesVoV9oJeNV2DSJl6WcSKN3LyToHSl5x5
         zwcHsj/rq4sw/Pg776faEmITtf2dQmTnC9CwimHUhFpWzGtOddgu3LknAkXGEJHsMo
         4OH7YlkDglsokt1sMMcjk/a1j/G3SPrypGiwfa0eVD/ohCz23X/vVJOp6Ouh9g2l7t
         BhoWzLSe+zaFiuGsHH5jhchh/8TkMjSsDyVCHk4KgMKAzA3rrI/9aNxNsyNBpS2P+h
         POUY6uTCKP2BpXpPYfNxmW46p+Ef3aD7joza+ZvVYRAq0baoImKv8BVgnTJQMHtq+s
         6Jxo7ClDmoxqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 19:54, Dmitry Osipenko wrote:
> The memory interface configuration and re-calibration interval are left
> unassigned on resume from LP1 because these registers are shadowed and
> require latching after being adjusted.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/sleep-tegra30.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
> index 127fc78365fe..801fe58978ae 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -521,6 +521,8 @@ zcal_done:
>  	ldr	r1, [r5, #0x0]		@ restore EMC_CFG
>  	str	r1, [r0, #EMC_CFG]
>  
> +	emc_timing_update r1, r0
> +
>  	/* Tegra114 had dual EMC channel, now config the other one */
>  	cmp	r10, #TEGRA114
>  	bne	__no_dual_emc_chanl
> 

This is stated in the TRM as what needs to be done. So ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
