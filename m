Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB96C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950112087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950112087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLDG7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:59:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:3228 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeLDG7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:59:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 22:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="126879544"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2018 22:59:31 -0800
Received: from tiger-server (dazhang1-ssd.sh.intel.com [10.239.48.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EE272580375;
        Mon,  3 Dec 2018 22:59:28 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:59:15 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     dan.j.williams@intel.com, pbonzini@redhat.com, brho@google.com,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de, rkrcmar@redhat.com,
        jglisse@redhat.com
Subject: Re: [PATCH RFC 0/3] Fix KVM misinterpreting Reserved page as an MMIO
 page
Message-ID: <20181204065914.GB73736@tiger-server>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        dan.j.williams@intel.com, pbonzini@redhat.com, brho@google.com,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de, rkrcmar@redhat.com,
        jglisse@redhat.com
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-03 at 11:25:20 -0800, Alexander Duyck wrote:
> I have loosely based this patch series off of the following patch series
> from Zhang Yi:
> https://lore.kernel.org/lkml/cover.1536342881.git.yi.z.zhang@linux.intel.com
> 
> The original set had attempted to address the fact that DAX pages were
> treated like MMIO pages which had resulted in reduced performance. It
> attempted to address this by ignoring the PageReserved flag if the page
> was either a DEV_DAX or FS_DAX page.
> 
> I am proposing this as an alternative to that set. The main reason for this
> is because I believe there are a few issues that were overlooked with that
> original set. Specifically KVM seems to have two different uses for the
> PageReserved flag. One being whether or not we can pin the memory, the other
> being if we should be marking the pages as dirty or accessed. I believe
> only the pinning really applies so I have split the uses of
> kvm_is_reserved_pfn and updated the function uses to determine support for
> page pinning to include a check of the pgmap to see if it supports pinning.
kvm is not the only one users of the dax page.

A similar user of PageReserved to look at is:
 drivers/vfio/vfio_iommu_type1.c:is_invalid_reserved_pfn(
vfio is also want to know the page is capable for pinning.

I throught that you have removed the reserved flag on the dax page

in https://patchwork.kernel.org/patch/10707267/

is something I missing here?

> 
> ---
> 
> Alexander Duyck (3):
>       kvm: Split use cases for kvm_is_reserved_pfn to kvm_is_refcounted_pfn
>       mm: Add support for exposing if dev_pagemap supports refcount pinning
>       kvm: Add additional check to determine if a page is refcounted
> 
> 
>  arch/x86/kvm/mmu.c        |    6 +++---
>  drivers/nvdimm/pfn_devs.c |    2 ++
>  include/linux/kvm_host.h  |    2 +-
>  include/linux/memremap.h  |    5 ++++-
>  include/linux/mm.h        |   11 +++++++++++
>  virt/kvm/kvm_main.c       |   34 +++++++++++++++++++++++++---------
>  6 files changed, 46 insertions(+), 14 deletions(-)
> 
> --
