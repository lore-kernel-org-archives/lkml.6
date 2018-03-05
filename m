Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbeCELYq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:24:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40289 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933983AbeCELYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:24:45 -0500
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
To: William Cohen <wcohen@redhat.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>, Jiri Olsa <jolsa@redhat.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
 <cafdb160-3072-389b-8c31-93f09eff84a8@redhat.com>
 <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
 <8f72afe5-8620-bdd3-3a54-87a22f77c3d4@redhat.com>
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
Message-ID: <599637d9-0b78-9edb-d459-515f76aca9fe@huawei.com>
Date: Mon, 5 Mar 2018 11:24:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8f72afe5-8620-bdd3-3a54-87a22f77c3d4@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am seeing issue(log below) with this patchset on our platfrom.
>> i have tried using your v2 branch [1]
>>
>> root@borg-1>perf_acme>> ./perf --version
>> perf version 4.16.rc1.g087f7ca
>> root@borg-1>perf_acme>> ./perf stat -e bus_access_rd sleep 1
>>
>>  Performance counter stats for 'sleep 1':
>>
>>             23,099      bus_access_rd
>>
>>        1.000708516 seconds time elapsed
>>
>> root@borg-1>perf_acme>> cd -
>> /ganapat/perf/linux-hisi/tools/perf
>> root@borg-1>perf>> ./perf --version
>> perf version 4.16.rc1.gcb5a74
>> root@borg-1>perf>> ./perf stat -e bus_access_rd sleep 1
>>
>>  Performance counter stats for 'sleep 1':
>>
>>                  0      bus_access_rd
>>
>>        1.000709162 seconds time elapsed
>>
>> root@borg-1>perf>>
>>
>>
>> [1] https://github.com/hisilicon/linux-hisi.git
>>
> Hi,

Hi Will Cohen, Ganapatrao,

>
> I took a slightly different tack and compared the output of "perf list --details" to see if the event numbers numbers were the same.  For the common events borrowed from the armv8-recommended.json all the events are 0 for the cortex a53.  That would explain why the bus_access_rd above were counts were different if it was counting the SW_INCR event instead of bus_access_rd.
>

Thanks for this. I see the problem. At the end I missed bringing across 
something from v1. Easily fixed.

> Why not key the matching of common events off the "EventName" rather than "EventCode"? The EventName would be more descriptive. Then the json files could eliminate the "BriefDescription" and just have the EventName with nothing else for each event.  This would further reduce the amount of redundant fields between the specific implementations and the common set.
>

I did consider it and it could work. But it all depends on whether the 
"EventName" only is always readable/descriptive enough in the JSON, 
without requiring the "BriefDescription". The "EventName" can be rather 
succinct for any arch. And we need to guarantee that the "EventName" is 
unique.

Here's a sample:
[
     {
         "ArchStdEvent": "L1D_CACHE_RD",
     },
     {
         "ArchStdEvent": "L1D_CACHE_WR",
     },

vs.

[
     {
         "ArchStdEvent": "0x40",
         "BriefDescription": "L1D cache access, read"
     },
     {
         "ArchStdEvent": "0x41",
         "BriefDescription": "L1D cache access, write"
     },


Opinion?

John

> -Will
>
> .
>

thanks,
John
