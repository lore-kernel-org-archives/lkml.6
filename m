Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB26ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9FB20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9FB20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeGUWdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:33:07 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:45782 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeGUWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:33:07 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1fgzaN-0002Qh-5T; Sat, 21 Jul 2018 23:38:43 +0200
Date:   Sat, 21 Jul 2018 23:38:43 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color
 improvements
Message-ID: <20180721213843.wkculy5cdrrbmuij@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180721074319.GA30454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721074319.GA30454@kroah.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 09:43:19AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 18, 2018 at 05:01:52AM +0200, Adam Borowski wrote:
> > Here's a patchset with two entangled improvements:
> > 
> > * it'd be good to get rid of blinking where possible.  Even CGA (thus VGA)
> >   allows disabling it, rendering such characters with a bright background
> >   instead.
> > * due to my error, 256-color mode uses a much darker palette for conversion,
> >   resulting in behaving inconsistently with 24-bit mode.
> > 
> > The new code uses bright backgrounds when possible, enabled with \e[100m or
> > \e[48;m.
> > 
> > Despite the whole idea following a VGA capability, this patchset doesn't
> > change vgacon yet, just fbcon.  [Not breaking nvidia-proprietary.]
> > 
> > Thus, let's enable unblinking on fbcon for now.  We can flip that bit (in
> > register 0x10) later.
> > 
> > This fixes the display of catimg and similar tools.
> 
> I've applied the first patch, as it was obvious :)
> 
> For the rest, can you make it a config option as Alan said?  And I
> agree, we don't care about breaking nvidia systems, go ahead :)

The only thing such an option would be able to set is disabling blinking on
vgacon, which is not yet implemented.  fbcon never blinks, and the only case
it can't display bright background is 1-bit black&white.

I probably should change the line in fbcon:
+       vc->vc_unblinking = vc->vc_can_do_color;
to always use 1, but it doesn't matter either way.  Only difference would be
matching the variable name ("unblinking" vs "shows_bright_bg").

Console drivers can interpret that bit of attribute as:
* blinking (vc_unblinking = 0)
* bright background (vc_unblinking = 1)
* neither (result is ignored down the pipeline)

The matrix is:
                color                                     b&w
-------+-------------------------------------------+--------------
fb            bright bg                                 neither
mda              N/A                                     blink
newport      ?bright bg?                                 ?N/A?
sti           ?neither?                                    ?
vga      CGA/VGA: hardware switch (write to port)      MDA: blink
sisusb            ?                                        ?

Technically, every console can be made to blink by drawing/clearing affected
characters a few times per second, but that'd be quite a waste of coding
time and kernel size.  There's a reason browsers dropped support for <blink>
and text-decoration:blink.

This patchset doesn't drop blink in any case that was supported before,
though.  I did the easy part used by most people first (fbcon), so it can be
reviewed/merged.  Doing the hard part is quite pointless if this is NAKed
(but obviously doesn't require actual merging).

But perhaps by "option" you mean letting the user drop blink with no
replacement, which might also be a good idea if configurable?


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable And Non-Discriminatory prices.
