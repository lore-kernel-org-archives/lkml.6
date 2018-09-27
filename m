Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7035C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8B215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD8B215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeI0Vqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:46:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:28311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbeI0Vqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:46:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 08:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,311,1534834800"; 
   d="scan'208";a="87166124"
Received: from unknown (HELO [10.7.198.153]) ([10.7.198.153])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2018 08:27:56 -0700
Subject: Re: [RFC workqueue/driver-core PATCH 3/5] driver core: Probe devices
 asynchronously instead of the driver
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215149.13512.51991.stgit@localhost.localdomain>
 <CAPcyv4h5U4Fph52H80QodBRXK+PjS6Zw_6qK2+DXtr=qZT7Gzw@mail.gmail.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <021d55fb-9f6a-0b52-3513-e9c5493bd7d7@linux.intel.com>
Date:   Thu, 27 Sep 2018 08:27:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h5U4Fph52H80QodBRXK+PjS6Zw_6qK2+DXtr=qZT7Gzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2018 5:48 PM, Dan Williams wrote:
> On Wed, Sep 26, 2018 at 2:51 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
>>
>> This change makes it so that we probe devices asynchronously instead of the
>> driver. This results in us seeing the same behavior if the device is
>> registered before the driver or after. This way we can avoid serializing
>> the initialization should the driver not be loaded until after the devices
>> have already been added.
>>
>> The motivation behind this is that if we have a set of devices that
>> take a significant amount of time to load we can greatly reduce the time to
>> load by processing them in parallel instead of one at a time. In addition,
>> each device can exist on a different node so placing a single thread on one
>> CPU to initialize all of the devices for a given driver can result in poor
>> performance on a system with multiple nodes.
>>
>> One issue I can see with this patch is that I am using the
>> dev_set/get_drvdata functions to store the driver in the device while I am
>> waiting on the asynchronous init to complete. For now I am protecting it by
>> using the lack of a dev->driver and the device lock.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> [..]
>> @@ -891,6 +914,25 @@ static int __driver_attach(struct device *dev, void *data)
>>                  return ret;
>>          } /* ret > 0 means positive match */
>>
>> +       if (driver_allows_async_probing(drv)) {
>> +               /*
>> +                * Instead of probing the device synchronously we will
>> +                * probe it asynchronously to allow for more parallelism.
>> +                *
>> +                * We only take the device lock here in order to guarantee
>> +                * that the dev->driver and driver_data fields are protected
>> +                */
>> +               dev_dbg(dev, "scheduling asynchronous probe\n");
>> +               device_lock(dev);
>> +               if (!dev->driver) {
>> +                       get_device(dev);
>> +                       dev_set_drvdata(dev, drv);
>> +                       async_schedule(__driver_attach_async_helper, dev);
> 
> I'm not sure async drivers / sub-systems are ready for their devices
> to show up in parallel. While userspace should not be relying on
> kernel device names, people get upset when devices change kernel names
> from one boot to the next, and I can see this change leading to that
> scenario.

The thing is the current async behavior already does this if the driver 
is loaded before the device is added. All I am doing is making the 
behavior with the driver loaded first the standard instead of letting it 
work the other way around. This way we get consistent behavior.

> If a driver / sub-system wants more parallelism than what
> driver_allows_async_probing() provides it should do it locally, for
> example, like libata does.

So where I actually saw this was with the pmem legacy setup I had. After 
doing all the work to parallelize things in the driver it had no effect. 
That was because the nd_pmem driver wasn't loaded yet so all the 
device_add calls did is add the device but didn't attach the nd_pmem 
driver. Then when the driver loaded it serialized the probe calls 
resulting in it taking twice as long as it needed to in order to 
initialize the memory.

This seems to affect standard persistent memory as well. The only 
difference is that instead of probing the device on the first pass we 
kick it back and reprobe it in nd_pmem_probe/nd_pfn_probe in order to 
set the correct personality and that in turn allows us to asynchronously 
reschedule the work on the correct CPU and deserialize it.


