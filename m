Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755188AbeDTOMa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:12:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754902AbeDTOM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:12:29 -0400
Date: Fri, 20 Apr 2018 17:12:21 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, alex.williamson@redhat.com,
        ddutile@redhat.com, alexander.h.duyck@intel.com,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, jianfeng.tan@intel.com, xiao.w.wang@intel.com
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Message-ID: <20180420165302-mutt-send-email-mst@kernel.org>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
 <20180419212911-mutt-send-email-mst@kernel.org>
 <060e2b5f-2e93-c53f-387b-5baaa33e87cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060e2b5f-2e93-c53f-387b-5baaa33e87cd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 11:52:47AM +0800, Jason Wang wrote:
> > The biggest issue is that you let userspace poke at the
> > device which is also allowed by the IOMMU to poke at
> > kernel memory (needed for kernel driver to work).
> 
> I don't quite get. The userspace driver could be built on top of VFIO for
> sure. So kernel memory were perfectly isolated in this case.

VFIO does what it can but it mostly just has the IOMMU to play with.
So don't overestimate what it can do - it assumes a high level
of spec compliance for protections to work. For example,
ATS is enabled by default if device has it, and that
treats translated requests are trusted. FLS is assumed to reset
the device for when VFIO is unbound from the device. etc.


> > 
> > Yes, maybe if device is not buggy it's all fine, but
> > it's better if we do not have to trust the device
> > otherwise the security picture becomes more murky.
> > 
> > I suggested attaching a PASID to (some) queues - see my old post "using
> > PASIDs to enable a safe variant of direct ring access".
> > 
> > Then using IOMMU with VFIO to limit access through queue to corrent
> > ranges of memory.
> 
> Well userspace driver could benefit from this too. And we can even go
> further by using nested IO page tables to share IOVA address space between
> devices and a VM.
> 
> Thanks

Yes I suggested this separately.

-- 
MST
