Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeDSSk1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:40:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752908AbeDSSkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:40:25 -0400
Date: Thu, 19 Apr 2018 21:40:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, alex.williamson@redhat.com,
        ddutile@redhat.com, alexander.h.duyck@intel.com,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, jianfeng.tan@intel.com, xiao.w.wang@intel.com
Subject: Re: [RFC] vhost: introduce mdev based hardware vhost backend
Message-ID: <20180419212911-mutt-send-email-mst@kernel.org>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
 <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
 <20180410045723.rftsb7l4l3ip2ioi@debian>
 <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a63fff-7599-640a-361f-a27e5783012a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 03:25:45PM +0800, Jason Wang wrote:
> > > > One problem is that, different virtio ring compatible devices
> > > > may have different device interfaces. That is to say, we will
> > > > need different drivers in QEMU. It could be troublesome. And
> > > > that's what this patch trying to fix. The idea behind this
> > > > patch is very simple: mdev is a standard way to emulate device
> > > > in kernel.
> > > So you just move the abstraction layer from qemu to kernel, and you still
> > > need different drivers in kernel for different device interfaces of
> > > accelerators. This looks even more complex than leaving it in qemu. As you
> > > said, another idea is to implement userspace vhost backend for accelerators
> > > which seems easier and could co-work with other parts of qemu without
> > > inventing new type of messages.
> > I'm not quite sure. Do you think it's acceptable to
> > add various vendor specific hardware drivers in QEMU?
> > 
> 
> I don't object but we need to figure out the advantages of doing it in qemu
> too.
> 
> Thanks

To be frank kernel is exactly where device drivers belong.  DPDK did
move them to userspace but that's merely a requirement for data path.
*If* you can have them in kernel that is best:
- update kernel and there's no need to rebuild userspace
- apps can be written in any language no need to maintain multiple
  libraries or add wrappers
- security concerns are much smaller (ok people are trying to
  raise the bar with IOMMUs and such, but it's already pretty
  good even without)

The biggest issue is that you let userspace poke at the
device which is also allowed by the IOMMU to poke at
kernel memory (needed for kernel driver to work).

Yes, maybe if device is not buggy it's all fine, but
it's better if we do not have to trust the device
otherwise the security picture becomes more murky.

I suggested attaching a PASID to (some) queues - see my old post "using
PASIDs to enable a safe variant of direct ring access".

Then using IOMMU with VFIO to limit access through queue to corrent
ranges of memory.


-- 
MST
