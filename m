Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64694C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190ED2432B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR34LdpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190ED2432B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFVOB3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbeFVOB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:01:27 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B2324329;
        Fri, 22 Jun 2018 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529676087;
        bh=xhjjl2ySV0Ylqw6LkZR3ZE8mtFrFg9k7VynxmRp8eXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vR34LdpI/nD2gMqJJau5PAwBQ4Zm13CPMFVFD7H46SnYgD1SmgzydIlWXqDp8K3RH
         PqGzw8EgMQsCeOA7gqYQP5g39go/vtbKfxMo9v84maKwrMixSCsXBg8itgBkzHjGAY
         DrW4BOjhF9Pj0bV6+xqSaarn+y2T9q4r/EQRLV+E=
Date:   Fri, 22 Jun 2018 09:01:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Message-ID: <20180622140125.GD108993@bhelgaas-glaptop.roam.corp.google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180619214346.GD33049@bhelgaas-glaptop.roam.corp.google.com>
 <2593baec-8a28-a3e7-7ebf-7c21addda0b8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2593baec-8a28-a3e7-7ebf-7c21addda0b8@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Alex]

On Tue, Jun 19, 2018 at 06:21:43PM -0400, Sinan Kaya wrote:
> On 6/19/2018 5:43 PM, Bjorn Helgaas wrote:
> >> Hotplug driver removes the device from system when a link down interrupt
> >> is observed and performs re-enumeration when link up interrupt is observed.
> >>
> >> This conflicts with what this code is trying to do. Try secondary bus reset
> >> only if pci_reset_slot() fails/unsupported.
> > Hi Sinan,
> > 
> > We had a bunch of discussion here but not sure we ever reached a
> > consensus.  It did seem like we'd like to avoid putting hotplug
> > knowledge in drivers, though.  What do you think the path forward is?
> > 
> 
> There are multiple issues. 
> 
> We discussed the need for a retrain API on this thread. However,
> retrain API may not be enough for this particular usage as the
> device might need a full link training sequence following firmware
> load including a hot reset message. I don't think we can remove the
> bus reset usage in this code.
> 
> I'd like to start with a small one to address your comment here.
> 
> "I think my concern is that knowledge about this reset/link
> down/hotplug issue is leaking out and we'll end up with different
> reset interfaces that may or may not result in hotplug events.  This
> seems like a confusing API because it's hard to explain which
> interface a driver should use."
> 
> I'm thinking of removing pci_reset_slot() and pci_try_reset_slot()
> functions as an exported API and fold them into pci_reset_bus() and
> pci_try_reset_bus() API respectively.

pci_try_reset_slot() and pci_try_reset_bus() are both used by VFIO,
but I don't see any callers of either pci_reset_slot() or
pci_reset_bus().

I suspect what happened was that we added pci_reset_slot(), used it
in VFIO, found a deadlock, added pci_try_reset_slot(), and converted
VFIO to use pci_try_reset_slot() to fix the deadlock, leaving no
callers of pci_reset_slot() itself.

  090a3c5322e9 ("PCI: Add pci_reset_slot() and pci_reset_bus()")
  8b27ee60bfd6 ("vfio-pci: PCI hot reset interface")
  61cf16d8bd38 ("PCI: Add pci_try_reset_function(), pci_try_reset_slot(), pci_try_reset_bus()")
  890ed578df82 ("vfio-pci: Use pci "try" reset interface")

I *think* pci_try_reset_slot() is already equivalent to pci_reset_slot()
except that it returns -EAGAIN if it can't lock the slot.  But if you
remove pci_reset_slot(), you could rename pci_try_reset_slot() to
pci_reset_slot().  It doesn't seem like keeping "try" in the function
name would be necessary.

> This is what happens when you insert a fatal error to a hotplug
> slot. See multiple link up/down messages.
> 
> /_#_[__333.699731]_pcieport_0001:00:00.0:_AER:_Uncorrected_(Fatal)_error_received:_id=0000
> [  333.748116] pcieport 0001:00:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id
> [  333.816044] pcieport 0001:00:00.0:   device [17cb:0404] error status/mask=00040000/00400000
> [  333.871581] pcieport 0001:00:00.0:    [18] Malformed TLP          (First)
> [  333.914675] pcieport 0001:00:00.0:   TLP Header: 40000001 000000ff 00000000 00000000
> [  333.968397] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down
> [  334.043234] iommu: Removing device 0001:01:00.4 from group 0
> [  334.095952] iommu: Removing device 0001:01:00.3 from group 0
> [  334.144644] iommu: Removing device 0001:01:00.2 from group 0
> [  334.194653] iommu: Removing device 0001:01:00.1 from group 0
> [  334.243564] pciehp 0001:00:00.0:pcie004: Slot(2): Link Up
> [  334.282556] iommu: Removing device 0001:01:00.0 from group 0
> [  334.330994] pciehp 0001:00:00.0:pcie004: Slot(2): Link Up event queued; currently getting powered off
> [  334.890587] pciehp 0001:00:00.0:pcie004: Timeout on hotplug command 0x13f1 (issued 282900 msec ago)
> [  335.070190] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down
> [  335.106960] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down event queued; currently getting powered on
> [  335.191119] pcieport 0001:00:00.0: AER: Device recovery failed
> [  346.590153] pciehp 0001:00:00.0:pcie004: Timeout on hotplug command 0x17f1 (issued 10250 msec ago)
> 
> As a suggestion:
> 
> 1. If the device belongs to a slot, do slot reset. 
> 2. Otherwise, do bus reset.

I assume this refers to pci_try_reset_slot() and pci_try_reset_bus(),
which are only used by VFIO in vfio_pci_ioctl() and
vfio_pci_try_bus_reset().

Both of those callers use pci_probe_reset_slot() to decide whether to
use pci_try_reset_slot() or pci_try_reset_bus().  If you're suggesting
to pull that slot/bus distinction into the PCI core somehow, that
would be fine with me, although VFIO does use the
pci_probe_reset_slot() result for other purposes in those functions.

> Since Oza's DPC/AER patch to refactor fatal error handling, both
> hotplug driver and AER/DPC driver will try removing devices and
> perform enumeration on link events/AER events.
> 
> Perfect environment for race condition without a change.

Yeah, this looks like a bit of a mess.  I guess we're getting two
interrupts (AER interrupt and hotplug interrupt) and we should
coordinate their handling somehow.  I don't have a proposal.  This
race could happen independent of the device reset paths, of course.

Bjorn
