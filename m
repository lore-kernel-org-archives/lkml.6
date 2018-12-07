Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACB3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A2B20673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A2B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeLGPc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:32:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGPcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:32:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 567B831256D7;
        Fri,  7 Dec 2018 15:32:54 +0000 (UTC)
Received: from redhat.com (ovpn-125-106.rdu2.redhat.com [10.10.125.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4295D98E;
        Fri,  7 Dec 2018 15:32:51 +0000 (UTC)
Date:   Fri, 7 Dec 2018 10:32:49 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end callback
Message-ID: <20181207153249.GA3293@redhat.com>
References: <20181205053628.3210-1-jglisse@redhat.com>
 <20181205053628.3210-2-jglisse@redhat.com>
 <20181207033027.GA20236@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207033027.GA20236@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 07 Dec 2018 15:32:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 08:30:27PM -0700, Jason Gunthorpe wrote:
> On Wed, Dec 05, 2018 at 12:36:26AM -0500, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > To avoid having to change many callback definition everytime we want
> > to add a parameter use a structure to group all parameters for the
> > mmu_notifier invalidate_range_start/end callback. No functional changes
> > with this patch.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Matthew Wilcox <mawilcox@microsoft.com>
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Felix Kuehling <felix.kuehling@amd.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: kvm@vger.kernel.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 43 +++++++++++--------------
> >  drivers/gpu/drm/i915/i915_gem_userptr.c | 14 ++++----
> >  drivers/gpu/drm/radeon/radeon_mn.c      | 16 ++++-----
> >  drivers/infiniband/core/umem_odp.c      | 20 +++++-------
> >  drivers/infiniband/hw/hfi1/mmu_rb.c     | 13 +++-----
> >  drivers/misc/mic/scif/scif_dma.c        | 11 ++-----
> >  drivers/misc/sgi-gru/grutlbpurge.c      | 14 ++++----
> >  drivers/xen/gntdev.c                    | 12 +++----
> >  include/linux/mmu_notifier.h            | 14 +++++---
> >  mm/hmm.c                                | 23 ++++++-------
> >  mm/mmu_notifier.c                       | 21 ++++++++++--
> >  virt/kvm/kvm_main.c                     | 14 +++-----
> >  12 files changed, 102 insertions(+), 113 deletions(-)
> 
> The changes to drivers/infiniband look mechanical and fine to me.
> 
> It even looks like this avoids merge conflicts with the other changes
> to these files :)
> 
> For infiniband:
> 
> Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> I assume this will go through the mm tree?

Yes this is my exceptation as in the ends it touch more mm
stuff than anything else. Andrew already added v1 to its
patchset.

Cheers,
Jérôme
