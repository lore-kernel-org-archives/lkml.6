Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE5920661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE5920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLCUVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:21:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:19340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCUVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:21:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 12:21:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="115613450"
Received: from ahduyck-desk1.amr.corp.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 03 Dec 2018 12:21:42 -0800
Message-ID: <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
Subject: Re: [PATCH RFC 2/3] mm: Add support for exposing if dev_pagemap
 supports refcount pinning
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Barret Rhoden <brho@google.com>,
        KVM list <kvm@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, rkrcmar@redhat.com,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>
Date:   Mon, 03 Dec 2018 12:21:42 -0800
In-Reply-To: <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
         <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
         <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 11:47 -0800, Dan Williams wrote:
> On Mon, Dec 3, 2018 at 11:25 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > Add a means of exposing if a pagemap supports refcount pinning. I am doing
> > this to expose if a given pagemap has backing struct pages that will allow
> > for the reference count of the page to be incremented to lock the page
> > into place.
> > 
> > The KVM code already has several spots where it was trying to use a
> > pfn_valid check combined with a PageReserved check to determien if it could
> > take a reference on the page. I am adding this check so in the case of the
> > page having the reserved flag checked we can check the pagemap for the page
> > to determine if we might fall into the special DAX case.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  drivers/nvdimm/pfn_devs.c |    2 ++
> >  include/linux/memremap.h  |    5 ++++-
> >  include/linux/mm.h        |   11 +++++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> > index 6f22272e8d80..7a4a85bcf7f4 100644
> > --- a/drivers/nvdimm/pfn_devs.c
> > +++ b/drivers/nvdimm/pfn_devs.c
> > @@ -640,6 +640,8 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
> >         } else
> >                 return -ENXIO;
> > 
> > +       pgmap->support_refcount_pinning = true;
> > +
> 
> There should be no dev_pagemap instance instance where this isn't
> true, so I'm missing why this is needed?

I thought in the case of HMM there were instances where you couldn't
pin the page, isn't there? Specifically I am thinking of the definition
of MEMORY_DEVICE_PUBLIC:
  Device memory that is cache coherent from device and CPU point of 
  view. This is use on platform that have an advance system bus (like 
  CAPI or CCIX). A driver can hotplug the device memory using 
  ZONE_DEVICE and with that memory type. Any page of a process can be 
  migrated to such memory. However no one should be allow to pin such 
  memory so that it can always be evicted.

It sounds like MEMORY_DEVICE_PUBLIC and MMIO would want to fall into
the same category here in order to allow a hot-plug event to remove the
device and take the memory with it, or is my understanding on this not
correct?

Thanks.

- Alex



