Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52668C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1D20875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A1D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeFUBn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:43:26 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:56036 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754276AbeFUBnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:43:23 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fVod3-0003z9-9y; Thu, 21 Jun 2018 03:43:17 +0200
Date:   Thu, 21 Jun 2018 03:43:17 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:34:34AM -0400, Nicolas Pitre wrote:
> On Tue, 19 Jun 2018, Adam Borowski wrote:
> > Thus, it'd be nice to use the structure you add to implement full Unicode
> > range for the vast majority of people.  This includes even U+2800..FF.  :)
> 
> Be my guest if you want to use this structure. As for U+2800..FF, like I 
> said earlier, this is not what most people use when communicating, so it 
> is of little interest even to blind users except for displaying native 
> braille documents, or showing off. ;-)

It's meant for displaying braille to _sighted_ people.  And in real world,
the main [ab]use is a way to show images that won't get corrupted by
proportional fonts. :-þ

> If the core console code makes the switch to full unicode then yes, that 
> would be the way to go to maintain backward compatibility. However 
> vgacon users would see a performance drop when switching between VT's 
> and we used to brag about how fast the Linux console used to be 20 years 
> ago. Does it still matter today?

I've seen this slowness.  A long time ago, on a server that someone gave an
_ISA_ graphics card (it was an old machine, and it was 1.5 decades ago). 
Indeed, switching VTs took around a second.  But this was drawing speed, not
Unicode conversion.

There are three cases when a character can enter the screen:
* being printed by the tty.  This is the only case not sharply rate-limited.
  It already has to do the conversion.  If we eliminate the old struct, it
  might even be a speed-up when lots of text gets blasted to a non-active
  VT.
* VT switch
* scrollback

The last two cases are initiated by the user, and within human reaction time
you need to convert usually 2000 -- up to 20k-ish -- characters.  The
conversion is done by a 3-level array.  I think a ZX Spectrum can handle
this fine without a visible slowdown.

> > > I'm a prime user of this feature, as well as the BRLTTY maintainer Dave Mielke
> > > who implemented support for this in BRLTTY. There is therefore a vested
> > > interest in maintaining this feature as necessary. And this received
> > > extensive testing as well at this point.
> > 
> > So, you care only about people with faulty wetware.  Thus, it sounds like
> > work that benefits sighted people would need to be done by people other than
> > you. 
> 
> Hard for me to contribute more if I can't enjoy the result.

Obviously.

The primary users would be:
* people who want symbols uncorrupted (especially if their language uses a
  non-latin script)
* CJK people (as discussed below)

It could also simplify the life for distros -- less required configuration:
a single font needed for currently supported charsets together has mere
~1000 glyphs, at 8x16 that's 16000 bytes (+ mapping).  Obviously for CJK
that's more.
 
> > So I'm only mentioning possible changes; they could possibly go after
> > your patchset goes in:
> > 
> > A) if memory is considered to be at premium, what about storing only one
> >    32-bit value, masked 21 bits char 11 bits attr?  On non-vgacon, there's
> >    no reason to keep the old structures.
> 
> Absolutely. As soon as vgacon is officially relegated to second class 
> citizen i.e. perform the glyph translation each time it requires 
> a refresh instead of dictating how the core console code works then the 
> central glyph buffer can go.

Per the analysis above, on-the-fly translation is so unobtrusive that it
shouldn't be a problem.

> > B) if being this frugal wrt memory is ridiculous today, what about instead
> >    going for 32 bits char (wasteful) 32 bits attr?  This would be much nicer
> >    15 bit fg color + 15 bit bg color + underline + CJK or something.
> > You already triple memory use; variant A) above would reduce that to 2x,
> > variant B) to 4x.
> 
> You certainly won't find any objections from me.

Right, let's see if your patchset gets okayed before building atop it.
 
> In the mean time, both systems may work in parallel for a smooth 
> transition.

Sounds like a good idea.


WRT support for fonts >512 glyphs: I talked to a Chinese hacker (log
starting at 15:32 on https://irclog.whitequark.org/linux-sunxi/2018-06-19),
she said there are multiple popular non-mainline patchsets implementing CJK
on console.  None of them got accepted because of pretty bad code like
https://github.com/Gentoo-zh/linux-cjktty/commit/b6160f85ef5bc5c2cae460f6c0a1aba3e417464f
but getting this done cleanly would require just:
* your patchset here
* console driver using the Unicode structure
* loading such larger fonts (the one in cjktty is built-in)
* double-width characters in vt.c


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ There's an easy way to tell toy operating systems from real ones.
⣾⠁⢰⠒⠀⣿⡁ Just look at how their shipped fonts display U+1F52B, this makes
⢿⡄⠘⠷⠚⠋⠀ the intended audience obvious.  It's also interesting to see OSes
⠈⠳⣄⠀⠀⠀⠀ go back and forth wrt their intended target.
