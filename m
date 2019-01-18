Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A36C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4D20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfARBPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:15:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3952 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726188AbfARBPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:15:46 -0500
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="52257746"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Jan 2019 09:15:42 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A9F084BAD9D7;
        Fri, 18 Jan 2019 09:15:40 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 18 Jan 2019 09:15:39 +0800
Date:   Fri, 18 Jan 2019 09:14:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190118011445.GK30900@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <20190116110158.GC15409@zn.tnic>
 <20190117032027.GA31097@localhost.localdomain>
 <20190117152751.GD5023@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190117152751.GD5023@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A9F084BAD9D7.ADEE2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 04:27:51PM +0100, Borislav Petkov wrote:
>On Thu, Jan 17, 2019 at 11:20:27AM +0800, Chao Fan wrote:
>> I have changed as you suggested, looks clear without type cast, and
>> we need some variable as long to calculate the address, and at same
>> time as the struct pointer to find it's length, so I change as below,
>> and get_acpi_srat_table() return an unsigned long.
>> How do you think of that.
>> 
>> int get_immovable_mem_num(void)
>
>I'd call that
>
>int count_immovable_mem_regions(void)
>
>or
>
>int enumerate_immovable_regions(void)
>
>or so and put a comment above it explaining what it does and what it
>returns.
>
>"mem_num" is not clear what it is.
>

Sounds good, I will rename it.

>> {
>>         unsigned long table_addr, table_end, table;
>>         struct acpi_table_header *table_header;
>>         struct acpi_subtable_header *sub_table;
>>         char arg[MAX_ACPI_ARG_LENGTH];
>>         int num = 0;
>> 
>>         if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>>             !strncmp(arg, "off", 3))
>>                 return;
>> 
>>         table_addr = get_acpi_srat_table();
>>         if (!table_addr)
>>                 return;
>> 
>>         table_header = (struct acpi_table_header *)table_addr;
>>         table_end = table_addr + table_header->length;
>>         table = table_addr + sizeof(struct acpi_table_srat);
>> 
>>         while (table + sizeof(struct acpi_subtable_header) < table_end) {
>>                 sub_table = (struct acpi_subtable_header *)table;
>>                 if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>>                         struct acpi_srat_mem_affinity *ma;
>> 
>>                         ma = (struct acpi_srat_mem_affinity *)table;
>>                         if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>>                                 immovable_mem[num].start = ma->base_address;
>>                                 immovable_mem[num].size = ma->length;
>>                                 num++;
>>                         }
>> 
>>                         if (num >= MAX_NUMNODES*2) {
>>                                 debug_putstr("Too many immovable memory regions, aborting.\n");
>>                                 return 0;
>>                         }
>>                 }
>>                 table += sub_table->length;
>>         }
>>         return num;
>> }
>
>That looks clean.

Then I will change based on that.

Thanks,
Chao Fan

>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


