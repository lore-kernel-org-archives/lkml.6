Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7754C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7597620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfAQDV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:21:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40675 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727772AbfAQDV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:21:26 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="52187350"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Jan 2019 11:21:24 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A5A624BAD9C2;
        Thu, 17 Jan 2019 11:21:22 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 17 Jan 2019 11:21:29 +0800
Date:   Thu, 17 Jan 2019 11:20:27 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190117032027.GA31097@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <20190116110158.GC15409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190116110158.GC15409@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A5A624BAD9C2.AE99A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 12:01:58PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:42AM +0800, Chao Fan wrote:
>> +void get_immovable_mem(void)
>> +{
>> +	struct acpi_table_header *table_header;
>> +	struct acpi_subtable_header *table;
>> +	struct acpi_srat_mem_affinity *ma;
>> +	char arg[MAX_ACPI_ARG_LENGTH];
>> +	unsigned long table_end;
>> +	int i = 0;
>> +
>> +	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>> +	    !strncmp(arg, "off", 3))
>> +		return;
>> +
>> +	table_header = get_acpi_srat_table();
>> +	if (!table_header)
>> +		return;
>> +
>> +	table_end = (unsigned long)table_header + table_header->length;
>> +	table = (struct acpi_subtable_header *)
>> +		((unsigned long)table_header + sizeof(struct acpi_table_srat));
>> +
>> +	while (((unsigned long)table) +
>> +		       sizeof(struct acpi_subtable_header) < table_end) {
>> +		if (table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>> +			ma = (struct acpi_srat_mem_affinity *)table;
>> +			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>> +				immovable_mem[i].start = ma->base_address;
>> +				immovable_mem[i].size = ma->length;
>> +				i++;
>> +			}
>> +
>> +			if (i >= MAX_NUMNODES*2) {
>> +				debug_putstr("Too many immovable memory regions, aborting.\n");
>> +				return;
>> +			}
>> +		}
>> +		table = (struct acpi_subtable_header *)
>> +			((unsigned long)table + table->length);
>
>That's a lot of unnecessary casting AFAICT. You can return an unsigned
>long from get_acpi_srat_table() and get rid of all that casting here.
>
Hi Boris,

I have changed as you suggested, looks clear without type cast, and
we need some variable as long to calculate the address, and at same
time as the struct pointer to find it's length, so I change as below,
and get_acpi_srat_table() return an unsigned long.
How do you think of that.

int get_immovable_mem_num(void)
{
        unsigned long table_addr, table_end, table;
        struct acpi_table_header *table_header;
        struct acpi_subtable_header *sub_table;
        char arg[MAX_ACPI_ARG_LENGTH];
        int num = 0;

        if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
            !strncmp(arg, "off", 3))
                return;

        table_addr = get_acpi_srat_table();
        if (!table_addr)
                return;

        table_header = (struct acpi_table_header *)table_addr;
        table_end = table_addr + table_header->length;
        table = table_addr + sizeof(struct acpi_table_srat);

        while (table + sizeof(struct acpi_subtable_header) < table_end) {
                sub_table = (struct acpi_subtable_header *)table;
                if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
                        struct acpi_srat_mem_affinity *ma;

                        ma = (struct acpi_srat_mem_affinity *)table;
                        if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
                                immovable_mem[num].start = ma->base_address;
                                immovable_mem[num].size = ma->length;
                                num++;
                        }

                        if (num >= MAX_NUMNODES*2) {
                                debug_putstr("Too many immovable memory regions, aborting.\n");
                                return 0;
                        }
                }
                table += sub_table->length;
        }
        return num;
}

Thanks,
Chao Fan


