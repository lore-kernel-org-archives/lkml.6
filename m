Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BC7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F1A2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F1A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLCETc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:19:32 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37090 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbeLCETc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:19:32 -0500
X-IronPort-AV: E=Sophos;i="5.56,308,1539619200"; 
   d="scan'208";a="48930142"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Dec 2018 12:19:24 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id C0F204B6ED69;
        Mon,  3 Dec 2018 12:19:24 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Dec 2018 12:19:27 +0800
Date:   Mon, 3 Dec 2018 12:19:10 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 4/5] x86/boot: Parse SRAT table from RSDP and store
 immovable memory
Message-ID: <20181203041910.GE30941@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-5-fanc.fnst@cn.fujitsu.com>
 <20181129175520.xcmj3bv4yhdr7kk3@gabell>
 <20181130012454.GB1527@localhost.localdomain>
 <20181130145432.j2iwbglwrtj5xdus@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181130145432.j2iwbglwrtj5xdus@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: C0F204B6ED69.AD9D5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:54:33AM -0500, Masayoshi Mizuma wrote:
>On Fri, Nov 30, 2018 at 09:24:54AM +0800, Chao Fan wrote:
>> >>  /* acpitb.c */
>> >> +#ifdef CONFIG_RANDOMIZE_BASE
>> >> +/* Store the amount of immovable memory regions */
>> >> +int num_immovable_mem;
>> >> +#endif
>> >> +
>> >> +#ifdef CONFIG_EARLY_PARSE_RSDP
>> >> +void get_immovable_mem(void);
>> >
>> >> +/* There are 72 kinds of ACPI_SIG in head file of ACPI. */
>> >> +#define MAX_ACPI_SIG	72
>> >
>> >The 72 isn't the specification of ACPI, right? So the number
>> 
>> Yes, it's from  ACPI code, include/acpi/actbl*h.
>> Boris said there should be a check for the num_entries,
>> I didn't get a good idea, so I use the max number to check it.
>> So do you have some advice?
>
>Ah, got it. How about adding the check for len to prevent the wrap?
>Like as:
>
>	len = header->length;
>	if (len <= sizeof(struct acpi_table_header))
>		return NULL;
> 	num_entries = (u32)((len - sizeof(struct acpi_table_header)) / size);

Hi Masa,

Your check is right, but not exactly the same.
I think what Boris said is to prevent num_entries from getting too large
and the loop getting too much.
So the 'num_entries' or 'len' can't be more than a fixed value.

Thanks,
Chao Fan

>
>Thanks,
>Masa
>
>


