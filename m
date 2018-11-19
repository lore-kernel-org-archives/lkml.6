Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA552086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA552086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeKSLxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:53:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59902 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725979AbeKSLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:53:31 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="48340336"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Nov 2018 09:31:30 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 959DD4B75BED;
        Mon, 19 Nov 2018 09:31:29 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 09:31:32 +0800
Date:   Mon, 19 Nov 2018 09:31:23 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v11 5/5] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20181119013123.GB2336@localhost.localdomain>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-6-fanc.fnst@cn.fujitsu.com>
 <20181116135039.GE20313@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181116135039.GE20313@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 959DD4B75BED.AF434
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:50:39PM +0100, Borislav Petkov wrote:
> Subject: Re: [PATCH v11 5/5] x86/boot/KASLR: Walk srat tables to filter immovable memory
>
>s/srat/SRAT/g
>
>On Mon, Nov 12, 2018 at 05:46:45PM +0800, Chao Fan wrote:
>> KASLR may randomly chooses some positions which are located in movable
>
>		    choose
>
>> memory regions. This will break memory hotplug feature and make the
>> movable memory chosen by KASLR can't be removed.
>
>			by KASLR practically immovable.

Thanks,

>
>:)
>
>> The solution is limite KASLR to choose memory regions in immovable
>
>limite?
>
>"to limit"
>
>> node according to SRAT tables.
>> 
>> If CONFIG_MEMORY_HOTREMOVE enabled, walk through the SRAT memory
>
>			   *is* enabled,
>
>> tables and store those immovable memory regions so that KASLR can get
>> where to choose for randomization.
>> 
>> If the amount of immovable memory regions is not zero, which
>> means the immovable memory regions existing. Calculate the intersection
>> between memory regions from e820/efi memory table and immovable memory
>> regions.
>
>This is explaining *what* the patch does and generally doesn't need to
>be in the commit messge as people can read it in the patch itself.

OK,

>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/kaslr.c | 77 +++++++++++++++++++++++++++-----
>>  1 file changed, 66 insertions(+), 11 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index b251572e77af..174d2114045e 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -97,6 +97,11 @@ static bool memmap_too_large;
>>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>>  static unsigned long long mem_limit = ULLONG_MAX;
>>  
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +/* Store the immovable memory regions */
>> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
>> +#endif
>
>For this and the other occurrences of ifdef CONFIG_MEMORY_HOTREMOVE,
>define empty stubs for those functions in a header and remove the
>ifdeffery at the call sites.

OK,

>
>> +
>>  
>>  enum mem_avoid_index {
>>  	MEM_AVOID_ZO_RANGE = 0,
>> @@ -413,6 +418,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>>  	/* Mark the memmap regions we need to avoid */
>>  	handle_mem_options();
>>  
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +	/* Mark the immovable regions we need to choose */
>> +	get_immovable_mem();
>> +#endif
>> +
>>  #ifdef CONFIG_X86_VERBOSE_BOOTUP
>>  	/* Make sure video RAM can be used. */
>>  	add_identity_map(0, PMD_SIZE);
>> @@ -568,9 +578,9 @@ static unsigned long slots_fetch_random(void)
>>  	return 0;
>>  }
>>  
>> -static void process_mem_region(struct mem_vector *entry,
>> -			       unsigned long minimum,
>> -			       unsigned long image_size)
>> +static void slots_count(struct mem_vector *entry,
>
>That's a strange rename.
>
I will change it.

Thanks,
Chao Fan

>__process_mem_region() makes more sense to me.
>
>> +			unsigned long minimum,
>> +			unsigned long image_size)
>>  {
>>  	struct mem_vector region, overlap;
>>  	unsigned long start_orig, end;
>> @@ -646,6 +656,57 @@ static void process_mem_region(struct mem_vector *entry,
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
>> +	 * walk all the regions, so use region directely.
>
>"directly"
>
>> +	 */
>> +	if (num_immovable_mem == 0) {
>
>	if (!...
>
>> +		slots_count(region, minimum, image_size);
>> +
>> +		if (slot_area_index == MAX_SLOT_AREA) {
>> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
>> +			return 1;
>> +		}
>> +		return 0;
>> +	}
>> +
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


