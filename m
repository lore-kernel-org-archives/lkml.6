Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FAAECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B98E2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZHOcuK9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B98E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJRLuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:50:03 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:63510 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeJRLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:50:03 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181018035106epoutp024ce717cb48dc92d38be4e07a56318006~el3h-i5GC1005710057epoutp02O;
        Thu, 18 Oct 2018 03:51:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181018035106epoutp024ce717cb48dc92d38be4e07a56318006~el3h-i5GC1005710057epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539834666;
        bh=XCu1FYOzGvX85/qjqDOADjYYw3fUZKPmmXhaGJqp3aQ=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=ZHOcuK9tuJcIVcqxvsNXEqFirj7EkEcD4RAlKCVSVFW19nZsrUTmATnRLwOi2r54e
         726hX+ihgLswiQnMvk6qi34E5LS7BSjW7ioParWiif3MVMerNjhzrCa25sthN/OqZu
         siE3RQWQbfzhp8j2Hmg+8c1X1dEhoVtg2fm4/2pI=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018035103epcas1p12095acb3d6928c581e315d0e64d3f79d~el3fDZA9J2988029880epcas1p1z;
        Thu, 18 Oct 2018 03:51:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.5F.04220.62308CB5; Thu, 18 Oct 2018 12:51:02 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181018035102epcas1p18049acaf0192a6078632a91f565cf919~el3eVG0UK2988029880epcas1p1y;
        Thu, 18 Oct 2018 03:51:02 +0000 (GMT)
X-AuditID: b6c32a38-839ff7000000107c-85-5bc80326e11f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 31.73.03743.62308CB5; Thu, 18 Oct
        2018 12:51:02 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGS00G59012S5A0@mmp2.samsung.com>; Thu, 18 Oct 2018 12:51:02 +0900 (KST)
Message-id: <5BC80326.2000108@samsung.com>
Date:   Thu, 18 Oct 2018 12:51:02 +0900
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
Subject: Re: [PATCH v3 4/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
In-reply-to: <20181017134159.9656-5-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTURDO6263C2n1UVFf6lVWjEJSZKHVVanBaMhGMSHxhwQSYIW1EHql
        23olRuIBiAQRo2hVlGg0QRQtR1ARFVGISvFISTWIeMYjnlS8j2U3Rv7NfPN9876ZNySmrSZ0
        ZIHdzbvsnJUiwvGWqzEGw0ysOzN+sEjNnN3XoGTeHy8HTM3QFKbqUSXO9PaeUTG+p31K5t75
        gwSzr7ddwZzqfKhifvX/JphG3x6MefWxG09Ws/U19YD11W0n2P6+NoJ95/er2MZjm9iKpjrA
        DvmmpqkyCpPyeS6Pd+l5e64jr8BuMVPLVmQvzjbNiacN9DxmLqW3czbeTC1JTTOkFFhFn5R+
        DWf1iFAaJwjU7IVJLofHzevzHYLbTPHOPKtznjNO4GyCx26Jy3XY5tPx8QkmkZhTmP89sB04
        Q+p1XaFmvAicDy8DYSSCRtSxI6goA+GkFrYC1FdVCuTkC0APKr7h/1iP2ytxuXAGoJ3116WC
        Bkagr7sHxJgkMTgNdd4tHIExGIOaLzSoZP5DgJr3VxMyPxY1nC2StDicgc4Vf1KOxISIX3oZ
        lDhjYRQKfH0KRuLxMB2dOzwsNYqEXvHht7slexjsUaCBiwFJMQ7moFs9IalTGDSjnpt3JBKC
        fwjkGx7ERuwhuATV7k2RxxmHXnc1qWR4Erp7zSzTSwAKvdyilJNKgD7caFTIgkT0orZMIc82
        Br37XK6UxRpUWqyVKSy6PXhfcq2FVwFqe85WgineUUvy/l+Sd9SSjgCsDkzgnYLNwgu00zj6
        +3xAOspYphW0+VM7ACQBpdaU5nZlapXcGmG9rQMgEqMiNfgBEdLkces38C5Htstj5YUOYBJ3
        vAvTjc91iCdud2fTpoTExETGSM8x0TQ1UfNMdyhTCy2cmy/keSfv+qdTkGG6IrA0K+ZNeSAl
        GJVQEhlxAswsKN7c+mf62366dNHPks0Z0bqB1owqelV07NBwUH0yKmdHS/XKZFd0cONkT8Dh
        N+gVoItcsDxkWmt1qi4f4P2zkrZGtCckbzMePT1/hQZsjWvwWq2P05uN6ZfKsmw/nuzasPqj
        5Unnlckt38d0v6+4RuFCPkfHYi6B+wtxsYuxqgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jQV015hPRBl0PxCw2zljPavF+WQ+j
        xbzPshaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW/y984/NYvOmqcwWLz+eYHHg
        8Vgzbw2jx6ZVnWwed67tYfN4d+4cu8fmJfUefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlfHr
        aidjwReeiuNftrI0MO7i6mLk5JAQMJF4uG8CC4gtJLCOUeLm4hwQm1dAUOLH5HtAcQ4OZgF5
        iSOXskHCzALqEpPmLWLuYuQCKr/PKLFmbTMbRL2WxPqNDWBzWARUJXa2fWIFsdmA4vtf3ACr
        4RdQlLj64zEjyExRgQiJ7hOVIHNEBGYxSjzvXcEGseAik8SP+8wgtrBAgsT3bRtYIJYdZpR4
        suIzE0iCU8BW4uzpi4wTGIFaEW6dhXDrLCS3LmBkXsUomVpQnJueW2xUYJiXWq5XnJhbXJqX
        rpecn7uJERgt2w5r9e1gvL8k/hCjAAejEg9vR/LxaCHWxLLiytxDjBIczEoivCyzgUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUwJhnuNO478rVolbF4
        lNTvZ4EPpgTJzc+p8DypLeeZX5eQ26wutKbq8SYZxk+PPgV+Pt631GjzTe+tkulX860EteXk
        XTc7bm4MWPha7cCnfVbq/9UWGT1hl7wpIiWzKf/2jkesE1r9a9briYroZKxznbaJdec/tS+T
        j5xiEJb75XVy+h8ve/0fSizFGYmGWsxFxYkAllQ+K5ICAAA=
X-CMS-MailID: 20181018035102epcas1p18049acaf0192a6078632a91f565cf919
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181017134207eucas1p1b938eefe31fc47baaf538c9ebafc1a7e
References: <20181017134159.9656-1-m.szyprowski@samsung.com>
        <CGME20181017134207eucas1p1b938eefe31fc47baaf538c9ebafc1a7e@eucas1p1.samsung.com>
        <20181017134159.9656-5-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2018년 10월 17일 22:41, Marek Szyprowski wrote:
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks (global system counter). This patch
> adds a mode of cooperation with arch_timer driver, so kernel can use
> CP15 based timer interface via arch_timer driver, which is mandatory
> on ARM64. In such mode MCT driver only enables its clocks and starts
> global timer. Everything else will be handled by arch_timer driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 02ad55db390b..1b19a4f03929 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -606,6 +606,15 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  	if (ret)
>  		return ret;
>  
> +	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
> +		struct device_node *np = of_find_compatible_node(NULL, NULL,
> +							     "arm,armv8-timer");
> +		if (np) {
> +			of_node_put(np);
> +			exynos4_mct_frc_start();
> +			return 0;
> +		}
> +	}
>  
>  	ret = exynos4_timer_interrupts(np, int_type);
>  	if (ret)
> 

I tested it on Exynos5433-based TM2 board.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
