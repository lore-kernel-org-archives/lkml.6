Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEPOkm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:40:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:38029 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEPOkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:40:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="51345691"
Date: Wed, 16 May 2018 08:42:40 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: INTMS/INTMC not being used in NVME interrupt handling
Message-ID: <20180516144240.GA20223@localhost.localdomain>
References: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 12:35:15PM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> As per NVME specification: 
> 7.5.1.1 Host Software Interrupt Handling
> It is recommended that host software utilize the Interrupt Mask Set and Interrupt Mask Clear (INTMS/INTMC) 
> registers to efficiently handle interrupts when configured to use pin based or MSI messages.
> 
> In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr 
> doesn't  use these registers. 
> 
> Any reason why these registers are not used in nvme interrupt handler ?

I think you've answered your own question: we process completions in the
interrupt context. The interrupt is already masked at the CPU level in
this context, so there should be no reason to mask them at the device
level.
 
> Why NVMe driver is not using any bottom half and processing all completion queues
> in interrupt handler ?

Performance.
