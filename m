Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2651C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2811206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544798179;
	bh=XLdKlUninapLHSQFInhjEm3wepY0KIRNOwVq8Anmqg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bCdG2cHsa1gpD80EuN07uszTvpjebHzofUHa3cbAtbdezD99IP1VbItvQGv0Jljvl
	 vWS/wAWoJ4YAOTIibRVAx4s9FJ8mfVzANkUm9BJZKD7pXKBElbhihjWvr3tU4Odz/l
	 07eMSEKIWT1d0RMwgVy2uCqtyVGvoRaiO93aJJjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbeLNOgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729935AbeLNOgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:36:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1280E206BA;
        Fri, 14 Dec 2018 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544798176;
        bh=XLdKlUninapLHSQFInhjEm3wepY0KIRNOwVq8Anmqg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPoCB4dBhKUjLOaInmmcYeG2Bm/2j1nly/aaneR3piEXH5ZTRibHCrEDuQvCjbIhR
         3HGZu+VGXzTiD9iq2C0AQ9JYvP0rXMSH+BQoqltSkSS808gPfVwB7CCirtbpM5F/Mu
         yfUBskC6rVetSusoOwzQbA5MkKjiJx2JDeoTZ/Ro=
Date:   Fri, 14 Dec 2018 15:36:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     sudipm.mukherjee@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4.14 12/89] tcp: Do not underestimate rwnd_limited
Message-ID: <20181214143614.GA29266@kroah.com>
References: <20181214115729.658859279@linuxfoundation.org>
 <20181214115730.277730409@linuxfoundation.org>
 <CADVatmN2tM+zNFmz+upPpV4+g1R1+kg62yL8Q=8jJ4Sy2EU6Xw@mail.gmail.com>
 <20181214142621.GA28340@kroah.com>
 <CANn89iKnuwQAybYEtXwvRFfQ8Rp8VihO16bVucAjDn1GRBtv9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKnuwQAybYEtXwvRFfQ8Rp8VihO16bVucAjDn1GRBtv9w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 06:29:54AM -0800, Eric Dumazet wrote:
> On Fri, Dec 14, 2018 at 6:26 AM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Dec 14, 2018 at 02:03:55PM +0000, Sudip Mukherjee wrote:
> > > Hi Greg,
> > >
> > > On Fri, Dec 14, 2018 at 12:08 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > 4.14-stable review patch.  If anyone has any objections, please let me
> > know.
> > > >
> > > > ------------------
> > > >
> > > > From: Eric Dumazet <edumazet@google.com>
> > > >
> > > > [ Upstream commit 41727549de3e7281feb174d568c6e46823db8684 ]
> > >
> > > There is one upstream commit which fixes this one.
> > > f9bfe4e6a9d0 ("tcp: lack of available data can also cause TSO defer")
> >
> > I can take this if Eric and/or David ack it :)
> >
> >
> I ack it, I guess David had this queued already.
> 
> No big deal, that is only for tcp_info instrumentation accuracy.

If this is already queued for the next round of stable patches, and it's
not a major issue, I'll just wait and take it when it shows up in a week
or so.

thanks,

greg k-h
