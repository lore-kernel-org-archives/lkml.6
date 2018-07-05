Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F101C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4882401D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4882401D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeGEFda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:33:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:19525 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeGEFd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:33:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 22:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,310,1526367600"; 
   d="scan'208";a="64286405"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.115]) ([10.239.13.115])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2018 22:33:25 -0700
Subject: Re: [PATCH 3/3] kvm: add a function to check if page is from NVDIMM
 pmem.
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, yi.z.zhang@intel.com
References: <cover.1530716899.git.yi.z.zhang@linux.intel.com>
 <359fdf0103b61014bf811d88d4ce36bc793d18f2.1530716899.git.yi.z.zhang@linux.intel.com>
 <1efab832-8782-38f3-9fd5-7a8b45bde153@redhat.com>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <a6049ab7-19f4-3cdb-a954-c8ad7a05ed37@linux.intel.com>
Date:   Thu, 5 Jul 2018 21:19:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1efab832-8782-38f3-9fd5-7a8b45bde153@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月04日 23:25, Paolo Bonzini wrote:
> On 04/07/2018 17:30, Zhang Yi wrote:
>> For device specific memory space, when we move these area of pfn to
>> memory zone, we will set the page reserved flag at that time, some of
>> these reserved for device mmio, and some of these are not, such as
>> NVDIMM pmem.
>>
>> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
>> backend, since these pages are reserved. the check of
>> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
>> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
>> to indentify these pages are from NVDIMM pmem. and let kvm treat these
>> as normal pages.
>>
>> Without this patch, Many operations will be missed due to this
>> mistreatment to pmem pages. For example, a page may not have chance to
>> be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
>> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
>>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
>> ---
>>  virt/kvm/kvm_main.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index afb2e6e..1365d18 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -140,10 +140,23 @@ __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>>  {
>>  }
>>  
>> +static bool kvm_is_nd_pfn(kvm_pfn_t pfn)
>> +{
>> +	struct page *page = pfn_to_page(pfn);
>> +
>> +	return is_zone_device_page(page) &&
>> +		((page->pgmap->type == MEMORY_DEVICE_FS_DAX) ||
>> +		 (page->pgmap->type == MEMORY_DEVICE_DEV_DAX));
>> +}
> If the mm people agree, I'd prefer something that takes a struct page *
> and is exported by include/linux/mm.h.  Then KVM can just do something like
>
> 	struct page *page;
> 	if (!pfn_valid(pfn))
> 		return true;
>
> 	page = pfn_to_page(pfn);
> 	return PageReserved(page) && !is_dax_page(page);
>
> Thanks,
>
> Paolo
Yeah, that could be much better. Thanks for your comments Paolo.

Hi Kara, Do u have Any opinions/ideas to add such definition in mm?

Regards,
Yi
