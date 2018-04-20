Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeDTD1Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:27:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:38695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753964AbeDTD1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:27:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,299,1520924400";
   d="scan'208";a="33311949"
Date: Fri, 20 Apr 2018 11:28:07 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, alex.williamson@redhat.com,
        ddutile@redhat.com, alexander.h.duyck@intel.com,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, jianfeng.tan@intel.com, xiao.w.wang@intel.com,
        kevin.tian@intel.com
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Message-ID: <20180420032806.i3jy7xb7emgil6eu@debian>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
 <20180419212911-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419212911-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:40:23PM +0300, Michael S. Tsirkin wrote:
> On Tue, Apr 10, 2018 at 03:25:45PM +0800, Jason Wang wrote:
> > > > > One problem is that, different virtio ring compatible devices
> > > > > may have different device interfaces. That is to say, we will
> > > > > need different drivers in QEMU. It could be troublesome. And
> > > > > that's what this patch trying to fix. The idea behind this
> > > > > patch is very simple: mdev is a standard way to emulate device
> > > > > in kernel.
> > > > So you just move the abstraction layer from qemu to kernel, and you still
> > > > need different drivers in kernel for different device interfaces of
> > > > accelerators. This looks even more complex than leaving it in qemu. As you
> > > > said, another idea is to implement userspace vhost backend for accelerators
> > > > which seems easier and could co-work with other parts of qemu without
> > > > inventing new type of messages.
> > > I'm not quite sure. Do you think it's acceptable to
> > > add various vendor specific hardware drivers in QEMU?
> > > 
> > 
> > I don't object but we need to figure out the advantages of doing it in qemu
> > too.
> > 
> > Thanks
> 
> To be frank kernel is exactly where device drivers belong.  DPDK did
> move them to userspace but that's merely a requirement for data path.
> *If* you can have them in kernel that is best:
> - update kernel and there's no need to rebuild userspace
> - apps can be written in any language no need to maintain multiple
>   libraries or add wrappers
> - security concerns are much smaller (ok people are trying to
>   raise the bar with IOMMUs and such, but it's already pretty
>   good even without)
> 
> The biggest issue is that you let userspace poke at the
> device which is also allowed by the IOMMU to poke at
> kernel memory (needed for kernel driver to work).

I think the device won't and shouldn't be allowed to
poke at kernel memory. Its kernel driver needs some
kernel memory to work. But the device doesn't have
the access to them. Instead, the device only has the
access to:

(1) the entire memory of the VM (if vIOMMU isn't used)
or
(2) the memory belongs to the guest virtio device (if
    vIOMMU is being used).

Below is the reason:

For the first case, we should program the IOMMU for
the hardware device based on the info in the memory
table which is the entire memory of the VM.

For the second case, we should program the IOMMU for
the hardware device based on the info in the shadow
page table of the vIOMMU.

So the memory can be accessed by the device is limited,
it should be safe especially for the second case.

My concern is that, in this RFC, we don't program the
IOMMU for the mdev device in the userspace via the VFIO
API directly. Instead, we pass the memory table to the
kernel driver via the mdev device (BAR0) and ask the
driver to do the IOMMU programming. Someone may don't
like it. The main reason why we don't program IOMMU via
VFIO API in userspace directly is that, currently IOMMU
drivers don't support mdev bus.

> 
> Yes, maybe if device is not buggy it's all fine, but
> it's better if we do not have to trust the device
> otherwise the security picture becomes more murky.
> 
> I suggested attaching a PASID to (some) queues - see my old post "using
> PASIDs to enable a safe variant of direct ring access".

It's pretty cool. We also have some similar ideas.
Cunming will talk more about this.

Best regards,
Tiwei Bie

> 
> Then using IOMMU with VFIO to limit access through queue to corrent
> ranges of memory.
> 
> 
> -- 
> MST
