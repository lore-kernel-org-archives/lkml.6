Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDBAlL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 20:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753988AbeDBAlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 20:41:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555AF21723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Sun, 1 Apr 2018 19:41:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 04/14] PCI: Add pcie_bandwidth_available() to compute
 bandwidth available to device
Message-ID: <20180402004107.GB131023@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244391143.135666.12548496808512444463.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <7b82d160-002f-9687-ad80-5aaff639d7ab@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b82d160-002f-9687-ad80-5aaff639d7ab@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 11:41:42PM +0300, Tal Gilboa wrote:
> On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
> > From: Tal Gilboa <talgi@mellanox.com>
> > 
> > Add pcie_bandwidth_available() to compute the bandwidth available to a
> > device.  This may be limited by the device itself or by a slower upstream
> > link leading to the device.
> > 
> > The available bandwidth at each link along the path is computed as:
> > 
> >    link_speed * link_width * (1 - encoding_overhead)
> > 
> > The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
> > encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
> > encoding.
> > 
> > Also return the device with the slowest link and the speed and width of
> > that link.
> > 
> > Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> > [bhelgaas: changelog, leave pcie_get_minimum_link() alone for now, return
> > bw directly, use pci_upstream_bridge(), check "next_bw <= bw" to find
> > uppermost limiting device, return speed/width of the limiting device]
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/pci/pci.c   |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >   include/linux/pci.h |    3 +++
> >   2 files changed, 57 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9ce89e254197..e00d56b12747 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5146,6 +5146,60 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
> >   }
> >   EXPORT_SYMBOL(pcie_get_minimum_link);
> > +/**
> > + * pcie_bandwidth_available - determine minimum link settings of a PCIe
> > + *			      device and its bandwidth limitation
> > + * @dev: PCI device to query
> > + * @limiting_dev: storage for device causing the bandwidth limitation
> > + * @speed: storage for speed of limiting device
> > + * @width: storage for width of limiting device
> > + *
> > + * Walk up the PCI device chain and find the point where the minimum
> > + * bandwidth is available.  Return the bandwidth available there and (if
> > + * limiting_dev, speed, and width pointers are supplied) information about
> > + * that point.
> > + */
> > +u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
> > +			     enum pci_bus_speed *speed,
> > +			     enum pcie_link_width *width)
> > +{
> > +	u16 lnksta;
> > +	enum pci_bus_speed next_speed;
> > +	enum pcie_link_width next_width;
> > +	u32 bw, next_bw;
> > +
> > +	*speed = PCI_SPEED_UNKNOWN;
> > +	*width = PCIE_LNK_WIDTH_UNKNOWN;
> 
> This is not safe anymore, now that we allow speed/width=NULL.

Good catch, thanks!
