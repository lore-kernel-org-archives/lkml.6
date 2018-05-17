Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeEQQGX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:06:23 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50122 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeEQQGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:06:21 -0400
To: Bjorn Helgaas <helgaas@kernel.org>, dmeyer@gigaio.com
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com, bhelgaas@google.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
 <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
Date: Thu, 17 May 2018 10:06:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, bhelgaas@google.com, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, dmeyer@gigaio.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/05/18 07:45 AM, Bjorn Helgaas wrote:
> On Thu, May 17, 2018 at 05:00:13AM -0700, dmeyer@gigaio.com wrote:
>> From: Doug Meyer <dmeyer@gigaio.com>
>>
>> Here we add the PCI quirk for the Microsemi Switchtec parts to allow
>> non-transparent bridging to work when the IOMMU is turned on.
> 
> I'm not an NTB expert, but it *sounds* like you're specifically fixing
> DMA initiated by an NT endpoint.  I assume other aspects of
> non-transparent bridging, e.g., routing of config accesses,
> interrupts, doorbells, etc., might work even without this quirk.

Yes, that's correct.

>> When a requestor on one NT endpoint accesses memory on another NT
>> endpoint, it does this via a devfn proxy ID. Proxy IDs are uniquely
>> assigned on a per-requestor basis within the NT hardware, and are not
>> visible via PCI enumeration. As a result, a memory access from a peer
>> NT endpoint will have an unrecognized requestor ID devfn which the
>> IOMMU will reject.
> 
> It would be very helpful if you could include a reference to the
> relevant section of a publicly available spec.

I'm not aware of any public specs on this. The basic idea is that a peer
accesses a BAR memory window on it's own side and the NTB translates it
to a memory request on the local side. This request has it's requester
ID translated through a LUT seeing the requester ID on the initiating
side isn't valid on the receiving side. The LUT has multiple entries so
that multiple requester IDs can be translated and the responses routed
back to the original requester.

> Who assigns these proxy IDs?  Quirks run before drivers claim the
> device, so it looks like this assumes the proxy ID assignments are
> either hard-wired into the device or programmed by firmware.  If the
> latter, how would they be programmed for hot-added NTBs?

The local side of the requester ID LUT are fixed by the hardware so we
can determine all the possible IDs coming from the NTB device just by
reading some registers. The peer's side of the LUT are programmed with
all possible source requester IDs by the driver but these don't have any
effect on the ID's on the receiving side.

> I'm wondering if all this could or should be done in the switchtec
> driver instead of in a quirk.  But I really don't know how that driver
> works.

We'd like it to be done in the driver too but it seems
pci_add_dma_alias() must be called before the driver is initialized and
therefore in a quirk. Presently, it seems nearly all calls to that
function are in quirks.c for this reason.

Thanks,

Logan
