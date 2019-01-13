Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09AB20873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfAMJso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:48:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57920 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfAMJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:48:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,473,1539619200"; 
   d="scan'208";a="51907664"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Jan 2019 17:48:01 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id E56E34B7D57E;
        Sun, 13 Jan 2019 17:48:00 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 13 Jan 2019 17:48:00 +0800
Date:   Sun, 13 Jan 2019 17:47:04 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v15 3/6] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20190113094704.GC13263@localhost.localdomain>
References: <20190107032243.25324-1-fanc.fnst@cn.fujitsu.com>
 <20190107032243.25324-4-fanc.fnst@cn.fujitsu.com>
 <20190110211523.GG17621@zn.tnic>
 <20190111012353.GD2216@localhost.localdomain>
 <20190111103225.GA4729@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190111103225.GA4729@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: E56E34B7D57E.AAD14
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:32:25AM +0100, Borislav Petkov wrote:
>On Fri, Jan 11, 2019 at 09:23:53AM +0800, Chao Fan wrote:
>> Yes, 'table64' looks superfluous here, but after these lines, there is:
>>                         if (!IS_ENABLED(CONFIG_X86_64) && table64 >> 32) {
>> so the 'table64' is useful here for i386. 'table' is unsigned long, it
>> can't do the right shift. But the 'table64' who is u64 can do that right
>> shift.
>
>Have you actually tried fixing what I suggested or you're just talking?

Sure, I tried what I was talking.
I ever used 'unsigned long table' directly. But that caused warning:
  CC      arch/x86/boot/compressed/acpi.o
arch/x86/boot/compressed/acpi.c: In function ‘efi_get_rsdp_addr’:
arch/x86/boot/compressed/acpi.c:106:44: warning: right shift count >= width of type [-Wshift-count-overflow]
    if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
To avoid this warning, I add 'u64 table64' to do the right shift.

Well, the acpi_physicall_address defined as:

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

'acpi_physical_address' could be define as u64 or u32.
In my guest machine, it's defined as u64, there is no problem as you
suggested.
I didn't find a machine where 'acpi_physical_address' defined as u32.
I thought if 'acpi_physical_address' defined as u32, it will meet
the same warning as using 'unsigned long'.
I tried to define 'table' as u32, that will also cause the warning.
So once acpi_physical_address is define as u32, that warning will
happen. We should make sure u64 to do the right shift.

Thanks,
Chao Fan

>
>---
>diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>index e9dd84f459ed..0537d46fb21f 100644
>--- a/arch/x86/boot/compressed/acpi.c
>+++ b/arch/x86/boot/compressed/acpi.c
>@@ -77,21 +77,19 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> 			sizeof(efi_config_table_32_t);
> 
> 	for (i = 0; i < systab->nr_tables; i++) {
>+		acpi_physical_address table;
> 		void *config_tables;
>-		unsigned long table;
> 		efi_guid_t guid;
> 
> 		config_tables = (void *)(systab->tables + size * i);
> 		if (efi_64) {
> 			efi_config_table_64_t *tmp_table;
>-			u64 table64;
> 
> 			tmp_table = config_tables;
> 			guid = tmp_table->guid;
>-			table64 = tmp_table->table;
>-			table = table64;
>+			table = tmp_table->table;
> 
>-			if (!IS_ENABLED(CONFIG_X86_64) && table64 >> 32) {
>+			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> 				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> 				return 0;
> 			}
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


