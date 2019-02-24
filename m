Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 01:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B32920855
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 01:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfBXBln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 20:41:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:14880 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727475AbfBXBln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 20:41:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2019 17:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,405,1544515200"; 
   d="scan'208";a="120291651"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2019 17:41:40 -0800
Subject: Re: [PATCH v12 3/3] Documentation/filesystems/proc.txt: add
 AVX512_elapsed_ms
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org
References: <20190221011741.97070-1-aubrey.li@linux.intel.com>
 <20190221011741.97070-3-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1902231849400.1666@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d38b5679-1f07-7b94-51ca-cb9b60db8b6f@linux.intel.com>
Date:   Sun, 24 Feb 2019 09:41:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231849400.1666@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/24 2:16, Thomas Gleixner wrote:
> On Thu, 21 Feb 2019, Aubrey Li wrote:
>> @@ -45,6 +45,7 @@ Table of Contents
>>    3.9   /proc/<pid>/map_files - Information about memory mapped files
>>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
>>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>> +  3.12	/proc/<pid>/AVX512_elapsed_ms - time elapsed since last AVX512 use
> 
> So is this a separate file now?
>   
>> +3.12	/proc/<pid>/AVX512_elapsed_ms - time elapsed since last AVX512 use
>> +--------------------------------------------------------------------------
>> +If AVX512 is supported on the machine, this file displays time elapsed since
> 
> This is not a file and this documentation wants to be where the status file
> is described.
> 
>> +last AVX512 usage of the task in millisecond.
> 
> Since last usage is misleading. What you want to say is:
> 
>   The entry shows the milliseconds elapsed since the last time AVX512 usage
>   was recorded.
> 
>> +The per-task AVX512 usage tracking mechanism is added during context switch.
>> +When the task is scheduled out, the AVX512 timestamp of the task is tagged
>> +by jiffies if AVX512 usage is detected.
>> +
>> +When this interface is queried, AVX512_elapsed_ms is calculated as follows:
>> +
>> +	delta = (long)(jiffies_now - AVX512_timestamp);
>> +	AVX512_elpased_ms = jiffies_to_msecs(delta);
> 
> This information is not really helpful for someone who wants to use that
> field.
> 
>> +
>> +Because this tracking mechanism depends on context switch, the number of
>> +AVX512_elapsed_ms could be inaccurate if the AVX512 using task runs alone on
>> +a CPU and not scheduled out for a long time. An extreme experiment shows a
>> +task is spinning on the AVX512 ops on an isolated CPU, but the longest elapsed
>> +time is close to 4 seconds(HZ = 250).
>> +
>> +So 5s or even longer is an appropriate threshold for the job scheduler to poll
>> +and decide if the task should be classifed as an AVX512 task and migrated
>> +away from the core on which a Non-AVX512 task is running.
> 
> 5 seconds or long is appropriate? No. It really depends on the workload and
> the scheduling scenarios. What the documentation has to provide is the
> information that this value is a crystal ball estimate and what the reasons
> are why its inaccurate.
> 
> Something like this instead of this conglomorate of useful, irrelevant and
> misleading information:
> 
>   The AVX512_elapsed_ms entry shows the milliseconds elapsed since the last
>   time AVX512 usage was recorded. The recording happens on a best effort
>   basis when a task is scheduled out. This means that the value depends on
>   two factors:
> 
>     1) The time which the task spent on the CPU without being scheduled
>        out. With CPU isolation and a single runnable task this can take
>        several seconds.
> 
>     2) The time since the task was scheduled out last. Depending on the
>        reason for being scheduled out (time slice exhausted, syscall ...)
>        this can be arbitrary long time.
> 
>   As a consequence the value cannot be considered precise and authoritive
>   information. The application which uses this information has to be aware
>   of the overall scenario on the system in order to determine whether a
>   task is a real AVX512 user or not.
> 
> See? No jiffies, no code snippets, no absolute numbers and no magic
> recommendation which might be correct for your test scenario, but
> completely bogus for some other scenario.
> 
> Instead it contains the things which a application programmer who wants to
> use that value needs to know. He then has to map it to his scenario and
> build the crystal ball logic which makes it perhaps useful.

Thanks a lot, I'll try to refine it again.

Regards,
-Aubrey
