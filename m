Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeDCQy4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:54:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:59973 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751270AbeDCQyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:54:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,401,1517904000";
   d="scan'208";a="40391597"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
CC: Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute
 max supported link bandwidth
Thread-Topic: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute
 max supported link bandwidth
Thread-Index: AQHTyGrIFr77DKg4/kStVKf2xuGFuqPs12iAgABDmICAAHO3AIAAbPqAgACu3wCAAOOzAP//ucyQ
Date: Tue, 3 Apr 2018 16:54:52 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882D4AA53@ORSMSX115.amr.corp.intel.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
 <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
 <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com>
 <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
 <CA+P7+xr1N+X5DyPwNpWUtfqr9U4pLL9bMoB1wkBdf2K9n6cxKw@mail.gmail.com>
 <20180403140552.GB60020@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180403140552.GB60020@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTMwZmZjODgtYWIyNS00ZWU1LWJlODQtYTlmM2UzZmNhNGMzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IlloTDM5MmozSnY0NzR6MDQrbHN3XC92a3Z0bVNHcUFCWXBwTHlCdUsxK09NPSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, April 03, 2018 7:06 AM
> To: Jacob Keller <jacob.keller@gmail.com>
> Cc: Tal Gilboa <talgi@mellanox.com>; Tariq Toukan <tariqt@mellanox.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Ariel Elior <ariel.elior@cavium.com>;
> Ganesh Goudar <ganeshgr@chelsio.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; everest-linux-l2@cavium.com; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-pci@vger.kernel.org
> Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute
> max supported link bandwidth
> 
> On Mon, Apr 02, 2018 at 05:30:54PM -0700, Jacob Keller wrote:
> > On Mon, Apr 2, 2018 at 7:05 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > +/* PCIe speed to Mb/s reduced by encoding overhead */
> > > +#define PCIE_SPEED2MBS_ENC(speed) \
> > > +       ((speed) == PCIE_SPEED_16_0GT ? (16000*(128/130)) : \
> > > +        (speed) == PCIE_SPEED_8_0GT  ?  (8000*(128/130)) : \
> > > +        (speed) == PCIE_SPEED_5_0GT  ?  (5000*(8/10)) : \
> > > +        (speed) == PCIE_SPEED_2_5GT  ?  (2500*(8/10)) : \
> > > +        0)
> > > +
> >
> > Should this be "(speed * x ) / y" instead? wouldn't they calculate
> > 128/130 and truncate that to zero before multiplying by the speed? Or
> > are compilers smart enough to do this the other way to avoid the
> > losses?
> 
> Yep, thanks for saving me yet more embarrassment.

That's what patch review is for :D

Thanks,
Jake
