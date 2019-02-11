Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34DEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDADD2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfBKSaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:30:14 -0500
Received: from mga09.intel.com ([134.134.136.24]:58990 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbfBKSaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:30:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:30:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="137749085"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 11 Feb 2019 10:30:10 -0800
Message-ID: <58e57acd628f2d6535fc45a028af50855158fda6.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] kvm: Add host side support for free memory hints
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, pbonzini@redhat.com, tglx@linutronix.de,
        akpm@linux-foundation.org
Date:   Mon, 11 Feb 2019 10:30:10 -0800
In-Reply-To: <20190211124203-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181546.12095.81356.stgit@localhost.localdomain>
         <20190209194108-mutt-send-email-mst@kernel.org>
         <39c915a7-e317-db01-0286-579230f37da2@intel.com>
         <20190211124203-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 12:48 -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 11, 2019 at 09:41:19AM -0800, Dave Hansen wrote:
> > On 2/9/19 4:44 PM, Michael S. Tsirkin wrote:
> > > So the policy should not leak into host/guest interface.
> > > Instead it is better to just keep the pages pinned and
> > > ignore the hint for now.
> > 
> > It does seems a bit silly to have guests forever hinting about freed
> > memory when the host never has a hope of doing anything about it.
> > 
> > Is that part fixable?
> 
> 
> Yes just not with existing IOMMU APIs.
> 
> It's in the paragraph just above that you cut out:
> 	Yes right now assignment is not smart enough but generally
> 	you can protect the unused page in the IOMMU and that's it,
> 	it's safe.
> 
> So e.g.
> 	extern int iommu_remap(struct iommu_domain *domain, unsigned long iova,
> 				     phys_addr_t paddr, size_t size, int prot);
> 
> 
> I can elaborate if you like but generally we would need an API that
> allows you to atomically update a mapping for a specific page without
> perturbing the mapping for other pages.
> 

I still don't see how this would solve anything unless you have the
guest somehow hinting on what pages it is providing to the devices. 
You would have to have the host invalidating the pages when the hint is
provided, and have a new hint tied to arch_alloc_page that would
rebuild the IOMMU mapping when a page is allocated.

I'm pretty certain that the added cost of that would make the hinting
pretty pointless as my experience has been that the IOMMU is too much
of a bottleneck to have multiple CPUs trying to create and invalidate
mappings simultaneously.

