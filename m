Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE57C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A99214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A99214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbeISHvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:51:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:19236 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeISHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:51:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 19:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,392,1531810800"; 
   d="scan'208";a="71111037"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2018 19:15:55 -0700
Received: from tiger-server (unknown [10.239.48.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1A4DF580115;
        Tue, 18 Sep 2018 19:15:52 -0700 (PDT)
Date:   Wed, 19 Sep 2018 18:55:05 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, jglisse@redhat.com,
        yi.z.zhang@intel.com
Subject: Re: [PATCH V5 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
Message-ID: <20180919105505.GA43643@tiger-server>
Mail-Followup-To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi.z.zhang@intel.com
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?

Hi Pankaj and Paolo,

Can we Queue this to merge list since there no other comments last 2
weeks?

Regards
Yi.

On 2018-09-08 at 02:03:02 +0800, Zhang Yi wrote:
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
> https://lkml.org/lkml/2018/7/10/135
> 
> V3:
> https://lkml.org/lkml/2018/8/9/17
> 
> V4:
> https://lkml.org/lkml/2018/8/22/17
> 
> V5:
> [PATCH V3 1/4] Reviewed-by: David / Acked-by: Pankaj
> [PATCH V3 2/4] Reviewed-by: Jan
> [PATCH V3 3/4] Acked-by: Jan
> [PATCH V3 4/4] Added "Acked-by: Pankaj", Added in-line comments: Dave
> 
> Zhang Yi (4):
>   kvm: remove redundant reserved page check
>   mm: introduce memory type MEMORY_DEVICE_DEV_DAX
>   mm: add a function to differentiate the pages is from DAX device
>     memory
>   kvm: add a check if pfn is from NVDIMM pmem.
> 
>  drivers/dax/pmem.c       |  1 +
>  include/linux/memremap.h |  8 ++++++++
>  include/linux/mm.h       | 12 ++++++++++++
>  virt/kvm/kvm_main.c      | 24 ++++++++++++++++--------
>  4 files changed, 37 insertions(+), 8 deletions(-)
> 
> -- 
> 2.7.4
> 
