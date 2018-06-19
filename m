Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD02C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F4020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F4020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937355AbeFSG7c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:59:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3474 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937303AbeFSG73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:59:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b28a9d60000>; Mon, 18 Jun 2018 23:59:35 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Jun 2018 23:59:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Jun 2018 23:59:28 -0700
Received: from [10.2.175.123] (10.2.175.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Jun
 2018 06:59:28 +0000
Subject: Re: [PATCH v3 8/8] mm: Fix exports that inadvertently make put_page()
 EXPORT_SYMBOL_GPL
To:     Dan Williams <dan.j.williams@intel.com>,
        <akpm@linux-foundation.org>
CC:     Joe Gorse <jhgorse@gmail.com>, <hch@lst.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152938832086.17797.4538943238207602944.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3f7833bf-99ad-f36c-1e95-36bf78b60d50@nvidia.com>
Date:   Mon, 18 Jun 2018 23:59:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152938832086.17797.4538943238207602944.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [10.2.175.123]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 11:05 PM, Dan Williams wrote:
> Now that all producers of dev_pagemap instances in the kernel are
> properly converted to EXPORT_SYMBOL_GPL, fix up implicit consumers that
> interact with dev_pagemap owners via put_page(). To reiterate,
> dev_pagemap producers are EXPORT_SYMBOL_GPL because they adopt and
> modify core memory management interfaces such that the dev_pagemap owner
> can interact with all other kernel infrastructure and sub-systems
> (drivers, filesystems, etc...) that consume page structures.
> 
> Fixes: e76384884344 ("mm: introduce MEMORY_DEVICE_FS_DAX and CONFIG_DEV_PAGEMAP_OPS")
> Reported-by: Joe Gorse <jhgorse@gmail.com>
> Reported-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  kernel/memremap.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 16141b608b63..ecee37b44aa1 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>  
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
>  DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
> -EXPORT_SYMBOL_GPL(devmap_managed_key);
> +EXPORT_SYMBOL(devmap_managed_key);
>  static atomic_t devmap_enable;
>  
>  /*
> @@ -371,5 +371,5 @@ void __put_devmap_managed_page(struct page *page)
>  	} else if (!count)
>  		__put_page(page);
>  }
> -EXPORT_SYMBOL_GPL(__put_devmap_managed_page);
> +EXPORT_SYMBOL(__put_devmap_managed_page);
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
> 

Yep, that fixes everything I was seeing.

thanks,
-- 
John Hubbard
NVIDIA
