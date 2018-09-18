Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC4ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586E321471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bgF3RFii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586E321471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeIRPAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:00:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34366 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeIRPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:00:22 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180918092836euoutp01c6fd5248464f386d8121d46fdabcacef~VdHo99isr1507515075euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 09:28:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180918092836euoutp01c6fd5248464f386d8121d46fdabcacef~VdHo99isr1507515075euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537262916;
        bh=BBH8ASxraAOXNthsJaNx2YBtg8L/mOwF6+wVYtjm1tU=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=bgF3RFiiZQ/SsxLpSUeAudA4E8EV+egsVNbTDmQzQo3PbroJzNFGeOjPbZJqTxGfF
         KrVAnzim6qjNUZrCE7nh6yq0mO0xFxLoRWdDNjljNA4BkTUFAGHR2p+O9I4Gjncwyu
         3JvmlJfA/k+16Gn2renR8+WfwJxXKpo5rsbQPC+U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180918092835eucas1p1282c25a90853ca6519e6b61278bbff38~VdHob-pr32656326563eucas1p1Q;
        Tue, 18 Sep 2018 09:28:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DB.50.04441.345C0AB5; Tue, 18
        Sep 2018 10:28:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784~VdHnT_5yZ0331203312eucas1p1U;
        Tue, 18 Sep 2018 09:28:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180918092834eusmtrp2f8add3de38d892970fb796146d680343~VdHnDOD7t1060910609eusmtrp2F;
        Tue, 18 Sep 2018 09:28:34 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c3-5ba0c54321e9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8F.B6.04128.145C0AB5; Tue, 18
        Sep 2018 10:28:34 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180918092833eusmtip2c2bbc41f7fff2f411c41f08c81ff8bf2~VdHmsYSFn0905909059eusmtip21;
        Tue, 18 Sep 2018 09:28:33 +0000 (GMT)
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing cma to command
 line
To:     zhe.he@windriver.com, hch@lst.de, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 18 Sep 2018 11:28:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537154660-296740-1-git-send-email-zhe.he@windriver.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7rORxdEG5y4L2yxcvVRJosF+60t
        Lu+aw2Zx8MMTVovlu4wcWD3WzFvD6DH5xnJGj903G9g8Pm+S81i/ZStTAGsUl01Kak5mWWqR
        vl0CV8aCH+cZC74KVKxq7GNsYNzL28XIySEhYCLRvL+HpYuRi0NIYAWjxKdf/6GcL4wSP96f
        YIdwPjNKrNh5gQmm5eS/h1CJ5YwSnXM2sYMkhATeM0qc/VIBYgsLBEl8vnEWLC4iUCNx9dBd
        VhCbTcBQouttFxuIzSKgKrHlwAWgGg4OUYEYid+7rEHCvAKCEidnPmEBsTkF3CSWXVgONoZZ
        QF5i+9s5zBC2uMStJ/OZQG6QEOhnl1iz/RsjRHOZxPaFzewQh7pIXH45mRXCFpZ4dXwLVFxG
        4v9OmOZmRon2GbPYIZweRomtc3awQVRZSxw+fpEV5DpmAU2J9bv0IcKOEq83/2IDCUsI8Enc
        eCsIcRCfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJWYI20Piz/kFjBMYFWcheXkWkjdnIXlz
        FsINCxhZVjGKp5YW56anFhvmpZbrFSfmFpfmpesl5+duYgSmmtP/jn/awfj1UtIhRgEORiUe
        3gUL5kcLsSaWFVfmHmKU4GBWEuHlzFkQLcSbklhZlVqUH19UmpNafIhRmoNFSZyXTystWkgg
        PbEkNTs1tSC1CCbLxMEp1cCY0rtD4fNP7awJ+irBqqdPR7wzOlb99oBBjIhNPsNH8UPR+ROZ
        n1RxcCny8b5VPPMrPe9apci9o88PKeWV8M0+3KrQWvtt69RHT1j3/pj80Hen0JQvc3VdJTwP
        icR2n7qdbO16Q0Hf7P4czk7pmj2+3JpVJyPEzigbvT15SnnzyWmvzk9Y7yauxFKckWioxVxU
        nAgAFnOQ2TEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xe7pORxdEGxz7xWixcvVRJosF+60t
        Lu+aw2Zx8MMTVovlu4wcWD3WzFvD6DH5xnJGj903G9g8Pm+S81i/ZStTAGuUnk1RfmlJqkJG
        fnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaCH+cZC74KVKxq7GNs
        YNzL28XIySEhYCJx8t9D9i5GLg4hgaWMEmc/7mCESMhInJzWwAphC0v8udbFBmILCbxllLh4
        ygHEFhYIkvh84yw7iC0iUCMx/xxEvZDATEaJSbfA6tkEDCW63kL08grYSUy8fQbMZhFQldhy
        4AJYr6hAjMTRyS1QNYISJ2c+YQGxOQXcJJZdWA5WwyxgJjFv80NmCFteYvvbOVC2uMStJ/OZ
        JjAKzkLSPgtJyywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGEPbjv3cAgyL
        d8GHGAU4GJV4eH8smh8txJpYVlyZe4hRgoNZSYSXM2dBtBBvSmJlVWpRfnxRaU5q8SFGU6Dn
        JjJLiSbnA+M7ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QD48qj
        2gsO2DuZLg28oSfDuOnwuWvN709FhmZHHTnCZx7/8F2DZF3w+dNtr0u0P65sCV6/8Pw1jvdr
        k6LkZ4hxf9vhmay+7XcWP9PuqVWzC57tSf10f/4jN5etQd6P+3+tb/we4x1me6jp28vXS0SX
        shff0T/5NYzf64rDybV9Kt+2z/T2C1S39VJiKc5INNRiLipOBABHZVTqtwIAAA==
Message-Id: <20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784~VdHnT_5yZ0331203312eucas1p1U@eucas1p1.samsung.com>
X-CMS-MailID: 20180918092834eucas1p1ebdbc3051a7ca8bbacec26b955689784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917032603epcas4p4da3674e558c4704622f58b133e7fe5ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917032603epcas4p4da3674e558c4704622f58b133e7fe5ce
References: <CGME20180917032603epcas4p4da3674e558c4704622f58b133e7fe5ce@epcas4p4.samsung.com>
        <1537154660-296740-1-git-send-email-zhe.he@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2018-09-17 05:24, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
>
> early_cma does not check input argument before passing it to
> simple_strtoull. The argument would be a NULL pointer if "cma", without
> its value, is set in command line and thus causes the following panic.
>
> PANIC: early exception 0xe3 IP 10:ffffffffa3e9db8d error 0 cr2 0x0
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #7
> [    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
> ...
> [    0.000000] Call Trace:
> [    0.000000]  simple_strtoull+0x29/0x70
> [    0.000000]  memparse+0x26/0x90
> [    0.000000]  early_cma+0x17/0x6a
> [    0.000000]  do_early_param+0x57/0x8e
> [    0.000000]  parse_args+0x208/0x320
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_options+0x29/0x2d
> [    0.000000]  ? rdinit_setup+0x30/0x30
> [    0.000000]  parse_early_param+0x36/0x4d
> [    0.000000]  setup_arch+0x336/0x99e
> [    0.000000]  start_kernel+0x6f/0x4e6
> [    0.000000]  x86_64_start_reservations+0x24/0x26
> [    0.000000]  x86_64_start_kernel+0x6f/0x72
> [    0.000000]  secondary_startup_64+0xa4/0xb0
>
> This patch adds a check to prevent the panic.
>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: stable@vger.kernel.org
> Cc: hch@lst.de
> Cc: m.szyprowski@samsung.com
> Cc: robin.murphy@arm.com

Thanks for the fix.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   kernel/dma/contiguous.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 286d823..b2a8790 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -49,7 +49,11 @@ static phys_addr_t limit_cmdline;
>   
>   static int __init early_cma(char *p)
>   {
> -	pr_debug("%s(%s)\n", __func__, p);
> +	if (!p) {
> +		pr_err("Config string not provided\n");
> +		return -EINVAL;
> +	}
> +
>   	size_cmdline = memparse(p, &p);
>   	if (*p != '@')
>   		return 0;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

