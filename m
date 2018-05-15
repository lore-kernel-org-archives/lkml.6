Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeEOKl1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 06:41:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:16554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752727AbeEOKlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 06:41:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="199489097"
Subject: Re: [PATCH RFC 07/19] perf tools: Workaround missing maps for x86_64
 KPTI entry trampolines
To: Jiri Olsa <jolsa@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-8-git-send-email-adrian.hunter@intel.com>
 <20180515103043.GA7425@krava>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <edb2e6aa-8a99-aa8d-1ff0-a69a9161f170@intel.com>
Date: Tue, 15 May 2018 13:40:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515103043.GA7425@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/18 13:30, Jiri Olsa wrote:
> On Wed, May 09, 2018 at 02:43:36PM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>> +
>> +	for (i = 0; i < ARRAY_SIZE(syms); i++) {
>> +		if (syms[i].addr)
>> +			return syms[i].addr;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * These values can be used for kernels that do not have symbols for the entry
>> + * trampolines in kallsyms.
>> + */
>> +#define X86_64_CPU_ENTRY_AREA_PER_CPU	0xfffffe0000000000ULL
>> +#define X86_64_CPU_ENTRY_AREA_SIZE	0x2c000
>> +#define X86_64_ENTRY_TRAMPOLINE		0x6000
>> +
>> +/* Map x86_64 KPTI entry trampolines */
>> +int machine__map_x86_64_entry_trampolines(struct machine *machine,
>> +					  struct dso *kernel)
>> +{
> 
> would it make sense to put all this under arch/x86/util/machine.c ?

In this case, machine__map_x86_64_entry_trampolines() is specific to the
arch in the perf.data file, not the arch perf is currently running on.
