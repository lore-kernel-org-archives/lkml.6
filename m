Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42002C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0625F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ltr8t3G4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0625F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeKTIRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:17:10 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2377 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbeKTIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:17:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf330590001>; Mon, 19 Nov 2018 13:51:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Nov 2018 13:51:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Nov 2018 13:51:30 -0800
Received: from [10.26.11.92] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 21:51:29 +0000
Subject: Re: [PATCH v1 1/4] ARM: tegra: Fix missed EMC registers latching on
 resume from LP1 on Tegra30+
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-2-digetx@gmail.com>
 <3c7e275e-c833-cfbf-813e-d71858bbef63@nvidia.com>
Message-ID: <b8279f9d-1bab-0346-c383-57f7ad92fca2@nvidia.com>
Date:   Mon, 19 Nov 2018 21:51:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3c7e275e-c833-cfbf-813e-d71858bbef63@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542664281; bh=tzbjy3O96p6Zb/djZ4f9+oziVlY5Vj85KiR/aVzHUDQ=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ltr8t3G4UXu5MKp48PSbQ3i7y1fKQJ/Q/zDt5a6AdS67PyKOFgqA0q7tF67mx6YnR
         rawMp42fnq+VGAZaQUbuwVfY+h2ZqJMZpSJprGwm59cY05BI/BqcdF26hbG81t+Dvs
         PSRAgeNBTvQfyHaNZbYW/XCMzppBlq76WaoOrwmYYHNOnWhdiwV3pOfi0jrvz18zLS
         tO0nQX+l+2mcm72HtiIcboL4w7p0gaG/TQs5N7N084rySrkBrKP9wG7QnJYhLWisG1
         VDcip2rWGEWr5zNq2NHe5HSviYFiLwrM3eoSYe6BZUSvK2f1WedP4R8+E+2/pDT8gv
         KSK9IVeeWxCMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/11/2018 21:27, Jon Hunter wrote:
> 
> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>> The memory interface configuration and re-calibration interval are left
>> unassigned on resume from LP1 because these registers are shadowed and
>> require latching after being adjusted.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/sleep-tegra30.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>> index 127fc78365fe..801fe58978ae 100644
>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>> @@ -521,6 +521,8 @@ zcal_done:
>>  	ldr	r1, [r5, #0x0]		@ restore EMC_CFG
>>  	str	r1, [r0, #EMC_CFG]
>>  
>> +	emc_timing_update r1, r0
>> +
>>  	/* Tegra114 had dual EMC channel, now config the other one */
>>  	cmp	r10, #TEGRA114
>>  	bne	__no_dual_emc_chanl
>>
> 
> This is stated in the TRM as what needs to be done. So ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Also ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
