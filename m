Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97CC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED1D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED1D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbeKGK5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:57:22 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41407 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731011AbeKGK5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:57:22 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="47460020"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Nov 2018 09:29:14 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D2BE44B714AF;
        Wed,  7 Nov 2018 09:29:11 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 7 Nov 2018 09:29:16 +0800
Date:   Wed, 7 Nov 2018 09:28:02 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v10 2/7] x86/boot: Copy kstrtoull() to compressed period
Message-ID: <20181107012802.GC2683@localhost.localdomain>
References: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
 <20181022093720.21426-3-fanc.fnst@cn.fujitsu.com>
 <20181106191303.GN13712@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181106191303.GN13712@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D2BE44B714AF.AD034
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:13:03PM +0100, Borislav Petkov wrote:
>On Mon, Oct 22, 2018 at 05:37:15PM +0800, Chao Fan wrote:
>> kstrtoull() lives in 'uncompressed' period, used to
>> convert a string to an unsigned long long.
>> Copy to 'compressed' so that we can use it to
>> convert the memory address from sting to unsigned
>
>sting?

oops, typo, string.
>
>> long long in 'compressed' period.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/misc.c | 88 +++++++++++++++++++++++++++++++++
>>  arch/x86/boot/compressed/misc.h |  4 ++
>>  2 files changed, 92 insertions(+)
>
>Why do you need to copy things?
>
>You can link that file into compressed/ as lib/kstrtox.c is a library or
>include it similar to what arch/x86/boot/compressed/cmdline.c does.
>
>Still better than copying the code.

I will have a try, thanks for your suggestion.

>
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index 008fdc47a29c..40378408d980 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -63,6 +63,10 @@ static inline void debug_puthex(const char *s)
>>  
>>  #endif
>>  
>> +#if (defined CONFIG_RANDOMIZE_BASE) && (defined CONFIG_RANDOMIZE_BASE)
>
>CONFIG_RANDOMIZE_BASE twice huh? Once not enough?

Sorry for that, the second should be CONFIG_MEMORY_HOTREMOVE.

Thanks,
Chao Fan

>
>:-)
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


