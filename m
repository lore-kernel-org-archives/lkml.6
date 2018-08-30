Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A00C2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A00C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeH3Ops (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:45:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:41906 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbeH3Ops (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:45:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 03:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="84639912"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2018 03:44:16 -0700
Received: from tiger-server (dazhang1-ssd.sh.intel.com [10.239.48.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3A091580224;
        Thu, 30 Aug 2018 03:44:14 -0700 (PDT)
Date:   Fri, 31 Aug 2018 03:23:13 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        yu c zhang <yu.c.zhang@intel.com>, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi z zhang <yi.z.zhang@intel.com>
Subject: Re: [PATCH V4 4/4] kvm: add a check if pfn is from NVDIMM pmem.
Message-ID: <20180830192312.GA84758@tiger-server>
Mail-Followup-To: Pankaj Gupta <pagupta@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        yu c zhang <yu.c.zhang@intel.com>, david@redhat.com, jack@suse.cz,
        hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi z zhang <yi.z.zhang@intel.com>
References: <cover.1534934405.git.yi.z.zhang@linux.intel.com>
 <a4183c0f0adfb6d123599dd306062fd193e83f5a.1534934405.git.yi.z.zhang@linux.intel.com>
 <380594559.7598107.1535537748154.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <380594559.7598107.1535537748154.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-29 at 06:15:48 -0400, Pankaj Gupta wrote:
> 
> > 
> > For device specific memory space, when we move these area of pfn to
> > memory zone, we will set the page reserved flag at that time, some of
> > these reserved for device mmio, and some of these are not, such as
> > NVDIMM pmem.
> > 
> > Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> > backend, since these pages are reserved, the check of
> > kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> > introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> > to identify these pages are from NVDIMM pmem and let kvm treat these
> > as normal pages.
> > 
> > Without this patch, many operations will be missed due to this
> > mistreatment to pmem pages, for example, a page may not have chance to
> > be unpinned for KVM guest(in kvm_release_pfn_clean), not able to be
> > marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
> > 
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > ---
> >  virt/kvm/kvm_main.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index c44c406..969b6ca 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -147,8 +147,12 @@ __weak void
> > kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> >  
> >  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
> >  {
> > -	if (pfn_valid(pfn))
> > -		return PageReserved(pfn_to_page(pfn));
> > +	struct page *page;
> > +
> > +	if (pfn_valid(pfn)) {
> > +		page = pfn_to_page(pfn);
> > +		return PageReserved(page) && !is_dax_page(page);
> > +	}
> >  
> >  	return true;
> >  }
> 
> Acked-by: Pankaj Gupta <pagupta@redhat.com>

Thanks for your kindly review, Pankaj, as all the patch [1,2,3,4]/4 got
the reviewed[acked]-by, can we Queue this by now?

> 
> > --
> > 2.7.4
> > 
> > 
