Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A8366070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbeFFJqj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:46:39 -0400
Received: from foss.arm.com ([217.140.101.70]:38618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeFFJqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:46:38 -0400
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
Date: Wed, 6 Jun 2018 10:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606082422.GB19727@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
> On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
>> Increment the refcnt for driver modules in current use by calling
>> module_get in coresight_build_path and module_put in release_path.
>>
>> This prevents driver modules from being unloaded when they are in use,
>> either in sysfs or perf mode.
> 
> Why does it matter?  Shouldn't you be allowed to remove any module at
> any point in time, much like a networking driver?
> 
> 
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
>> index 338f1719641c..1c941351f1d1 100644
>> --- a/drivers/hwtracing/coresight/coresight.c
>> +++ b/drivers/hwtracing/coresight/coresight.c
>> @@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
>>   
>>   	node->csdev = csdev;
>>   	list_add(&node->link, path);
>> +
>> +	if (!try_module_get(csdev->dev.parent->driver->owner)) {
> 
> What is to keep parent->driver from going away right here?  What keeps
> parent around?  This feels very fragile to me, I don't see any locking
> anywhere around this code path to try to keep things in place.

You're right. We do have coresight_mutex, which is held across the build 
path and the csdev is removed when a device is unregistered. However, I
see that we don't hold the mutex while removing the connections from
coresight_unregister(). Holding the mutex should protect us from the
csdev being removed, while we build the path.

And while we are at this, I also realised that we hold references to the
parent devices for each connection (via bus_find_device() from 
of_coresight_get_endpoint_device()), while parsing the platform data, 
which is never released.

Thanks
Suzuki

> 
> thanks,
> 
> greg k-h
> 
