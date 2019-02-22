Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BCD206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfBVU2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:28:15 -0500
Received: from nautica.notk.org ([91.121.71.147]:39960 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfBVU2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:28:14 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A9889C009; Fri, 22 Feb 2019 21:28:09 +0100 (CET)
Date:   Fri, 22 Feb 2019 21:27:54 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tom Herbert <tom@herbertland.com>
Cc:     Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190222202754.GA20806@nautica>
References: <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica>
 <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica>
 <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
 <20190215045214.GA13123@nautica>
 <20190220041151.GA13520@nautica>
 <CALx6S35jPN+E7-A4JK9ypAETophtKrJzjd9HPmXowU7RMS=bcA@mail.gmail.com>
 <20190221082209.GA32719@nautica>
 <CALx6S36o3JVHh3UtOsfXNrosXK0NCZo703gfzfJPgJvZK9brOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALx6S36o3JVHh3UtOsfXNrosXK0NCZo703gfzfJPgJvZK9brOA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Herbert wrote on Fri, Feb 22, 2019:
> > > So basically it sounds like you're interested in supporting TCP
> > > connections that are half closed. I believe that the error in half
> > > closed is EPIPE, so if the TCP socket returns that it can be ignored
> > > and the socket can continue being attached and used to send data.
> >
> > Did you mean 'can continue being attached and used to receive data'?
>
> No, I meant shutdown on receive side when FIN is receved. TX is still
> allowed to drain an queued bytes. To support shutdown on the TX side
> would require additional logic since we need to effectively detach the
> transmit path but retain the receive path. I'm not sure this is a
> compelling use case to support.

Hm, it must be a matter of how we see thing but from what I understand
it's exactly the other way around. The remote closed the connection, so
trying to send anything would just yield a RST, so TX doesn't make
sense.
On the other hand, anything that had been sent by the remote before the
FIN and is on the local side's memory should still be receivable.

When you think about it as a TCP stream it's really weird: data coming,
data coming, data coming, FIN received.
But in the networking stack that received FIN short-circuits all the
data that was left around and immediately raises an EPIPE error.

I don't see what makes this FIN packet so great that it should be
processed before the data; we should only see that EPIPE when we're
done reading the data before it or trying to send something.

I'll check tomorrow/next week but I'm pretty sure the packets before
that have been ack'd at a tcp level as well, so losing them in the
application level is really unexpected.
 
> > I can confirm getsockopt with SO_ERROR gets me EPIPE, but I don't see
> > how to efficiently ignore EPIPE until POLLIN gets unset -- polling on
> > both the csock and kcm socket will do many needless wakeups on only the
> > csock from what I can see, so I'd need some holdoff timer or something.
> > I guess it's possible though.
> 
> We might need to clear the error somehow. May a read of zero bytes?

Can try.

> > After a bit more debugging, this part works (__strp_recv() is called
> > again); but the next packet that is treated properly is rejected because
> > by the time __strp_recv() was called again a new skb was read and the
> > length isn't large enough to go all the way into the new packet, so this
> > test fails:
> >                         } else if (len <= (ssize_t)head->len -
> >                                           skb->len - stm->strp.offset) {
> >                                 /* Length must be into new skb (and also
> >                                  * greater than zero)
> >                                  */
> >                                 STRP_STATS_INCR(strp->stats.bad_hdr_len);
> >                                 strp_parser_err(strp, -EPROTO, desc);
> >
> > So I need to figure a way to say "call this function again without
> > reading more data" somehow, or make this check more lax e.g. accept any
> > len > 0 after a retry maybe...
> > Removing that branch altogether seems to work at least but I'm not sure
> > we'd want to?
> 
> I like the check since it's conservative and covers the normal case.
> Maybe just need some more logic?

I can add a "retrying" state and not fail here if we ewre retrying for
whatever reason perhaps...
But I'm starting to wonder how this would work if my client didn't keep
on sending data, I'll try to fail on the last client's packet and see
how __strp_recv is called again through the timer, with the same skb
perhaps?

-- 
Dominique
