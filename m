Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D966C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EC72070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405263AbfBOJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:47:23 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21727 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404420AbfBOJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:47:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,372,1544457600"; 
   d="scan'208";a="54421037"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Feb 2019 17:47:00 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 181014BAD925;
        Fri, 15 Feb 2019 17:46:57 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 Feb 2019 17:47:01 +0800
Date:   Fri, 15 Feb 2019 17:46:44 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Move detecting acpi=off in cmdline to
 get_rsdp_addr()
Message-ID: <20190215094644.GA9326@localhost.localdomain>
References: <20190215091047.23047-1-fanc.fnst@cn.fujitsu.com>
 <20190215092841.GA10433@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190215092841.GA10433@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 181014BAD925.A91AD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 10:28:41AM +0100, Borislav Petkov wrote:
>On Fri, Feb 15, 2019 at 05:10:47PM +0800, Chao Fan wrote:
>> If "acpi=off" specified in cmdline, the whole functions of acpi.c
>> should not work, there is no need to ealy parse RSDP, so detect
>> "acpi=off" in the very first place.
>> 
>> Also replace magic number with macro.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpi.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> 
>> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
>> index 0ef4ad55b29b..5510a2105b7b 100644
>> --- a/arch/x86/boot/compressed/acpi.c
>> +++ b/arch/x86/boot/compressed/acpi.c
>> @@ -213,8 +213,13 @@ static acpi_physical_address bios_get_rsdp_addr(void)
>>  /* Return RSDP address on success, otherwise 0. */
>>  acpi_physical_address get_rsdp_addr(void)
>>  {
>> +	char arg[MAX_ACPI_ARG_LENGTH];
>>  	acpi_physical_address pa;
>>  
>> +	if (cmdline_find_option("acpi", arg, sizeof(arg)) == 3 &&
>> +	    !strncmp(arg, "off", 3))
>> +		return 0;
>
>This place looks wrong because we have a get_acpi_rsdp() call before
>that which overrides acpi=off practically.

Oh thanks.
In my old version PATCH, it was in count_immovable_mem_regions() which
is the entry function of acpi.c. Then in last version, I splite acpi.c
so that the first entry is get_rsdp_addr(), that's why I want to move
the detecting here.

>
>Also, if you move it to get_rsdp_addr(), add a static variable recording
>the previous result of the cmdline parsing because I don't want it
>parsing cmdline each time it is called.

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


