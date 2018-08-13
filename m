Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27264C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5AE214FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5AE214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeHMMbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:31:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:61210 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbeHMMbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:31:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 02:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,232,1531810800"; 
   d="scan'208";a="253629557"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.128]) ([10.239.13.128])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2018 02:49:53 -0700
Subject: Re: [PATCH V3 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
To:     Jan Kara <jack@suse.cz>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, hch@lst.de, yu.c.zhang@intel.com,
        linux-mm@kvack.org, rkrcmar@redhat.com, yi.z.zhang@intel.com
References: <cover.1533811181.git.yi.z.zhang@linux.intel.com>
 <20180809090208.GD5069@quack2.suse.cz>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <154a783f-5aff-c910-b252-5a6a36b37907@linux.intel.com>
Date:   Tue, 14 Aug 2018 01:33:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180809090208.GD5069@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月09日 17:02, Jan Kara wrote:
> On Thu 09-08-18 18:52:48, Zhang Yi wrote:
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
>> V1:
>> https://lkml.org/lkml/2018/7/4/91
>>
>> V2:
>> https://lkml.org/lkml/2018/7/10/135
>>
>> V3:
>> [PATCH V3 1/4] Needs Comments.
>> [PATCH V3 2/4] Update the description of MEMORY_DEVICE_DEV_DAX: Jan
>> [PATCH V3 3/4] Acked-by: Jan in V2
> Hum, but it is not the the patch...
>
> 								Honza
Sorry, I missed that, will add in the next version, thanks for your review

