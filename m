Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeERAPY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 20:15:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:28629 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbeERAPX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 20:15:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="40847196"
Subject: Re: [PATCH v1 2/2] perf annotate: Create hotkey 'c' to show max/min
 cycles
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1526569118-14217-1-git-send-email-yao.jin@linux.intel.com>
 <1526569118-14217-3-git-send-email-yao.jin@linux.intel.com>
 <20180517200610.GA25467@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f3340f4d-8614-ad6a-e8c1-15d0fbda5b01@linux.intel.com>
Date: Fri, 18 May 2018 08:15:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180517200610.GA25467@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2018 4:06 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 17, 2018 at 10:58:38PM +0800, Jin Yao escreveu:
>> In perf annotate view, a new hotkey 'c' is created for
>> showing the max/min cycles.
> 
> I just changed everything from "max/min" to "min/max", as it looked
> strange print the max first, thanks, applying.
> 
> - Arnaldo
>   

Hi Arnaldo,

Thanks for helping to change from "max/min" to "min/max" and thanks for 
applying the patch. Yes, "min/max" looks better.

Thanks
Jin Yao

>> For example, when press 'c', the annotate view is:
>>
>> Percent│ IPC     Cycle(max/min)
>>         │
>>         │
>>         │                             Disassembly of section .text:
>>         │
>>         │                             000000000003aab0 <random@@GLIBC_2.2.5>:
>>    8.22 │3.92                           sub    $0x18,%rsp
>>         │3.92                           mov    $0x1,%esi
>>         │3.92                           xor    %eax,%eax
>>         │3.92                           cmpl   $0x0,argp_program_version_hook@@G
>>         │3.92             1(2/1)      ↓ je     20
>>         │                               lock   cmpxchg %esi,__abort_msg@@GLIBC_P
>>         │                             ↓ jne    29
>>         │                             ↓ jmp    43
>>         │1.10                     20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+
>>    8.93 │1.10             1(5/1)      ↓ je     43
>>
>> When press 'c' again, the annotate view is switched back:
>>
>> Percent│ IPC Cycle
>>         │
>>         │
>>         │                Disassembly of section .text:
>>         │
>>         │                000000000003aab0 <random@@GLIBC_2.2.5>:
>>    8.22 │3.92              sub    $0x18,%rsp
>>         │3.92              mov    $0x1,%esi
>>         │3.92              xor    %eax,%eax
>>         │3.92              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x
>>         │3.92     1      ↓ je     20
>>         │                  lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
>>         │                ↓ jne    29
>>         │                ↓ jmp    43
>>         │1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
>>    8.93 │1.10     1      ↓ je     43
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/ui/browsers/annotate.c |  8 ++++++++
>>   tools/perf/util/annotate.c        | 37 +++++++++++++++++++++++++++++++------
>>   tools/perf/util/annotate.h        |  7 ++++++-
>>   3 files changed, 45 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index 3781d74..f202a3f 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -695,6 +695,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   		"O             Bump offset level (jump targets -> +call -> all -> cycle thru)\n"
>>   		"s             Toggle source code view\n"
>>   		"t             Circulate percent, total period, samples view\n"
>> +		"c             Show max/min cycle\n"
>>   		"/             Search string\n"
>>   		"k             Toggle line numbers\n"
>>   		"P             Print to [symbol_name].annotation file.\n"
>> @@ -791,6 +792,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   				notes->options->show_total_period = true;
>>   			annotation__update_column_widths(notes);
>>   			continue;
>> +		case 'c':
>> +			if (notes->options->show_maxmin_cycle)
>> +				notes->options->show_maxmin_cycle = false;
>> +			else
>> +				notes->options->show_maxmin_cycle = true;
>> +			annotation__update_column_widths(notes);
>> +			continue;
>>   		case K_LEFT:
>>   		case K_ESC:
>>   		case 'q':
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 934a172..17fff6f 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2495,13 +2495,38 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>>   		else
>>   			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
>>   
>> -		if (al->cycles)
>> -			obj__printf(obj, "%*" PRIu64 " ",
>> +		if (!notes->options->show_maxmin_cycle) {
>> +			if (al->cycles)
>> +				obj__printf(obj, "%*" PRIu64 " ",
>>   					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
>> -		else if (!show_title)
>> -			obj__printf(obj, "%*s", ANNOTATION__CYCLES_WIDTH, " ");
>> -		else
>> -			obj__printf(obj, "%*s ", ANNOTATION__CYCLES_WIDTH - 1, "Cycle");
>> +			else if (!show_title)
>> +				obj__printf(obj, "%*s",
>> +					    ANNOTATION__CYCLES_WIDTH, " ");
>> +			else
>> +				obj__printf(obj, "%*s ",
>> +					    ANNOTATION__CYCLES_WIDTH - 1,
>> +					    "Cycle");
>> +		} else {
>> +			if (al->cycles) {
>> +				char str[32];
>> +
>> +				scnprintf(str, sizeof(str),
>> +					"%" PRIu64 "(%" PRIu64 "/%" PRIu64 ")",
>> +					al->cycles, al->cycles_max,
>> +					al->cycles_min);
>> +
>> +				obj__printf(obj, "%*s ",
>> +					    ANNOTATION__MAXMIN_CYCLES_WIDTH - 1,
>> +					    str);
>> +			} else if (!show_title)
>> +				obj__printf(obj, "%*s",
>> +					    ANNOTATION__MAXMIN_CYCLES_WIDTH,
>> +					    " ");
>> +			else
>> +				obj__printf(obj, "%*s ",
>> +					    ANNOTATION__MAXMIN_CYCLES_WIDTH - 1,
>> +					    "Cycle(max/min)");
>> +		}
>>   	}
>>   
>>   	obj__printf(obj, " ");
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index d50363d..4cafd63 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -61,6 +61,7 @@ bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
>>   
>>   #define ANNOTATION__IPC_WIDTH 6
>>   #define ANNOTATION__CYCLES_WIDTH 6
>> +#define ANNOTATION__MAXMIN_CYCLES_WIDTH 19
>>   
>>   struct annotation_options {
>>   	bool hide_src_code,
>> @@ -69,7 +70,8 @@ struct annotation_options {
>>   	     show_linenr,
>>   	     show_nr_jumps,
>>   	     show_nr_samples,
>> -	     show_total_period;
>> +	     show_total_period,
>> +	     show_maxmin_cycle;
>>   	u8   offset_level;
>>   };
>>   
>> @@ -243,6 +245,9 @@ struct annotation {
>>   
>>   static inline int annotation__cycles_width(struct annotation *notes)
>>   {
>> +	if (notes->have_cycles && notes->options->show_maxmin_cycle)
>> +		return ANNOTATION__IPC_WIDTH + ANNOTATION__MAXMIN_CYCLES_WIDTH;
>> +
>>   	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
>>   }
>>   
>> -- 
>> 2.7.4
