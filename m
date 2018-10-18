Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00852ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D9021480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D9021480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJRLKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:10:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56324 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbeJRLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:10:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07727201|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03295;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.D3jfmVO_1539832245;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D3jfmVO_1539832245)
          by smtp.aliyun-inc.com(10.147.42.198);
          Thu, 18 Oct 2018 11:10:45 +0800
Date:   Thu, 18 Oct 2018 11:10:24 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com,
        linfei_chen@c-sky.com, Mao Han <han_mao@c-sky.com>
Subject: Re: [PATCH V9 13/21] csky: Library functions
Message-ID: <20181018031024.GA15088@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <f884af8fffa1645c2650292a3001a2fbfc4cc390.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a3hJ+Xt2xfTg=bkDBfahk7Z-3+Unt1MqmMQrRnCeJhVtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3hJ+Xt2xfTg=bkDBfahk7Z-3+Unt1MqmMQrRnCeJhVtg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:24:36PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > +++ b/arch/csky/lib/delay.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/delay.h>
> > +
> > +void __delay(unsigned long loops)
> > +{
> > +       asm volatile (
> > +               "mov r0, r0\n"
> > +               "1:declt %0\n"
> > +               "bf     1b"
> > +               : "=r"(loops)
> > +               : "0"(loops));
> > +}
> > +EXPORT_SYMBOL(__delay);
> > +
> > +void __const_udelay(unsigned long xloops)
> > +{
> > +       unsigned long long loops;
> > +
> > +       loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
> > +
> > +       __delay(loops >> 32);
> > +}
> > +EXPORT_SYMBOL(__const_udelay);
> 
> I can't find any indication we discussed this part before. Can you
> explain (in the
> changelog and in a reply) if there is a reliable high-resolution clocksource
> available in the architecture? If you can read the elapsed time here instead of
> using the loops_per_jiffy estimate, that would make this more robust, as
> well as speed up the boot.
> 
> If you can't do that in general, that's fine, and you can add my
I'll add TODO list here, __delay should use get_cycles() and we didn't
implement __udelay() __ndelay() ... We'll improve it next.

Best Regards
 Guo Ren
