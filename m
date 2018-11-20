Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F62C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8366220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D0ymKu3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8366220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeKTU4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:56:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17538 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTU4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:56:21 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3e1a00000>; Tue, 20 Nov 2018 02:27:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 02:27:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 02:27:56 -0800
Received: from [10.26.11.164] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 10:27:53 +0000
Subject: Re: [PATCH v1 2/4] ARM: tegra: Fix DRAM refresh-interval clobbering
 on resume from LP1 on Tegra30
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-3-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0f032d8b-60d3-57fd-6f25-5b7b667e0636@nvidia.com>
Date:   Tue, 20 Nov 2018 10:27:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830185404.7224-3-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542709665; bh=sJVyr02c9Jzyj2RKVAPmwds5phpPGtn1X4pTM1DeRTg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=D0ymKu3H6+iCn7CZcJb7YyBPEuuQ6L6DdJObCYFUTc9eI+Pw3SN6DKglSEW582m97
         6OHgDA2t64Gl4FZTDa/H7keOcNEB0I+hPu54luO6M6b5lciNxAgtvp0JrMtswAiznN
         DbmFUJykHox7lZPx1/PHErQxEZAgThEEXQJ/qjtidbR7dbsnQkNS8uSycc+zhX/+r7
         CUEXSt63oQrifbvrM840+QkDL0MXf2SnWztTy6Bs+acCMqU4bHhVB3OUuowfI5GuRf
         Td+hFhIf4PjXXN3qHy68RdsmJc7lp2F48U4E+IOysCYYNj5Ssoer7TmXm1sERRKjy+
         dYXWI5/RusezA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 19:54, Dmitry Osipenko wrote:
> The DRAM refresh-interval is getting erroneously set to "1" on exiting
> from memory self-refreshing mode. The clobbered interval causes the
> "refresh request overflow timeout" error raised by the External Memory
> Controller on exiting from LP1 on Tegra30.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/sleep-tegra30.S | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
> index 801fe58978ae..99ac9c6dcf7c 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -29,7 +29,6 @@
>  #define EMC_CFG				0xc
>  #define EMC_ADR_CFG			0x10
>  #define EMC_TIMING_CONTROL		0x28
> -#define EMC_REFRESH			0x70
>  #define EMC_NOP				0xdc
>  #define EMC_SELF_REF			0xe0
>  #define EMC_MRW				0xe8
> @@ -459,7 +458,6 @@ emc_wait_auto_cal_onetime:
>  	cmp	r10, #TEGRA30
>  	streq	r1, [r0, #EMC_NOP]
>  	streq	r1, [r0, #EMC_NOP]
> -	streq	r1, [r0, #EMC_REFRESH]
>  
>  	emc_device_mask r1, r0

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
