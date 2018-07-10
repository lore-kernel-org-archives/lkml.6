Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5648208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5648208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeGJIjE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:39:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:60195 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbeGJIjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:39:01 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B605BC009; Tue, 10 Jul 2018 10:38:59 +0200 (CEST)
Date:   Tue, 10 Jul 2018 10:38:44 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [V9fs-developer] [PATCH] p9_check_errors() validate PDU length
Message-ID: <20180710083844.GA23124@nautica>
References: <20180709224323.20597-1-tomasbortoli@gmail.com>
 <20180709235403.GB19917@nautica>
 <20180710022819.GA19285@nautica>
 <ba4e159c-a78e-1d42-ca11-d4c8897a9a83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba4e159c-a78e-1d42-ca11-d4c8897a9a83@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Tue, Jul 10, 2018:
> > This however gets more complicated once you start factoring in that
> > change I suggested about p9_parse_header not setting size (and checking
> > size) because trans_fd relies on it; so I'm not sure how we should
> > proceed.
>
> Mmh, me neither. I don't see where the *actual* PDU length is stored.

That's precisely the problem, none of the transports actually write in
the pdu how much has been read.
Instead, we blindly trust how much the client says it has written and
p9_parse_header will write pdu->size which is then used as the 'actual'
PDU length.


With the three lines I added in each file all transports will store the
PDU length in pdu->size so my following suggestion would be to just
check that in p9_parse_header the length read from the packet match that
of the received data and flag any packet where this is wrong as invalid.

The only problem with that is that TCP will use p9_parse_header with a
partial packet to know how much it needs to read, so that modification
needs actual testing (hence my question below) as it is more intrusive
than a simple boundary check.

I'd suggest implementing some logic like already here with the if
(pdu->size == 0) -- only check if pdu->size was previously set, and set
it if it wasn't... But feel free to try something else.

With that done I don't expect more problems but if I do it there's
little point in making you do it as well ;)


> > Do you have a working 9p tcp server to test changes are valid, or are
> > you only working off the syzbot reproducer?
>
> No, I was just using the reproducer to test.
>
> > In the first place, are you willing to take the time to do that bigger
> > fix?
>
> Yes.

Ok, let's get you a working setup for TCP then.
You need to install a 9p server, the two I'm aware of are diod and
nfs-ganesha (I'm using ganesha); once you have a working config you can
mount with something like this:
 mount -t 9p -o aname=path,trans=fd <server-ip> <mount-point>

Once you have that you should be able to fiddle with things until it
works as expected.
(for virtio I use qemu, that's probably easy to test as well; for RDMA
you can use rxe to setup a virtual interface (with rxe_cfg) and then use
either diod or ganesha again but the setup is more complicated so it's
OK to leave that aside for now)

> For me both ways are good. Signed-off-by will be good.
> You know for sure more than me about 9p as I started delving it for the
> first time yesterday. I can also make and test a patch but I'll need to
> understand more about it. Let me know if you find out more.

There's a saying about giving a fish or teaching how to fish, so let's
have you try if you're motivated :)

I don't think much is left if you can sew the pieces together, the most
difficult part will probably to set the test environment up if you want
to do this properly.


Please ask if you run into any trouble,
-- 
Dominique Martinet | Asmadeus
