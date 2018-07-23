Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476520779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ukYBDa7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1476520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbeGWP0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:26:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54419 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbeGWP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:26:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180723142505euoutp02761ef06aa6ff282800f8cf50c28a4e18~EBZPgiK5z1942419424euoutp02f
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:25:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180723142505euoutp02761ef06aa6ff282800f8cf50c28a4e18~EBZPgiK5z1942419424euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532355905;
        bh=LE1lCUmNpEv2T/BQ2ZNR2LNlGFfdM9x/wcixnD/gT+g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ukYBDa7oMr9PM+S12XMpQaM+bJYPBNnJNp9x6/XeBCqvIKojlwwIQ0ohDyA+ffpdt
         cVq+St8oL5WXuXZNUag68svz/cvV7dhbDS7Vr9dhU7LftsF/z8suiBHwjcvS5M00oV
         +CZdd3ofOiTfoLO1TemZSs01erOPJQYfJPKYp8OA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180723142504eucas1p21861a869f2c31775f5ccf1078f4727b2~EBZOV1UPO1751717517eucas1p2y;
        Mon, 23 Jul 2018 14:25:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 05.70.04627.045E55B5; Mon, 23
        Jul 2018 15:25:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2~EBZNDRgPc2952429524eucas1p2C;
        Mon, 23 Jul 2018 14:25:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180723142503eusmtrp235c19235c2befeb3b58b9513a7a7772a~EBZM0cHub0601506015eusmtrp2O;
        Mon, 23 Jul 2018 14:25:03 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-25-5b55e5402439
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1E.33.04178.E35E55B5; Mon, 23
        Jul 2018 15:25:02 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180723142502eusmtip19e9ed96e93adfc16f6d1667585e282fa~EBZMK7Oh81634616346eusmtip1S;
        Mon, 23 Jul 2018 14:25:02 +0000 (GMT)
Subject: Re: [RFC] ARM: exynos: Fix imprecise abort during Exynos5422
 suspend to RAM
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 23 Jul 2018 16:24:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718195929.5852-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b27u1Nn16n4oKE06BP8gpALhhn4Y0FIUGpoOKdeVNRpm5oK
        1ULQWlpmSnNISxlplqlTlw38aIZjVn6G5iwSbQaG+DXBSjO3m+W/c85znvc8B14SE/ZxfckM
        WR4jl0mzRIQLbhj8MRwYaYtJCBnvJenZRwaCble3cukp+zcufW/+O0aPjLTxaP38JJeuL9Xh
        9ISxjqDVI70c2lTTg+iGLjsv0lU8MTmGifXNtwlxh+6G+G5nMxKv6/3Pc+NdTqUyWRkFjDw4
        Iskl3TjahnK1/oU9Nh1SojEfFeKTQJ0Ey/IoR4VcSCHVhGDB3shliR3B5zIbwZJ1BDWbG9y9
        lcq6LcQOGhHMdNj+kmUEE1tawuHypGJBu6J3rntR9RywtFY7XRhVtptibnG6CCoUVEsqJ8ap
        w/C+f3Y3gyS9qcvwyxjukAWUB1hqv+IOzN+NNkxXOzFGBcDLpTqMxT5g/ap1tgBqiAe6FSvP
        8Y6AKoDhXm/27CioqppHLPaERXMnj8UHYefV3m4JgjK1hseScgRddd0E6wqHAfOY8ziMOg6t
        xmBWPgNDZd24QwbKHT4uebD3uEOV4SHGygK4VSpk3UdAY37xL/b16DhWiUSafS01+5pp9jXT
        /M99jPBm5MPkK7LTGEWojLkapJBmK/JlaUEpOdl6tPut3v42r3WjjfFkE6JIJHITbC5dTBBy
        pQWKomwTAhITeQnGiZgEoSBVWlTMyHMk8vwsRmFCfiQu8hEkHrseL6TSpHlMJsPkMvK9KYfk
        +ypR13xVwOpNySfXKX05P+zOT3VpnLsoeWvu0GD/dObCM+bCpdynFpVhZwCUs6ZQYcuT1g9t
        3tFH/WWFX8rz7W6bizsD5xq22yJXlOT2taYrtYFJcc+LT8fPlRjbQx6su60dGItIefPu7Mx9
        sIatFkdsS+olFTN+sVHRxYnxFfw+qwhXpEtDT2ByhfQPzFcfo1IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7p2T0OjDTYctbZ4MG8bm8XGGetZ
        La5/ec5q0f/4NbPF+fMb2C02Pb7GarGwbQmLxeVdc9gsZpzfx2RxaOpeRotFW7+wO3B7XL52
        kdlj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL2PXhQ2MBfPlKvY+XcLYwHhRvIuRk0NCwERiwpw/jF2MXBxC
        AksZJf5/b2WESMhInJzWwAphC0v8udbFBmILCbxllFg2XwjEFhYIk7j28wwbSLOIwEImie3t
        i1hAHGaBdkaJjpX/2CDGAjkrfz0BG8smYCjR9RZiFK+AncTsY7/A4iwCqhJnDzwAWycqECNx
        dHILVI2gxMmZT1hAbE6gW7fdnAJmMwuYSczb/JAZwpaX2P52DpQtLnHryXymCYxCs5C0z0LS
        MgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExue2Yz8372C8tDH4EKMAB6MS
        D++PtyHRQqyJZcWVuYcYJTiYlUR4L7GFRgvxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjB1
        5JXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYJR7tjO2hS0v48+y
        VOdm5+zCo8+MajnzbwdOsRKuv+hfGuNhVbfO6oDUvpbry6IUSrY3nX3itM5Q9q2J3eoDrs0/
        Ey7e57nG2negrUKV88rT5/tTwtYEcyVVW2+pybf3TrVzlk6K2FtUqifHItoq/uR7p3zSp1dZ
        BU5lKm3fX33hfNzTKHRUiaU4I9FQi7moOBEANrako+UCAAA=
Message-Id: <20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2~EBZNDRgPc2952429524eucas1p2C@eucas1p2.samsung.com>
X-CMS-MailID: 20180723142503eucas1p24f8d96f8c4ec25dbdb80e27e2f1444c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180718200005epcas1p1cb2568c593276849c066b3a53f1e971b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180718200005epcas1p1cb2568c593276849c066b3a53f1e971b
References: <CGME20180718200005epcas1p1cb2568c593276849c066b3a53f1e971b@epcas1p1.samsung.com>
        <20180718195929.5852-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-07-18 21:59, Krzysztof Kozlowski wrote:
> Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
> imprecise abort:
>
> 	PM: Syncing filesystems ... done.
> 	Freezing user space processes ... (elapsed 0.003 seconds) done.
> 	OOM killer disabled.
> 	Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
> 	wake enabled for irq 139
> 	Disabling non-boot CPUs ...
> 	IRQ51 no longer affine to CPU1
> 	IRQ52 no longer affine to CPU2
> 	IRQ53 no longer affine to CPU3
> 	IRQ54 no longer affine to CPU4
> 	IRQ55 no longer affine to CPU5
> 	IRQ56 no longer affine to CPU6
> 	cpu cpu4: Dropping the link to regulator.40
> 	IRQ57 no longer affine to CPU7
> 	Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
> 	Internal error: : 1008 [#1] PREEMPT SMP ARM
>
> with last call trace in exynos_suspend_enter().
>
> The abort is caused by writing to register in secure part of sysram.
> All Exynos5422 devices, including Hardkernel Odroid boards, boot with
> TrustZone in non-secure mode therefore they should access non-secure
> sysram.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Comments, whether my understanding is correct, are welcomed!

The decision, weather to use secure or non-secure sysram depends on the
enabled TrustZone interface IMHO. Exynos5420 PeachPIT and Exynos5800 PeachPI
don't use TrustZone and don't have 'firmware' node in dts, thus they should
keep existing code.

> ---
>   Documentation/arm/Samsung/Bootloader-interface.txt | 1 +
>   arch/arm/mach-exynos/suspend.c                     | 6 +++---
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/arm/Samsung/Bootloader-interface.txt b/Documentation/arm/Samsung/Bootloader-interface.txt
> index ed494ac0beb2..d17ed518a7ea 100644
> --- a/Documentation/arm/Samsung/Bootloader-interface.txt
> +++ b/Documentation/arm/Samsung/Bootloader-interface.txt
> @@ -26,6 +26,7 @@ Offset        Value                                        Purpose
>   0x20          0xfcba0d10 (Magic cookie)                    AFTR
>   0x24          exynos_cpu_resume_ns                         AFTR
>   0x28 + 4*cpu  0x8 (Magic cookie, Exynos3250)               AFTR
> +0x28          0x0 or last value during resume (Exynos542x) System suspend
>   
>   
>   2. Secure mode
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index d3db306a5a70..0ec52f442b97 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -256,7 +256,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
>   	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>   	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>   
> -	writel_relaxed(0x0, sysram_base_addr + EXYNOS5420_CPU_STATE);
> +	writel_relaxed(0x0, sysram_ns_base_addr + EXYNOS5420_CPU_STATE);
>   
>   	if (IS_ENABLED(CONFIG_EXYNOS5420_MCPM)) {
>   		mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
> @@ -328,7 +328,7 @@ static void exynos5420_pm_prepare(void)
>   	 * needs to restore it back in case, the primary cpu fails to
>   	 * suspend for any reason.
>   	 */
> -	exynos5420_cpu_state = readl_relaxed(sysram_base_addr +
> +	exynos5420_cpu_state = readl_relaxed(sysram_ns_base_addr +
>   					     EXYNOS5420_CPU_STATE);
>   
>   	exynos_pm_enter_sleep_mode();
> @@ -448,7 +448,7 @@ static void exynos5420_pm_resume(void)
>   
>   	/* Restore the sysram cpu state register */
>   	writel_relaxed(exynos5420_cpu_state,
> -		       sysram_base_addr + EXYNOS5420_CPU_STATE);
> +		       sysram_ns_base_addr + EXYNOS5420_CPU_STATE);
>   
>   	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
>   			S5P_CENTRAL_SEQ_OPTION);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

