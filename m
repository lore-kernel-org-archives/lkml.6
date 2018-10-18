Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0C0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304C82145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mkFGK6kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304C82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJRLtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:49:31 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:50425 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:49:30 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181018035035epoutp03de89bdab378afdfe36665dc221d71f89~el3FiM0zg2803228032epoutp03F;
        Thu, 18 Oct 2018 03:50:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181018035035epoutp03de89bdab378afdfe36665dc221d71f89~el3FiM0zg2803228032epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539834635;
        bh=7bjZJmG/fNh54+ErkBw+E0zeL2TQRqP4noGLxZMw0O0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=mkFGK6khjCBnvsU0Y7q9Az5ttrTVgzQkqpiKvB0dg496IjLIvnakB3HUqYTjAZkqQ
         5T4jHPJM1OtmHWq84Vl3sQ+ioz8TNvYAOKheadR8/gAs/stqMs/GuqX3ZvomYMrnXn
         baOX8o3gVvzQt+hJsNem/y9Im/9uAp1DYG9+7QwE=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181018035031epcas1p3f504aa0dff90668c695a7e92ffeb1bbe~el3Bq-Gsu3195831958epcas1p3z;
        Thu, 18 Oct 2018 03:50:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.4F.04220.70308CB5; Thu, 18 Oct 2018 12:50:31 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018035031epcas1p220da784fa05d8978ca590a9509d45996~el3BRXGOw0654606546epcas1p2D;
        Thu, 18 Oct 2018 03:50:31 +0000 (GMT)
X-AuditID: b6c32a38-839ff7000000107c-1e-5bc803077c57
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id CF.63.03743.70308CB5; Thu, 18 Oct
        2018 12:50:31 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGS008SX006L410@mmp2.samsung.com>; Thu, 18 Oct 2018 12:50:31 +0900 (KST)
Message-id: <5BC80306.1020005@samsung.com>
Date:   Thu, 18 Oct 2018 12:50:30 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v3 3/6] clocksource: exynos_mct: Refactor resources
 allocation
In-reply-to: <20181017134159.9656-4-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTt25mdGc2taX30oVg6UKRh7riuTeGakNRAUkIloZVN6+DaPtlZ
        e1G0GNVm+eglur0seoAV6a6VZW3gA0VSwTIy1DTFLGjN7B1luztF/rv33HM+7jnfJRB5JRZO
        5ButvMXI6SksEL3bFBMXhyNt2Yq2wxFMbcVtKTN+7ThgLkxGMidflaFMV1cNzjiHn0uZpw/O
        YUxFl1vC3Grux5lffb8xxuU8gzBvJ9rQ1CD25oWbgHVWH8XYvucPMdbT2YmzrisH2JK6asBO
        Oudl4Fm6ZC3P5fKWKN6oMeXmG/PU1Jr1OStzVEkKOo5exiylooycgVdTaekZcavy9d49qaid
        nL7AC2VwgkDFpyRbTAVWPkprEqxqijfn6s3LzEsEziAUGPOWaEyG5bRCkaDyErfptG53AzD/
        iNg9XvoTsYGasCIQQEAyEZZfHESKQCAhJ+sBrCn1SMTmK4Cu6nbpP9aUawQVBzUAFrorEd9A
        Rs6B304NeAcEgZDzYXO3zgcjZAy803AbF/n9AJ62DQKRHws9xSf8j6LkAmj/2Iv6asyLPx57
        gfnq2WQ07Pk27OeHkpvg/Ytf/A+FkA4AS9+fAr4GITskcOBRj18RTG6AJcca/XUAqYaFv35i
        PhIkD+LQ/bkYFz2kwdrBc3/9BMN3rXW4b21IRsDuFrXIPwLgp7GDUrEpA/BDu0siCpRw9FKR
        RDQ3C3o+H5eKYhm0H5aLFBb29dn+em4C8NCnHrQMRDqmxeT4H5NjWkxVAKkGYbxZMOTxAm1O
        nP6BTuA/y1imHjzsTG8EJAGoIJld05otl3I7hT2GRgAJhAqRoWe9kCyX27OXt5hyLAV6XmgE
        Km/KJ5DwUI3Je+RGaw6tSlAqlUwinaSiaWqubCT8fLaczOOsvI7nzbzln05CBITbgO3GlkJJ
        kGvlxqBnb8qR+cQKWcOq1WVd++6su9dSF/JlpNg2Efm96Wp9VaZ9KjVCiM7SXArzJHesnZN/
        aFHn6I7tmVzhSUQ13NF0Pfv14ifyywtdQ9oHCmrooy7x6YypXUpr9+aZL+Ol+6r2WyKtB4zs
        k62ZWVO9p2UT9pSwRY73LgoVtBwdi1gE7g+wDdJmrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e+xoC4784log6nXeC02zljPavF+WQ+j
        xbzPshaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW/y984/NYvOmqcwWLz+eYHHg
        8Vgzbw2jx6ZVnWwed67tYfN4d+4cu8fmJfUefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlbFv
        327Ggl/SFe/7fzM3MG4Q62Lk5JAQMJH4v/kJSxcjF4eQwDpGiUdHdjOBJHgFBCV+TL4HlODg
        YBaQlzhyKRskzCygLjFp3iJmiPr7jBKHfj5gh6jXknjXO5EVxGYRUJXo+HSTBcRmA4rvf3GD
        DcTmF1CUuPrjMSPITFGBCInuE5Ugc0QEZjFKPO9dwQax4CKTxI/7zCC2sECIRF/3ITaIZYcZ
        JR4vagZbwClgK9H09zfbBEagVoRbZyHcOgvJrQsYmVcxSqYWFOem5xYbFRjmpZbrFSfmFpfm
        pesl5+duYgTGy7bDWn07GO8viT/EKMDBqMTD25F8PFqINbGsuDL3EKMEB7OSCC/LbKAQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjKuvzV7iuH5VlX98
        /BLHPzf3zBRbVCaxafHrB3u9GJuNPm7nUl2yQc8qc1lapOlLl+sbfcu0N11JmnxESssrr9RK
        fNWetN0rfUpec16ecS1EIfjQnKeLNuVacF66lv5LbdtVnUbPm0YHL/dPnLG3pTE+9+TRmL0W
        C7ubvLi9+lwPSM2OurFt90UlluKMREMt5qLiRAB+tLJ1kwIAAA==
X-CMS-MailID: 20181018035031epcas1p220da784fa05d8978ca590a9509d45996
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3@eucas1p1.samsung.com>
        <20181017134159.9656-4-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

I tested it for both kernel booting and cpu hotplugging
on Exynos5433-based TM2 board.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

On 2018년 10월 17일 22:41, Marek Szyprowski wrote:
> Move interrupts allocation from exynos4_timer_resources() into separate
> function together with the interrupt number parsing code from
> mct_init_dt(), so the code for managing interrupts is kept together.
> While touching exynos4_timer_resources() function, move of_iomap() to it.
> No functional changes.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 49 +++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 49413900b24c..02ad55db390b 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
> +static int __init exynos4_timer_resources(struct device_node *np)
>  {
> -	int err, cpu;
>  	struct clk *mct_clk, *tick_clk;
>  
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base)
> +		panic("%s: unable to ioremap mct address space\n", __func__);
> +
>  	tick_clk = of_clk_get_by_name(np, "fin_pll");
>  	if (IS_ERR(tick_clk))
>  		panic("%s: unable to determine tick clock rate\n", __func__);
> @@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  		panic("%s: unable to retrieve mct clock instance\n", __func__);
>  	clk_prepare_enable(mct_clk);
>  
> -	reg_base = base;
> -	if (!reg_base)
> -		panic("%s: unable to ioremap mct address space\n", __func__);
> +	return 0;
> +}
> +
> +static int __init exynos4_timer_interrupts(struct device_node *np,
> +					   unsigned int int_type)
> +{
> +	int i, err, cpu;
> +
> +	mct_int_type = int_type;
> +
> +	/* This driver uses only one global timer interrupt */
> +	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +
> +	/*
> +	 * Find out the number of local irqs specified. The local
> +	 * timer irqs are specified after the four global timer
> +	 * irqs are specified.
> +	 */
> +	nr_irqs = of_irq_count(np);
> +	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> +		mct_irqs[i] = irq_of_parse_and_map(np, i);
>  
>  	if (mct_int_type == MCT_INT_PPI) {
>  
> @@ -579,24 +600,14 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  
>  static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  {
> -	u32 nr_irqs, i;
>  	int ret;
>  
> -	mct_int_type = int_type;
> -
> -	/* This driver uses only one global timer interrupt */
> -	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +	ret = exynos4_timer_resources(np);
> +	if (ret)
> +		return ret;
>  
> -	/*
> -	 * Find out the number of local irqs specified. The local
> -	 * timer irqs are specified after the four global timer
> -	 * irqs are specified.
> -	 */
> -	nr_irqs = of_irq_count(np);
> -	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> -		mct_irqs[i] = irq_of_parse_and_map(np, i);
>  
> -	ret = exynos4_timer_resources(np, of_iomap(np, 0));
> +	ret = exynos4_timer_interrupts(np, int_type);
>  	if (ret)
>  		return ret;
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
