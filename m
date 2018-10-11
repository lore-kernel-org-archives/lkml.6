Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C8C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E72C2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E72C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeJKXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:19:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:26371 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbeJKXTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:19:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 08:51:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="91162913"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.157]) ([10.7.198.157])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2018 08:51:17 -0700
Subject: Re: [workqueue/driver-core PATCH v2 2/5] async: Add support for
 queueing on specific NUMA node
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230747.10609.15866.stgit@localhost.localdomain>
 <20181011104740.GB30183@kroah.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <d9d75577-6663-aa1c-7f15-03dc07922212@linux.intel.com>
Date:   Thu, 11 Oct 2018 08:51:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181011104740.GB30183@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2018 3:47 AM, Greg KH wrote:
> On Wed, Oct 10, 2018 at 04:08:21PM -0700, Alexander Duyck wrote:
>> This patch introduces four new variants of the async_schedule_ functions
>> that allow scheduling on a specific NUMA node.
>>
>> The first two functions are async_schedule_near and
>> async_schedule_near_domain which end up mapping to async_schedule and
>> async_schedule_domain but provide NUMA node specific functionality. They
>> replace the original functions which were moved to inline function
>> definitions that call the new functions while passing NUMA_NO_NODE.
>>
>> The second two functions are async_schedule_dev and
>> async_schedule_dev_domain which provide NUMA specific functionality when
>> passing a device as the data member and that device has a NUMA node other
>> than NUMA_NO_NODE.
>>
>> The main motivation behind this is to address the need to be able to
>> schedule device specific init work on specific NUMA nodes in order to
>> improve performance of memory initialization.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> ---
>>
>> v1->v2:
>>      Replaced call to queue_work_near with call to queue_work_node
>>
>>   include/linux/async.h |   36 +++++++++++++++++++++++++++++++++---
>>   kernel/async.c        |   47 ++++++++++++++++++++++-------------------------
>>   2 files changed, 55 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/async.h b/include/linux/async.h
>> index 6b0226bdaadc..1f6cb0d50263 100644
>> --- a/include/linux/async.h
>> +++ b/include/linux/async.h
>> @@ -14,6 +14,8 @@
>>   
>>   #include <linux/types.h>
>>   #include <linux/list.h>
>> +#include <linux/numa.h>
>> +#include <linux/device.h>
>>   
>>   typedef u64 async_cookie_t;
>>   typedef void (*async_func_t) (void *data, async_cookie_t cookie);
>> @@ -37,9 +39,37 @@ struct async_domain {
>>   	struct async_domain _name = { .pending = LIST_HEAD_INIT(_name.pending), \
>>   				      .registered = 0 }
>>   
>> -extern async_cookie_t async_schedule(async_func_t func, void *data);
>> -extern async_cookie_t async_schedule_domain(async_func_t func, void *data,
>> -					    struct async_domain *domain);
>> +async_cookie_t async_schedule_near(async_func_t func, void *data,
>> +				   int node);
>> +async_cookie_t async_schedule_near_domain(async_func_t func, void *data,
>> +					  int node,
>> +					  struct async_domain *domain);
>> +
>> +static inline async_cookie_t async_schedule(async_func_t func, void *data)
>> +{
>> +	return async_schedule_near(func, data, NUMA_NO_NODE);
>> +}
>> +
>> +static inline async_cookie_t
>> +async_schedule_domain(async_func_t func, void *data,
>> +		      struct async_domain *domain)
>> +{
>> +	return async_schedule_near_domain(func, data, NUMA_NO_NODE, domain);
>> +}
>> +
>> +static inline async_cookie_t
>> +async_schedule_dev(async_func_t func, struct device *dev)
>> +{
>> +	return async_schedule_near(func, dev, dev_to_node(dev));
>> +}
>> +
>> +static inline async_cookie_t
>> +async_schedule_dev_domain(async_func_t func, struct device *dev,
>> +			  struct async_domain *domain)
>> +{
>> +	return async_schedule_near_domain(func, dev, dev_to_node(dev), domain);
>> +}
> 
> No kerneldoc for these functions?  We lost it for
> async_schedule_domain() which used to be documented before this patch :(
> 
> thanks,
> 
> greg k-h
> 

I will add it for v3.

Thanks.

- Alex
