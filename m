Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756082AbeEHVwF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:52:05 -0400
Received: from foss.arm.com ([217.140.101.70]:36230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755266AbeEHVwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:52:03 -0400
Subject: Re: [PATCH v2 23/27] coresight: tmc-etr: Handle driver mode specific
 ETR buffers
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-24-git-send-email-suzuki.poulose@arm.com>
 <20180508171800.GA3389@xps15>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a16587f9-bb0f-e806-9c8d-ee4af0e8b805@arm.com>
Date: Tue, 8 May 2018 22:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508171800.GA3389@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 06:18 PM, Mathieu Poirier wrote:
> On Tue, May 01, 2018 at 10:10:53AM +0100, Suzuki K Poulose wrote:
>> Since the ETR could be driven either by SYSFS or by perf, it
>> becomes complicated how we deal with the buffers used for each
>> of these modes. The ETR driver cannot simply free the current
>> attached buffer without knowing the provider (i.e, sysfs vs perf).
>>
>> To solve this issue, we provide:
>> 1) the driver-mode specific etr buffer to be retained in the drvdata
>> 2) the etr_buf for a session should be passed on when enabling the
>>     hardware, which will be stored in drvdata->etr_buf. This will be
>>     replaced (not free'd) as soon as the hardware is disabled, after
>>     necessary sync operation.
>>
>> The advantages of this are :
>>
>> 1) The common code path doesn't need to worry about how to dispose
>>     an existing buffer, if it is about to start a new session with a
>>     different buffer, possibly in a different mode.
>> 2) The driver mode can control its buffers and can get access to the
>>     saved session even when the hardware is operating in a different
>>     mode. (e.g, we can still access a trace buffer from a sysfs mode
>>     even if the etr is now used in perf mode, without disrupting the
>>     current session.)
>>
>> Towards this, we introduce a sysfs specific data which will hold the
>> etr_buf used for sysfs mode of operation, controlled solely by the
>> sysfs mode handling code.
> 
> Thinking further on this... I toyed with the idea of doing the same thing when
> working on the original driver and decided against it.  Do we really have a case
> where users would want to use sysFS and perf alternatively?  To me this looks
> overdesigned.
> 
> If we are going to go that way we need to enact the same behavior for ETB10 and
> ETF...  And take it out of this set as it is already substantial enough.

The difference between ETB10/ETF and ETR is the usage of the buffer. The 
former uses an internal buffer and we always have to copy it out to an
external buffer for consumption. Now this external buffer is actually 
separate for each mode, i.e sysfs and perf. Also the data is copied
out right after we disable the HW. This ensures that the interleaved
mode doesn't corrupt each others data.

However, the ETR doesn't have an internal buffer and uses the System 
RAM. That brings in the problem of one mode using the "buffer" as
described by the drvdata. So, eventually either mode could write to
the buffer allocated by the other mode before it is consumed by the
end user (via syfs read or perf). That brings in the challenge of
managing the buffer safely, switching back and forth the buffer
(with the right size and pages) for each mode without any interferences.
That also implies, one mode must be able to free the left-over buffer
from the previous mode safely (which could be potentially linked to
other data structures maintained by the mode). And that makes it more 
complex. e.g, we must leave the sysfs trace data for collection and
meanwhile the perf could grab the ETR for its usage. The perf mode
might not know the mode of the existing buffer and thus wouldn't know
how to free it properly.

This is why we need buffers per mode which can be managed by
each mode. i.e, both allocated, used and more importantly free'd
appropriately.

Cheers
Suzuki
