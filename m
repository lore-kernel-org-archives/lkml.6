Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF920C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4983621566
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4983621566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbeHHDzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:55:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:46499 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeHHDzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:55:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 18:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="74635618"
Received: from unknown (HELO [10.239.13.128]) ([10.239.13.128])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2018 18:38:36 -0700
Subject: Re: [PATCH V2 2/4] mm: introduce memory type MEMORY_DEVICE_DEV_DAX
To:     Jan Kara <jack@suse.cz>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, hch@lst.de, yu.c.zhang@intel.com,
        linux-mm@kvack.org, rkrcmar@redhat.com, yi.z.zhang@intel.com
References: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
 <7e20d862f96662e1a7736dbb747a71949933dcd4.1531241281.git.yi.z.zhang@linux.intel.com>
 <20180807091120.ybne44o2fy2mxcch@quack2.suse.cz>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <60a42f73-1772-24eb-26f0-efd892b0487c@linux.intel.com>
Date:   Wed, 8 Aug 2018 17:22:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180807091120.ybne44o2fy2mxcch@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月07日 17:11, Jan Kara wrote:
> On Wed 11-07-18 01:01:59, Zhang Yi wrote:
>> Currently, NVDIMM pages will be marked 'PageReserved'. However, unlike
>> other reserved PFNs, pages on NVDIMM shall still behave like normal ones
>> in many cases, i.e. when used as backend memory of KVM guest. This patch
>> introduces a new memory type, MEMORY_DEVICE_DEV_DAX. And set this flag
>> while dax driver hotplug the device memory.
>>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
>> ---
>>  drivers/dax/pmem.c       | 1 +
>>  include/linux/memremap.h | 9 +++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
>> index fd49b24..fb3f363 100644
>> --- a/drivers/dax/pmem.c
>> +++ b/drivers/dax/pmem.c
>> @@ -111,6 +111,7 @@ static int dax_pmem_probe(struct device *dev)
>>  		return rc;
>>  
>>  	dax_pmem->pgmap.ref = &dax_pmem->ref;
>> +	dax_pmem->pgmap.type = MEMORY_DEVICE_DEV_DAX;
>>  	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>>  	if (IS_ERR(addr))
>>  		return PTR_ERR(addr);
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 5ebfff6..a36bce8 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -53,11 +53,20 @@ struct vmem_altmap {
>>   * wakeup event whenever a page is unpinned and becomes idle. This
>>   * wakeup is used to coordinate physical address space management (ex:
>>   * fs truncate/hole punch) vs pinned pages (ex: device dma).
>> + *
>> + * MEMORY_DEVICE_DEV_DAX:
>> + * DAX driver hotplug the device memory and move it to memory zone, these
>> + * pages will be marked reserved flag. However, some other kernel componet
>> + * will misconceive these pages are reserved mmio (ex: we map these dev_dax
>> + * or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
>> + * MEMORY_DEVICE_FS_DAX, we can differentiate the pages on NVDIMM with the
>> + * normal reserved pages.
> So I believe the description should be in terms of what kind of memory is
> the MEMORY_DEVICE_DEV_DAX type, not how users use this type. See comments
> for other memory types...
>
> 								Honza
Yes, agree, thanks for your kindly review. Jan.
>
>>   */
>>  enum memory_type {
>>  	MEMORY_DEVICE_PRIVATE = 1,
>>  	MEMORY_DEVICE_PUBLIC,
>>  	MEMORY_DEVICE_FS_DAX,
>> +	MEMORY_DEVICE_DEV_DAX,
>>  };
>>  
>>  /*
>> -- 
>> 2.7.4
>>

