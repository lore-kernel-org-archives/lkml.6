Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD6240FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD6240FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeGEFef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:34:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:28337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752900AbeGEFed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:34:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 22:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,310,1526367600"; 
   d="scan'208";a="242753694"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.115]) ([10.239.13.115])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2018 22:34:30 -0700
Subject: Re: [PATCH 2/3] mm: introduce memory type MEMORY_DEVICE_DEV_DAX
To:     Dan Williams <dan.j.williams@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux MM <linux-mm@kvack.org>, rkrcmar@redhat.com
References: <cover.1530716899.git.yi.z.zhang@linux.intel.com>
 <5c7996b8e6d31541f3185f8e4064ff97582c86f8.1530716899.git.yi.z.zhang@linux.intel.com>
 <CAPcyv4gjFVG7tHv65Z=FsZ9=5wXDxNWawFJqO8MkyMudch4zDw@mail.gmail.com>
From:   zhangyi6 <yi.z.zhang@intel.com>
Message-ID: <c5fad961-05ea-73da-7fda-f48c910136d9@intel.com>
Date:   Thu, 5 Jul 2018 21:20:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gjFVG7tHv65Z=FsZ9=5wXDxNWawFJqO8MkyMudch4zDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月04日 22:50, Dan Williams wrote:
> On Wed, Jul 4, 2018 at 8:30 AM, Zhang Yi <yi.z.zhang@linux.intel.com> wrote:
>> Currently, NVDIMM pages will be marked 'PageReserved'. However, unlike
>> other reserved PFNs, pages on NVDIMM shall still behave like normal ones
>> in many cases, i.e. when used as backend memory of KVM guest. This patch
>> introduces a new memory type, MEMORY_DEVICE_DEV_DAX. Together with the
>> existing type MEMORY_DEVICE_FS_DAX, we can differentiate the pages on
>> NVDIMM with the normal reserved pages.
>>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
>> ---
>>  drivers/dax/pmem.c       | 1 +
>>  include/linux/memremap.h | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
>> index fd49b24..fb3f363 100644
>> --- a/drivers/dax/pmem.c
>> +++ b/drivers/dax/pmem.c
>> @@ -111,6 +111,7 @@ static int dax_pmem_probe(struct device *dev)
>>                 return rc;
>>
>>         dax_pmem->pgmap.ref = &dax_pmem->ref;
>> +       dax_pmem->pgmap.type = MEMORY_DEVICE_DEV_DAX;
>>         addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>>         if (IS_ERR(addr))
>>                 return PTR_ERR(addr);
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 5ebfff6..4127bf7 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -58,6 +58,7 @@ enum memory_type {
>>         MEMORY_DEVICE_PRIVATE = 1,
>>         MEMORY_DEVICE_PUBLIC,
>>         MEMORY_DEVICE_FS_DAX,
>> +       MEMORY_DEVICE_DEV_DAX,
> Please add documentation for this new type to the comment block about
> this definition.
Thanks for your comments Dan, Will add it in next version,
Regards
Yi.
