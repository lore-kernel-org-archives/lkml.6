Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC18214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC18214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeISIXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:23:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeISIXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:23:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 257BE34C9;
        Wed, 19 Sep 2018 02:48:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06FF81001F56;
        Wed, 19 Sep 2018 02:48:03 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8F4A44BB74;
        Wed, 19 Sep 2018 02:48:02 +0000 (UTC)
Date:   Tue, 18 Sep 2018 22:48:02 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        yu c zhang <yu.c.zhang@intel.com>, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi z zhang <yi.z.zhang@intel.com>
Message-ID: <373427884.13987814.1537325282516.JavaMail.zimbra@redhat.com>
In-Reply-To: <044309496afbb4121447dff6a453bd6b96d6068d.1534934405.git.yi.z.zhang@linux.intel.com>
References: <cover.1534934405.git.yi.z.zhang@linux.intel.com> <044309496afbb4121447dff6a453bd6b96d6068d.1534934405.git.yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH V4 3/4] mm: add a function to differentiate the pages is
 from DAX device memory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.79, 10.4.195.12]
Thread-Topic: add a function to differentiate the pages is from DAX device memory
Thread-Index: ebQHsnixA0QSUk8WEmIsX4j9TyKNWg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 19 Sep 2018 02:48:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> DAX driver hotplug the device memory and move it to memory zone, these
> pages will be marked reserved flag, however, some other kernel componet
> will misconceive these pages are reserved mmio (ex: we map these dev_dax
> or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
> MEMORY_DEVICE_FS_DAX, we can use is_dax_page() to differentiate the pages
> is DAX device memory or not.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> Acked-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/mm.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 68a5121..de5cbc3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -889,6 +889,13 @@ static inline bool is_device_public_page(const struct
> page *page)
>  		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
>  }
>  
> +static inline bool is_dax_page(const struct page *page)
> +{
> +	return is_zone_device_page(page) &&
> +		(page->pgmap->type == MEMORY_DEVICE_FS_DAX ||
> +		page->pgmap->type == MEMORY_DEVICE_DEV_DAX);
> +}
> +
>  #else /* CONFIG_DEV_PAGEMAP_OPS */
>  static inline void dev_pagemap_get_ops(void)
>  {
> @@ -912,6 +919,11 @@ static inline bool is_device_public_page(const struct
> page *page)
>  {
>  	return false;
>  }
> +
> +static inline bool is_dax_page(const struct page *page)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
>  
>  static inline void get_page(struct page *page)
> --

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 2.7.4
> 
> 
