Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19432183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 04:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfBTEMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:12:13 -0500
Received: from nautica.notk.org ([91.121.71.147]:39353 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfBTEMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 23:12:13 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 69EECC009; Wed, 20 Feb 2019 05:12:07 +0100 (CET)
Date:   Wed, 20 Feb 2019 05:11:52 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tom Herbert <tom@quantonium.net>
Cc:     Tom Herbert <tom@herbertland.com>,
        David Miller <davem@davemloft.net>,
        Doron Roberts-Kedes <doronrk@fb.com>,
        Dave Watson <davejwatson@fb.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcm: remove any offset before parsing messages
Message-ID: <20190220041151.GA13520@nautica>
References: <20180917.184502.447385458615284933.davem@davemloft.net>
 <20180918015723.GA26300@nautica>
 <20181031025657.GA17861@nautica>
 <20190215010029.GA10899@nautica>
 <CALx6S35HBKgtYkFde_AhCMPRtZfcVYfCYf=mLKjWSLLAfhMHyQ@mail.gmail.com>
 <20190215015705.GA17974@nautica>
 <CALx6S37MZadJ=PaAd+SSv9hxSX9kFTmTUtijPGA39JCx3PYq1Q@mail.gmail.com>
 <20190215033102.GA3099@nautica>
 <CAPDqMeoJ7CCo1eGNBp_-crkxfVt_4f=XQqhEo7kmyCN-hf_EWQ@mail.gmail.com>
 <20190215045214.GA13123@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190215045214.GA13123@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Fri, Feb 15, 2019:
> With all that said I guess my patch should work correctly then, I'll try
> to find some time to check the error does come back up the tcp socket in
> my reproducer but I have no reason to believe it doesn't.

Ok, so I can confirm this part - the 'csock' does come back up with
POLLERR if the parse function returns ENOMEM in the current code.

It also comes back up with POLLERR when the remote side closes the
connection, which is expected, but I'm having a very hard time
understanding how an application is supposed to deal with these
POLLERR after having read the documentation and a bit of
experimentation.
I'm not sure how much it would matter for real life (if the other end
closes the connection most servers would not care about what they said
just before closing, but I can imagine some clients doing that in real
life e.g. a POST request they don't care if it succeeds or not)...
My test program works like this:
 - client connects, sends 10k messages and close()s the socket
 - server loops recving and close()s after 10k messages; it used to be
recvmsg() directly but it's now using poll then recvmsg.


When the client closes the socket, some messages are obviously still "in
flight", and the server will recv a POLLERR notification on the csock at
some point with many messages left.
The documentation says to unattach the csock when you get POLLER. If I
do that, the kcm socket will no longer give me any message, so all the
messages still in flight at the time are lost.

If I just ignore the csock like I used to, all the messages do come just
fine, but as said previously on a real error this will just make recvmsg
or the polling hang forever and I see no way to distinguish a "real"
error vs. a connection shut down from the remote side with data left in
the pipe.
I thought of checking POLLERR on csock and POLLIN not set on kcmsock,
but even that seems to happen fairly regularily - the kcm sock hasn't
been filled up, it's still reading from the csock.


On the other hand, checking POLLIN on the csock does say there is still
data left, so I know there is data left on the csock, but this is also
the case on a real error (e.g. if parser returns -ENOMEM)
... And this made me try to read from the csock after detaching it and I
can resume manual tcp parsing for a few messages until read() fails with
EPROTO ?! and I cannot seem to be able to get anything out of attaching
it back to kcm (for e.g. an ENOMEM error that was transient)...



I'm honestly not sure how the POLLERR notification mechanism works but I
think it would be much easier to use KCM if we could somehow delay that
error until KCM is done feeding from the csock (when netparser really
stops reading from it like on real error, e.g. abort callback maybe?)
I think it's fine if the csock is closed before the kcm sock message is
read, but we should not lose messages like this.



> I'd like to see some retry on ENOMEM before this is merged though, so
> while I'm there I'll resend this with a second patch doing that
> retry,.. I think just not setting strp->interrupted and not reporting
> the error up might be enough? Will have to try either way.

I also tried playing with that without much success.
I had assumed just not calling strp_parser_err() (which calls the
abort_parser cb) would be enough, eventually calling strp_start_timer()
like the !len case, but no can do.
With that said, returning 0 from the parse function also raises POLLERR
on the csock and hangs netparser, so things aren't that simple...


I could use a bit of help again.

Thanks,
-- 
Dominique
