Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeECUco (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:32:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35533 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeECUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:32:42 -0400
X-Google-Smtp-Source: AB8JxZqkLhgq1Fp5jy0PlvbJBRrI0OmpElGKhVEVsT1Q4oX76oGKBmwXVCpGydPOHhpkfvpG3m9BV9F1rJ0KRivGZUM=
MIME-Version: 1.0
In-Reply-To: <20180501131300.GA31425@rob-hp-laptop>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-11-git-send-email-suzuki.poulose@arm.com> <20180501131300.GA31425@rob-hp-laptop>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 3 May 2018 14:32:40 -0600
Message-ID: <CANLsYkwozU7QC5EeEy46KrEd4X7J9S69SiNg8-GhSSuMkhQrBw@mail.gmail.com>
Subject: Re: [PATCH v2 10/27] dts: bindings: Restrict coresight tmc-etr
 scatter-gather mode
To: Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        John Horley <john.horley@arm.com>,
        Mathieu Poirier <matheiu.poirier@linaro.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 May 2018 at 07:13, Rob Herring <robh@kernel.org> wrote:
> On Tue, May 01, 2018 at 10:10:40AM +0100, Suzuki K Poulose wrote:
>> We are about to add the support for ETR builtin scatter-gather mode
>> for dealing with large amount of trace buffers. However, on some of
>> the platforms, using the ETR SG mode can lock up the system due to
>> the way the ETR is connected to the memory subsystem.
>>
>> In SG mode, the ETR performs READ from the scatter-gather table to
>> fetch the next page and regular WRITE of trace data. If the READ
>> operation doesn't complete(due to the memory subsystem issues,
>> which we have seen on a couple of platforms) the trace WRITE
>> cannot proceed leading to issues. So, we by default do not
>> use the SG mode, unless it is known to be safe on the platform.
>> We define a DT property for the TMC node to specify whether we
>> have a proper SG mode.
>>
>> Cc: Mathieu Poirier <matheiu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Horley <john.horley@arm.com>
>> Cc: Robert Walker <robert.walker@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: frowand.list@gmail.com
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  Documentation/devicetree/bindings/arm/coresight.txt | 3 +++
>>  drivers/hwtracing/coresight/coresight-tmc.c         | 8 +++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index cdd84d0..7c0c8f0 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -88,6 +88,9 @@ its hardware characteristcs.
>>       * arm,buffer-size: size of contiguous buffer space for TMC ETR
>>        (embedded trace router)
>>
>> +     * scatter-gather: boolean. Indicates that the TMC-ETR can safely
>> +       use the SG mode on this system.
>> +
>
> Needs a vendor prefix.
>

Thinking further on this, do we need to make it device specific as
well - something like "arm,etr-scatter-gather"?  That way we don't
have to redefine "scatter-gather" for other ARM devices if they happen
to need the same property but for different reasons.

>>  * Optional property for CATU :
>>       * interrupts : Exactly one SPI may be listed for reporting the address
>>         error
