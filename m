Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE949ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6462720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6462720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeGTHMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:12:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:37619 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeGTHMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:12:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 23:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,377,1526367600"; 
   d="scan'208";a="76342471"
Received: from dazhang1-z97x.sh.intel.com (HELO [10.239.13.115]) ([10.239.13.115])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2018 23:25:33 -0700
Subject: Re: [PATCH V2 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com, dave.jiang@intel.com
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, yi.z.zhang@intel.com
References: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
From:   "Zhang,Yi" <yi.z.zhang@linux.intel.com>
Message-ID: <c4e1c527-a372-bd6a-a101-5a8e9026e7c1@linux.intel.com>
Date:   Fri, 20 Jul 2018 22:11:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added Jiang,Dave,

Ping for further review, comments.

Thanks All

Regards
Yi.


On 2018年07月11日 01:01, Zhang Yi wrote:
> For device specific memory space, when we move these area of pfn to
> memory zone, we will set the page reserved flag at that time, some of
> these reserved for device mmio, and some of these are not, such as
> NVDIMM pmem.
>
> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> backend, since these pages are reserved. the check of
> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> to indentify these pages are from NVDIMM pmem. and let kvm treat these
> as normal pages.
>
> Without this patch, Many operations will be missed due to this
> mistreatment to pmem pages. For example, a page may not have chance to
> be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
>
> V1:
> https://lkml.org/lkml/2018/7/4/91
>
> V2:
> *Add documentation for MEMORY_DEVICE_DEV_DAX memory type in comment block
> *Add is_dax_page() in mm.h to differentiate the pages is from DAX device.
> *Remove the function kvm_is_nd_pfn().
>
> Zhang Yi (4):
>   kvm: remove redundant reserved page check
>   mm: introduce memory type MEMORY_DEVICE_DEV_DAX
>   mm: add a function to differentiate the pages is from DAX device
>     memory
>   kvm: add a check if pfn is from NVDIMM pmem.
>
>  drivers/dax/pmem.c       |  1 +
>  include/linux/memremap.h |  9 +++++++++
>  include/linux/mm.h       | 12 ++++++++++++
>  virt/kvm/kvm_main.c      | 16 ++++++++--------
>  4 files changed, 30 insertions(+), 8 deletions(-)
>

