Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752847AbeEGT2n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:28:43 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40985 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbeEGT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:28:38 -0400
X-Google-Smtp-Source: AB8JxZrUwFiR55wNSjRsbKdSmlibIkXoniAd+SzTPtTzqoc7M7weTg9e7PM9TLOTLG8GvzjnnrnIXKh4qpDNso3sEFc=
MIME-Version: 1.0
In-Reply-To: <57fc5480-c57e-dfd3-e6af-5e5bba296430@arm.com>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
 <20180302145531.20463-4-srinivas.kandagatla@linaro.org> <57fc5480-c57e-dfd3-e6af-5e5bba296430@arm.com>
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 7 May 2018 12:28:37 -0700
Message-ID: <CAOCOHw4RDwmbCySN==-zT7cQ6abzLzKUhBHBSdv_EvWnU4g4Pg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu: armsmmu: set iommu ops for rpmsg bus
To: Robin Murphy <robin.murphy@arm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM"
        <linux-remoteproc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 8:59 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 02/03/18 14:55, srinivas.kandagatla@linaro.org wrote:
>>
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> On Qualcomm SoCs, ADSP exposes many functions like audio and
>> others. These services need iommu access to allocate any
>> memory for the DSP. As these drivers are childeren of
>> rpmsg bus, able to allocate memory from iommus is basic
>> requirement. So set arm smmu iommu ops for this bus type.
>

Forgot to answer this and the dma_ops patch seems to be going in the
right direction.

>
> Documentation/rpmsg.txt: "Every rpmsg device is a communication channel with
> a remote processor (thus rpmsg devices are called channels)."
>
> I'd instinctively assume that a remote processor already has its own memory,
> and that a communication channel doesn't somehow go directly through an
> IOMMU, so that "basic requirement" seems like a pretty big assumption.
>

As of today rpmsg exclusively uses system memory for implementing the
communication fifos, but this memory is owned/handled by the rpmsg
bus. The need here is for drivers on top of the rpmsg_bus,
implementing some application-level protocol that requires indirection
buffers; e.g. to achieve zero copy of audio or image buffers that the
remote processor is expected to operate on. In this case the device
sitting on top of the rpmsg bus will have to map the buffer to the
appropriate context and can then send application specific control
requests referencing this mapping.

As different parts of the firmware might operate in different contexts
it's not feasible to utilize the parent's (the rpmsg_bus) context for
these indirection buffers.

>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index e6920d32ac9e..9b63489af15c 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -53,6 +53,7 @@
>>   #include <linux/spinlock.h>
>>     #include <linux/amba/bus.h>
>> +#include <linux/rpmsg.h>
>>     #include "io-pgtable.h"
>>   #include "arm-smmu-regs.h"
>> @@ -2168,6 +2169,10 @@ static void arm_smmu_bus_init(void)
>>                 bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>>         }
>>   #endif
>> +#ifdef CONFIG_RPMSG
>
>
> Ah, so this will at least build OK with RPMSG=m, but I doubt it does what
> you want it to in that case.
>

Things have been refactored but the core has remained tristate,
causing extra head aches in various areas. I think it's very
reasonable to review the rpmsg config options and make CONFIG_RPMSG
bool.

So with the addition of making CONFIG_RPMSG bool the patch has my Acked-by.

That said I'm generally concerned about the first probed iommu
implementation assigning itself as the sole iommu implementation for
all busses, but I guess we haven't yet hit the point where there are
different iommu implementations in a single SoC?

Regards,
Bjorn
