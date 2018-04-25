Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeDYP20 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:28:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:54675 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754395AbeDYP2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:28:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="44551199"
Subject: Re: [V2 PATCH] perf parse-events: Specially handle uncore event alias
 in small groups
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
References: <1524664218-134407-1-git-send-email-kan.liang@linux.intel.com>
 <20180425142337.GE3396@krava>
 <dbc6f99c-3728-3f23-9c38-a91865dbdefe@linux.intel.com>
 <20180425145920.GF3396@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <6699e9dc-35df-1da5-7271-d5d3e2ab1459@linux.intel.com>
Date: Wed, 25 Apr 2018 11:28:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425145920.GF3396@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2018 10:59 AM, Jiri Olsa wrote:
> On Wed, Apr 25, 2018 at 10:42:27AM -0400, Liang, Kan wrote:
>>
>>
>> On 4/25/2018 10:23 AM, Jiri Olsa wrote:
>>> On Wed, Apr 25, 2018 at 06:50:18AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Perf stat doesn't count the uncore event aliases from the same uncore
>>>> block in a group, for example:
>>>>
>>>>     perf stat -e '{unc_m_cas_count.all,unc_m_clockticks}' -a -I 1000
>>>>     #           time             counts unit events
>>>>          1.000447342      <not counted>      unc_m_cas_count.all
>>>>          1.000447342      <not counted>      unc_m_clockticks
>>>>          2.000740654      <not counted>      unc_m_cas_count.all
>>>>          2.000740654      <not counted>      unc_m_clockticks
>>>>
>>>> The output is very misleading. It gives a wrong impression that the
>>>> uncore event doesn't work.
>>>>
>>>> An uncore block could be composed by several PMUs. An uncore event alias
>>>> is a joint name which means the same event runs on all PMUs of a block.
>>>> Perf doesn't support mixed events from different PMUs in the same group.
>>>> It is wrong to put uncore event aliases in a big group.
>>>>
>>>> The right way is to split the big group into multiple small groups which
>>>> only include the events from the same PMU.
>>>> Only uncore event aliases from the same uncore block should be specially
>>>> handled here. It doesn't make sense to mix the uncore events with other
>>>> uncore events from different blocks or even core events in a group.
>>>>
>>>> With the patch:
>>>>     #           time             counts unit events
>>>>        1.001557653            140,833      unc_m_cas_count.all
>>>>        1.001557653      1,330,231,332      unc_m_clockticks
>>>>        2.002709483             85,007      unc_m_cas_count.all
>>>>        2.002709483      1,429,494,563      unc_m_clockticks
>>>
>>> hum, I still can see the original behaviour even with the patch:
>>>
>>
>> That's because the data_reads and clockticks are from different uncore
>> blocks. The data_reads is a IMC event. The clockticks is a CBOX event.
>>
>> The patch only supports the events from the same uncore blocks in group.
> 
> I see, found another example from same uncore blocks and it seems to work:
>    #  perf stat -e '{cas_count_read,cas_count_write}' -a -I 1000
> 
> but I have it aborted on:
>    # ./perf stat -e '{cas_count_read,cas_count_write,cas_count_read}' -a -I 1000
>    perf: util/evsel.c:1483: get_group_fd: Assertion `!(!leader->fd)' failed.
>    Aborted (core dumped)
> 

Yes, there is a bug if leader and member have the same event name.
I will fix it in V3. Thanks for the test.

Thanks,
Kan
