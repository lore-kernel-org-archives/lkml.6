Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeDMPeN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:34:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:30323 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeDMPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:34:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="191284303"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jakub Kicinski <kubakici@wp.pl>
CC: Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link
 speed and whether it's limited
Thread-Topic: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link
 speed and whether it's limited
Thread-Index: AQHTyGrUSS9MhIAeskOrU+NRjtQ9xqP+pXeAgACgTYD//6MBcA==
Date: Fri, 13 Apr 2018 15:34:08 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882D7BF4B@ORSMSX115.amr.corp.intel.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180412213249.06661048@cakuba.netronome.com>
 <20180413140633.GD46420@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180413140633.GD46420@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGU5YTY4OGQtMGQ1Ni00MTFjLWI2YWUtOWFjMDBjNmZjMjYwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImgyZlNQc1RBWCszb1pqVGdVek45cDlQSnNIYm9FUzRVYWVcL1kyZHhNVVEwPSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Friday, April 13, 2018 7:07 AM
> To: Jakub Kicinski <kubakici@wp.pl>
> Cc: Tal Gilboa <talgi@mellanox.com>; Tariq Toukan <tariqt@mellanox.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavium.com>;
> Ganesh Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-pci@vger.kernel.org
> Subject: Re: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link speed
> and whether it's limited
> 
> On Thu, Apr 12, 2018 at 09:32:49PM -0700, Jakub Kicinski wrote:
> > On Fri, 30 Mar 2018 16:05:18 -0500, Bjorn Helgaas wrote:
> > > +	if (bw_avail >= bw_cap)
> > > +		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
> > > +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> > > +	else
> > > +		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d
> link at %s (capable of %d Mb/s with %s x%d link)\n",
> > > +			 bw_avail, PCIE_SPEED2STR(speed), width,
> > > +			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
> > > +			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
> >
> > I was just looking at using this new function to print PCIe BW for a
> > NIC, but I'm slightly worried that there is nothing in the message that
> > says PCIe...  For a NIC some people may interpret the bandwidth as NIC
> > bandwidth:
> >
> > [   39.839989] nfp 0000:04:00.0: Netronome Flow Processor NFP4000/NFP6000
> PCIe Card Probe
> > [   39.848943] nfp 0000:04:00.0: 63.008 Gb/s available bandwidth (8 GT/s x8 link)
> > [   39.857146] nfp 0000:04:00.0: RESERVED BARs: 0.0: General/MSI-X SRAM, 0.1:
> PCIe XPB/MSI-X PBA, 0.4: Explicit0, 0.5: Explicit1, fre4
> >
> > It's not a 63Gbps NIC...  I'm sorry if this was discussed before and I
> > didn't find it.  Would it make sense to add the "PCIe: " prefix to the
> > message like bnx2x used to do?  Like:
> >
> > nfp 0000:04:00.0: PCIe: 63.008 Gb/s available bandwidth (8 GT/s x8 link)
> 
> I agree, that does look potentially confusing.  How about this:
> 
>   nfp 0000:04:00.0: 63.008 Gb/s available PCIe bandwidth (8 GT/s x8 link)
> 
> I did have to look twice at this before I remembered that we're
> printing Gb/s (not GB/s).  Most of the references I found on the web
> use GB/s when talking about total PCIe bandwidth.
> 
> But either way I think it's definitely worth mentioning PCIe
> explicitly.

I also agree printing PCIe explicitly is good.

Thanks,
Jake
