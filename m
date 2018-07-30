Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981520894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7981520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeG3VUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:20:45 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:39262 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727474AbeG3VUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:20:45 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1fkE4Y-0004RM-1Y; Mon, 30 Jul 2018 21:43:14 +0200
Date:   Mon, 30 Jul 2018 21:43:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Miller <davem@davemloft.net>, nharold@google.com,
        fw@strlen.de, steffen.klassert@secunet.com,
        linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        0x7f454c46@gmail.com, netdev@vger.kernel.org, luto@kernel.org,
        ard.biesheuvel@linaro.org, hpa@zytor.com, mingo@redhat.com,
        john.stultz@linaro.org, kirill.shutemov@linux.intel.com,
        oleg@redhat.com, sboyd@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, x86@kernel.org, linux-efi@vger.kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, eparis@redhat.com,
        kadlec@blackhole.kfki.hu, pablo@netfilter.org, paul@paul-moore.com,
        coreteam@netfilter.org, linux-audit@redhat.com,
        netfilter-devel@vger.kernel.org, fan.du@intel.com
Subject: Re: [PATCH 00/18] xfrm: Add compat layer
Message-ID: <20180730194314.ixzvniuvdfofvvpj@breakpoint.cc>
References: <1532703111.2679.20.camel@arista.com>
 <CADhJOfam+cY8uD4XTGvZSEFQdAgTu49G6cg6c64NJoP3bNuBmw@mail.gmail.com>
 <1532795215.2679.27.camel@arista.com>
 <20180728.141812.1026007723536955024.davem@davemloft.net>
 <1532972360.2679.32.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532972360.2679.32.camel@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <dima@arista.com> wrote:
> On Sat, 2018-07-28 at 14:18 -0700, David Miller wrote:
> > From: Dmitry Safonov <dima@arista.com>
> > Date: Sat, 28 Jul 2018 17:26:55 +0100
> > 
> > > Well, I think, I'll rework my patches set according to critics and
> > > separate compat xfrm layer. I've already a selftest to check that
> > 32/64
> > > bit xfrm works - so the most time-taking part is done.
> > 
> > The way you've done the compat structures using __packed is only
> > going
> > to work on x86, just FYI.
> 
> Thanks for pointing, so I'll probably cover it under something like
> HAS_COMPAT_XFRM.
> (if there isn't any better idea).

You can do that, I suspect you can use
CONFIG_COMPAT_FOR_U64_ALIGNMENT
as AFAICR the only reason for the compat problem is different alignment
requirements of 64bit integer types in the structs, not e.g. due to
"long" size differences.

Instead of __packed, you can use the "compat" data types, e.g.
compat_u64 instead of u64:

struct compat_xfrm_lifetime_cur {
	compat_u64 bytes, packets, add_time, use_time;
}; /* same size on i386, but only 4 byte alignment required even on x86_64*/

You might be able to reuse
https://git.breakpoint.cc/cgit/fw/net-next.git/commit/?h=xfrm_config_compat_07&id=f64430e6d9e297f3990f485a4832e273751b9869

in your patch set.

I can try to submit the first few patches (which are not related to
compat, they just add const qualifiers) for inclusion later this week.
