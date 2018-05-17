Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeEQSCo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:02:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:8510 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbeEQSCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:02:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,411,1520924400";
   d="scan'208";a="40182978"
Date: Thu, 17 May 2018 12:04:44 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: INTMS/INTMC not being used in NVME interrupt handling
Message-ID: <20180517180444.GG23555@localhost.localdomain>
References: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20180516144240.GA20223@localhost.localdomain>
 <BLUPR0201MB1505BF5E68D05F25A53D3B96A5910@BLUPR0201MB1505.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB1505BF5E68D05F25A53D3B96A5910@BLUPR0201MB1505.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 11:15:59AM +0000, Bharat Kumar Gogada wrote:
> > > Hi,
> > >
> > > As per NVME specification:
> > > 7.5.1.1 Host Software Interrupt Handling It is recommended that host
> > > software utilize the Interrupt Mask Set and Interrupt Mask Clear
> > > (INTMS/INTMC) registers to efficiently handle interrupts when configured
> > to use pin based or MSI messages.
> > >
> > > In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr doesn't  use
> > > these registers.
> > >
> > > Any reason why these registers are not used in nvme interrupt handler ?
> > 
> > I think you've answered your own question: we process completions in the
> > interrupt context. The interrupt is already masked at the CPU level in this
> > context, so there should be no reason to mask them at the device level.
> > 
> > > Why NVMe driver is not using any bottom half and processing all
> > > completion queues in interrupt handler ?
> > 
> > Performance.
> Thanks keith. 
> Currently driver isn't setting any Coalesce count.  
> So the NVMe card will raise interrupt for every single completion queue ?
> 
> For legacy interrupt for each CQ 
> CQ-> ASSERT_INTA-> DOORBELL-> DEASSERT_INTA is this flow correct ?

Mostly, yes. There could be a case where the controller wouldn't
deassert INTx if there are more completes past the CQ head doorbell write.

> Is the following flow valid
> CQ1->ASSERT_INTA->CQ2/CQ3->Doorbell->DEASSERT_INTA ?
> 
> When using legacy interrupts, if CQ1 is sent followed by ASSERT_INTA, can the EP send 
> another CQ2,CQ3.. before DEASSERT_INTA of CQ1 is generated?

I assume you are saying CQ entry 1, CQ entry 2, etc ...

The end point may continue posting those completion queue entries while
the interrupt is asserted. It should not deassert the interrupt until
the host acknowledges all outstanding completions with a CQ doorbell
write.
