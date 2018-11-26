Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572822086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572822086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeK0ALv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:11:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeK0ALu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:11:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DCB75393E4C32;
        Mon, 26 Nov 2018 21:17:39 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 26 Nov 2018
 21:17:36 +0800
Subject: Re: [PATCH -next] platform/x86: intel-ips: fix 'passing zero to
 ERR_PTR()' warning
To:     <dvhart@infradead.org>, <andy@infradead.org>, <jkosina@suse.cz>
References: <20181126130646.22568-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <5648d56f-532e-8cea-a24b-d0dc49d7e425@huawei.com>
Date:   Mon, 26 Nov 2018 21:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181126130646.22568-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/26 21:06, YueHaibing wrote:
> Fix a static code checker warning:
> drivers/platform/x86/intel_ips.c:1314
>  ips_debugfs_init() warn: passing zero to 'PTR_ERR'
> drivers/platform/x86/intel_ips.c:1328
>  ips_debugfs_init() warn: passing zero to 'PTR_ERR'
> 
> If error occurs,debugfs_create_dir/debugfs_create_file
> return NULL while debugfs is enabled, which should not
> passing to ERR_PTR.

Sorry, a typo 'ERR_PTR' should be 'PTR_ERR', will send v2.

> 
> Fixes: aa7ffc01d254 ("x86 platform driver: intelligent power sharing driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/platform/x86/intel_ips.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index 225638a..a5d1a68 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1311,8 +1311,7 @@ static void ips_debugfs_init(struct ips_driver *ips)
>  
>  	ips->debug_root = debugfs_create_dir("ips", NULL);
>  	if (!ips->debug_root) {
> -		dev_err(ips->dev, "failed to create debugfs entries: %ld\n",
> -			PTR_ERR(ips->debug_root));
> +		dev_err(ips->dev, "failed to create debugfs entries\n")
>  		return;
>  	}
>  
> @@ -1325,8 +1324,7 @@ static void ips_debugfs_init(struct ips_driver *ips)
>  					  ips->debug_root, node,
>  					  &ips_debugfs_ops);
>  		if (!ent) {
> -			dev_err(ips->dev, "failed to create debug file: %ld\n",
> -				PTR_ERR(ent));
> +			dev_err(ips->dev, "failed to create debug file\n");
>  			goto err_cleanup;
>  		}
>  	}
> 

