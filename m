Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20D0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9C721473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9C721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeJRLkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:40:49 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40939 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbeJRLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:40:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09651969|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.D3koQ0i_1539834078;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D3koQ0i_1539834078)
          by smtp.aliyun-inc.com(10.147.44.145);
          Thu, 18 Oct 2018 11:41:19 +0800
Date:   Thu, 18 Oct 2018 11:41:18 +0800
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
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Subject: Re: [PATCH V9 21/21] csky: support dword access for get_user_size()
Message-ID: <20181018034117.GD15088@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <4bc11ff0cff5960892a464189605f9bc808383fc.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a1wfeWboHvU1o_kooMc2hML8iWcNrz=mp6tYT52iGwfjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1wfeWboHvU1o_kooMc2hML8iWcNrz=mp6tYT52iGwfjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:44:17PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:33 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Support dword access for get_user_size and redesign put_user_size with
> > the same style of get_user_size. It's Ok to use xxx_user_asm_common for
> > all size of variable with ldb, ldh, ldw, ld.d
> >
> > ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
> > follow abiv2 gcc ABI for dword access.
> 
> Are you sure this is correct for this?
> 
> static inline u32 get_64_to_32(__u64 __user *p)
> {
>       u32 ret;
>       get_user(ret, p);
>       return ret;
> }
> 
> If I read __get_user_asm_common() right, the ld.d would overwrite
> two registers, but the caller only expects one, so it clobbers one
> that might be in use.
Ah... BUG! I only consider the get_user(u64, u64 *) :P

Change to:
case 8:							\
__get_user_asm_dword((x), ptr, "ld.d", retval);		\
break;

#define __get_user_asm_dword(x, ptr, err)		\
do {							\
	u64 tmp;					\
	__get_user_asm_common(tmp, ptr, "ld.d", err);	\
	x = typeof(x) tmp;				\
} while(0)

#define __put_user_asm_dword(x, ptr, err)		\
do {							\
	u64 tmp = (u64) x;				\
	__put_user_asm_common(tmp, ptr, "st.d", err);	\
} while(0)

Hmm?

Best Regards
 Guo Ren
