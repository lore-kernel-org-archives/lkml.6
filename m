Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AD321767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AD321767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeHIL0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:26:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeHIL0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B438AEB2;
        Thu,  9 Aug 2018 09:02:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 746771E3C98; Thu,  9 Aug 2018 11:02:08 +0200 (CEST)
Date:   Thu, 9 Aug 2018 11:02:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com, linux-mm@kvack.org, rkrcmar@redhat.com,
        yi.z.zhang@intel.com
Subject: Re: [PATCH V3 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
Message-ID: <20180809090208.GD5069@quack2.suse.cz>
References: <cover.1533811181.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533811181.git.yi.z.zhang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-08-18 18:52:48, Zhang Yi wrote:
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
> [PATCH V3 1/4] Needs Comments.
> [PATCH V3 2/4] Update the description of MEMORY_DEVICE_DEV_DAX: Jan
> [PATCH V3 3/4] Acked-by: Jan in V2

Hum, but it is not the the patch...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
