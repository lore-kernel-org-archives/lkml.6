Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C55ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4A62150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4A62150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbeIUT6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:58:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:40753 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbeIUT6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:58:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 07:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,285,1534834800"; 
   d="scan'208";a="92107733"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 21 Sep 2018 07:08:27 -0700
Received: from tiger-server (dazhang1-ssd.sh.intel.com [10.239.48.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 05CFF5805BB;
        Fri, 21 Sep 2018 07:08:24 -0700 (PDT)
Date:   Sat, 22 Sep 2018 06:47:39 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH V5 4/4] kvm: add a check if pfn is from NVDIMM pmem.
Message-ID: <20180921224739.GA33892@tiger-server>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
 <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
 <CAPcyv4ifg2BZMTNfu6mg0xxtPWs3BVgkfEj51v1CQ6jp2S70fw@mail.gmail.com>
 <fefbd66e-623d-b6a5-7202-5309dd4f5b32@redhat.com>
 <20180920224953.GA53363@tiger-server>
 <CAPcyv4g6OS=_uSjJenn5WVmpx7zCRCbzJaBr_m0Bq=qyEyVagg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4g6OS=_uSjJenn5WVmpx7zCRCbzJaBr_m0Bq=qyEyVagg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-20 at 14:19:17 -0700, Dan Williams wrote:
> On Thu, Sep 20, 2018 at 7:11 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
> >
> > On 2018-09-19 at 09:20:25 +0200, David Hildenbrand wrote:
> > > Am 19.09.18 um 04:53 schrieb Dan Williams:
> > > >
> > > > Should we consider just not setting PageReserved for
> > > > devm_memremap_pages()? Perhaps kvm is not be the only component making
> > > > these assumptions about this flag?
> > >
> > > I was asking the exact same question in v3 or so.
> > >
> > > I was recently going through all PageReserved users, trying to clean up
> > > and document how it is used.
> > >
> > > PG_reserved used to be a marker "not available for the page allocator".
> > > This is only partially true and not really helpful I think. My current
> > > understanding:
> > >
> > > "
> > > PG_reserved is set for special pages, struct pages of such pages should
> > > in general not be touched except by their owner. Pages marked as
> > > reserved include:
> > > - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
> > > - Pages allocated early during boot (bootmem, memblock)
> > > - Zero pages
> > > - Pages that have been associated with a zone but were not onlined
> > >   (e.g. NVDIMM/pmem, online_page_callback used by XEN)
> > > - Pages to exclude from the hibernation image (e.g. loaded kexec images)
> > > - MCA (memory error) pages on ia64
> > > - Offline pages
> > > Some architectures don't allow to ioremap RAM pages that are not marked
> > > as reserved. Allocated pages might have to be set reserved to allow for
> > > that - if there is a good reason to enforce this. Consequently,
> > > PG_reserved part of a user space table might be the indicator for the
> > > zero page, pmem or MMIO pages.
> > > "
> > >
> > > Swapping code does not care about PageReserved at all as far as I
> > > remember. This seems to be fine as it only looks at the way pages have
> > > been mapped into user space.
> > >
> > > I don't really see a good reason to set pmem pages as reserved. One
> > > question would be, how/if to exclude them from the hibernation image.
> > > But that could also be solved differently (we would have to double check
> > > how they are handled in hibernation code).
> > >
> > >
> > > A similar user of PageReserved to look at is:
> > >
> > > drivers/vfio/vfio_iommu_type1.c:is_invalid_reserved_pfn()
> > >
> > > It will not mark pages dirty if they are reserved. Similar to KVM code.
> > Yes, kvm is not the only one user of the dax reserved page.
> > >
> > > >
> > > > Why is MEMORY_DEVICE_PUBLIC memory specifically excluded?
> > > >
> > > > This has less to do with "dax" pages and more to do with
> > > > devm_memremap_pages() established ranges. P2PDMA is another producer
> > > > of these pages. If either MEMORY_DEVICE_PUBLIC or P2PDMA pages can be
> > > > used in these kvm paths then I think this points to consider clearing
> > > > the Reserved flag.
> >
> > Thanks Dan/David's comments.
> > for MEMORY_DEVICE_PUBLIC memory, since host driver could manager the
> > memory resource to share to guest, Jerome says we could ignore it at
> > this time.
> >
> > And p2pmem, it seems mapped in a PCI bar space which should most likely
> > a mmio. I think kvm should treated as a reserved page.
> 
> Ok, but the question you left unanswered is whether it would be better
> for devm_memremap_pages() to clear the PageReserved flag for
> MEMORY_DEVICE_{FS,DEV}_DAX rather than introduce a local kvm-only hack
> for what looks like a global problem.

Remove the PageReserved flag sounds more reasonable. 
And Could we still have a flag to identify it is a device private memory, or
where these pages coming from?
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
