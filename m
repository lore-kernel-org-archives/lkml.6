Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1C1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B1120879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfAKB2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:28:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55175 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728834AbfAKB2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:28:17 -0500
X-IronPort-AV: E=Sophos;i="5.56,463,1539619200"; 
   d="scan'208";a="51752542"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2019 09:28:13 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 7E5984BAD909;
        Fri, 11 Jan 2019 09:28:14 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 09:28:13 +0800
Date:   Fri, 11 Jan 2019 09:27:18 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 4/6] x86/boot: Introduce bios_get_rsdp_addr() to
 search RSDP in memory
Message-ID: <20190111012718.GE2216@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-5-fanc.fnst@cn.fujitsu.com>
 <20190110212747.GH17621@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110212747.GH17621@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 7E5984BAD909.AB3F3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:27:47PM +0100, Borislav Petkov wrote:
>On Mon, Jan 07, 2019 at 11:22:41AM +0800, Chao Fan wrote:
>> Memory information in SRAT table is necessary to fix the conflict
>> between KASLR and memory-hotremove. So RSDP and SRAT should be parsed.
>> 
>> When booting form KEXEC/EFI/BIOS, the methods to compute RSDP
>> are different. When booting from BIOS, there is no variable who can
>> point to RSDP directly, so scan memory for the RSDP and verify RSDP
>> by signature and checksum.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpi.c | 86 +++++++++++++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>
>...
>
>> +/* Search RSDP address, based on acpi_find_root_pointer(). */
>> +static acpi_physical_address bios_get_rsdp_addr(void)
>> +{
>> +	u8 *table_ptr;
>> +	u32 address;
>> +	u8 *rsdp;
>
>But those u8's together:
>
>	u8 *table_ptr, *rsdp;
>	u32 address;

Thanks, will change that.

>
>> +
>> +	/* Get the location of the Extended BIOS Data Area (EBDA) */
>> +	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
>> +	address = *(u16 *)table_ptr;
>> +	address <<= 4;
>> +	table_ptr = (u8 *)(long)address;
>> +
>> +	/*
>> +	 * Search EBDA paragraphs (EBDA is required to be a minimum of
>> +	 * 1K length)
>> +	 */
>> +	if (address > 0x400) {
>> +		rsdp = scan_mem_for_rsdp(table_ptr, ACPI_EBDA_WINDOW_SIZE);
>> +		if (rsdp) {
>> +			address += (u32)ACPI_PTR_DIFF(rsdp, table_ptr);
>> +			return address;
>> +		}
>> +	}
>> +
>> +	/* Search upper memory: 16-byte boundaries in E0000h-FFFFFh */
>> +	table_ptr = (u8 *)ACPI_HI_RSDP_WINDOW_BASE;
>> +	rsdp = scan_mem_for_rsdp(table_ptr, ACPI_HI_RSDP_WINDOW_SIZE);
>> +
>
>Superfluous newline.

Will drop it.

Thanks,
Chao Fan

>
>> +	if (rsdp) {
>> +		address = (u32)(ACPI_HI_RSDP_WINDOW_BASE +
>> +				ACPI_PTR_DIFF(rsdp, table_ptr));
>> +		return address;
>> +	}
>> +	return 0;
>> +}
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


