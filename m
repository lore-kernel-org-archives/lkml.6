Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2165B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 07:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbeLYHn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 02:43:56 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22889 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725827AbeLYHnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 02:43:55 -0500
X-IronPort-AV: E=Sophos;i="5.56,395,1539619200"; 
   d="scan'208";a="50592202"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Dec 2018 15:43:53 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 561BB4B71F5D;
        Tue, 25 Dec 2018 15:43:49 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 25 Dec 2018 15:43:54 +0800
Date:   Tue, 25 Dec 2018 15:43:12 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v14 2/5] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181225074312.GA14472@localhost.localdomain>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-3-fanc.fnst@cn.fujitsu.com>
 <20181217173032.GB90818@gmail.com>
 <20181217173605.GA14613@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181217173605.GA14613@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 561BB4B71F5D.AB518
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 06:36:05PM +0100, Ingo Molnar wrote:
>
>* Ingo Molnar <mingo@kernel.org> wrote:
>
>> > +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>> > +			rsdp_addr = (acpi_physical_address)table;
>> > +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>> > +			return (acpi_physical_address)table;
>> 
>> 'return' is not a function.
>

Hi Ingo,

I will remove the typecast in next version.
But when doing more tests, I found a special condition.

>Disregard this - I got confused by the type cast.
>
>The type cast is ugly nevertheless. 'table' is an 'unsigned long'.
>
>So 'acpi_physical_address' is basically an u64/u32, depending on 
>ACPI_MACHINE_WIDTH, right?
>
>Since this is x86, can ACPI_MACHINE_WIDTH ever get out of sync with the 
>native 'unsigned long' size?

Not always.
Here is define of acpi_physical_address:

#if ACPI_MACHINE_WIDTH == 64
typedef u64 acpi_physical_address;
#elif ACPI_MACHINE_WIDTH == 32
#ifdef ACPI_32BIT_PHYSICAL_ADDRESS
typedef u32 acpi_physical_address;
#else                           /* ACPI_32BIT_PHYSICAL_ADDRESS */

/*
 * It is reported that, after some calculations, the physical addresses
can
 * wrap over the 32-bit boundary on 32-bit PAE environment.
 * https://bugzilla.kernel.org/show_bug.cgi?id=87971
 */
typedef u64 acpi_physical_address;
#endif

That means in 32-bit with PAE, acpi_physical_address is u64.
I set up a debian9-32bit with PAE in QEMU and found size of
acpi_physical_address is 8. So they are not always sync.
Of course, that doesn't influence the conclusion, since return table directly
can always work. It will return u32 to u32, u64 to u64, or u32 to u64.
So the typecast about acpi_physical_address can be removed.

Thanks,
Chao Fan

>
>If not then why not make the return type 'unsigned long', instead of 
>'acpi_physical_address' that you have to wade through a couple of headers 
>to figure out its true size. Does that cause complications elsewhere?
>
>I.e. the excessive type casts are ugly and make the code somewhat 
>fragile.
>
>Thanks,
>
>	Ingo
>
>


