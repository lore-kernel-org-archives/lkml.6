Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28939C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D4F21A8E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D4F21A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeHKXxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:53:00 -0400
Received: from smtp-4.orcon.net.nz ([60.234.4.59]:39399 "EHLO
        smtp-4.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbeHKXxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:53:00 -0400
X-Greylist: delayed 1093 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Aug 2018 19:52:59 EDT
Received: from [121.99.228.40] (port=44121 helo=tower)
        by smtp-4.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <mcree@orcon.net.nz>)
        id 1foayY-00035n-S7; Sun, 12 Aug 2018 08:59:06 +1200
Date:   Sun, 12 Aug 2018 08:59:01 +1200
From:   Michael Cree <mcree@orcon.net.nz>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Subject: Re: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi header
Message-ID: <20180811205901.gxbcn5vf4z36cozi@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
 <20180811192804.GI6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811192804.GI6515@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 08:28:04PM +0100, Al Viro wrote:
> On Mon, Jul 16, 2018 at 03:53:53PM +0530, Firoz Khan wrote:
> > It is correct to keep __IGNORE* entry in non uapi header
> > asm/unistd.h while uapi/asm/unistd.h must hold information
> > only useful for user space applications.
> 
> > diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
> > index e153ca6..3bb6ac1 100644
> > --- a/arch/alpha/include/uapi/asm/unistd.h
> > +++ b/arch/alpha/include/uapi/asm/unistd.h
> > @@ -481,9 +481,4 @@
> >  #define __NR_pwritev2			521
> >  #define __NR_statx			522
> >  
> > -/* Alpha doesn't have protection keys. */
> > -#define __IGNORE_pkey_mprotect
> > -#define __IGNORE_pkey_alloc
> > -#define __IGNORE_pkey_free
> > -
> >  #endif /* _UAPI_ALPHA_UNISTD_H */
> 
> Hmm...  There's also
> 
> #define __IGNORE_alarm
> #define __IGNORE_creat

Tell you what, I wouldn't mind if the following ones were actually
implemented as syscalls in the kernel on Alpha:

> #define __IGNORE_getegid
> #define __IGNORE_geteuid
> #define __IGNORE_getgid
> #define __IGNORE_getpid
> #define __IGNORE_getppid
> #define __IGNORE_getuid

There's a growing number of software packages that are deciding
to sideskip glibc and call these syscalls directly.  Supporting
OSF's C ABI incompliant getxpid, etc., in such packages is not
easy and rather intrusive.

Cheers,
Michael.
