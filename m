Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeENNDw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:03:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:15755 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeENNDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:03:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="199203450"
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
 <20180510201542.GD4311@kernel.org> <20180510201922.GE4311@kernel.org>
 <20180510204700.GF4311@kernel.org>
 <291c0615-2b5c-0076-faeb-720df9ab5c84@intel.com>
 <20180511144526.GQ13491@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b698fcd5-be86-4c94-3af5-f23b49203c4e@intel.com>
Date: Mon, 14 May 2018 16:02:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511144526.GQ13491@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 17:45, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 11, 2018 at 02:18:01PM +0300, Adrian Hunter escreveu:
>> On 10/05/18 23:47, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, May 10, 2018 at 05:19:22PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> Em Thu, May 10, 2018 at 05:15:42PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>> Em Thu, May 10, 2018 at 07:08:37PM +0000, Hunter, Adrian escreveu:
>>>>>> Let me know if you want me to post the workaround patches separately,
>>>>>> otherwise I will wait a bit before sending the patches again.
>>>
>>>>> I'll see if I went thru all of the patches already...
>>>  
>>>> So I looked at the patches posted and one comment is about the terse
>>>> commit logs for some of the kcore_copy patches, for instance:
>>>  
>>>> --------------------
>>>>  In preparation to add more program headers, get rid of kernel_map and
>>>> modules_map.
>>>> --------------------
>>>  
>>>> Can't this be made a bit more verbose? Lemme re-read the patch...
>>>
>>> So you had just one pointers to the kernel map and a module_maps, and
>>> then this is replaced by kcore_copy__map() that instead of populating
>>> those fields that are being removed:
>>>
>>> -       struct phdr_data kernel_map;
>>> -       struct phdr_data modules_map;
>>>
>>> Will allocate and add "struct phdr_data" instances to the
>>> kcore_copy_info->phdrs list, so I propose, to follow convention used
>>> elsewhere in tools/perf/ that you rename kcore_copy__map() to
>>>
>>>   kcore_copy_info__addnew(kci, fields)
>>>
>>> I would do it as:
>>>
>>> struct phdr_data *phdr_data__new(fields)
>>> {
>>> 	return  zalloc() + init fields;
>>> }
>>>
>>> struct phdr_data *kcore_copy_info__addnew(kci, fields)
>>> {
>>> 	struct phdr_data *pd = phdr_data__new(fields);
>>>
>>> 	if (pd)
>>> 		list_add(&pd->list, &kci->phdrs)
>>> }
>>>
>>> Also please rename pd->list to pd->node, to clarify that it is a node in
>>> some list, not a list.
>>>
>>> The commit log list then could reflect that somehow, with something
>>> around:
>>>
>>> ----------------------
>>>
>>> Move ->kernel_map and ->modules_map to newly allocated entries in the
>>> ->phdrs list.
>>>
>>> ----------------------
>>>
>>> wdyt?
>>
>> I have done the changes but still have kcore_copy__map() calling
>> kcore_copy_info__addnew().  The changes have been pushed to the same branch.
> 
> Thanks! I'll process a perf/urgent round and then go over your updated
> tree to get it tested on a skylake machine and merged to perf/core,

I changed some terminology 'x86_64 KPTI' -> 'x86 PTI' as requested by Ingo,
and pushed to a new branch perf-tools-kpti-v0.

	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v0
