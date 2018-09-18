Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1322133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1322133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbeISCCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:02:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729200AbeISCCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 448E180F95;
        Tue, 18 Sep 2018 20:28:23 +0000 (UTC)
Received: from redhat.com (ovpn-124-13.rdu2.redhat.com [10.10.124.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BCDC308BDA0;
        Tue, 18 Sep 2018 20:28:21 +0000 (UTC)
Date:   Tue, 18 Sep 2018 16:28:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        alexander.h.duyck@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] mm, devm_memremap_pages: Kill mapping "System
 RAM" support
Message-ID: <20180918202818.GB14689@redhat.com>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680533172.453305.5701902165148172434.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153680533172.453305.5701902165148172434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 18 Sep 2018 20:28:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 07:22:11PM -0700, Dan Williams wrote:
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

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
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
