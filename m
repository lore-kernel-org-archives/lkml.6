Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EBDC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3841E2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3841E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966416AbeFSNKD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:10:03 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:36866 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965720AbeFSNKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:10:02 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fVGOP-0007o6-RG; Tue, 19 Jun 2018 15:09:53 +0200
Date:   Tue, 19 Jun 2018 15:09:53 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180619130953.bxil552igfkckjmr@angband.pl>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180617190706.14614-1-nicolas.pitre@linaro.org>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 03:07:02PM -0400, Nicolas Pitre wrote:
> The vt code translates UTF-8 strings into glyph index values and stores
> those glyph values directly in the screen buffer. Because there can only
> be at most 512 glyphs, it is impossible to represent most unicode
> characters, in which case a default glyph (often '?') is displayed
> instead. The original unicode value is then lost.
> 
> The 512-glyph limitation is inherent to VGA displays, but users of
> /dev/vcs* shouldn't have to be restricted to a narrow unicode space from
> lossy screen content because of that. This is especially true for
> accessibility applications such as BRLTTY that rely on /dev/vcs to rander
> screen content onto braille terminals.

You're thinking small.  That 256 possible values for Braille are easily
encodable within the 512-glyph space (256 char + stolen fg brightness bit,
another CGA peculiarity).  Your patchset, though, can be used for proper
Unicode support for the rest of us.

The 256/512 value limitation applies only to CGA-compatible hardware; these
days this means vgacon.  But most people use other drivers.  Nouveau forces
graphical console, on arm* there's no such thing as VGA[1], etc.

Thus, it'd be nice to use the structure you add to implement full Unicode
range for the vast majority of people.  This includes even U+2800..FF.  :)

> This patch series introduces unicode support to /dev/vcs* devices,
> allowing full unicode access from userspace to the vt console which
> can, amongst other purposes, appropriately translate actual unicode
> screen content into braille. Memory is allocated, and possible CPU
> overhead introduced, only if /dev/vcsu is read at least once.

What about doing so if any updated console driver is loaded?  Possibly, once
the vt in question has been switched to (>99% people never see anything but
tty1 during boot-up, all others showing nothing but getty).  Or perhaps the
moment any non-ASCII character is output to the given vt.

If memory usage is a concern, it's possible to drop the old structure and
convert back only in the rare case the driver is unloaded; reads of old-
style /dev/vc{s,sa}\d* are not speed-critical thus can use conversion on the
fuly.  Unicode takes only 21 bits out of 32 you allocate, that's plenty of
space for attributes: they currently take 8 bits; naive way gives us free 3
bits that could be used for additional attributes.

Especially underline is in common use these days; efficient support for CJK
would also use one bit to mark left/right half.  And it's decades overdue to
drop blink, which is not even supported by anything but vgacon anyway!
(Graphical drivers tend to show this bit as bright background, but don't
accept SGR codes other thank blink[2].)

> I'm a prime user of this feature, as well as the BRLTTY maintainer Dave Mielke
> who implemented support for this in BRLTTY. There is therefore a vested
> interest in maintaining this feature as necessary. And this received
> extensive testing as well at this point.

So, you care only about people with faulty wetware.  Thus, it sounds like
work that benefits sighted people would need to be done by people other than
you.  So I'm only mentioning possible changes; they could possibly go after
your patchset goes in:

A) if memory is considered to be at premium, what about storing only one
   32-bit value, masked 21 bits char 11 bits attr?  On non-vgacon, there's
   no reason to keep the old structures.
B) if being this frugal wrt memory is ridiculous today, what about instead
   going for 32 bits char (wasteful) 32 bits attr?  This would be much nicer
   15 bit fg color + 15 bit bg color + underline + CJK or something.
You already triple memory use; variant A) above would reduce that to 2x,
variant B) to 4x.

Considering that modern machines can draw complex scenes of several
megapixels 60 times a second, it could be reasonable to drop the complexity
of two structures even on vgacon: converting characters on the fly during vt
switch is beyond notice on any hardware Linux can run.

> This is also available on top of v4.18-rc1 here:
> 
>   git://git.linaro.org/people/nicolas.pitre/linux vt-unicode



Meow!

[1]. config VGA_CONSOLE
  depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
          (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
          !ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390

[2]. Sounds like an easy improvement; not so long ago I added "\e[48;5;m",
"\e[48;2;m" and "\e[100m" which could be improved when on unblinking drivers.
Heck, even VGA can be switched to unblinking by flipping bit 3 of the
Attribute Mode Control Register -- like we already flip foreground
brightness when 512 glyphs are needed.
-- 
⢀⣴⠾⠻⢶⣦⠀ There's an easy way to tell toy operating systems from real ones.
⣾⠁⢰⠒⠀⣿⡁ Just look at how their shipped fonts display U+1F52B, this makes
⢿⡄⠘⠷⠚⠋⠀ the intended audience obvious.  It's also interesting to see OSes
⠈⠳⣄⠀⠀⠀⠀ go back and forth wrt their intended target.
