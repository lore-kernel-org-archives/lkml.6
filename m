Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEBXtb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:49:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:25572 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeEBXt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:49:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="42603486"
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in irq
 handler
To: Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        joro@8bytes.org, "Raj, Ashok" <ashok.raj@intel.com>
References: <20180331003312.6390-1-dima@arista.com>
 <20180331003312.6390-2-dima@arista.com> <5AE95BFF.5040306@linux.intel.com>
 <1525264687.14025.20.camel@arista.com>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        iommu@lists.linux-foundation.org
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AEA4E84.6050609@linux.intel.com>
Date: Thu, 3 May 2018 07:49:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1525264687.14025.20.camel@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/02/2018 08:38 PM, Dmitry Safonov wrote:
> Hi Lu,
>
> On Wed, 2018-05-02 at 14:34 +0800, Lu Baolu wrote:
>> Hi,
>>
>> On 03/31/2018 08:33 AM, Dmitry Safonov wrote:
>>> Theoretically, on some machines faults might be generated faster
>>> than
>>> they're cleared by CPU.
>> Is this a real case?
> No. 1/2 is a real case and this one was discussed on v3:
> lkml.kernel.org/r/<20180215191729.15777-1-dima@arista.com>
>
> It's not possible on my hw as far as I tried, but the discussion result
> was to fix this theoretical issue too.

If faults are generated faster than CPU can clear them, the PCIe
device should be in a very very bad state. How about disabling
the PCIe device and ask the administrator to replace it? Anyway,
I don't think that's goal of this patch series. :-)

>
>>>  Let's limit the cleaning-loop by number of hw
>>> fault registers.
>> Will this cause the fault recording registers full of faults, hence
>> new faults will be dropped without logging?
> If faults come faster then they're being cleared - some of them will be
> dropped without logging. Not sure if it's worth to report all faults in
> such theoretical(!) situation.
> If amount of reported faults for such situation is not enough and it's
> worth to keep all the faults, then probably we should introduce a
> workqueue here (which I did in v1, but it was rejected by the reason
> that it will introduce some latency in fault reporting).
>
>> And even worse, new faults will not generate interrupts?
> They will, we clear page fault overflow outside of the loop, so any new
> fault will raise interrupt, iiuc.
>

I am afraid that they might not generate interrupts any more.

Say, the fault registers are full of events that are not cleared,
then a new fault comes. There is no room for this event and
hence the hardware might drop it silently.

Best regards,
Lu Baolu
