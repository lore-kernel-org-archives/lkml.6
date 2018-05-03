Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbeECCQe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 22:16:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:22457 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751837AbeECCQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 22:16:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="196297191"
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in irq
 handler
To: Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        joro@8bytes.org, "Raj, Ashok" <ashok.raj@intel.com>
References: <20180331003312.6390-1-dima@arista.com>
 <20180331003312.6390-2-dima@arista.com> <5AE95BFF.5040306@linux.intel.com>
 <1525264687.14025.20.camel@arista.com> <5AEA4E84.6050609@linux.intel.com>
 <1525308755.14025.25.camel@arista.com> <5AEA66BC.5050202@linux.intel.com>
 <1525312776.14025.29.camel@arista.com>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        iommu@lists.linux-foundation.org
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AEA70FD.1010209@linux.intel.com>
Date: Thu, 3 May 2018 10:16:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1525312776.14025.29.camel@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/03/2018 09:59 AM, Dmitry Safonov wrote:
> On Thu, 2018-05-03 at 09:32 +0800, Lu Baolu wrote:
>> Hi,
>>
>> On 05/03/2018 08:52 AM, Dmitry Safonov wrote:
>>> AFAICS, we're doing fault-clearing in a loop inside irq handler.
>>> That means that while we're clearing if a fault raises, it'll make
>>> an irq level triggered (or on edge) on lapic. So, whenever we
>>> return
>>> from the irq handler, irq will raise again.
>>>
>> Uhm, double checked with the spec. Interrupts should be generated
>> since we always clear the fault overflow bit.
>>
>> Anyway, we can't clear faults in a limited loop, as the spec says in
>> 7.3.1:
> Mind to elaborate?
> ITOW, I do not see a contradiction. We're still clearing faults in FIFO
> fashion. There is no limitation to do some spare work in between
> clearings (return from interrupt, then fault again and continue).

Hardware maintains an internal index to reference the fault recording
register in which the next fault can be recorded. When a fault comes,
hardware will check the Fault bit (bit 31 of the 4th 32-bit register recording
register) referenced by the internal index. If this bit is set, hardware will
not record the fault.

Since we now don't clear the F bit until a register entry which has the F bit
cleared, we might exit the fault handling with some register entries still
have the F bit set.

  F
| 0 |  xxxxxxxxxxxxx|
| 0 |  xxxxxxxxxxxxx|
| 0 |  xxxxxxxxxxxxx|  <--- Fault record index in fault status register
| 0 |  xxxxxxxxxxxxx|
| 1 |  xxxxxxxxxxxxx|  <--- hardware maintained index
| 1 |  xxxxxxxxxxxxx|
| 1 |  xxxxxxxxxxxxx|
| 0 |  xxxxxxxxxxxxx|
| 0 |  xxxxxxxxxxxxx|
| 0 |  xxxxxxxxxxxxx|
| 0 |  xxxxxxxxxxxxx|

Take an example as above, hardware could only record 2 more faults with
others all dropped.

Best regards,
Lu Baolu
