Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A39FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C1A206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbfBODbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:31:21 -0500
Received: from nautica.notk.org ([91.121.71.147]:48203 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfBODbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:31:20 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9AB7CC009; Fri, 15 Feb 2019 04:31:17 +0100 (CET)
Date:   Fri, 15 Feb 2019 04:31:02 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tom Herbert <tom@herbertland.com>
Cc:     David Miller <davem@davemloft.net>, doronrk@fb.com,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190215033102.GA3099@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
 <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica>
 <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica>
 <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Herbert wrote on Thu, Feb 14, 2019:
> > This second patch[2] (the current thread) now does an extra clone if
> > there is an offset, but the problem really isn't in the clone but the
> > pull itself that can fail and return NULL when there is memory pressure.
> > For some reason I hadn't been able to reproduce that behaviour with
> > strparser doing the pull, but I assume it would also be possible to hit
> > in extreme situations, I'm not sure...
>
> This option looks the best to me, at least as a way to fix the issue
> without requiring a change to the API. If the pull fails, doesn't that
> just mean that the parser fails? Is there some behavior with this
> patch that is not being handled gracefully?

Yes, the parser fails with -ENOMEM ; that is not handled gracefully at
all: from a user point of view, the connection just hangs (recvmsg never
returns), without so much as a message in dmesg either.

It took me a while to figure out what failed exactly as I did indeed
expect strparser/kcm to handle that better, but ultimately as things
stand if the parser fails it calls strp_parser_err() with the error
which ends up in strp_abort_strp that should call
sk->sk_error_report(sk) but in kcm case sk is the csk and I guess
failing csk does not make a pending recv on the kcm sock to fail...

I'm not sure whether propagating the error to the upper socket is the
right thing to do, kcm is meant to be able to work with multiple
underlying sockets so I feel we must be cautious about that, but
strparser might be able to retry somehow.
This is what I said below:
> > [,,,]
> >  - the current patch, that I could only get to fail with KASAN, but does
> > complexify kcm a bit; this also does not fix bpf sockmap at all.
> > Would still require to fix the hang, so make strparser retry a few times
> > if strp->cb.parse_msg failed maybe? Or at least get the error back to
> > userspace somehow.

Thanks,
-- 
Dominique
