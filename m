Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15072229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439922AbfBNUO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:14:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391479AbfBNUO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:14:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8FD2C07412D;
        Thu, 14 Feb 2019 20:14:57 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F96717D38;
        Thu, 14 Feb 2019 20:14:56 +0000 (UTC)
Date:   Thu, 14 Feb 2019 13:14:56 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
Message-ID: <20190214131456.3db38cdb@w520.home>
In-Reply-To: <20190213040301.23021-1-baolu.lu@linux.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Feb 2019 20:14:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 12:02:52 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> The Mediate Device is a framework for fine-grained physical device
> sharing across the isolated domains. Currently the mdev framework
> is designed to be independent of the platform IOMMU support. As the
> result, the DMA isolation relies on the mdev parent device in a
> vendor specific way.
> 
> There are several cases where a mediated device could be protected
> and isolated by the platform IOMMU. For example, Intel vt-d rev3.0
> [1] introduces a new translation mode called 'scalable mode', which
> enables PASID-granular translations. The vt-d scalable mode is the
> key ingredient for Scalable I/O Virtualization [2] [3] which allows
> sharing a device in minimal possible granularity (ADI - Assignable
> Device Interface).
> 
> A mediated device backed by an ADI could be protected and isolated
> by the IOMMU since 1) the parent device supports tagging an unique
> PASID to all DMA traffic out of the mediated device; and 2) the DMA
> translation unit (IOMMU) supports the PASID granular translation.
> We can apply IOMMU protection and isolation to this kind of devices
> just as what we are doing with an assignable PCI device.
> 
> In order to distinguish the IOMMU-capable mediated devices from those
> which still need to rely on parent devices, this patch set adds one
> new member in struct mdev_device.
> 
> * iommu_device
>   - This, if set, indicates that the mediated device could
>     be fully isolated and protected by IOMMU via attaching
>     an iommu domain to this device. If empty, it indicates
>     using vendor defined isolation.
> 
> Below helpers are added to set and get above iommu device in mdev core
> implementation.
> 
> * mdev_set/get_iommu_device(dev, iommu_device)
>   - Set or get the iommu device which represents this mdev
>     in IOMMU's device scope. Drivers don't need to set the
>     iommu device if it uses vendor defined isolation.
> 
> The mdev parent device driver could opt-in that the mdev could be
> fully isolated and protected by the IOMMU when the mdev is being
> created by invoking mdev_set_iommu_device() in its @create().
> 
> In the vfio_iommu_type1_attach_group(), a domain allocated through
> iommu_domain_alloc() will be attached to the mdev iommu device if
> an iommu device has been set. Otherwise, the dummy external domain
> will be used and all the DMA isolation and protection are routed to
> parent driver as the result.
> 
> On IOMMU side, a basic requirement is allowing to attach multiple
> domains to a PCI device if the device advertises the capability
> and the IOMMU hardware supports finer granularity translations than
> the normal PCI Source ID based translation.
> 
> As the result, a PCI device could work in two modes: normal mode
> and auxiliary mode. In the normal mode, a pci device could be
> isolated in the Source ID granularity; the pci device itself could
> be assigned to a user application by attaching a single domain
> to it. In the auxiliary mode, a pci device could be isolated in
> finer granularity, hence subsets of the device could be assigned
> to different user level application by attaching a different domain
> to each subset.
> 
> Below APIs are introduced in iommu generic layer for aux-domain
> purpose:
> 
> * iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
>   - Check whether both IOMMU and device support IOMMU aux
>     domain feature. Below aux-domain specific interfaces
>     are available only after this returns true.
> 
> * iommu_dev_enable/disable_feature(dev, IOMMU_DEV_FEAT_AUX)
>   - Enable/disable device specific aux-domain feature.
> 
> * iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)
>   - Check whether the aux domain specific feature enabled or
>     not.
> 
> * iommu_aux_attach_device(domain, dev)
>   - Attaches @domain to @dev in the auxiliary mode. Multiple
>     domains could be attached to a single device in the
>     auxiliary mode with each domain representing an isolated
>     address space for an assignable subset of the device.
> 
> * iommu_aux_detach_device(domain, dev)
>   - Detach @domain which has been attached to @dev in the
>     auxiliary mode.
> 
> * iommu_aux_get_pasid(domain, dev)
>   - Return ID used for finer-granularity DMA translation.
>     For the Intel Scalable IOV usage model, this will be
>     a PASID. The device which supports Scalable IOV needs
>     to write this ID to the device register so that DMA
>     requests could be tagged with a right PASID prefix.
> 
> In order for the ease of discussion, sometimes we call "a domain in
> auxiliary mode' or simply 'an auxiliary domain' when a domain is
> attached to a device for finer granularity translations. But we need
> to keep in mind that this doesn't mean there is a differnt domain
> type. A same domain could be bound to a device for Source ID based
> translation, and bound to another device for finer granularity
> translation at the same time.
> 
> This patch series extends both IOMMU and vfio components to support
> mdev device passing through when it could be isolated and protected
> by the IOMMU units. The first part of this series (PATCH 1/09~6/09)
> adds the interfaces and implementation of the multiple domains per
> device. The second part (PATCH 7/09~9/09) adds the iommu device
> attribute to each mdev, determines isolation type according to the
> existence of an iommu device when attaching group in vfio type1 iommu
> module, and attaches the domain to iommu aware mediated devices.
> 
> References:
> [1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
> [2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
> [3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
> 
> Best regards,
> Lu Baolu
> 
> Change log:
>   v5->v6:

This looks pretty reasonable with Jean-Philippe's nit fixups.  Where do
we go from here?  I think we need an ack from Kirti since they have an
interest here.  Presumably this looks ok to the ARM folks.  Do we have
any consumers of this code yet?  Theoretically I think a vfio-pci-like
meta driver could be written as an mdev vendor driver with this support
(restricted to type1 iommu use cases).  Thanks,

Alex
