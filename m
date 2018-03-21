Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeCURMK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:12:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:36826 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751853AbeCURMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:12:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="213620505"
Subject: Re: [PATCH v1 2/3] perf report: extend raw dump (-D) out with switch
 out event type
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
 <86313484-3601-b218-48b8-1f54843e52de@linux.intel.com>
 <20180321164148.GC2707@krava>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <661ea703-4090-35ae-43f8-56c64ed67bb1@linux.intel.com>
Date: Wed, 21 Mar 2018 20:12:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321164148.GC2707@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2018 19:41, Jiri Olsa wrote:
> On Tue, Mar 20, 2018 at 04:05:17PM +0300, Alexey Budankov wrote:
>> Print additional 'yield' tag for PERF_RECORD_SWITCH[_CPU_WIDE] OUT records when
>> event header misc field contains PERF_RECORD_MISC_SWITCH_OUT_YIELD bit set 
>> designating synchronization context switch out event:
>>
>> perf report -D -i system-wide.perf: 
>>
>> 0x1b9c50 [0x30]: event: 15
>> .
>> . ... raw event: size 48 bytes
>> .  0000:  0f 00 00 00 00 20 30 00 01 1e 00 00 01 1e 00 00  ..... 0.........
>> .  0010:  00 00 00 00 00 00 00 00 85 ae d4 e3 3e 0e 00 00  ............>...
>> .  0020:  54 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00  T...............
>>
>> 5 15663273127557 0x1b9c50 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT  next pid/tid:  7681/7681 
>>
>> 0x2646c0 [0x30]: event: 15
>> .
>> . ... raw event: size 48 bytes
>> .  0000:  0f 00 00 00 00 60 30 00 00 00 00 00 00 00 00 00  .....`0.........
>> .  0010:  00 1e 00 00 00 1e 00 00 29 1e d5 e3 3e 0e 00 00  ........)...>...
>> .  0020:  56 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  V...............
>>
>> 7 15663273156137 0x2646c0 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/event.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index f0a6cbd033cc..af5a85d56446 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
>>  size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
>>  {
>>  	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
>> -	const char *in_out = out ? "OUT" : "IN ";
>> +	const char *in_out = !out ? "IN " :
>> +		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_YIELD) ?
>> +				"OUT" : "OUT yield";
> 
> I'm getting:
> 
>        rcu_sched     9 [004] Sy     1303.392349: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
>          swapper     0 [004]        1303.392350: PERF_RECORD_SWITCH_CPU_WIDE IN   prev pid/tid:     9/9
> 
> could you plase format the 'OUT yield' line so the rest of the
> fields are in line with 'IN' and 'OUT' lines like:
> 
>        rcu_sched     9 [004] Sy     1303.392349: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0
>          swapper     0 [004]        1303.392350: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid:     9/9

Yes, let me take care of that.

Thanks,
Alexey

> 
> thanks,
> jirka
> 
