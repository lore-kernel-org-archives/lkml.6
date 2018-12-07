Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22925214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22925214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLGDUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:20:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28995 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725939AbeLGDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:20:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,324,1539619200"; 
   d="scan'208";a="49173189"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Dec 2018 11:20:33 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1C7F34B710EA;
        Fri,  7 Dec 2018 11:20:29 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 7 Dec 2018 11:20:31 +0800
Date:   Fri, 7 Dec 2018 11:20:01 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Masayoshi Mizuma <msys.mizuma@gmail.com>, <bp@alien8.de>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <hpa@zytor.com>,
        <keescook@chromium.org>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181207032001.GA27206@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181207021055.GI17340@MiWiFi-R3L-srv>
 <20181207025021.GJ17340@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181207025021.GJ17340@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 1C7F34B710EA.AC198
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 10:50:21AM +0800, Baoquan He wrote:
>On 12/07/18 at 10:10am, Baoquan He wrote:
>> Hi,
>> 
>> On 11/29/18 at 04:10pm, Masayoshi Mizuma wrote:
>> > > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>> > > index 8dd1d5ccae58..e51713fe3add 100644
>> > > --- a/arch/x86/boot/compressed/misc.c
>> > > +++ b/arch/x86/boot/compressed/misc.c
>> > > @@ -12,6 +12,7 @@
>> > >   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
>> > >   */
>> > >  
>> > > +#define BOOT_CTYPE_H
>> > >  #include "misc.h"
>> > >  #include "error.h"
>> > >  #include "pgtable.h"
>> > > @@ -426,3 +427,7 @@ void fortify_panic(const char *name)
>> > >  {
>> > >  	error("detected buffer overflow");
>> > >  }
>> > > +
>> > > +#ifdef BOOT_STRING
>> > > +#include "../../../../lib/kstrtox.c"
>> > > +#endif
>> > > diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> > > index a1d5918765f3..809c31effa4b 100644
>> > > --- a/arch/x86/boot/compressed/misc.h
>> > > +++ b/arch/x86/boot/compressed/misc.h
>> > > @@ -116,3 +116,7 @@ static inline void console_init(void)
>> > >  void set_sev_encryption_mask(void);
>> > >  
>> > >  #endif
>> > > +
>> > > +/* acpitb.c */
>> > > +#define BOOT_STRING
>> > > +extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>> > > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>> > > index 1006bf70bf74..a0ac1b2257b8 100644
>> > > --- a/lib/kstrtox.c
>> > > +++ b/lib/kstrtox.c
>> > > @@ -126,6 +126,9 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>> > >  }
>> > >  EXPORT_SYMBOL(kstrtoull);
>> > >  
>> > > +/* Make compressed period code be able to use kstrtoull(). */
>> > > +#ifndef BOOT_STRING
>> > 
>> > I got the following build error.
>> > 
>> > ]$ make arch/x86/boot/compressed/misc.o
>> >   CALL    scripts/checksyscalls.sh
>> >   DESCEND  objtool
>> >   CC      arch/x86/boot/compressed/misc.o
>> > ld: -r and -pie may not be used together
>> > make[1]: *** [scripts/Makefile.build:294: arch/x86/boot/compressed/misc.o] Error 1
>> > make: *** [Makefile:1715: arch/x86/boot/compressed/misc.o] Error 2
>> 
>> I have met this issue when change code in boot/compressed/kaslr.c.
>> 
>> I remember Ingo merged my patch and found this build error. Since if 
>> CONFIG_MODULES=n EXPORT_SYMBOL is defined as empty in
>> include/linux/export.h, that's why you can only meet it only if
>> CONFIG_MODULES=y.
>> 
>> I remember I just muted it with below code, please check commit
>> d52e7d5a95.
>> 
>> +#define _LINUX_EXPORT_H
>> +#define EXPORT_SYMBOL(sym)
>
>I made below change, it passed. My another question is why you need
>include "lib/kstrtox.c" into misc.c. Does it make sense if you plan to
>use it to replace simple_strtoull() in arch/x86/boot/string.c ?
>
>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>index e51713fe3add..777e807756e8 100644
>--- a/arch/x86/boot/compressed/misc.c
>+++ b/arch/x86/boot/compressed/misc.c
>@@ -13,6 +13,8 @@
>  */
> 
> #define BOOT_CTYPE_H
>+#define __DISABLE_EXPORTS
>+
> #include "misc.h"
> #include "error.h"
> #include "pgtable.h"
>
>I just tried to include it into boot/string.c, there's no any problem.

Thanks for your help, I think it's better to include it into
boot/string.c.

Thanks,
Chao Fan
>
>Thanks
>Baoquan
>
>


