Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeCMStr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:49:47 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:46289 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCMStq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:49:46 -0400
X-Google-Smtp-Source: AG47ELtCRCip0Ztbyq0GD9OcpQC86KBOxNr0eoX8Y+j/n+0UbmNBoGIA97CCraprgBHAiepMgGC8taW+NfeRJZqwoak=
MIME-Version: 1.0
In-Reply-To: <8366ba39-a5a1-7734-752e-f3dce18e8007@arm.com>
References: <20171011094148.15674-4-punit.agrawal@arm.com> <28f9c1cd-e1df-f4db-32b4-c9ca0f0f256a@ti.com>
 <8366ba39-a5a1-7734-752e-f3dce18e8007@arm.com>
From: Nishanth Menon <nm@ti.com>
Date: Tue, 13 Mar 2018 13:49:44 -0500
X-Google-Sender-Auth: oyQw2PDpVG6f45cQzMQT_mVBs6k
Message-ID: <CAGo_u6phePsj-CQsaJTzg7pXjNDXTcAKnAh1z3BNfYfjMszf-g@mail.gmail.com>
Subject: Re: [3/3] irqchip/gic-v3: Bounds check redistributor accesses
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On Tue, Mar 13, 2018 at 9:21 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Lokesh,
>
> On 13/03/18 13:38, Lokesh Vutla wrote:
>> Hi All,
>>
>> On Wednesday 11 October 2017 03:11 PM, Punit Agrawal wrote:
>>> The kernel crashes while iterating over a redistributor that is
>>> in-correctly sized by the platform firmware or doesn't contain the last
>>> record.
>>>
>>> Prevent the crash by checking accesses against the size of the region
>>> provided by the firmware. While we are at it, warn the user about
>>> incorrect region size.
>>>
>>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Sorry to bring up an old thread. Just wanted to check what is the status
>> on this series.
>
> So far, I wasn't inclined to merge it, as it only allowed you to detect
> a broken system, as opposed to help with a working one.

Is'nt that a good reason to have it? Why not help an error in dtb with
a debug helper than an obtuse crash to debug painfully?

>
>> This will also be useful when we try to boot linux + hypervisor with
>> less number of cores than the SoC supports. For example:
>> - SoC has 4 cores and Linux tries to boot with 2 cores.
>> - then a type-2 hypervisor gets installed.
>> - Hypervisor tries to boot a VM with linux on core 1.
>>
>> Now the VM boot will fail while it iterates over all the GICR regions
>> till GICR_TYPER is found. Hypervisor will trap any accesses to GICR
>> regions of any invalid cpus(cpu 2, cpu 3 in this case).
>
> It you're passing the redistributors to a guest, you're doing something
> terribly wrong. You're putting the guest in a position to do a DoS on
> the hypervisor (disabling its timer interrupt, for example). Not the
> greatest move. There is a number of other gotchas with this approach
> (virtual interrupts, distributor virtualization...).
>
>> If the $patch is not the right approach, can you suggest on how to
>> handle the above scenario?
>
> The proper way to handle this is to virtualize the distributor and
> redistributor by trap/emulate. The only thing you can safely pass to a
> guest is the CPU interface, either as system registers or in its MMIO
> form (if you have the GICv2 compatibility interface).
>

Dumb question: Would'nt a trap emulate be real expensive with hyp
context in v8 (all the context save/restore we'd have to do? (in the
context of discussion, GICV2 compat is disabled).


-- 
---
Regards,
Nishanth Menon
