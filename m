Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeEVBru (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 21:47:50 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33009 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751505AbeEVBrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 21:47:45 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40185578"
Subject: Re: [PATCH 4/5] acpi/processor: Fix the return value of
 acpi_processor_ids_walk()
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
 <20180320110432.28127-5-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.21.1805191704150.1599@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <7c33b3bd-7e9d-1583-737c-d2edd457bd1a@cn.fujitsu.com>
Date: Tue, 22 May 2018 09:47:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805191704150.1599@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 2137248AE92A.AA514
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



At 05/19/2018 11:06 PM, Thomas Gleixner wrote:
> On Tue, 20 Mar 2018, Dou Liyang wrote:
> 
>> ACPI driver should make sure all the processor IDs in their ACPI Namespace
>> are unique for CPU hotplug. the driver performs a depth-first walk of the
>> namespace tree and calls the acpi_processor_ids_walk().
>>
>> But, the acpi_processor_ids_walk() will return true if one processor is
>> checked, that cause the walk break after walking pass the first processor.
>>
>> Repace the value with AE_OK which is the standard acpi_status value.
>>
>> Fixes 8c8cb30f49b8 ("acpi/processor: Implement DEVICE operator for processor enumeration")
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>>   drivers/acpi/acpi_processor.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 449d86d39965..db5bdb59639c 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -663,11 +663,11 @@ static acpi_status __init (acpi_handle handle,
>>   	}
>>   
>>   	processor_validated_ids_update(uid);
>> -	return true;
>> +	return AE_OK;
>>   
>>   err:
>>   	acpi_handle_info(handle, "Invalid processor object\n");
>> -	return false;
>> +	return AE_OK;
> 
> I'm not sure whether this is the right return value here. Rafael?
> 
Hi, Thomas, Rafael,

Yes, I used AE_OK to make sure it can skip the invalid objects and
continue to do the following other objects, I'm also not sure.

For this bug, recently, I sent another patch to remove this check code
away.

    https://lkml.org/lkml/2018/5/17/320

IMO, the duplicate IDs can be avoid by the other code

    if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) ---- 1)

As the mapping of cpu_id(pr->id) and processor_id is fixed, when
hot-plugging a physical CPU, if its processor_id is duplicated with the
present, the above condition 1) will be 0, and Linux will do not add
this CPU.

And, when every time the system starts, this code will be executed, it
will waste more time with the increase in the number of CPU.

So I prefer to remove this code.

Thanks,
	dou
