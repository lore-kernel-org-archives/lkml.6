Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DAAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE72087A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE72087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeKSLij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:38:39 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44185 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726235AbeKSLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:38:39 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="48339614"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Nov 2018 09:16:39 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 900BC4B7117F;
        Mon, 19 Nov 2018 09:16:40 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 09:16:43 +0800
Date:   Mon, 19 Nov 2018 09:16:34 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v11 3/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181119011634.GA2336@localhost.localdomain>
References: <20181112094645.4879-1-fanc.fnst@cn.fujitsu.com>
 <20181112094645.4879-4-fanc.fnst@cn.fujitsu.com>
 <20181112174343.mvjri2okwboew2nw@gabell>
 <20181113021218.GD7453@localhost.localdomain>
 <20181113161111.6jwm36fpxk5xjtn5@gabell>
 <20181113175413.GL10502@zn.tnic>
 <20181113200615.7dypqvhimxzlloek@gabell>
 <20181113215156.GP10502@zn.tnic>
 <20181114061215.GC2875@localhost.localdomain>
 <20181114183016.GI13926@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181114183016.GI13926@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 900BC4B7117F.AA91E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 07:30:17PM +0100, Borislav Petkov wrote:
>On Wed, Nov 14, 2018 at 02:12:16PM +0800, Chao Fan wrote:
>> But isdigit() would be redefine, so:
>> 
>> diff --git a/include/linux/ctype.h b/include/linux/ctype.h
>> index 363b004426db..aba01c385232 100644
>> --- a/include/linux/ctype.h
>> +++ b/include/linux/ctype.h
>> @@ -23,10 +23,12 @@ extern const unsigned char _ctype[];
>>  #define isalnum(c)     ((__ismask(c)&(_U|_L|_D)) != 0)
>>  #define isalpha(c)     ((__ismask(c)&(_U|_L)) != 0)
>>  #define iscntrl(c)     ((__ismask(c)&(_C)) != 0)
>> +#ifndef BOOT_STRING
>>  static inline int isdigit(int c)
>>  {
>>         return '0' <= c && c <= '9';
>>  }
>> +#endif
>>  #define isgraph(c)     ((__ismask(c)&(_P|_U|_L|_D)) != 0)
>>  #define islower(c)     ((__ismask(c)&(_L)) != 0)
>>  #define isprint(c)     ((__ismask(c)&(_P|_U|_L|_D|_SP)) != 0)
>> 
>> Now I can make it.
>> I wonder whether this is OK to cover isdigit() with 'BOOT_STRING' tag.
>
>See the beginning of arch/x86/boot/compressed/kaslr.c for a possible way
>to disable boot/ctype.h

I have done this with BOOT_CTYPE_H.
So misc.c can only use isdigit() and isxdigit() in
include/linux/ctype.h.

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8dd1d5ccae58..e51713fe3add 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -12,6 +12,7 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */

+#define BOOT_CTYPE_H
 #include "misc.h"
 #include "error.h"
 #include "pgtable.h"
@@ -426,3 +427,7 @@ void fortify_panic(const char *name)
 {
        error("detected buffer overflow");
 }
+
+#ifdef BOOT_STRING
+#include "../../../../lib/kstrtox.c"
+#endif

This looks better than before.

Thanks,
Chao Fan

>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


