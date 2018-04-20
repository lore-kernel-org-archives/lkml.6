Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755203AbeDTNxr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:53:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60754 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754872AbeDTNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:53:44 -0400
Subject: Re: s390 perf events JSONs query
To: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        <brueckner@linux.vnet.ibm.com>, <tmricht@linux.vnet.ibm.com>
References: <68e84967-ca29-0b86-027a-76307e003a55@huawei.com>
 <c5dde055-de48-52c1-04d7-7ec22623d75f@linux.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, "Namhyung Kim" <namhyung@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c5c99152-4823-2f21-1b98-2a271637bed4@huawei.com>
Date: Fri, 20 Apr 2018 14:53:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <c5dde055-de48-52c1-04d7-7ec22623d75f@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2018 14:25, Thomas-Mich Richter wrote:
> On 04/20/2018 12:51 PM, John Garry wrote:
>> Hi Hendrik, Thomas,
>>
>> I noticed that in 4.17-rc1 support was included for s390 perf pmu-events. I also notice that the JSONs contain many common (identical actually) events between different chips for this arch.
>>
>> Support was added for factoring out common arch events in https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/tools/perf/pmu-events?h=next-20180420&id=e9d32c1bf0cd7a98358ec4aa1625bf2b3459b9ac
>>
>> ARM64 chips use this feature. I am not familiar with the s390 arch, but do you think you could also use this feature?
>>
>> Thanks,
>> John
>>
>
> I have just played with this feature. I was caught off by this error message:
>
> [root@s35lp76 pmu-events]# ./jevents s390 arch /tmp/xxx 100000
> d 0    4096 s390                 arch/s390
> d 1    4096 cf_z14               arch/s390/cf_z14
> f 2    1338 basic.json           arch/s390/cf_z14/basic.json
> ....
> jevents: Ignoring file arch/s390/archevent.json  <---- confusing error message

Let me check if this can be silenced.

>
> jevents: Processing mapfile arch/s390/mapfile.csv
> [root@s35lp76 pmu-events]#
>
> I started debugging, until I realized this file is still processed.....
> (Just a side remark).
>
> Anyway the features is nice, but it does not save anything in the resulting
> pmu-events.c file, correct? The events defined in the common archevent.json
> files are just copied into the structures of a specific machine.
>

Yes, the resulting derived pmu-events.c should be the same. In fact, if 
there was naming inconsistencies in JSONs previously, they should now be 
gone.

> The feature saves time and space when you create the machine specific json
> files because it allows you to refer to a common event by name. Cool!
>
> On s390 we do not create the json files manually, but have some scripts to
> create them based on s390 type/model hardware specific input files.

Right, I would say that this is mostly useful when the JSONs are created 
manually, which was the case in the ARM world, but not x86. I didn't 
know about s390.

>
> @Hendirk,
> we could rework our internal tool chain to emit the new "ArchStdEvent"
> keyword for common events, but in the end we do not save anything in the
> resulting pmu-events.c file. And it requires considerable rework to
> support it.
> Given that, I would put it very low priority on your todo list, comments?
>

Cheers,
John
