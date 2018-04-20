Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755250AbeDTNwf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:52:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754836AbeDTNwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:52:32 -0400
Date: Fri, 20 Apr 2018 16:52:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liang, Cunming" <cunming.liang@intel.com>
Cc: "Bie, Tiwei" <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Daly, Dan" <dan.daly@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        "Tan, Jianfeng" <jianfeng.tan@intel.com>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Message-ID: <20180420165208-mutt-send-email-mst@kernel.org>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
 <20180419212911-mutt-send-email-mst@kernel.org>
 <20180420032806.i3jy7xb7emgil6eu@debian>
 <D0158A423229094DA7ABF71CF2FA0DA34E9511D5@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9511D5@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 03:50:41AM +0000, Liang, Cunming wrote:
> 
> 
> > -----Original Message-----
> > From: Bie, Tiwei
> > Sent: Friday, April 20, 2018 11:28 AM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>; alex.williamson@redhat.com;
> > ddutile@redhat.com; Duyck, Alexander H <alexander.h.duyck@intel.com>;
> > virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org;
> > kvm@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > netdev@vger.kernel.org; Daly, Dan <dan.daly@intel.com>; Liang, Cunming
> > <cunming.liang@intel.com>; Wang, Zhihong <zhihong.wang@intel.com>; Tan,
> > Jianfeng <jianfeng.tan@intel.com>; Wang, Xiao W <xiao.w.wang@intel.com>;
> > Tian, Kevin <kevin.tian@intel.com>
> > Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
> > 
> > On Thu, Apr 19, 2018 at 09:40:23PM +0300, Michael S. Tsirkin wrote:
> > > On Tue, Apr 10, 2018 at 03:25:45PM +0800, Jason Wang wrote:
> > > > > > > One problem is that, different virtio ring compatible devices
> > > > > > > may have different device interfaces. That is to say, we will
> > > > > > > need different drivers in QEMU. It could be troublesome. And
> > > > > > > that's what this patch trying to fix. The idea behind this
> > > > > > > patch is very simple: mdev is a standard way to emulate device
> > > > > > > in kernel.
> > > > > > So you just move the abstraction layer from qemu to kernel, and
> > > > > > you still need different drivers in kernel for different device
> > > > > > interfaces of accelerators. This looks even more complex than
> > > > > > leaving it in qemu. As you said, another idea is to implement
> > > > > > userspace vhost backend for accelerators which seems easier and
> > > > > > could co-work with other parts of qemu without inventing new type of
> > messages.
> > > > > I'm not quite sure. Do you think it's acceptable to add various
> > > > > vendor specific hardware drivers in QEMU?
> > > > >
> > > >
> > > > I don't object but we need to figure out the advantages of doing it
> > > > in qemu too.
> > > >
> > > > Thanks
> > >
> > > To be frank kernel is exactly where device drivers belong.  DPDK did
> > > move them to userspace but that's merely a requirement for data path.
> > > *If* you can have them in kernel that is best:
> > > - update kernel and there's no need to rebuild userspace
> > > - apps can be written in any language no need to maintain multiple
> > >   libraries or add wrappers
> > > - security concerns are much smaller (ok people are trying to
> > >   raise the bar with IOMMUs and such, but it's already pretty
> > >   good even without)
> > >
> > > The biggest issue is that you let userspace poke at the device which
> > > is also allowed by the IOMMU to poke at kernel memory (needed for
> > > kernel driver to work).
> > 
> > I think the device won't and shouldn't be allowed to poke at kernel memory. Its
> > kernel driver needs some kernel memory to work. But the device doesn't have
> > the access to them. Instead, the device only has the access to:
> > 
> > (1) the entire memory of the VM (if vIOMMU isn't used) or
> > (2) the memory belongs to the guest virtio device (if
> >     vIOMMU is being used).
> > 
> > Below is the reason:
> > 
> > For the first case, we should program the IOMMU for the hardware device based
> > on the info in the memory table which is the entire memory of the VM.
> > 
> > For the second case, we should program the IOMMU for the hardware device
> > based on the info in the shadow page table of the vIOMMU.
> > 
> > So the memory can be accessed by the device is limited, it should be safe
> > especially for the second case.
> > 
> > My concern is that, in this RFC, we don't program the IOMMU for the mdev
> > device in the userspace via the VFIO API directly. Instead, we pass the memory
> > table to the kernel driver via the mdev device (BAR0) and ask the driver to do the
> > IOMMU programming. Someone may don't like it. The main reason why we don't
> > program IOMMU via VFIO API in userspace directly is that, currently IOMMU
> > drivers don't support mdev bus.
> > 
> > >
> > > Yes, maybe if device is not buggy it's all fine, but it's better if we
> > > do not have to trust the device otherwise the security picture becomes
> > > more murky.
> > >
> > > I suggested attaching a PASID to (some) queues - see my old post
> > > "using PASIDs to enable a safe variant of direct ring access".
> > 
> Ideally we can have a device binding with normal driver in host, meanwhile support to allocate a few queues attaching with PASID on-demand. By vhost mdev transport channel, the data path ability of queues(as a device) can expose to qemu vhost adaptor as a vDPA instance. Then we can avoid VF number limitation, providing vhost data path acceleration in a small granularity.

Exactly my point.

> > It's pretty cool. We also have some similar ideas.
> > Cunming will talk more about this.
> > 
> > Best regards,
> > Tiwei Bie
> > 
> > >
> > > Then using IOMMU with VFIO to limit access through queue to corrent
> > > ranges of memory.
> > >
> > >
> > > --
> > > MST
