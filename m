Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965739AbeEIRNC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:13:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55858 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965594AbeEIRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:13:01 -0400
X-Google-Smtp-Source: AB8JxZqWDTz5N1sgY60pcia/KDPBuitc6nhfSp3T+qJKQcu4qFJkLmPOvjaEYKJIyNGTLwP+tMQtK7eiM1VyuGFpDLE=
MIME-Version: 1.0
In-Reply-To: <a16587f9-bb0f-e806-9c8d-ee4af0e8b805@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-24-git-send-email-suzuki.poulose@arm.com>
 <20180508171800.GA3389@xps15> <a16587f9-bb0f-e806-9c8d-ee4af0e8b805@arm.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 9 May 2018 11:12:59 -0600
Message-ID: <CANLsYkxT90EtuJas08auzsZCEYgxTt93TZRpQqhA-bX3oE1=ug@mail.gmail.com>
Subject: Re: [PATCH v2 23/27] coresight: tmc-etr: Handle driver mode specific
 ETR buffers
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
        John Horley <john.horley@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 May 2018 at 15:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> On 05/08/2018 06:18 PM, Mathieu Poirier wrote:
>>
>> On Tue, May 01, 2018 at 10:10:53AM +0100, Suzuki K Poulose wrote:
>>>
>>> Since the ETR could be driven either by SYSFS or by perf, it
>>> becomes complicated how we deal with the buffers used for each
>>> of these modes. The ETR driver cannot simply free the current
>>> attached buffer without knowing the provider (i.e, sysfs vs perf).
>>>
>>> To solve this issue, we provide:
>>> 1) the driver-mode specific etr buffer to be retained in the drvdata
>>> 2) the etr_buf for a session should be passed on when enabling the
>>>     hardware, which will be stored in drvdata->etr_buf. This will be
>>>     replaced (not free'd) as soon as the hardware is disabled, after
>>>     necessary sync operation.
>>>
>>> The advantages of this are :
>>>
>>> 1) The common code path doesn't need to worry about how to dispose
>>>     an existing buffer, if it is about to start a new session with a
>>>     different buffer, possibly in a different mode.
>>> 2) The driver mode can control its buffers and can get access to the
>>>     saved session even when the hardware is operating in a different
>>>     mode. (e.g, we can still access a trace buffer from a sysfs mode
>>>     even if the etr is now used in perf mode, without disrupting the
>>>     current session.)
>>>
>>> Towards this, we introduce a sysfs specific data which will hold the
>>> etr_buf used for sysfs mode of operation, controlled solely by the
>>> sysfs mode handling code.
>>
>>
>> Thinking further on this... I toyed with the idea of doing the same thing
>> when
>> working on the original driver and decided against it.  Do we really have
>> a case
>> where users would want to use sysFS and perf alternatively?  To me this
>> looks
>> overdesigned.
>>
>> If we are going to go that way we need to enact the same behavior for
>> ETB10 and
>> ETF...  And take it out of this set as it is already substantial enough.
>
>
> The difference between ETB10/ETF and ETR is the usage of the buffer. The
> former uses an internal buffer and we always have to copy it out to an
> external buffer for consumption. Now this external buffer is actually
> separate for each mode, i.e sysfs and perf. Also the data is copied
> out right after we disable the HW. This ensures that the interleaved
> mode doesn't corrupt each others data.

Hi Suzuki,

When I wrote my original comment I was under the impression that
ETB10/ETF's drvdata->buf was used for both sysFS and perf, but after
going back to the code find it isn't the case.  As such a user can
call sysFS and perf session alternately without destroying the results
acquired from the previous trace scenario.  This is also what your
patch is providing, enacting the same (desired) behaviour we currently
have.

I'm good with this one.

Mathieu

>
> However, the ETR doesn't have an internal buffer and uses the System RAM.
> That brings in the problem of one mode using the "buffer" as
> described by the drvdata. So, eventually either mode could write to
> the buffer allocated by the other mode before it is consumed by the
> end user (via syfs read or perf). That brings in the challenge of
> managing the buffer safely, switching back and forth the buffer
> (with the right size and pages) for each mode without any interferences.
> That also implies, one mode must be able to free the left-over buffer
> from the previous mode safely (which could be potentially linked to
> other data structures maintained by the mode). And that makes it more
> complex. e.g, we must leave the sysfs trace data for collection and
> meanwhile the perf could grab the ETR for its usage. The perf mode
> might not know the mode of the existing buffer and thus wouldn't know
> how to free it properly.
>
> This is why we need buffers per mode which can be managed by
> each mode. i.e, both allocated, used and more importantly free'd
> appropriately.
>
> Cheers
> Suzuki
