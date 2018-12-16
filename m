Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D195B21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbeLPTdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:33:47 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:35569 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730688AbeLPTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:33:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 403DB2B5202D;
        Sun, 16 Dec 2018 20:33:45 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oUn-c8l3N9_9; Sun, 16 Dec 2018 20:33:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id CD2E52B52035;
        Sun, 16 Dec 2018 20:33:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qFxLihmiS-mT; Sun, 16 Dec 2018 20:33:43 +0100 (CET)
Received: from localhost (unknown [82.120.188.200])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTPSA id 8421A2B5202D;
        Sun, 16 Dec 2018 20:33:43 +0100 (CET)
Date:   Sun, 16 Dec 2018 20:33:43 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] l2tp: Add Protocol field compression
Message-ID: <20181216193319.h5kxzuuo7unalg7u@kdev>
References: <20181214211242.9721-1-semen.protsenko@linaro.org>
 <20181214211242.9721-2-semen.protsenko@linaro.org>
 <20181216163059.i5nadsfzyvcwa4o6@kdev>
 <CAKaJLVvj2Yv0hOXiRLvJ1Gnm3axOds21LHxmCW5K0YNpx+hk6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaJLVvj2Yv0hOXiRLvJ1Gnm3axOds21LHxmCW5K0YNpx+hk6w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 08:46:19PM +0200, Sam Protsenko wrote:
> Hi Guillaume,
> 
> On Sun, Dec 16, 2018 at 6:30 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
> >
> > On Fri, Dec 14, 2018 at 11:12:42PM +0200, Sam Protsenko wrote:
> > > When Protocol Field Compression (PFC) is enabled, the "Protocol" field
> > > in PPP packet should be transmitted without leading 0x00. See section
> > > 6.5 in RFC 1661 for details. Let's compress protocol field if needed,
> > > the same way it's done in drivers/net/ppp/pptp.c.
> > >
> > > To actually enable PFC, one should issue corresponding ioctl to L2TP
> > > driver from user-space, like this:
> > >
> > >     ioctl(fd, PPPIOCGFLAGS, &flags);
> > >     flags |= SC_COMP_PROT;
> > >     ioctl(fd, PPPIOCSFLAGS, &flags);
> > >
> > > It can be done e.g. from pppol2tp plugin (pppd), when pcomp option was
> > > negotiated with peer.
> > >
> > > Of course, we don't compress Protocol field when sending LCP packets. As
> > > stated in RFC 1661, section 6.5:
> > >
> > >     The Protocol field is never compressed when sending any LCP
> > >     packet.  This rule guarantees unambiguous recognition of LCP
> > >     packets.
> > >
> > Again, I'm sorry, but I must oppose this change. Although I'm lacking
> > time to keep sanitising L2TP, at least I'd like to avoid making the
> > situation worse.
> >
> > L2TP's uapi is already messy enough. Please don't add non-L2TP features
> > there.
> >
> > Activating PFC should be done on PPP file descriptors, not no L2TP
> > sockets. We certainly don't want L2TP to snoop on PPP data, much less
> > modify them.
> 
> Makes sense. I thought about this, too, just found that it's done that
> way in PPTP code and decided not to be too smart about this. Let me
> try and re-work this one. Will send v2 soon.
> 
While at it, be sure to target net-next and to post a cover letter if
you have more than one patch in the series.

Also, the code will have to be compatible with those layers that
already implement PFC using their own API (pptp.c, ppp_async.c, etc.).
I haven't looked at MP-PPP for a while, but multi-link might have to be
taken into account too.

But, for now, fixing the reception part is more important, IMO.
