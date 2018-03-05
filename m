Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeCEQ3D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:29:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47013 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752986AbeCEQ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:28:59 -0500
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
To: William Cohen <wcohen@redhat.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>, Jiri Olsa <jolsa@redhat.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
 <cafdb160-3072-389b-8c31-93f09eff84a8@redhat.com>
 <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
 <8f72afe5-8620-bdd3-3a54-87a22f77c3d4@redhat.com>
 <599637d9-0b78-9edb-d459-515f76aca9fe@huawei.com>
 <6564ebca-b87d-f307-72ce-e1c541800e42@redhat.com>
CC: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Jayachandran.Nair@cavium.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <39385b47-b8f2-7673-ea17-8550787663e8@huawei.com>
Date: Mon, 5 Mar 2018 16:28:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <6564ebca-b87d-f307-72ce-e1c541800e42@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 15:39, William Cohen wrote:
> On 03/05/2018 06:24 AM, John Garry wrote:
>>>> I am seeing issue(log below) with this patchset on our platfrom.
>>>> i have tried using your v2 branch [1]
>>>>
>>>> root@borg-1>perf_acme>> ./perf --version
>>>> perf version 4.16.rc1.g087f7ca
>>>> root@borg-1>perf_acme>> ./perf stat -e bus_access_rd sleep 1
>>>>
>>>>  Performance counter stats for 'sleep 1':
>>>>
>>>>             23,099      bus_access_rd
>>>>
>>>>        1.000708516 seconds time elapsed
>>>>
>>>> root@borg-1>perf_acme>> cd -
>>>> /ganapat/perf/linux-hisi/tools/perf
>>>> root@borg-1>perf>> ./perf --version
>>>> perf version 4.16.rc1.gcb5a74
>>>> root@borg-1>perf>> ./perf stat -e bus_access_rd sleep 1
>>>>
>>>>  Performance counter stats for 'sleep 1':
>>>>
>>>>                  0      bus_access_rd
>>>>
>>>>        1.000709162 seconds time elapsed
>>>>
>>>> root@borg-1>perf>>
>>>>
>>>>
>>>> [1] https://github.com/hisilicon/linux-hisi.git
>>>>
>>> Hi,
>>
>> Hi Will Cohen, Ganapatrao,
>>
>>>
>>> I took a slightly different tack and compared the output of "perf list --details" to see if the event numbers numbers were the same.  For the common events borrowed from the armv8-recommended.json all the events are 0 for the cortex a53.  That would explain why the bus_access_rd above were counts were different if it was counting the SW_INCR event instead of bus_access_rd.
>>>
>>
>> Thanks for this. I see the problem. At the end I missed bringing across something from v1. Easily fixed.
>>
>>> Why not key the matching of common events off the "EventName" rather than "EventCode"? The EventName would be more descriptive. Then the json files could eliminate the "BriefDescription" and just have the EventName with nothing else for each event.  This would further reduce the amount of redundant fields between the specific implementations and the common set.
>>>
>>
>> I did consider it and it could work. But it all depends on whether the "EventName" only is always readable/descriptive enough in the JSON, without requiring the "BriefDescription". The "EventName" can be rather succinct for any arch. And we need to guarantee that the "EventName" is unique.
>>
>> Here's a sample:
>> [
>>     {
>>         "ArchStdEvent": "L1D_CACHE_RD",
>>     },
>>     {
>>         "ArchStdEvent": "L1D_CACHE_WR",
>>     },
>>
>> vs.
>>
>> [
>>     {
>>         "ArchStdEvent": "0x40",
>>         "BriefDescription": "L1D cache access, read"
>>     },
>>     {
>>         "ArchStdEvent": "0x41",
>>         "BriefDescription": "L1D cache access, write"
>>     },
>>
>>
>> Opinion?
>

Hi Will,

> Hi John,
>
> The "ArchStdEvent" version is more concise by avoiding the duplication
> of "BriefDescription" field and possible differences in
> "BriefDescription" due to typos.  Would it make easier for people coding
> up descriptions for specific processors?  It would depend on how the
> documentation is written up.  For the armv8 documentation in "D5.10.3
> Common event numbers" list the event mnemonic in "Table D5-8 PMU common
> architectural and microarchitectural event numbers" so just using the
> event names seems like it would be pretty clear.

Fine. ***If anyone disagrees on this then please say so.***

For different Intel
> ia64 microarchitecture implementations there are different event coding
> to implement the same event name.  Not sure how would handle the
> universe of different families of ia64 processor implementations.

I think for this example, if we were to use the "EventName" as the 
matching field, then it may be still possible to support by overriding 
the "EventCode" in the platform JSON.

The support in this patchset allows fields to be overriden; the 
following is a sample of how it would look:
{
     "ArchStdEvent": "L1D_CACHE_RD", // Arch EventCode 0x40
     "EventCode": "0x123456"   // override the eventcode
},

>
> Is the armv8-common.json being used as a template that fills out the
> fields of the json elements that match up an entry in the
> armv8-common.json? Or does it only use the information from the
> armv8-common.json.  If the code treated the armv8-common.json as default
> values, then if something differs in the architecture specific entry it
> could overwrite the default value from the template.

Yes, this is supported. By default, the values in template 
armv8-common.json are used (I called it armv8-recommended.json); 
however, any fields defined in the platform JSON for a matching event 
are prioritized, as above.

>
> -Will Cohen

Thanks,
John

>
>
> .
>
> .
>
