Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7752AC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A52F21B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfBOEwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:52:34 -0500
Received: from nautica.notk.org ([91.121.71.147]:41326 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfBOEwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:52:34 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 35FDEC009; Fri, 15 Feb 2019 05:52:29 +0100 (CET)
Date:   Fri, 15 Feb 2019 05:52:14 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tom Herbert <tom@quantonium.net>
Cc:     Tom Herbert <tom@herbertland.com>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190215045214.GA13123@nautica>
References: <20180912053642.GA2912@nautica>
 <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
 <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica>
 <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica>
 <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica>
 <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Herbert wrote on Thu, Feb 14, 2019:
> On Thu, Feb 14, 2019 at 7:31 PM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > Yes, the parser fails with -ENOMEM ; that is not handled gracefully at
> > all: from a user point of view, the connection just hangs (recvmsg never
> > returns), without so much as a message in dmesg either.
>
> That's by design. Here is the description in kcm.txt:
> 
> "When a TCP socket is attached to a KCM multiplexor data ready
> (POLLIN) and write space available (POLLOUT) events are handled by the
> multiplexor. If there is a state change (disconnection) or other error
> on a TCP socket, an error is posted on the TCP socket so that a
> POLLERR event happens and KCM discontinues using the socket. When the
> application gets the error notification for a TCP socket, it should
> unattach the socket from KCM and then handle the error condition (the
> typical response is to close the socket and create a new connection if
> necessary)."

Sigh, that's what I get for relying on pieces of code found on the
internet.

It does make "trivial" kcm sockets difficult to use though, the old
ganesha code I adapted to kcm was the horrible (naive?) kind spawning
one thread per connection and just waiting on read(), so making it just
create a kcm socket from the tcp one and wait on recvmsg() until an
error pops up does not seem an option.

That being said I'm a bit confused, I thought part of the point of kcm
was the multiplexing so a simple server could just keep attaching tcp
sockets to a single kcm socket and only have a single trivial loop
reading from the kcm socket ; but I guess there's no harm in also
looking for POLLERR on the tcp sockets... It would still need to close
them once clients disconnect I guess, this really only affects my naive
server.

> > strparser might be able to retry somehow.
> 
> We could retry on -ENOMEM since it is potentially a transient error,

Yes, I think we should aim to retry on -ENOMEM; I agree all errors are
not meant to be retried on but there already are different cases based
on what the parse cb returned; but that can be a different patch.

> but generally for errors (like connection is simply broken) it seems
> like it's working as intended. I suppose we could add a socket option
> to fail the KCM socket when all attached lower sockets have failed,
> but I not sure that would be a significant benefit for additional
> complexity.

Right, I agree it's probably not worth doing, now I'm aware of this I
can probably motivate myself to change this old code to use epoll
properly.

I think it could make sense to have this option for simpler programs,
but as things stand I guess we can require kcm users to do this much,
thanks for the explanation, and sorry for having failed to notice it.



With all that said I guess my patch should work correctly then, I'll try
to find some time to check the error does come back up the tcp socket in
my reproducer but I have no reason to believe it doesn't.

I'd like to see some retry on ENOMEM before this is merged though, so
while I'm there I'll resend this with a second patch doing that
retry,.. I think just not setting strp->interrupted and not reporting
the error up might be enough? Will have to try either way.



Thanks for the feedback,
-- 
Dominique
