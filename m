Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B551C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3B2204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3B2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLGCu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:50:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:50:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0526330CEC49;
        Fri,  7 Dec 2018 02:50:26 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF26760851;
        Fri,  7 Dec 2018 02:50:24 +0000 (UTC)
Date:   Fri, 7 Dec 2018 10:50:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, bp@alien8.de,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, keescook@chromium.org, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181207025021.GJ17340@MiWiFi-R3L-srv>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181207021055.GI17340@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207021055.GI17340@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 07 Dec 2018 02:50:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/18 at 10:10am, Baoquan He wrote:
> Hi,
> 
> On 11/29/18 at 04:10pm, Masayoshi Mizuma wrote:
> > > diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> > > index 8dd1d5ccae58..e51713fe3add 100644
> > > --- a/arch/x86/boot/compressed/misc.c
> > > +++ b/arch/x86/boot/compressed/misc.c
> > > @@ -12,6 +12,7 @@
> > >   * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
> > >   */
> > >  
> > > +#define BOOT_CTYPE_H
> > >  #include "misc.h"
> > >  #include "error.h"
> > >  #include "pgtable.h"
> > > @@ -426,3 +427,7 @@ void fortify_panic(const char *name)
> > >  {
> > >  	error("detected buffer overflow");
> > >  }
> > > +
> > > +#ifdef BOOT_STRING
> > > +#include "../../../../lib/kstrtox.c"
> > > +#endif
> > > diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> > > index a1d5918765f3..809c31effa4b 100644
> > > --- a/arch/x86/boot/compressed/misc.h
> > > +++ b/arch/x86/boot/compressed/misc.h
> > > @@ -116,3 +116,7 @@ static inline void console_init(void)
> > >  void set_sev_encryption_mask(void);
> > >  
> > >  #endif
> > > +
> > > +/* acpitb.c */
> > > +#define BOOT_STRING
> > > +extern int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
> > > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> > > index 1006bf70bf74..a0ac1b2257b8 100644
> > > --- a/lib/kstrtox.c
> > > +++ b/lib/kstrtox.c
> > > @@ -126,6 +126,9 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> > >  }
> > >  EXPORT_SYMBOL(kstrtoull);
> > >  
> > > +/* Make compressed period code be able to use kstrtoull(). */
> > > +#ifndef BOOT_STRING
> > 
> > I got the following build error.
> > 
> > ]$ make arch/x86/boot/compressed/misc.o
> >   CALL    scripts/checksyscalls.sh
> >   DESCEND  objtool
> >   CC      arch/x86/boot/compressed/misc.o
> > ld: -r and -pie may not be used together
> > make[1]: *** [scripts/Makefile.build:294: arch/x86/boot/compressed/misc.o] Error 1
> > make: *** [Makefile:1715: arch/x86/boot/compressed/misc.o] Error 2
> 
> I have met this issue when change code in boot/compressed/kaslr.c.
> 
> I remember Ingo merged my patch and found this build error. Since if 
> CONFIG_MODULES=n EXPORT_SYMBOL is defined as empty in
> include/linux/export.h, that's why you can only meet it only if
> CONFIG_MODULES=y.
> 
> I remember I just muted it with below code, please check commit
> d52e7d5a95.
> 
> +#define _LINUX_EXPORT_H
> +#define EXPORT_SYMBOL(sym)

I made below change, it passed. My another question is why you need
include "lib/kstrtox.c" into misc.c. Does it make sense if you plan to
use it to replace simple_strtoull() in arch/x86/boot/string.c ?

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index e51713fe3add..777e807756e8 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -13,6 +13,8 @@
  */
 
 #define BOOT_CTYPE_H
+#define __DISABLE_EXPORTS
+
 #include "misc.h"
 #include "error.h"
 #include "pgtable.h"

I just tried to include it into boot/string.c, there's no any problem.

Thanks
Baoquan
