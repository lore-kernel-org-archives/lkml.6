Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeEKLRJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:17:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:31424 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbeEKLRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:17:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="57786138"
Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for x86_64
 KPTI entry trampolines
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
 <20180509170717.GI13491@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C13DE9E@IRSMSX106.ger.corp.intel.com>
 <20180510201542.GD4311@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b34d2556-10d1-4de9-caa6-700dd850d8e5@intel.com>
Date: Fri, 11 May 2018 14:15:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510201542.GD4311@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/18 23:15, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 10, 2018 at 07:08:37PM +0000, Hunter, Adrian escreveu:
>>> -----Original Message-----
>>> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>>> Sent: Wednesday, May 9, 2018 8:07 PM
>>> To: Hunter, Adrian <adrian.hunter@intel.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
>>> <mingo@redhat.com>; Peter Zijlstra <peterz@infradead.org>; Andy
>>> Lutomirski <luto@kernel.org>; H. Peter Anvin <hpa@zytor.com>; Andi Kleen
>>> <ak@linux.intel.com>; Alexander Shishkin
>>> <alexander.shishkin@linux.intel.com>; Dave Hansen
>>> <dave.hansen@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; Jiri Olsa
>>> <jolsa@redhat.com>; linux-kernel@vger.kernel.org; x86@kernel.org
>>> Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for
>>> x86_64 KPTI entry trampolines
>>>
>>> Em Wed, May 09, 2018 at 02:43:36PM +0300, Adrian Hunter escreveu:
>>>> On x86_64 the KPTI entry trampolines are not in the kernel map created
>>>> by perf tools. That results in the addresses having no symbols and
>>>> prevents annotation. It also causes Intel PT to have decoding errors
>>>> at the trampoline addresses. Workaround that by creating maps for the
>>> trampolines.
>>>> At present the kernel does not export information revealing where the
>>>> trampolines are. Until that happens, the addresses are hardcoded.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  tools/perf/util/machine.c | 104
>>> ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  tools/perf/util/machine.h |   3 ++
>>>>  tools/perf/util/symbol.c  |  12 +++---
>>>>  3 files changed, 114 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>>> index 22047ff3cf2a..1bf15aa0b099 100644
>>>> --- a/tools/perf/util/machine.c
>>>> +++ b/tools/perf/util/machine.c
>>>> @@ -851,6 +851,110 @@ static int
>>> machine__get_running_kernel_start(struct machine *machine,
>>>>  	return 0;
>>>>  }
>>>>
>>>> +struct special_kernal_map {
>>>
>>> s/kernal/kernel/
>>>
>>> And "special"?
>>
>> I have added comment:
>>
>> /* Kernel-space maps that are not the main kernel map nor a module map */
> 
> Perhaps:
> 
>   /* Kernel-space maps for symbols that are outside the main kernel map and module maps */
> 
>   struct extra_kernel_map;
> 
> What do you think?

I have done the re-naming and comment change and pushed the changes to the
same branch.
