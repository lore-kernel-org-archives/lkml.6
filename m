Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755191AbeDTOAy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755043AbeDTOAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:00:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E3620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 20 Apr 2018 09:00:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, sulrich@codeaurora.org,
        timur@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
Message-ID: <20180420140049.GP28657@bhelgaas-glaptop.roam.corp.google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
 <290e9530-dcde-9c10-7ae0-59ac4c509db4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290e9530-dcde-9c10-7ae0-59ac4c509db4@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Rajat, Alex because of their interest in the reset/hotplug issue]

For context, Sinan's patch is this:

> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index 83d66e8..75f49e3 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -908,7 +908,8 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>          * delay after a reset is required.  Per spec requirements,
>          * the link is either working or not after that point.
>          */
> -       pci_reset_bridge_secondary_bus(dev->bus->self);
> +       if (pci_reset_slot(dev->slot))
> +               pci_reset_bridge_secondary_bus(dev->bus->self);

On Thu, Apr 19, 2018 at 06:19:32PM -0400, Sinan Kaya wrote:
> On 4/19/2018 5:47 PM, Bjorn Helgaas wrote:
> >> Bjorn, would be appropriate to export pci_parent_bus_reset() or some
> >> variation therin??
> > I agree it would be really nice if the PCI core could help out somehow
> > so we could get some of this code out of individual drivers.

What I was really thinking here was about the whole Gen3 transition
thing, not the reset thing by itself.

> I can create a function called pci_reset_link() and move both slot and
> secondary bus reset inside.

What exactly is your patch fixing?  Is it the following?

  If the HFI link is not operating at 8GT/s, the driver's .probe()
  method tries to transition it to 8GT/s, which involves resetting the
  HFI device with pci_reset_bridge_secondary_bus().  If the HFI device
  is in a hotplug slot, the reset causes a "Link Down" event, which
  causes the pciehp driver to remove the HFI device and re-enumerate
  it when the link comes back up.

  When pciehp removes the device, it calls the HFI .remove() method,
  which is a problem because the .probe() method is still active.

  It looks like this should deadlock because __device_attach() holds
  the device_lock while calling .probe() and the
  device_release_driver() path tries to acquire it.

Your patch uses pci_reset_slot(), which connects with Rajat's work
(06a8d89af551 ("PCI: pciehp: Disable link notification across slot
reset")) to avoid hotplug events for intentional resets.

So I think I just reverse-engineered the whole rationale for your
patch :)  Sorry about the long detour.

I'm having a hard time articulating my thoughts here.  I think my
concern is that knowledge about this reset/link down/hotplug issue is
leaking out and we'll end up with different reset interfaces that may
or may not result in hotplug events.  This seems like a confusing API
because it's hard to explain which interface a driver should use.

Bjorn
