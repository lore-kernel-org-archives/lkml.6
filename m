Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1483AC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF24820868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF24820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeK3Nvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:51:49 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7477 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726161AbeK3Nvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:51:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="48853424"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Nov 2018 10:44:04 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 63B424B734A9;
        Fri, 30 Nov 2018 10:44:01 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 30 Nov 2018 10:44:02 +0800
Date:   Fri, 30 Nov 2018 10:43:47 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181130024346.GB30941@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181129211003.saxfvyboxpsn5mdr@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 63B424B734A9.AABE7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +
>> +/* acpitb.c */
>> +#define BOOT_STRING
>> +extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>> index 1006bf70bf74..a0ac1b2257b8 100644
>> --- a/lib/kstrtox.c
>> +++ b/lib/kstrtox.c
>> @@ -126,6 +126,9 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>>  }
>>  EXPORT_SYMBOL(kstrtoull);
>>  
>> +/* Make compressed period code be able to use kstrtoull(). */
>> +#ifndef BOOT_STRING
>
>I got the following build error.
>
>]$ make arch/x86/boot/compressed/misc.o
>  CALL    scripts/checksyscalls.sh
>  DESCEND  objtool
>  CC      arch/x86/boot/compressed/misc.o
>ld: -r and -pie may not be used together
>make[1]: *** [scripts/Makefile.build:294: arch/x86/boot/compressed/misc.o] Error 1
>make: *** [Makefile:1715: arch/x86/boot/compressed/misc.o] Error 2
>]$

Hi Masa,

So many thanks for your test.

Could you give me more details about this error? More error message.
Just on the first commit or the whole PATCHSET?
Cause I didn't get error both on this commit and on the whole PATCHSET.

Thanks,
Chao Fan

>
>I think this error gets fixed by changing the BOOT_STRING ifndef
>order before the EXPORT_SYMBOL, like this:
>
>#ifndef BOOT_STRING
>EXPORT_SYMBOL(kstrtoull);
>
>I'm not sure this change is a good way...
>
>Thanks,
>Masa
>
>


