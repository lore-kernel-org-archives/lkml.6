Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901EE20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901EE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIGJrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:47:25 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46629 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbeIGJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:47:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07528035|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.CnYzP-y_1536296883;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CnYzP-y_1536296883)
          by smtp.aliyun-inc.com(10.147.41.138);
          Fri, 07 Sep 2018 13:08:03 +0800
Date:   Fri, 7 Sep 2018 13:08:02 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 13/26] csky: Library functions
Message-ID: <20180907050801.GA13356@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:24:59PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > --- /dev/null
> > +++ b/arch/csky/abiv1/memset.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#include <linux/types.h>
> > +
> > +void *memset(void *dest, int c, size_t l)
> > +{
> > +       char *d = dest;
> > +       int ch = c;
> > +       int tmp;
> > +
> > +       if ((long)d & 0x3)
> > +               while (l--) *d++ = ch;
> > +       else {
> > +               ch &= 0xff;
> > +               tmp = (ch | ch << 8 | ch << 16 | ch << 24);
> > +
> > +               while (l >= 16) {
> > +                       *(((long *)d)) = tmp;
> > +                       *(((long *)d)+1) = tmp;
> > +                       *(((long *)d)+2) = tmp;
> > +                       *(((long *)d)+3) = tmp;
> > +                       l -= 16;
> > +                       d += 16;
> > +               }
> > +
> > +               while (l > 3) {
> > +                       *(((long *)d)) = tmp;
> > +                       d = d + 4;
> > +                       l -= 4;
> > +               }
> > +
> > +               while (l) {
> > +                       *d++ = ch;
> > +                       l--;
> > +               }
> > +       }
> > +       return dest;
> > +}
> 
> I see that we have a trivial memset() implementation in lib/string.c, but yours
> seems to be better optimized. Where did you get it from?
We write it for our ck610 to improve the performance, but I think a lot
of other arch done it in asm style.

> Is this a version
> that works particularly well on C-Sky, or is this a generic optimized memset
> that others could use as well?
We only test it on C-SKY, but I think it will also work better on other
arch CPU than current lib/string.c memset implement.

I see that in lib/string.c:
void *memset(void *s, int c, size_t count)
{
	char *xs = s;

	while (count--)
		*xs++ = c;
	return s;
}
The most problem is "char *xs;" and it will cause "st.b" in asm.
"st.b" is very slow.

Our key improvement is:
> > +                       *(((long *)d)) = tmp;
> > +                       *(((long *)d)+1) = tmp;
> > +                       *(((long *)d)+2) = tmp;
> > +                       *(((long *)d)+3) = tmp;
It will cause SOC AXI burst transfer.

> In the latter case, we could add it to
> lib/string.c and let architectures select it in place of the triivial version.
Good idea.

 Guo Ren
