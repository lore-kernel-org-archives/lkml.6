Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeC2SCg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:02:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:65461 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752654AbeC2SCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:02:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="41861193"
Subject: Re: [PATCH v4 1/3] perf/core: store context switch out type into Perf
 trace
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <6f4a5d0d-9e1f-d5a1-7719-7547bb688453@linux.intel.com>
 <f8d6833d-2ba3-e7cb-5422-adffb24dd33e@linux.intel.com>
 <20180329154323.mxi3iaaqimtozjoj@lakrids.cambridge.arm.com>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e3f8881e-d688-1597-b87c-ccc034c95958@linux.intel.com>
Date: Thu, 29 Mar 2018 21:02:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329154323.mxi3iaaqimtozjoj@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29.03.2018 18:43, Mark Rutland wrote:
> Hi,
> 
> On Thu, Mar 29, 2018 at 06:02:48PM +0300, Alexey Budankov wrote:
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 912b85b52344..cd6ad7e13824 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -655,6 +655,10 @@ struct perf_event_mmap_page {
>>   * perf_event_attr::precise_ip.
>>   */
>>  #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
>> +/*
>> + * Indicates that thread was preempted in TASK_RUNNING state
>> + */
>> +#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
>>  /*
>>   * Reserve the last bit to indicate some extended misc field
>>   */
> 
> Could you please add a description (in the header) describing why it's safe to
> reuse this bit? i.e. describe which events these are valid for, so it's clear
> they don't overlap.

It is currently employed only on x86 architecture when reporting precise events 
samples with exact bit set in pt_regs->flags. Apparently there is no conflict on 
this bit among different trace records so the message could be like this:

/*
 * These PERF_RECORD_MISC_* flags are safely reused for the following events:
 *
 *   PERF_RECORD_MISC_PRECISE_IP         - PERF_RECORD_SAMPLE of precise events
 *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
 */

Thanks,
Alexey

> 
> For bit 13 we have:
> 
> /*
>  * Following PERF_RECORD_MISC_* are used on different
>  * events, so can reuse the same bit position:
>  *
>  *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
>  *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
>  *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
>  */
> #define PERF_RECORD_MISC_MMAP_DATA              (1 << 13)
> #define PERF_RECORD_MISC_COMM_EXEC              (1 << 13)
> #define PERF_RECORD_MISC_SWITCH_OUT             (1 << 13)
> 
> Thanks,
> Mark.
> 
