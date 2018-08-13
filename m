Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E93C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369121728
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4369121728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeHMMjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:39:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:28735 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbeHMMjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 02:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,232,1531810800"; 
   d="scan'208";a="253630878"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.128]) ([10.239.13.128])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2018 02:57:36 -0700
Subject: Re: [PATCH V3 3/4] mm: add a function to differentiate the pages is
 from DAX device memory
To:     Pankaj Gupta <pagupta@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>, jack@suse.cz,
        hch@lst.de, yu c zhang <yu.c.zhang@intel.com>, linux-mm@kvack.org,
        rkrcmar@redhat.com, yi z zhang <yi.z.zhang@intel.com>
References: <cover.1533811181.git.yi.z.zhang@linux.intel.com>
 <2b7856596e519130946c834d5d61b00b7f592770.1533811181.git.yi.z.zhang@linux.intel.com>
 <872818364.892078.1533806608252.JavaMail.zimbra@redhat.com>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <5ea50e63-b55a-c1e1-50be-6e2d951c04cf@linux.intel.com>
Date:   Tue, 14 Aug 2018 01:41:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <872818364.892078.1533806608252.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月09日 17:23, Pankaj Gupta wrote:
>> DAX driver hotplug the device memory and move it to memory zone, these
>> pages will be marked reserved flag, however, some other kernel componet
>> will misconceive these pages are reserved mmio (ex: we map these dev_dax
>> or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
>> MEMORY_DEVICE_FS_DAX, we can use is_dax_page() to differentiate the pages
>> is DAX device memory or not.
>>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
>> ---
>>  include/linux/mm.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 68a5121..de5cbc3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -889,6 +889,13 @@ static inline bool is_device_public_page(const struct
>> page *page)
>>  		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
>>  }
>>  
>> +static inline bool is_dax_page(const struct page *page)
>> +{
>> +	return is_zone_device_page(page) &&
>> +		(page->pgmap->type == MEMORY_DEVICE_FS_DAX ||
>> +		page->pgmap->type == MEMORY_DEVICE_DEV_DAX);
>> +}
> I think question from Dan for KVM VM with 'MEMORY_DEVICE_PUBLIC' still holds?
> I am also interested to know if there is any use-case.
>
> Thanks,
> Pankaj
Yes, it is, thanks for your remind, Pankaj.
Adding Jerome for Dan's questions on V1:
[Dan]:

Jerome, might there be any use case to pass MEMORY_DEVICE_PUBLIC
memory to a guest vm?

>
>> +
>>  #else /* CONFIG_DEV_PAGEMAP_OPS */
>>  static inline void dev_pagemap_get_ops(void)
>>  {
>> @@ -912,6 +919,11 @@ static inline bool is_device_public_page(const struct
>> page *page)
>>  {
>>  	return false;
>>  }
>> +
>> +static inline bool is_dax_page(const struct page *page)
>> +{
>> +	return false;
>> +}
>>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
>>  
>>  static inline void get_page(struct page *page)
>> --
>> 2.7.4
>>
>>

