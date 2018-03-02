Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934728AbeCBXio (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:38:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934410AbeCBXin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:38:43 -0500
Subject: Re: [PATCH v2 00/11] perf events patches for improved ARM64 support
To: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        ak@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org,
        Jayachandran.Nair@cavium.com
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <20180227095028.GG21033@krava>
 <6250a69e-71ab-5119-cc3f-7e2661aa8c0b@huawei.com>
 <cafdb160-3072-389b-8c31-93f09eff84a8@redhat.com>
 <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
From: William Cohen <wcohen@redhat.com>
Message-ID: <8f72afe5-8620-bdd3-3a54-87a22f77c3d4@redhat.com>
Date: Fri, 2 Mar 2018 18:38:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKTKpr5FfPWhQsTFjih+dfGXdKqL9-+PMoAPs_d9j5hje7OjVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 11:35 AM, Ganapatrao Kulkarni wrote:
> Hi John,
> 
> On Fri, Mar 2, 2018 at 9:35 PM, William Cohen <wcohen@redhat.com> wrote:
>> On 03/02/2018 03:24 AM, John Garry wrote:
>>> On 27/02/2018 09:50, Jiri Olsa wrote:
>>>> On Sat, Feb 24, 2018 at 12:05:21AM +0800, John Garry wrote:
>>>>> This patchset adds support for some perf events features,
>>>>> targeted at ARM64, implemented in a generic fashion.
>>>>>
>>>>> The two main features are as follows:
>>>>> - support for arch/vendor/platform pmu events directory structure
>>>>>    - to support this, topic subdirectory support needs to be dropped
>>>>> - support for parsing standard architecture pmu events
>>>>>
>>>>> On the back of these, the Cavium ThunderX2, ARM Cortex-A53,
>>>>> and HiSilicon hip08 JSONs are relocated/added/updated.
>>>>>
>>>>> In addition, there is a patch to drop mutli-mapfile.csv support and
>>>>> also a bugfix in jevents.c for an error code value.
>>>>>
>>>>> Differences to v1:
>>>>> - Address coding issues from Jiri Olsa in adding arch std event
>>>>>    support (https://lkml.org/lkml/2018/2/6/501)
>>>>> - add patch to drop topic subdirectory support
>>>>> - add patch for bug fix in json_events()
>>>>> - add review tags from Jiri Olsa
>>>>
>>>> can't tell if those json file changes are ok, but for all the code changes:
>>>>
>>>
>>> Hi William, Ganapatrao,
>>>
>>> Can you check the modifications to the ARM64 JSONs you originally submitted in the patchset please?>
>>> If they are not checked, I'll have to see if the maintainers will accept without your review. If not, I'll have to drop them.
> 
> I am seeing issue(log below) with this patchset on our platfrom.
> i have tried using your v2 branch [1]
> 
> root@borg-1>perf_acme>> ./perf --version
> perf version 4.16.rc1.g087f7ca
> root@borg-1>perf_acme>> ./perf stat -e bus_access_rd sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>             23,099      bus_access_rd
> 
>        1.000708516 seconds time elapsed
> 
> root@borg-1>perf_acme>> cd -
> /ganapat/perf/linux-hisi/tools/perf
> root@borg-1>perf>> ./perf --version
> perf version 4.16.rc1.gcb5a74
> root@borg-1>perf>> ./perf stat -e bus_access_rd sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>                  0      bus_access_rd
> 
>        1.000709162 seconds time elapsed
> 
> root@borg-1>perf>>
> 
> 
> [1] https://github.com/hisilicon/linux-hisi.git
> 
Hi,

I took a slightly different tack and compared the output of "perf list --details" to see if the event numbers numbers were the same.  For the common events borrowed from the armv8-recommended.json all the events are 0 for the cortex a53.  That would explain why the bus_access_rd above were counts were different if it was counting the SW_INCR event instead of bus_access_rd.

Why not key the matching of common events off the "EventName" rather than "EventCode"? The EventName would be more descriptive. Then the json files could eliminate the "BriefDescription" and just have the EventName with nothing else for each event.  This would further reduce the amount of redundant fields between the specific implementations and the common set.

-Will
