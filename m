Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1552EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFAE2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfBOB5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:57:23 -0500
Received: from nautica.notk.org ([91.121.71.147]:60003 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfBOB5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:57:22 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0F4F3C009; Fri, 15 Feb 2019 02:57:20 +0100 (CET)
Date:   Fri, 15 Feb 2019 02:57:05 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tom Herbert <tom@herbertland.com>
Cc:     David Miller <davem@davemloft.net>, doronrk@fb.com,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190215015705.GA17974@nautica>
References: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
 <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
 <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica>
 <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Herbert wrote on Thu, Feb 14, 2019:
> > The best alternative I see is adding a proper helper to get
> > "kcm_rx_msg(skb)->offset" from bpf and document it so users aren't as
> > lost as I have been; I'm not quite sure how/where to add such a helper
> > though as I've barely looked at the bpf code until now, but should we go
> > for that?
> 
> I'd rather not complicate the bpf code for this. Can we just always do
> an pskb_pull after skb_clone?

Which skb_clone are you thinking of?
If you're referring to the one in strparser, that was my very first
approach here[1], but Dordon shot it down saying that this is not an
strparser bug but a kcm bug since there are ways for users to properly
get the offset and use it -- and the ktls code does it right.

Frankly, my opinion still is that it'd be better in strparser because
there also is some bad use in bpf sockmap (they never look at the offset
either, while kcm uses it for rcv but not for parse), but looking at it
from an optimal performance point of view I agree the user can make
better decision than strparser so I understand where he comes from.


This second patch[2] (the current thread) now does an extra clone if
there is an offset, but the problem really isn't in the clone but the
pull itself that can fail and return NULL when there is memory pressure.
For some reason I hadn't been able to reproduce that behaviour with
strparser doing the pull, but I assume it would also be possible to hit
in extreme situations, I'm not sure...

So anyway, we basically have three choices that I can see:
 - push harder on strparser and go back to my first patch ; it's simple
and makes using strparser easier/safer but has a small overhead for
ktls, which uses the current strparser implementation correctly.
I hadn't been able to get this to fail with KASAN last time I tried but
I assume it should still be possible somehow.

 - the current patch, that I could only get to fail with KASAN, but does
complexify kcm a bit; this also does not fix bpf sockmap at all.
Would still require to fix the hang, so make strparser retry a few times
if strp->cb.parse_msg failed maybe? Or at least get the error back to
userspace somehow.

 - my last suggestion to document the kcm behaviour, and if possible add
a bpf helper to make proper usage easier ; this will make kcm harder to
use on end users but it's better than not being documented and seeing
random unappropriate lengths being parsed.



[1] first strparser patch
http://lkml.kernel.org/r/1534855906-22870-1-git-send-email-asmadeus@codewreck.org
[2] current thread's patch
http://lkml.kernel.org/r/1536657703-27577-1-git-send-email-asmadeus@codewreck.org


Thanks,
-- 
Dominique
