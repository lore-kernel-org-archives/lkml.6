Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeENKxX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:53:23 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34474 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeENKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:53:22 -0400
Date: Mon, 14 May 2018 11:53:03 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: valmiki <valmikibow@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: Difference between IOVA and bus address when SMMU is enabled
Message-ID: <20180514105303.GE16141@n2100.armlinux.org.uk>
References: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 06:25:13PM +0530, valmiki wrote:
> Hi All,
> 
> What is the difference between IOVA address and bus address
> when SMMU is enabled ?
> 
> Is IOVA address term used only when hypervisor is present ?

IOVA = IO virtual address.  IOVA is the term normally used to describe
the address used on the _device_ side of an IOMMU.

For any general setup:

RAM ----- MMU ----- DEVICE
      ^         ^
  physical   virtual
  address    address

where "device" can be an IO device or a CPU, the terms still apply.

If you have something like this:

RAM ----- PCI bridge ----- MMU ----- DEVICE
      ^                ^         ^
   physical           bus     virtual
   address          address   address

You could also have (eg, in the case of a system MMU):

RAM ----- MMU ----- PCI bridge ----- DEVICE
      ^         ^                ^
   physical  virtual            bus
   address   address          address
           (this can also be
            considered a bus
            address!)

In both of the above two cases, the PCI bridge may perform some address
translation, meaning that the bus address is different from the address
seen on the other side of the bridge.

So, the terms used depend exactly on the overall bus topology.

In the case of a system MMU, where the system MMU sits between peripheral
devices and RAM, then the bus addresses are the same as the
_IOVA of the system MMU_.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
