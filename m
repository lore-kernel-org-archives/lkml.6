Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D3ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14232086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14232086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeISISp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeISISp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:18:45 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 367B3C057F20;
        Wed, 19 Sep 2018 02:43:07 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E466930912F5;
        Wed, 19 Sep 2018 02:43:06 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A03C41800533;
        Wed, 19 Sep 2018 02:43:06 +0000 (UTC)
Date:   Tue, 18 Sep 2018 22:43:06 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Yi Zhang <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan j williams <dan.j.williams@intel.com>,
        dave jiang <dave.jiang@intel.com>,
        yu c zhang <yu.c.zhang@intel.com>, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi z zhang <yi.z.zhang@intel.com>
Message-ID: <900140442.13987264.1537324986294.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180919105505.GA43643@tiger-server>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com> <20180919105505.GA43643@tiger-server>
Subject: Re: [PATCH V5 0/4] Fix kvm misconceives NVDIMM pages as reserved
 mmio
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.79, 10.4.195.12]
Thread-Topic: Fix kvm misconceives NVDIMM pages as reserved mmio
Thread-Index: L+bzYhSJCn6RWTCWCgPkeGZY3VJMlA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 19 Sep 2018 02:43:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Yi,

> Any comments?
> 
> Hi Pankaj and Paolo,

I am just helping with the review. Paolo & Dan probably will decide.

Thanks,
Pankaj

> 
> Can we Queue this to merge list since there no other comments last 2
> weeks?
> 
> Regards
> Yi.
> 
> On 2018-09-08 at 02:03:02 +0800, Zhang Yi wrote:
> > For device specific memory space, when we move these area of pfn to
> > memory zone, we will set the page reserved flag at that time, some of
> > these reserved for device mmio, and some of these are not, such as
> > NVDIMM pmem.
> > 
> > Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> > backend, since these pages are reserved. the check of
> > kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> > introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> > to indentify these pages are from NVDIMM pmem. and let kvm treat these
> > as normal pages.
> > 
> > Without this patch, Many operations will be missed due to this
> > mistreatment to pmem pages. For example, a page may not have chance to
> > be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
> > marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
> > 
> > V1:
> > https://lkml.org/lkml/2018/7/4/91
> > 
> > V2:
> > https://lkml.org/lkml/2018/7/10/135
> > 
> > V3:
> > https://lkml.org/lkml/2018/8/9/17
> > 
> > V4:
> > https://lkml.org/lkml/2018/8/22/17
> > 
> > V5:
> > [PATCH V3 1/4] Reviewed-by: David / Acked-by: Pankaj
> > [PATCH V3 2/4] Reviewed-by: Jan
> > [PATCH V3 3/4] Acked-by: Jan
> > [PATCH V3 4/4] Added "Acked-by: Pankaj", Added in-line comments: Dave
> > 
> > Zhang Yi (4):
> >   kvm: remove redundant reserved page check
> >   mm: introduce memory type MEMORY_DEVICE_DEV_DAX
> >   mm: add a function to differentiate the pages is from DAX device
> >     memory
> >   kvm: add a check if pfn is from NVDIMM pmem.
> > 
> >  drivers/dax/pmem.c       |  1 +
> >  include/linux/memremap.h |  8 ++++++++
> >  include/linux/mm.h       | 12 ++++++++++++
> >  virt/kvm/kvm_main.c      | 24 ++++++++++++++++--------
> >  4 files changed, 37 insertions(+), 8 deletions(-)
> > 
> > --
> > 2.7.4
> > 
> 
