Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeEEKDp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:03:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbeEEKDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:03:32 -0400
Subject: Re: [PATCH v2 04/27] coresight: Introduce support for Coresight
 Addrss Translation Unit
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
        John Horley <john.horley@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-5-git-send-email-suzuki.poulose@arm.com>
 <20180503173141.GB11425@xps15>
 <CANLsYkwCYUD0OSEuVML=vKJysT=xi8M0ahpU2bz=nBykSgFgGQ@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4582be29-d46d-c3fd-d84f-6fd850252b39@arm.com>
Date: Sat, 5 May 2018 11:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwCYUD0OSEuVML=vKJysT=xi8M0ahpU2bz=nBykSgFgGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 09:25 PM, Mathieu Poirier wrote:
> On 3 May 2018 at 11:31, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>> On Tue, May 01, 2018 at 10:10:34AM +0100, Suzuki K Poulose wrote:
>>> Add the initial support for Coresight Address Translation Unit, which
>>> augments the TMC in Coresight SoC-600 by providing an improved Scatter
>>> Gather mechanism. CATU is always connected to a single TMC-ETR and
>>> converts the AXI address with a translated address (from a given SG
>>> table with specific format). The CATU should be programmed in pass
>>> through mode and enabled if the ETR doesn't translation by CATU.
>>>
>>> This patch provides mechanism to enable/disable the CATU always in the
>>> pass through mode.
>>>
>>> We reuse the existing ports mechanism to link the TMC-ETR to the
>>> connected CATU.
>>>
>>> i.e, TMC-ETR:output_port0 -> CATU:input_port0
>>>
>>> Reference manual for  CATU component is avilable in version r2p0 of :
>>> "Arm Coresight System-on-Chip SoC-600 Technical Reference Manual",
>>> under Section 4.9.
>>
>> Please remove the part about the TRM as it is bound to change.

Ok, I will. Generally the TRM for a particular release (rXpY) doesn't
change, unless there is a change in either X or Y or both.

>>>
>>> +config CORESIGHT_CATU
>>> +     bool "Coresight Address Translation Unit (CATU) driver"
>>> +     depends on CORESIGHT_LINK_AND_SINK_TMC
>>> +     help
>>> +        Enable support for the Coresight Address Translation Unit (CATU).
>>> +        CATU supports a scatter gather table of 4K pages, with forward/backward
>>> +        lookup. CATU helps TMC ETR to use large physically non-contiguous trace
>>> +        buffer by translating the addersses used by ETR to the corresponding
>>> +        physical adderss by looking up the table.
>>
>> There is a couple of typos in the last sentence.
> 
> There's also a typo in the patch title.
> 

>>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>>> new file mode 100644
>>> index 0000000..2cd69a6
>>> --- /dev/null
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>>> @@ -0,0 +1,195 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>
>> Extra line
>>
>>> +/*
>>> + * Copyright (C) 2017 ARM Limited. All rights reserved.
>>
>> You sure you don't want to bump this to 2018?
>>


>>> + *
>>> + * Coresight Address Translation Unit support
>>> + *
>>> + * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> + */
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/device.h>
>>> +#include <linux/amba/bus.h>
>>> +#include <linux/io.h>
>>> +#include <linux/slab.h>
>>
>> List in alphabetical order is possible.
>>

>>> +static int catu_disable(struct coresight_device *csdev, void *__unused)
>>> +{
>>> +     int rc;
>>> +     struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
>>> +
>>> +     CS_UNLOCK(catu_drvdata->base);
>>> +     rc = catu_disable_hw(catu_drvdata);
>>> +     CS_LOCK(catu_drvdata->base);
>>> +
>>
>> I suppose you can remove the extra line as catu_enable() doesn't have one.
>>
>>> +     return rc;
>>> +}

>>> +     drvdata->base = base;
>>> +     catu_desc.pdata = pdata;
>>> +     catu_desc.dev = dev;
>>> +     catu_desc.groups = catu_groups;
>>> +     catu_desc.type = CORESIGHT_DEV_TYPE_HELPER;
>>> +     catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>>> +     catu_desc.ops = &catu_ops;
>>> +     drvdata->csdev = coresight_register(&catu_desc);
>>> +     if (IS_ERR(drvdata->csdev))
>>> +             ret = PTR_ERR(drvdata->csdev);
>>> +     if (!ret)
>>> +             dev_info(drvdata->dev, "initialized\n");
>>
>> Please remove as it 1) doesn't convey HW related information and 2) the TMC
>> doesn't out put anything.
>>

>>> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
>>> new file mode 100644
>>> index 0000000..cd58d6f
>>> --- /dev/null
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.h
>>> @@ -0,0 +1,89 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>
>> Extra line
>>
>>> +/*
>>> + * Copyright (C) 2017 ARM Limited. All rights reserved.
>>> + *
>>> + * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> + *
>>
>> Extra line. In coresight-catu.c there isn't one.
>>

>>> +#define CATU_STATUS_READY    8
>>> +#define CATU_STATUS_ADRERR   0
>>> +#define CATU_STATUS_AXIERR   4
>>> +
>>> +
>>
>> Extra line.
>>
>>> +#define CATU_IRQEN_ON                0x1
>>> +#define CATU_IRQEN_OFF               0x0
>>> +
>>> +
>>
>> Extra line.
>>

Will address all the above.

Cheers
Suzuki
