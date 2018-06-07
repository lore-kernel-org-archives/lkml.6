Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fYaGECn1GFv9OAAAmS7hNA
	; Thu, 07 Jun 2018 09:04:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3360F6089E; Thu,  7 Jun 2018 09:04:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A76C460115;
	Thu,  7 Jun 2018 09:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A76C460115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeFGJEf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:04:35 -0400
Received: from foss.arm.com ([217.140.101.70]:48604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbeFGJE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:04:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F254A15AB;
        Thu,  7 Jun 2018 02:04:28 -0700 (PDT)
Received: from [10.37.9.91] (unknown [10.37.9.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF643F59D;
        Thu,  7 Jun 2018 02:04:23 -0700 (PDT)
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
 <20180607083401.GE16651@kroah.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
Date: Thu, 7 Jun 2018 10:04:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180607083401.GE16651@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
> On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
>> On Wed, 6 Jun 2018 10:46:36 +0100
>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>>> On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
>>>> On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
>>>>> Increment the refcnt for driver modules in current use by calling
>>>>> module_get in coresight_build_path and module_put in release_path.
>>>>>
>>>>> This prevents driver modules from being unloaded when they are in use,
>>>>> either in sysfs or perf mode.
>>>>
>>>> Why does it matter?  Shouldn't you be allowed to remove any module at
>>>> any point in time, much like a networking driver?

The user doesn't have an explicit refcount on the individual components
in a trace session. So, when a trace session is in progress, it is as
good as having a "file" open on each component that is part of the
active trace session. So, we don't want the driver to be removed when
the component is being used in the trace collection. This will be
released as soon as the session is ended. It is just like a PMU driver
where the module refcount is held to ensure the module stays until the
session is over. In this case, we have multiple components, each with
its own driver invisible to the PMU driver. Hence the coresight driver
must hold the reference.

>>>>
>>>>
>>>>>
>>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> Cc: Leo Yan <leo.yan@linaro.org>
>>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>>> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>>>>> ---
>>>>>    drivers/hwtracing/coresight/coresight.c | 9 +++++++++
>>>>>    1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
>>>>> index 338f1719641c..1c941351f1d1 100644
>>>>> --- a/drivers/hwtracing/coresight/coresight.c
>>>>> +++ b/drivers/hwtracing/coresight/coresight.c
>>>>> @@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
>>>>>    
>>>>>    	node->csdev = csdev;
>>>>>    	list_add(&node->link, path);
>>>>> +
>>>>> +	if (!try_module_get(csdev->dev.parent->driver->owner)) {
>>>>
>>>> What is to keep parent->driver from going away right here?  What keeps
>>>> parent around?  This feels very fragile to me, I don't see any locking
>>>> anywhere around this code path to try to keep things in place.
>>>
>>> You're right. We do have coresight_mutex, which is held across the build
>>> path and the csdev is removed when a device is unregistered. However, I
>>> see that we don't hold the mutex while removing the connections from
>>> coresight_unregister(). Holding the mutex should protect us from the
>>> csdev being removed, while we build the path.
>>
>> OK, I'll add this for the next version:
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index f96258de1e9b..da702507a55c 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1040,8 +1040,12 @@ EXPORT_SYMBOL_GPL(coresight_register);
>>   
>>   void coresight_unregister(struct coresight_device *csdev)
>>   {
>> +       mutex_lock(&coresight_mutex);
>> +
> 
> Locks are to protect data, not code, be careful here please.

The mutex here is to protect updates to the device links. We
keep a list of connections from each device to form a trace path.
When we unregister a device, we must remove the references to the
device from all the other connected components to ensure they don't
end up accessing a device which is gone.

> 
> That's the big issue with the module reference counting, it "protects"
> code, not data.  If at all possible, never grab a module reference
> count, as you should always be able to unload a module, unless you have
> a file handle open, and if you have that, the kernel core will properly
> protect you.

So in a nutshell, we have user invisible components which cannot be
refcounted explicitly by the file handles, and thus the driver must
do it.
Now, one option we could explore is getting the refcount on the
devices itself, rather than the drivers for trace sessions. And each
device could potentially hold a refcount on the driver (which I assume
is already held), which can be dropped when the device is no longer
used and thus get rid of the reference on the module everywhere.

Thoughts ? Suggestions ?

Suzuki


> 
> thanks,
> 
> greg k-h
> 
