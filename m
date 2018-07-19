Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F0DECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB852084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB852084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbeGSPMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:12:21 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:35606 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeGSPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:12:21 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fg9vA-0003mO-Fh; Thu, 19 Jul 2018 16:28:44 +0200
Date:   Thu, 19 Jul 2018 16:28:44 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color
 improvements
Message-ID: <20180719142844.u3u4p7tywb54y4yd@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180719114749.00a7f979@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719114749.00a7f979@alans-desktop>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:47:49AM +0100, Alan Cox wrote:
> On Wed, 18 Jul 2018 05:01:52 +0200
> Adam Borowski <kilobyte@angband.pl> wrote:
> 
> > Hi!
> > Here's a patchset with two entangled improvements:
> > 
> > * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
> >   allows disabling it, rendering such characters with a bright background
> >   instead.
> 
> That's a matter of taste so needs to configurable. Changing the default
> ought I think to be its own patch as it's a separate discussion to having
> the choice there and easy to make.

For vgacon yeah, you have a good point, as it can support either (and to be
exact, exactly one of the two as they share a hardware bit).  Only reason to
not have this configurable would be avoiding bloating the kernel with knobs
hardly anyone flips -- but you can already set minutiae like replacement
color for underline/italic/dim.  Thus you're right that if/when killing
blink on vgacon is implemented, it probably should be settable.

This is not an option on fbcon, though -- it can't blink (doable but I'm not
seeing anyone wanting to implement that) and already interprets that
attribute bit the way VGA would.  Thus, this patch merely makes vt behave a
way to match what the driver does.  This fixes some visual corruption in
certain user programs.

> For the palette why does it needs changing and exactly what standards
> document defines 'right', especially given we don't do ICC in console
> mode ? Have you tested the values used against multiple monitor types and
> cards with a light meter ?

You don't need a light meter for a difference of 53-out-of-256.  Most
desktop environments don't do ICC out of the box either, but there's an
assumption that whatever your monitor does, it gives the same result for the
same input (in the same lighting conditions).

That patch's purpose is:
* behave consistently between two APIs to set the same thing (\e[38;5;m vs
  \e[38;2;m) in a way that matches other terminals
* in case a future driver has better color handling we'd be different from
  other terminals

By the way, you can have ICC on console: "apt install vtgamma"
(https://github.com/kilobyte/vtgamma).

> BTW visibly breaking the Nvidia crud is also fine. They'll then actually
> bother to fix it and uually quite soon.

Yeah, but they haven't fixed 512-glyph yet (at least the last time I
looked), broken since day one.  In any case, this patchset doesn't support
vgacon yet, thus this is moot for now.  I picked the easy case (fbcon which
is always unblinking) over writing stuff to ports, we can update other
drivers later.

And vgacon has code that looks like it can do CGA and MDA (redundant with
mdacon?), either of which I haven't used in... quite a while.  Might be
tricky getting access to such hardware to test...


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
