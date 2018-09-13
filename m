Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62718FC616D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BA321566
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BA321566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeIMVVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:21:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44186 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeIMVVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:21:00 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g0UCf-0001Ef-BM; Thu, 13 Sep 2018 10:10:50 -0600
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        alexander.h.duyck@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680533172.453305.5701902165148172434.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <50c1172d-29c6-4509-de0d-897163b0b2e4@deltatee.com>
Date:   Thu, 13 Sep 2018 10:10:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153680533172.453305.5701902165148172434.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexander.h.duyck@intel.com, jglisse@redhat.com, hch@lst.de, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 2/7] mm, devm_memremap_pages: Kill mapping "System RAM"
 support
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 08:22 PM, Dan Williams wrote:
> Given the fact that devm_memremap_pages() requires a percpu_ref that is
> torn down by devm_memremap_pages_release() the current support for
> mapping RAM is broken.
> 
> Support for remapping "System RAM" has been broken since the beginning
> and there is no existing user of this this code path, so just kill the
> support and make it an explicit error.
> 
> This cleanup also simplifies a follow-on patch to fix the error path
> when setting a devm release action for devm_memremap_pages_release()
> fails.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

> ---
>  kernel/memremap.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index f95c7833db6d..92e838127767 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -202,15 +202,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>  	is_ram = region_intersects(align_start, align_size,
>  		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
>  
> -	if (is_ram == REGION_MIXED) {
> -		WARN_ONCE(1, "%s attempted on mixed region %pr\n",
> -				__func__, res);
> +	if (is_ram != REGION_DISJOINT) {
> +		WARN_ONCE(1, "%s attempted on %s region %pr\n", __func__,
> +				is_ram == REGION_MIXED ? "mixed" : "ram", res);
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	if (is_ram == REGION_INTERSECTS)
> -		return __va(res->start);
> -
>  	if (!pgmap->ref)
>  		return ERR_PTR(-EINVAL);
>  
> 
