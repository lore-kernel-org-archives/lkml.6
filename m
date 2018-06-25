Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABE3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7587D25393
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7587D25393
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeFYAdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 20:33:12 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:50650 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeFYAdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 20:33:11 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fXFRH-0005xl-Hh; Mon, 25 Jun 2018 02:33:03 +0200
Date:   Mon, 25 Jun 2018 02:33:03 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180625003303.fqq6kr2dg4lffcve@angband.pl>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
 <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
 <nycvar.YSQ.7.76.1806202210500.16670@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YSQ.7.76.1806202210500.16670@knanqh.ubzr>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:59:08PM -0400, Nicolas Pitre wrote:
> On Thu, 21 Jun 2018, Adam Borowski wrote:
> 
> > On Tue, Jun 19, 2018 at 11:34:34AM -0400, Nicolas Pitre wrote:
> > > On Tue, 19 Jun 2018, Adam Borowski wrote:
> > > > Thus, it'd be nice to use the structure you add to implement full Unicode
> > > > range for the vast majority of people.  This includes even U+2800..FF.  :)

> > > If the core console code makes the switch to full unicode then yes, that 
> > > would be the way to go to maintain backward compatibility. However 
> > > vgacon users would see a performance drop when switching between VT's 
> > > and we used to brag about how fast the Linux console used to be 20 years 
> > > ago. Does it still matter today?
> 
> > * VT switch
> > * scrollback
> > 
> > The last two cases are initiated by the user, and within human reaction time
> > you need to convert usually 2000 -- up to 20k-ish -- characters.  The
> > conversion is done by a 3-level array.  I think a ZX Spectrum can handle
> > this fine without a visible slowdown.
> 
> In the scrollback case, currently each driver is doing its own thing. 
> The vgacon driver is probably the most efficient as it only moves the 
> base memory register around without copying anything at all. And that 
> part doesn't have to change.

As long as the data is still in video memory, yeah.  Soft scrollback is not
yet the default, because some userspace tools assume vt switch clears
scrollback and do so for security reasons.  All known tools that do so have
been fixed (at least in Debian), but as you can run new kernels with
arbitrarily old userspace, it's better to wait a bit longer before switching
to something effectively identical to soft scrollback.  Failure mode: after
logout, you can scroll back to the supposedly cleared content of the old
session.

Your code avoids this, at the cost of losing data about anything
representable by the currently loaded charset for anything inside
scrollback.

But in the near future, it'd be good to have soft scrollback work the same
for all drivers.

> > Right, let's see if your patchset gets okayed before building atop it.
> 
> May I add your ACK to it?

I don't believe I'm knowledgeful nor active enough in this part for my ACKs
to be meaningful.  On the other hand, I've analyzed your patchset long
enough to see no problems with it, thus if you have an use for my tags, then
sure, you have my ACK.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ There's an easy way to tell toy operating systems from real ones.
⣾⠁⢰⠒⠀⣿⡁ Just look at how their shipped fonts display U+1F52B, this makes
⢿⡄⠘⠷⠚⠋⠀ the intended audience obvious.  It's also interesting to see OSes
⠈⠳⣄⠀⠀⠀⠀ go back and forth wrt their intended target.
