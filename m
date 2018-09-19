Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD57DECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF00214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF00214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeISITK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeISITK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:19:10 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07DC892E1B;
        Wed, 19 Sep 2018 02:43:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5E2C308BDA0;
        Wed, 19 Sep 2018 02:43:31 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id CCE854BB74;
        Wed, 19 Sep 2018 02:43:31 +0000 (UTC)
Date:   Tue, 18 Sep 2018 22:43:31 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        yu c zhang <yu.c.zhang@intel.com>, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi z zhang <yi.z.zhang@intel.com>
Message-ID: <1394508970.13987303.1537325011734.JavaMail.zimbra@redhat.com>
In-Reply-To: <c0b53c74379e6d654bbe42471fcef8aa5fd22efd.1534934405.git.yi.z.zhang@linux.intel.com>
References: <cover.1534934405.git.yi.z.zhang@linux.intel.com> <c0b53c74379e6d654bbe42471fcef8aa5fd22efd.1534934405.git.yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH V4 2/4] mm: introduce memory type MEMORY_DEVICE_DEV_DAX
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.79, 10.4.195.12]
Thread-Topic: introduce memory type MEMORY_DEVICE_DEV_DAX
Thread-Index: OFqm6aQlhMGxhCDm/axIixZAe4oqXg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 19 Sep 2018 02:43:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Currently, NVDIMM pages will be marked 'PageReserved'. However, unlike
> other reserved PFNs, pages on NVDIMM shall still behave like normal ones
> in many cases, i.e. when used as backend memory of KVM guest. This patch
> introduces a new memory type, MEMORY_DEVICE_DEV_DAX. And set this flag
> while dax driver hotplug the device memory.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> Reviewed-by: Jan Kara suse.cz>
> ---
>  drivers/dax/pmem.c       | 1 +
>  include/linux/memremap.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index fd49b24..fb3f363 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -111,6 +111,7 @@ static int dax_pmem_probe(struct device *dev)
>                  return rc;
>  
>          dax_pmem->pgmap.ref = &dax_pmem->ref;
> +        dax_pmem->pgmap.type = MEMORY_DEVICE_DEV_DAX;
>          addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>          if (IS_ERR(addr))
>                  return PTR_ERR(addr);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index f91f9e7..cd07ca8 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -53,11 +53,19 @@ struct vmem_altmap {
>   * wakeup event whenever a page is unpinned and becomes idle. This
>   * wakeup is used to coordinate physical address space management (ex:
>   * fs truncate/hole punch) vs pinned pages (ex: device dma).
> + *
> + * MEMORY_DEVICE_DEV_DAX:
> + * Device memory that support raw access to persistent memory. Without need
> + * of an intervening filesystem, it could be directed mapped via an mmap
> + * capable character device. Together with the type MEMORY_DEVICE_FS_DAX,
> + * we could distinguish the persistent memory pages from normal ZONE_DEVICE
> + * pages.
>   */
>  enum memory_type {
>          MEMORY_DEVICE_PRIVATE = 1,
>          MEMORY_DEVICE_PUBLIC,
>          MEMORY_DEVICE_FS_DAX,
> +        MEMORY_DEVICE_DEV_DAX,
>  };
>  
>  /*
> --

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 2.7.4
> 
> 
