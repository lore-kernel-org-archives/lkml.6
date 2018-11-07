Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3569C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C202C2089A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202C2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbeKGKxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:53:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51658 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388864AbeKGKxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:53:17 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47459847"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Nov 2018 09:25:09 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5197F4B71EA1;
        Wed,  7 Nov 2018 09:25:10 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 09:25:14 +0800
Date:   Wed, 7 Nov 2018 09:24:01 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v10 1/7] x86/boot: Introduce cmdline_find_option_arg()to
 detect if option=arg in cmdline
Message-ID: <20181107012400.GB2683@localhost.localdomain>
References: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
 <20181022093720.21426-2-fanc.fnst@cn.fujitsu.com>
 <20181106122253.GG13712@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181106122253.GG13712@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 5197F4B71EA1.A9E59
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 01:22:53PM +0100, Borislav Petkov wrote:
>On Mon, Oct 22, 2018 at 05:37:14PM +0800, Chao Fan wrote:
>> Now, there are cmdline_find_option() and cmdline_find_option_bool() in
>> cmdline.c. Sometimes, when detecting such as whether 'acpi=off' is
>> in cmdline, we need to cmdline_find_option() first, then compare
>> the argument. Now splite the operation as a independent function.
>> Introduce a new function cmdline_find_option_arg() to detect whether
>> option is in command line and the value is arg.
>
>For all future commit messages you write:
>
>Use passive tone in your commit message: no "we", etc.

Got it.

>
>Also, pls read section "2) Describe your changes" in
>Documentation/process/submitting-patches.rst.
OK.
>
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/cmdline.c | 15 +++++++++++++++
>>  arch/x86/boot/compressed/misc.h    |  1 +
>>  2 files changed, 16 insertions(+)
>> 
>> diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
>> index af6cda0b7900..61118c69feb8 100644
>> --- a/arch/x86/boot/compressed/cmdline.c
>> +++ b/arch/x86/boot/compressed/cmdline.c
>> @@ -1,5 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include "misc.h"
>> +#define STATIC
>> +#include <linux/decompress/mm.h>
>>  
>>  #if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE || CONFIG_X86_5LEVEL
>>  
>> @@ -30,5 +32,18 @@ int cmdline_find_option_bool(const char *option)
>>  {
>>  	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
>>  }
>> +bool cmdline_find_option_arg(const char *option, const char *arg, int argsize)
>> +{
>> +	char *buffer = malloc(argsize+1);
>> +	bool find = false;
>> +	int ret;
>> +
>> +	ret = cmdline_find_option(option, buffer, argsize+1);
>> +	if (ret == argsize && !strncmp(buffer, arg, argsize))
>> +		find = true;
>> +
>> +	free(buffer);
>> +	return find;
>> +}
>
>I don't think such wrapper is needed. Simply calling
>cmdline_find_option() and then examining the buffer - like other call
>sites do - is perfectly fine.

I will change it.

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


