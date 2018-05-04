Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeEDR6l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:58:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:8210 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEDR6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:58:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="36894209"
Subject: Re: [V5 PATCH] perf parse-events: Specially handle uncore event alias
 in small groups
To: Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org
References: <1525185096-13477-1-git-send-email-kan.liang@linux.intel.com>
 <20180501163340.GB11539@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <1c2fc5c1-2ad1-8caf-eac6-f08b5f42d7fc@linux.intel.com>
Date: Fri, 4 May 2018 13:57:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501163340.GB11539@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 12:33 PM, Jiri Olsa wrote:
> On Tue, May 01, 2018 at 07:31:36AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Perf stat doesn't count the uncore event aliases from the same uncore
>> block in a group, for example:
>>
>>    perf stat -e '{unc_m_cas_count.all,unc_m_clockticks}' -a -I 1000
>>    #           time             counts unit events
>>         1.000447342      <not counted>      unc_m_cas_count.all
>>         1.000447342      <not counted>      unc_m_clockticks
>>         2.000740654      <not counted>      unc_m_cas_count.all
>>         2.000740654      <not counted>      unc_m_clockticks
>>
>> The output is very misleading. It gives a wrong impression that the
>> uncore event doesn't work.
>>
>> An uncore block could be composed by several PMUs. An uncore event alias
>> is a joint name which means the same event runs on all PMUs of a block.
>> Perf doesn't support mixed events from different PMUs in the same group.
>> It is wrong to put uncore event aliases in a big group.
>>
>> The right way is to split the big group into multiple small groups which
>> only include the events from the same PMU.
>> Only uncore event aliases from the same uncore block should be specially
>> handled here. It doesn't make sense to mix the uncore events with other
>> uncore events from different blocks or even core events in a group.
>>
>> With the patch:
>>    #           time             counts unit events
>>       1.001557653            140,833      unc_m_cas_count.all
>>       1.001557653      1,330,231,332      unc_m_clockticks
>>       2.002709483             85,007      unc_m_cas_count.all
>>       2.002709483      1,429,494,563      unc_m_clockticks
>>
>> Reported-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>
>> Changes since V4:
>> - Add WARN_ON when failing to alloc an array for leaders
>> - Add comments to explain why it has to go through the whole group
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Thanks Jirka.

Hi Arnaldo,

Are you OK with the patch?
It looks like Jirka has another patch which will touch the same code.
If it's OK for you, could you please merge the patch? So he can do the 
changes on top of this patch.

Thanks,
Kan
