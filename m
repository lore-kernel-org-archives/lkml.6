Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oleBAVDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF3B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeKUS1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:27:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50022 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbeKUS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:27:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121075417euoutp01fa270dd9b5be86b02889993039999df8~pFHkO3ltC0231702317euoutp01w
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:54:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121075417euoutp01fa270dd9b5be86b02889993039999df8~pFHkO3ltC0231702317euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542786857;
        bh=TuR+F8AJlJP0ZaU+SxkoMw/jpv4p/kipzX27FfX5C6o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oleBAVDeepDeGNf1OhmWZh+ZMCjb0TnF+iwZ98tuA+FRJRWSddXr23rwRV3+oaRjs
         FlHbmSvZ4cYe+ATw3Hqurvsq+UsUaNXlYCz9aQHLgKbHLqcbERVolV5ktQ/BGnTOs+
         HESjQcOEs/UcIYDSJ5NRWgaWDdrWLUHC5tbggHy0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181121075416eucas1p2f84281156d49a519ca7ac477a464912c~pFHjlWWC91705417054eucas1p2g;
        Wed, 21 Nov 2018 07:54:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E5.44.04294.82F05FB5; Wed, 21
        Nov 2018 07:54:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181121075415eucas1p27dabe2e9e821fabf7ae19e5d27627f56~pFHipAC0b1706717067eucas1p2m;
        Wed, 21 Nov 2018 07:54:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181121075415eusmtrp229756842559f6144d12650deb65afe34~pFHiZ6j6A0546505465eusmtrp2S;
        Wed, 21 Nov 2018 07:54:15 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c9-5bf50f281efb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.58.04284.72F05FB5; Wed, 21
        Nov 2018 07:54:15 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121075415eusmtip2b6c9ab106cd068aaf08ee794c4c412b4~pFHh7S4640945409454eusmtip29;
        Wed, 21 Nov 2018 07:54:15 +0000 (GMT)
Subject: Re: [PATCH 7/9] videobuf2/videobuf2-dma-sg.c: Convert to use
 vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        willy@infradead.org, mhocko@suse.com, pawel@osciak.com,
        kyungmin.park@samsung.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1c228982-e1c6-a9d5-87ef-1a3206a426f3@samsung.com>
Date:   Wed, 21 Nov 2018 08:54:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181115155037.GA28004@jordon-HP-15-Notebook-PC>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUhTcRTt53t7e5vOntPwZqIwNNJIU6IeGGYl8fSPCvojclEtfam0qWxq
        WRDDSGuoSUnO1yoN8gtRW3OlEKRCS8tqiR+IzkDBpi77WDBbaD6flv+de8+595wLl8Tkb0Uh
        ZHZOPqvNUakVhBS3vl58v2vH5l/K3RXL4bSprYWgh4f0GD1QPC+mB7tMBF3W3iGiHS3LIrre
        /MeHnqxIoqtci2La6zERSVKmk5sQM88aoxlz8y2CMf+4I2beGL04M/XbSTAVlmbEtFmGcOan
        Oey4JE26P4NVZxey2tjEc9KsN9VuIu+h/+VS7zCmR1ZfA5KQQO0B57gHNyApKacaEQx+ta8V
        bgT3y0fWip8IrIYJfH1kvuQG4rGcakAw+0QtiBYQ2Os9BE8EUidhwF5O8EQQ9RTBwui4iCcw
        6gTUcgNiHhNUHBhchhURScqoRKgrYfk2TkWCp9e9Kt9CnYbXTaOrZjIqAPpqpldDSFbkjg6j
        j7AyHJ67TJiAg2Fs+pEP7wuUQwwTcw6RkDoZ7vV7MQEHwqzNIhZwKCx3rg9cR1Bq5MRCUYag
        w/SCEFQJ0Guzi/ikGBUFbV2xPATqIBR/UgjQH0ZdAUIGf7hjrcaEtgxulsiFHduBs7X+c+3+
        +AmrRApuw2Xchmu4Dddw/21rEd6MgtkCnSaT1cXnsJdidCqNriAnMyY9V2NGKy/2dsnmfoG6
        /pzvQRSJFH6yc4FupVykKtQVaXoQkJgiSFY+s9KSZaiKrrDa3LPaAjWr60HbSFwRLLu66bNS
        TmWq8tmLLJvHatdZH1ISokcRLVFhh4iXy85+v/YERUF3rufYBetw4hzrbG34ZlM+Sji1z4A6
        F1Pct7fa1Uupud8rJa+GasYeM8kHsA8HxvJ3DlZ7Dw9fw49k1Nn1D1K/7PVt7Usbf/dQr01u
        jK/Ay8q5uuIpy4cUpzV0pHZmV+TdptK2M1WNc0mTEenIeDRbgeuyVHHRmFan+gvzZXlmXgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xe7rq/F+jDSYslLGYs34Nm8W1qw3M
        Fmeb3rBbXN41h82iZ8NWVot7a/6zWizb9IfJ4n6fg8WUtz/ZLX7/mMPmwOWxc9Zddo/NK7Q8
        Nq3qZPPY9GkSu8eJGb9ZPB7/esnm0bdlFaPH+i1XWTw+b5IL4IzSsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzgx/QtbwTy+ivbf15gbGLdxdzFy
        ckgImEi8aWtlBLGFBJYySqz+XgkRl5E4Oa2BFcIWlvhzrYuti5ELqOYto8TZHTuZQBLCAuES
        Zy/2giVEBDYySjSdXsQOkmAWCJY4tfsV1NSJjBJH7iqC2GwChhJdb0EmcXDwCthJLGxLBQmz
        CKhK/Dj8BWyZqECMROf1eWwgNq+AoMTJmU9YQGxOoPJ7W2cwQYxXl/gz7xIzhC0vsf3tHChb
        XOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNpt
        x35u3sF4aWPwIUYBDkYlHt4E4S/RQqyJZcWVuYcYJTiYlUR4e58DhXhTEiurUovy44tKc1KL
        DzGaAj03kVlKNDkfmFDySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFw
        SjUwauRGn7a/WBD4/t13xhzOVxcsfG4FvNJcvs/hm/Rmzpbjnm6dzG4fmm4zMJx/9pR/EYuH
        M7eAwr/F+7UT1Fl/p6755GR3kTFq8oajl4qOcMbt+Z5fqjP/ocd2iYbUA2xmZVUf9v6YKG7T
        o7wxu2rx0rMp879MiK1nvvc+vai9NuRg/gfT9Am/lViKMxINtZiLihMBQdt4q/ACAAA=
X-CMS-MailID: 20181121075415eucas1p27dabe2e9e821fabf7ae19e5d27627f56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181115154713epcas4p1818fa71d5e67c9a73dc75ceda1704ea3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181115154713epcas4p1818fa71d5e67c9a73dc75ceda1704ea3
References: <CGME20181115154713epcas4p1818fa71d5e67c9a73dc75ceda1704ea3@epcas4p1.samsung.com>
        <20181115155037.GA28004@jordon-HP-15-Notebook-PC>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On 2018-11-15 16:50, Souptick Joarder wrote:
> Convert to use vm_insert_range to map range of kernel memory
> to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> index 015e737..898adef 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -328,28 +328,19 @@ static unsigned int vb2_dma_sg_num_users(void *buf_priv)
>  static int vb2_dma_sg_mmap(void *buf_priv, struct vm_area_struct *vma)
>  {
>  	struct vb2_dma_sg_buf *buf = buf_priv;
> -	unsigned long uaddr = vma->vm_start;
> -	unsigned long usize = vma->vm_end - vma->vm_start;
> -	int i = 0;
> +	unsigned long page_count = vma_pages(vma);
> +	int err;
>  
>  	if (!buf) {
>  		printk(KERN_ERR "No memory to map\n");
>  		return -EINVAL;
>  	}
>  
> -	do {
> -		int ret;
> -
> -		ret = vm_insert_page(vma, uaddr, buf->pages[i++]);
> -		if (ret) {
> -			printk(KERN_ERR "Remapping memory, error: %d\n", ret);
> -			return ret;
> -		}
> -
> -		uaddr += PAGE_SIZE;
> -		usize -= PAGE_SIZE;
> -	} while (usize > 0);
> -
> +	err = vm_insert_range(vma, vma->vm_start, buf->pages, page_count);
> +	if (err) {
> +		printk(KERN_ERR "Remapping memory, error: %d\n", err);
> +		return err;
> +	}
>  
>  	/*
>  	 * Use common vm_area operations to track buffer refcount.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

