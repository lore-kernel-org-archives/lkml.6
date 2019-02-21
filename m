Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEDFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8F720818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBUIWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:22:30 -0500
Received: from nautica.notk.org ([91.121.71.147]:55415 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbfBUIW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:22:29 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id D1AE3C009; Thu, 21 Feb 2019 09:22:24 +0100 (CET)
Date:   Thu, 21 Feb 2019 09:22:09 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tom Herbert <tom@herbertland.com>
Cc:     Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190221082209.GA32719@nautica>
References: <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica>
 <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica>
 <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica>
 <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
 <20190215045214.GA13123@nautica>
 <20190220041151.GA13520@nautica>
 <CALx6S35jPN+E7-A4JK9ypAETophtKrJzjd9HPmXowU7RMS=bcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALx6S35jPN+E7-A4JK9ypAETophtKrJzjd9HPmXowU7RMS=bcA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Herbert wrote on Wed, Feb 20, 2019:
> > When the client closes the socket, some messages are obviously still "in
> > flight", and the server will recv a POLLERR notification on the csock at
> > some point with many messages left.
> > The documentation says to unattach the csock when you get POLLER. If I
> > do that, the kcm socket will no longer give me any message, so all the
> > messages still in flight at the time are lost.
> 
> So basically it sounds like you're interested in supporting TCP
> connections that are half closed. I believe that the error in half
> closed is EPIPE, so if the TCP socket returns that it can be ignored
> and the socket can continue being attached and used to send data.

Did you mean 'can continue being attached and used to receive data'?

I can confirm getsockopt with SO_ERROR gets me EPIPE, but I don't see
how to efficiently ignore EPIPE until POLLIN gets unset -- polling on
both the csock and kcm socket will do many needless wakeups on only the
csock from what I can see, so I'd need some holdoff timer or something.
I guess it's possible though.

> Another possibility is to add some linger semantics to an attached
> socket. For instance, a large message might be sent so that part of
> the messge is queued in TCP and part is queued in the KCM socket.
> Unattach would probably break that message. We probably want to linger
> option similar to SO_LINGER (or maybe just use the option on the TCP
> socket) that means don't complete the detach until any message being
> transmitted on the lower socket has been queued.

That would certainly work, even if non-obvious from a user standpoint.


> > > I'd like to see some retry on ENOMEM before this is merged though, so
> > > while I'm there I'll resend this with a second patch doing that
> > > retry,.. I think just not setting strp->interrupted and not reporting
> > > the error up might be enough? Will have to try either way.
> >
> > I also tried playing with that without much success.
> > I had assumed just not calling strp_parser_err() (which calls the
> > abort_parser cb) would be enough, eventually calling strp_start_timer()
> > like the !len case, but no can do.
> 
> I think you need to ignore the ENOMEM and have a timer or other
> callback to retry the operation in the future.

Yes, that's what I had intended to try; basically just break out and
schedule timer as said above.

After a bit more debugging, this part works (__strp_recv() is called
again); but the next packet that is treated properly is rejected because
by the time __strp_recv() was called again a new skb was read and the
length isn't large enough to go all the way into the new packet, so this
test fails:
                        } else if (len <= (ssize_t)head->len -
                                          skb->len - stm->strp.offset) {
                                /* Length must be into new skb (and also
                                 * greater than zero)
                                 */
                                STRP_STATS_INCR(strp->stats.bad_hdr_len);
                                strp_parser_err(strp, -EPROTO, desc);

So I need to figure a way to say "call this function again without
reading more data" somehow, or make this check more lax e.g. accept any
len > 0 after a retry maybe...
Removing that branch altogether seems to work at least but I'm not sure
we'd want to?
(grmbl at this slow VM and strparser not being possible to enable as a
module, it takes ages to test)


> > With that said, returning 0 from the parse function also raises POLLERR
> > on the csock and hangs netparser, so things aren't that simple...
> 
> Can you point to where this is happening. If the parse_msg callback
> returns 0 that is suppose to indicate that more bytes are needed.

I just blindly returned 0 "from time to time" in the kcm parser
function, but looking at above it was failing on the same check.
This somewhat makes sense for this one to fail here if a new packet was
read, no sane parser function should give a length smaller than what
they require to determine the length.


Thanks,
-- 
Dominique
