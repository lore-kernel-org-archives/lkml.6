Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEPLiX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:38:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:14860 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752377AbeEPLiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:38:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="199815413"
Subject: Re: [PATCH V1 10/19] perf tools: Create maps for x86 PTI entry
 trampolines
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
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
 <1526388213-30696-11-git-send-email-adrian.hunter@intel.com>
 <20180516110656.GB25591@krava>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <29315e2d-a7cb-7c4e-5933-ce7b531b130b@intel.com>
Date: Wed, 16 May 2018 14:37:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516110656.GB25591@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/18 14:06, Jiri Olsa wrote:
> On Tue, May 15, 2018 at 03:43:24PM +0300, Adrian Hunter wrote:
> 
> SNIP
> 
>> +int machine__create_extra_kernel_map(struct machine *machine,
>> +				     struct dso *kernel,
>> +				     struct extra_kernel_map *xm)
>>  {
>>  	struct kmap *kmap;
>>  	struct map *map;
>> @@ -923,9 +915,33 @@ static u64 find_entry_trampoline(struct dso *dso)
>>  int machine__map_x86_64_entry_trampolines(struct machine *machine,
>>  					  struct dso *kernel)
>>  {
>> -	u64 pgoff = find_entry_trampoline(kernel);
>> +	struct map_groups *kmaps = &machine->kmaps;
>> +	struct maps *maps = &kmaps->maps;
>>  	int nr_cpus_avail = 0, cpu;
>> +	bool found = false;
>> +	struct map *map;
>> +	u64 pgoff;
>> +
>> +	/*
>> +	 * In the vmlinux case, pgoff is a virtual address which must now be
>> +	 * mapped to a vmlinux offset.
>> +	 */
>> +	for (map = maps__first(maps); map; map = map__next(map)) {
>> +		struct kmap *kmap = __map__kmap(map);
>> +		struct map *dest_map;
>> +
>> +		if (!kmap || !is_entry_trampoline(kmap->name))
>> +			continue;
>> +
>> +		dest_map = map_groups__find(kmaps, map->pgoff);
>> +		if (dest_map != map)
>> +			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
>> +		found = true;
> 
> hum, could you please explain/comment on above? the purpose of pgoff for these maps
> 
> all the trampoline maps seems to have the same pgoff at the end..
> 
> 0 0x158 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000006000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x1b0 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000032000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x208 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000005e000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x260 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000008a000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x2b8 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00000b6000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x310 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00000e2000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x368 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000010e000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x3c0 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000013a000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x418 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000166000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x470 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000192000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x4c8 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00001be000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x520 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00001ea000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x578 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000216000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x5d0 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000242000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x628 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000026e000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x680 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000029a000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x6d8 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00002c6000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x730 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00002f2000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x788 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000031e000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x7e0 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe000034a000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x838 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe0000376000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x890 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00003a2000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x8e8 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00003ce000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline
> 0 0x940 [0x58]: PERF_RECORD_MMAP -1/0: [0xfffffe00003fa000(0x1000) @ 0xffffffff8fc02000]: x __entry_SYSCALL_64_trampoline

The trampolines all map to the same page.  Since that page is also in the
kernel text, its virtual address (0xffffffff8fc02000 in your case) is also
recorded.  Then to find the offset in vmlinux,
machine__map_x86_64_entry_trampolines() can map that virtual address.
