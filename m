Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B0DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487DF208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487DF208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeHBFpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:45:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20160 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725785AbeHBFpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:45:36 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42967166"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Aug 2018 11:56:27 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 9A7A84B66A09;
        Thu,  2 Aug 2018 11:56:23 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 2 Aug 2018 11:56:27 +0800
Date:   Thu, 2 Aug 2018 11:54:14 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Dou Liyang <douly.fnst@cn.fujitsu.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180802035413.GC6723@localhost.localdomain>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-4-fanc.fnst@cn.fujitsu.com>
 <18d27595-43d8-d2a0-bfdf-bd731b77d1b9@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18d27595-43d8-d2a0-bfdf-bd731b77d1b9@cn.fujitsu.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 9A7A84B66A09.AB66E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:47:13AM +0800, Dou Liyang wrote:
>Hi Fan,
>
>At 07/23/2018 05:29 PM, Chao Fan wrote:
>> If 'CONFIG_MEMORY_HOTREMOVE' specified, walk the acpi srat memory
>> tables, store the immovable memory regions, so that kaslr can get
>> the information abouth where can be selected or not.
>> If 'CONFIG_MEMORY_HOTREMOVE' not specified, go on the old code.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>   arch/x86/boot/compressed/kaslr.c | 55 ++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>> index 531c9876f573..4705682caf1f 100644
>> --- a/arch/x86/boot/compressed/kaslr.c
>> +++ b/arch/x86/boot/compressed/kaslr.c
>> @@ -31,6 +31,7 @@
>>   #include "misc.h"
>>   #include "error.h"
>> +#include "acpitb.h"
>>   #include "../string.h"
>>   #include <generated/compile.h>
>> @@ -104,6 +105,14 @@ static bool memmap_too_large;
>>   /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>>   unsigned long long mem_limit = ULLONG_MAX;
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +/* Store the immovable memory regions */
>> +struct mem_vector immovable_mem[];
>> +
>> +/* Store the amount of immovable memory regions */
>> +static int num_immovable_mem;
>> +#endif
>> +
>>   enum mem_avoid_index {
>>   	MEM_AVOID_ZO_RANGE = 0,
>> @@ -298,6 +307,47 @@ static int handle_mem_options(void)
>>   	return 0;
>>   }
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +/*
>> + * According to ACPI table, filter the immvoable memory regions
>> + * and store them in immovable_mem[].
>> + */
>> +static void handle_immovable_mem(void)
>> +{
>> +	struct acpi_table_header *table_header;
>> +	struct acpi_subtable_header *table;
>> +	struct acpi_srat_mem_affinity *ma;
>> +	unsigned long table_size;
>> +	unsigned long table_end;
>> +	int i = 0;
>> +
>> +	table_header = get_acpi_srat_table();
>> +
>> +	if (!table_header)
>> +		return;
>> +
>> +	table_end = (unsigned long)table_header + table_header->length;
>> +
>> +	table = (struct acpi_subtable_header *)
>> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
>> +
>> +	table_size = sizeof(struct acpi_subtable_header);
>
>table_size isn't used, can be remove.
>

Thank you very much, will update in next version.

Thanks,
Chao Fan

>> +	while (((unsigned long)table) + table->length < table_end) {
>> +		if (table->type == 1) {
>> +			ma = (struct acpi_srat_mem_affinity *)table;
>> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>> +				immovable_mem[i].start = ma->base_address;
>> +				immovable_mem[i].size = ma->length;
>> +				i++;
>
>need a check(i < MAX_NUMNODES*2) before doing that in case of
>__IndexOutOfBoundsException__ even if it may be impossible in ACPI.
>
>Thanks,
>	dou
>> +			}
>> +		}
>> +		table = (struct acpi_subtable_header *)
>> +			((unsigned long)table + table->length);
>> +	}
>> +	num_immovable_mem = i;
>> +}
>> +#endif
>> +
>>   /*
>>    * In theory, KASLR can put the kernel anywhere in the range of [16M, 64T).
>>    * The mem_avoid array is used to store the ranges that need to be avoided
>> @@ -421,6 +471,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>>   	/* Mark the memmap regions we need to avoid */
>>   	handle_mem_options();
>> +#ifdef CONFIG_MEMORY_HOTREMOVE
>> +	/* Mark the immovable regions we need to choose */
>> +	handle_immovable_mem();
>> +#endif
>> +
>>   #ifdef CONFIG_X86_VERBOSE_BOOTUP
>>   	/* Make sure video RAM can be used. */
>>   	add_identity_map(0, PMD_SIZE);
>> 


