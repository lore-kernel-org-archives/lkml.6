Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EC420645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EC420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeIDUlA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeIDUlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DE7C3086250;
        Tue,  4 Sep 2018 16:15:11 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7BD82016234;
        Tue,  4 Sep 2018 16:15:09 +0000 (UTC)
Date:   Tue, 4 Sep 2018 10:15:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, linuxarm@huawei.com
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180904101509.62314b67@t450s.home>
In-Reply-To: <20180904150019.GA4024@redhat.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
        <20180904150019.GA4024@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 04 Sep 2018 16:15:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 11:00:19 -0400
Jerome Glisse <jglisse@redhat.com> wrote:

> On Mon, Sep 03, 2018 at 08:51:57AM +0800, Kenneth Lee wrote:
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > WarpDrive is an accelerator framework to expose the hardware capabilities
> > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > facilities. So the user application can send request and DMA to the
> > hardware without interaction with the kernel. This removes the latency
> > of syscall.
> > 
> > WarpDrive is the name for the whole framework. The component in kernel
> > is called SDMDEV, Share Domain Mediated Device. Driver driver exposes its
> > hardware resource by registering to SDMDEV as a VFIO-Mdev. So the user
> > library of WarpDrive can access it via VFIO interface.
> > 
> > The patchset contains document for the detail. Please refer to it for more
> > information.
> > 
> > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > patch [1], which enables not only IO side page fault, but also PASID
> > support to IOMMU and VFIO.
> > 
> > With these features, WarpDrive can support non-pinned memory and
> > multi-process in the same accelerator device.  We tested it in our SoC
> > integrated Accelerator (board ID: D06, Chip ID: HIP08). A reference work
> > tree can be found here: [2].
> > 
> > But it is not mandatory. This patchset is tested in the latest mainline
> > kernel without the SVA patches.  So it supports only one process for each
> > accelerator.
> > 
> > We have noticed the IOMMU aware mdev RFC announced recently [3].
> > 
> > The IOMMU aware mdev has similar idea but different intention comparing to
> > WarpDrive. It intends to dedicate part of the hardware resource to a VM.
> > And the design is supposed to be used with Scalable I/O Virtualization.
> > While sdmdev is intended to share the hardware resource with a big amount
> > of processes.  It just requires the hardware supporting address
> > translation per process (PCIE's PASID or ARM SMMU's substream ID).
> > 
> > But we don't see serious confliction on both design. We believe they can be
> > normalized as one.
> >   
> 
> So once again i do not understand why you are trying to do things
> this way. Kernel already have tons of example of everything you
> want to do without a new framework. Moreover i believe you are
> confuse by VFIO. To me VFIO is for VM not to create general device
> driver frame work.

VFIO is a userspace driver framework, the VM use case just happens to
be a rather prolific one.  VFIO was never intended to be solely a VM
device interface and has several other userspace users, notably DPDK
and SPDK, an NVMe backend in QEMU, a userspace NVMe driver, a ruby
wrapper, and perhaps others that I'm not aware of.  Whether vfio is
appropriate interface here might certainly still be a debatable topic,
but I would strongly disagree with your last sentence above.  Thanks,

Alex

> So here is your use case as i understand it. You have a device
> with a limited number of command queues (can be just one) and in
> some case it can support SVA/SVM (when hardware support it and it
> is not disabled). Final requirement is being able to schedule cmds
> from userspace without ioctl. All of this exists already exists
> upstream in few device drivers.
> 
> 
> So here is how every body else is doing it. Please explain why
> this does not work.
> 
> 1 Userspace open device file driver. Kernel device driver create
>   a context and associate it with on open. This context can be
>   uniq to the process and can bind hardware resources (like a
>   command queue) to the process.
> 2 Userspace bind/acquire a commands queue and initialize it with
>   an ioctl on the device file. Through that ioctl userspace can
>   be inform wether either SVA/SVM works for the device. If SVA/
>   SVM works then kernel device driver bind the process to the
>   device as part of this ioctl.
> 3 If SVM/SVA does not work userspace do an ioctl to create dma
>   buffer or something that does exactly the same thing.
> 4 Userspace mmap the command queue (mmap of the device file by
>   using informations gather at step 2)
> 5 Userspace can write commands into the queue it mapped
> 6 When userspace close the device file all resources are release
>   just like any existing device drivers.
> 
> Now if you want to create a device driver framework that expose
> a device file with generic API for all of the above steps fine.
> But it does not need to be part of VFIO whatsoever or explain
> why.
> 
> 
> Note that if IOMMU is fully disabled you probably want to block
> userspace from being able to directly scheduling commands onto
> the hardware as it would allow userspace to DMA anywhere and thus
> would open the kernel to easy exploits. In this case you can still
> keeps the same API as above and use page fault tricks to valid
> commands written by userspace into fake commands ring. This will
> be as slow or maybe even slower than ioctl but at least it allows
> you to validate commands.
> 
> Cheers,
> Jérôme

