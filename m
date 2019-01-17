Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA05620675
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAQB04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:26:56 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46864 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbfAQB0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:26:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="52179438"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jan 2019 09:26:53 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 6EB274BAD9C3;
        Thu, 17 Jan 2019 09:26:53 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 17 Jan 2019 09:27:00 +0800
Date:   Thu, 17 Jan 2019 09:25:58 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 6/6] x86/boot/KASLR: Limit KASLR to extracting kernel
 in immovable memory
Message-ID: <20190117012558.GE30900@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-7-fanc.fnst@cn.fujitsu.com>
 <20190116111507.GD15409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190116111507.GD15409@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 6EB274BAD9C3.AD736
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:15:07PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:43AM +0800, Chao Fan wrote:
>> KASLR may randomly choose some positions which are located in movable
>> memory regions. It will break memory hotplug feature and make the
>> movable memory chosen by KASLR can't be removed.
>> 
>> The solution is to limit KASLR to choose memory regions in immovable
>> node according to SRAT tables.
>> When CONFIG_EARLY_SRAT_PARSE is enabled, walk through SRAT to get the
>> information of immovable memory so that KASLR knows where should be
>> chosen for randomization.
>> 
>> Rename process_mem_region() as __process_mem_region() and name new
>> function as process_mem_region().
>
>The commit message doesn't need to contain *what* you're doing in the
>patch.
>

Will drop it.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/kaslr.c | 79 +++++++++++++++++++++++++++-----
>>  1 file changed, 68 insertions(+), 11 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index b251572e77af..7dbec6910203 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -97,6 +97,15 @@ static bool memmap_too_large;
>>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>>  static unsigned long long mem_limit = ULLONG_MAX;
>>  
>> +#ifdef CONFIG_EARLY_SRAT_PARSE
>> +/*
>> + * Information of immovable memory regions.
>> + * Max amount of memory regions is MAX_NUMNODES*2, so need such array
>> + * to place immovable memory regions if all of the memory is immovable.
>> + */
>
>Why is that comment repeated here?
>

Will drop it.
>> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
>> +#endif
>> +
>>  
>>  enum mem_avoid_index {
>>  	MEM_AVOID_ZO_RANGE = 0,
>> @@ -413,6 +422,9 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>>  	/* Mark the memmap regions we need to avoid */
>>  	handle_mem_options();
>>  
>> +	/* Mark the immovable regions we need to choose */
>> +	get_immovable_mem();
>
>get != mark.
>
>Which should tell you that the function name needs changing.
>
>Also, this function is void and it could very well return
>num_immovable_mem and num_immovable_mem can be a static variable in
>kaslr.c instead of sloppily adding yet another global one.

Will make num_immovable_mem returned, and how do you think change
the function name as "get_immovable_mem_num()" since the function
will return num_immovable_mem.
>
>> +
>>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>>  	/* Make sure video RAM can be used. */
>>  	add_identity_map(0, PMD_SIZE);
>> @@ -568,9 +580,9 @@ static unsigned long slots_fetch_random(void)
>>  	return 0;
>>  }
>>  
>> -static void process_mem_region(struct mem_vector *entry,
>> -			       unsigned long minimum,
>> -			       unsigned long image_size)
>> +static void __process_mem_region(struct mem_vector *entry,
>> +				 unsigned long minimum,
>> +				 unsigned long image_size)
>>  {
>>  	struct mem_vector region, overlap;
>>  	unsigned long start_orig, end;
>> @@ -646,6 +658,57 @@ static void process_mem_region(struct mem_vector *entry,
>>  	}
>>  }
>>  
>> +static bool process_mem_region(struct mem_vector *region,
>> +			       unsigned long long minimum,
>> +			       unsigned long long image_size)
>> +{
>> +	int i;
>> +	/*
>> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
>> +	 * walk all the regions, so use region directly.
>> +	 */
>> +	if (!num_immovable_mem) {
>> +		__process_mem_region(region, minimum, image_size);
>> +
>> +		if (slot_area_index == MAX_SLOT_AREA) {
>> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>> +			return 1;
>> +		}
>> +		return 0;
>> +	}
>> +
>> +#ifdef CONFIG_EARLY_SRAT_PARSE
>> +	/*
>> +	 * If immovable memory found, filter the intersection between
>> +	 * immovable memory and region to __process_mem_region().
>> +	 * Otherwise, go on old code.
>> +	 */
>> +	for (i = 0; i < num_immovable_mem; i++) {
>> +		unsigned long long start, end, entry_end, region_end;
>> +		struct mem_vector entry;
>> +
>> +		if (!mem_overlaps(region, &immovable_mem[i]))
>> +			continue;
>> +
>> +		start = immovable_mem[i].start;
>> +		end = start + immovable_mem[i].size;
>> +		region_end = region->start + region->size;
>> +
>> +		entry.start = clamp(region->start, start, end);
>> +		entry_end = clamp(region_end, start, end);
>> +		entry.size = entry_end - entry.start;
>> +
>> +		__process_mem_region(&entry, minimum, image_size);
>> +
>> +		if (slot_area_index == MAX_SLOT_AREA) {
>> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>
>Change this error message a bit to differ from the above for easier debugging.

Will change it.

Thanks,
Chao Fan

>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


