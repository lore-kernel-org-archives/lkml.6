Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C48C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74732246E9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74732246E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeFVRvQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:51:16 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:32902 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933995AbeFVRvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:51:15 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w5MHp37u004287;
        Fri, 22 Jun 2018 18:51:03 +0100
Date:   Fri, 22 Jun 2018 18:51:03 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Adam Borowski <kilobyte@angband.pl>, Dave Mielke <Dave@mielke.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180622185103.21a53a66@alans-desktop>
In-Reply-To: <nycvar.YSQ.7.76.1806221222340.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
        <20180619130953.bxil552igfkckjmr@angband.pl>
        <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
        <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
        <20180621022137.GB18453@beta.private.mielke.cc>
        <20180622015445.7r5u5nn6ofhd4k57@angband.pl>
        <20180622165927.68679862@alans-desktop>
        <nycvar.YSQ.7.76.1806221222340.16670@knanqh.ubzr>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 12:28:17 -0400 (EDT)
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> On Fri, 22 Jun 2018, Alan Cox wrote:
> 
> > > The other point is a quite pointless assumption that existing scrollback is
> > > "optimized".  Even vgacon mostly uses software scrollback these days, as the
> > > amount of VGA display memory is really small.  
> > 
> > All of our console driver code is horribly unoptimized for most of
> > todays hardware. Long ago I did look at what was needed but it's a
> > seriously non-trivial change. In particular
> > 
> > - Console I/O occurs under enough locks to keep fort knox safe. That
> >   means it's very very hard to accelerate
> > 
> > - The logic is plain wrong for a lot of modern video. We shouldn't be
> >   scrolling, we should be rendering the current backing text buffer at
> >   video refresh rate or similar and if the source of the updates outruns
> >   us it doesn't matter - we don't have to draw all the glyphs as if we
> >   were fast enough they would have been a blur anyway.  
> 
> My executive summary from what you say is that there is no longer an 
> advantage to maintain a central vga-style glyph buffer in the core 
> console code, right?

Yeah. The only driver that it suits is the VGA text mode driver, which at
2GHz+ is going to be fast enough whatever format you convert from. We
have the memory, the processor power and the fact almost all our displays
are bitmapped (or more complex still) all in favour of throwing away that
limit.

Alan
