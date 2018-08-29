Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B58EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C115A2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C115A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeH2OMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeH2OMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:12:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D7B73082A41;
        Wed, 29 Aug 2018 10:15:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD2FD5DEF9;
        Wed, 29 Aug 2018 10:15:49 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 44A3F1808855;
        Wed, 29 Aug 2018 10:15:49 +0000 (UTC)
Date:   Wed, 29 Aug 2018 06:15:48 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        yu c zhang <yu.c.zhang@intel.com>, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi z zhang <yi.z.zhang@intel.com>
Message-ID: <380594559.7598107.1535537748154.JavaMail.zimbra@redhat.com>
In-Reply-To: <a4183c0f0adfb6d123599dd306062fd193e83f5a.1534934405.git.yi.z.zhang@linux.intel.com>
References: <cover.1534934405.git.yi.z.zhang@linux.intel.com> <a4183c0f0adfb6d123599dd306062fd193e83f5a.1534934405.git.yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH V4 4/4] kvm: add a check if pfn is from NVDIMM pmem.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.193.73, 10.4.195.27]
Thread-Topic: add a check if pfn is from NVDIMM pmem.
Thread-Index: JCvcOeCBF3io5zdQkGycpA4mvM3AIA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 29 Aug 2018 10:15:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> For device specific memory space, when we move these area of pfn to
> memory zone, we will set the page reserved flag at that time, some of
> these reserved for device mmio, and some of these are not, such as
> NVDIMM pmem.
> 
> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> backend, since these pages are reserved, the check of
> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> to identify these pages are from NVDIMM pmem and let kvm treat these
> as normal pages.
> 
> Without this patch, many operations will be missed due to this
> mistreatment to pmem pages, for example, a page may not have chance to
> be unpinned for KVM guest(in kvm_release_pfn_clean), not able to be
> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  virt/kvm/kvm_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c44c406..969b6ca 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -147,8 +147,12 @@ __weak void
> kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>  
>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>  {
> -	if (pfn_valid(pfn))
> -		return PageReserved(pfn_to_page(pfn));
> +	struct page *page;
> +
> +	if (pfn_valid(pfn)) {
> +		page = pfn_to_page(pfn);
> +		return PageReserved(page) && !is_dax_page(page);
> +	}
>  
>  	return true;
>  }

Acked-by: Pankaj Gupta <pagupta@redhat.com>

> --
> 2.7.4
> 
> 
