Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913F20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rDT1zD5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAQP17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:27:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40060 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:58 -0500
Received: from zn.tnic (p200300EC2BCAA900D1C41FD2C17621F7.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:a900:d1c4:1fd2:c176:21f7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E4EF1EC0B7A;
        Thu, 17 Jan 2019 16:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547738877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KYPJn03ID5gBjx5+sNW0KtRLbDQTgdzQcRfxHbR7y6I=;
        b=rDT1zD5qvDlIHkqh9U7zJF0E0QvSax4Soc53s3/dG8V1WhHLkaUxar0FG/OvAFTGzydG8S
        7/BtKI3GbVco3zKzxhmhH5E9zCRUo+gjgu+PykXQxXVpcN37MHdoZ772Zb7aq2VgBjpwP8
        R+Ima/pr0wwytPs+uYekYupr7SsG6Os=
Date:   Thu, 17 Jan 2019 16:27:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, msys.mizuma@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v15 5/6] x86/boot: Parse SRAT address from RSDP and store
 immovable memory
Message-ID: <20190117152751.GD5023@zn.tnic>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-6-fanc.fnst@cn.fujitsu.com>
 <20190116110158.GC15409@zn.tnic>
 <20190117032027.GA31097@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117032027.GA31097@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:20:27AM +0800, Chao Fan wrote:
> I have changed as you suggested, looks clear without type cast, and
> we need some variable as long to calculate the address, and at same
> time as the struct pointer to find it's length, so I change as below,
> and get_acpi_srat_table() return an unsigned long.
> How do you think of that.
> 
> int get_immovable_mem_num(void)

I'd call that

int count_immovable_mem_regions(void)

or

int enumerate_immovable_regions(void)

or so and put a comment above it explaining what it does and what it
returns.

"mem_num" is not clear what it is.

> {
>         unsigned long table_addr, table_end, table;
>         struct acpi_table_header *table_header;
>         struct acpi_subtable_header *sub_table;
>         char arg[MAX_ACPI_ARG_LENGTH];
>         int num = 0;
> 
>         if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>             !strncmp(arg, "off", 3))
>                 return;
> 
>         table_addr = get_acpi_srat_table();
>         if (!table_addr)
>                 return;
> 
>         table_header = (struct acpi_table_header *)table_addr;
>         table_end = table_addr + table_header->length;
>         table = table_addr + sizeof(struct acpi_table_srat);
> 
>         while (table + sizeof(struct acpi_subtable_header) < table_end) {
>                 sub_table = (struct acpi_subtable_header *)table;
>                 if (sub_table->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
>                         struct acpi_srat_mem_affinity *ma;
> 
>                         ma = (struct acpi_srat_mem_affinity *)table;
>                         if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE)) {
>                                 immovable_mem[num].start = ma->base_address;
>                                 immovable_mem[num].size = ma->length;
>                                 num++;
>                         }
> 
>                         if (num >= MAX_NUMNODES*2) {
>                                 debug_putstr("Too many immovable memory regions, aborting.\n");
>                                 return 0;
>                         }
>                 }
>                 table += sub_table->length;
>         }
>         return num;
> }

That looks clean.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
