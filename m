Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F19CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EC02087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EC02087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJLQVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:21:23 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:45849 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbeJLQVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:21:23 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9C8qADG034367;
        Fri, 12 Oct 2018 16:52:10 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Fri, 12 Oct 2018
 16:49:44 +0800
Date:   Fri, 12 Oct 2018 16:49:45 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <deanbo422@gmail.com>, <linux-kernel@vger.kernel.org>,
        <green.hu@gmail.com>
Subject: Re: [PATCH v2 1/5] nds32: nds32 FPU port
Message-ID: <20181012084945.GB10286@andestech.com>
References: <1539224450-19928-1-git-send-email-vincentc@andestech.com>
 <1539224450-19928-2-git-send-email-vincentc@andestech.com>
 <CAK8P3a2U_-EmBf5r4wELddwTYF-S_GKPBcwPiqhV0cp-Cb44gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2U_-EmBf5r4wELddwTYF-S_GKPBcwPiqhV0cp-Cb44gA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9C8qADG034367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:30:30PM +0800, Arnd Bergmann wrote:
> On Thu, Oct 11, 2018 at 4:56 AM Vincent Chen <vincentc@andestech.com> wrote:
> >
> > This commit contains basic components for nds32 FPU support such as
> > FPU exception handler and context switch for FPU register.
> >
> > diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
> > index b8c8984..7ee4e19 100644
> > --- a/arch/nds32/Kconfig.cpu
> > +++ b/arch/nds32/Kconfig.cpu
> > @@ -7,6 +7,28 @@ config CPU_LITTLE_ENDIAN
> >         bool "Little endian"
> >         default y
> >
> > +config FPU
> > +       bool "FPU support"
> > +       default n
> > +       help
> > +         If FPU ISA is used in user space, this configure shall be Y to make
> > +         the fpu context switch and fpu exception handler is enabled in kernel.
> > +         Lazy FPU is the default scheme for fpu context switch. If user wants
> > +         to disable Lazy FPU scheme, please enable CONFIG_UNLAZY_FPU.
> > +
> > +         If no FPU ISA is used in user space, say N.
> 
> There was a long discussion on RISC-V about what happens when
> FPU support is enabled or disabled, you may have seen that as well.
> 
> Can you confirm that:
> 
> a) A kernel with FPU support enabled running on a CPU without an FPU
>     will behave the same as a kernel without FPU support, and in particular
>     not crash while trying to access the FPU
> b) A kernel with FPU support disabled running on a CPU with an FPU
>     prevents user space from accessing the FPU, to avoid corrupting
>     FPU registers during a task switch when a process accidentally contains
>     FPU access

In this patch user program will be terminated when accessing FPU register
if the FPU support is disabled on kernel. Hence, condition b) is promised.
Condition a) is unsupported in this patch. I will add this support in
the next version patch.
 
> > +config UNLAZY_FPU
> > +       bool "Unlazy FPU support"
> > +       depends on FPU
> > +       default n
> > +       help
> > +         Say Y here to disable lazy FPU scheme. Disable lazy FPU scheme causes
> > +         some performance loss because the fpu register are loaded and stored
> > +         in each context switch.
> > +
> > +         For nomal case, say N.
> 
> I prefer Kconfig symbols to avoid using negatives, as this easily gets
> confusing. Why not do it like
> 
> config LAZY_FPU_SWITCHING
>            bool "Lazy FPU switching"
>            depends on FPU
>            default y
> 
>       Arnd

OK, I will modify it in the next version patch.

Thanks for your comments.


Regards
Vincent

