Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E89C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609C52172E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609C52172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeHMMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:34:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:53057 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbeHMMez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:34:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 02:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,232,1531810800"; 
   d="scan'208";a="253629167"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.128]) ([10.239.13.128])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2018 02:48:01 -0700
Subject: Re: [PATCH V3 4/4] kvm: add a check if pfn is from NVDIMM pmem.
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, jack@suse.cz,
        hch@lst.de, yu c zhang <yu.c.zhang@intel.com>, linux-mm@kvack.org,
        rkrcmar@redhat.com, yi z zhang <yi.z.zhang@intel.com>
References: <cover.1533811181.git.yi.z.zhang@linux.intel.com>
 <0cc6cba7020f80168695fba731b8fd72fd649dc8.1533811181.git.yi.z.zhang@linux.intel.com>
 <2130082365.883434.1533803526182.JavaMail.zimbra@redhat.com>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <083b8170-a9ba-beee-7578-6d33e70a8b6e@linux.intel.com>
Date:   Tue, 14 Aug 2018 01:32:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2130082365.883434.1533803526182.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月09日 16:32, Pankaj Gupta wrote:
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
> s/indentify/identify & remove '.'
Thanks Pankaj, :-)
>
>> as normal pages.
>>
>> Without this patch, Many operations will be missed due to this
>> mistreatment to pmem pages. For example, a page may not have chance to
>> be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
>> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc
>>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> ---
>>  virt/kvm/kvm_main.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index c44c406..969b6ca 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -147,8 +147,12 @@ __weak void
>> kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>>  
>>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>>  {
>> -        if (pfn_valid(pfn))
>> -                return PageReserved(pfn_to_page(pfn));
>> +        struct page *page;
>> +
>> +        if (pfn_valid(pfn)) {
>> +                page = pfn_to_page(pfn);
>> +                return PageReserved(page) && !is_dax_page(page);
>> +        }
>>  
>>          return true;
>>  }
>> --
>> 2.7.4
>>
>>

