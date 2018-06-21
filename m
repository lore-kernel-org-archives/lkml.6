Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC21C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A1A20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nrx3NUuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A1A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeFUC7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:59:12 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39983 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754284AbeFUC7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:59:11 -0400
Received: by mail-qk0-f193.google.com with SMTP id b129-v6so986916qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 19:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xiB0KNq38BgdgXMHVyQuhWY8oDLW8w8aInhjYROv3gs=;
        b=Nrx3NUuY/x3AvIiCAl5Z31svAqnm6SkXpf7McUJIGV8Kj9Nu5wYbtYe49tOgySWp9m
         VcPfb6NpQ10vDgR5oc4pv92OSfcuG+q4JNoxVxLTg76rDh4naO9fVuAZxpMHQ8JaUEk9
         Sy/A8OLG/TRUstN/scibNVROm1aCeImYlpBps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xiB0KNq38BgdgXMHVyQuhWY8oDLW8w8aInhjYROv3gs=;
        b=tJUkYCwZubA1gJbbY5MIKQvPe4/vfahS6+tr99EUie6rhNHlRBN09CHGftvi86FZgo
         5agtdmkbzHjqoZN6fSKtuZuoAoXq1Y9Noz+n+ZGhMw6HA+dM68ZwLFxFHi2pGs8Y6mDa
         v4NUfrtU+SbT/OApGSlr/Qdo4cZFQ3F2LLNEDC3r26A6f8Tah1pJ8x2K3pEuAB3z9ui0
         6xXwL+/vh1CUKGKG1Wav9GmeZO4+DI+/cYx0osWO2O8pKl8UQxQRwlOIHkZxnSlCFIBl
         2KCqpwEiJTk+kTUC9fp+rwzKsF5qkZBUEWdWI151/40Ax0ExhK3fTTTyL1DbGU631asX
         fQvA==
X-Gm-Message-State: APt69E1dzUMxwh+rig+poGOkjSTopUl2Ed+cSYsOzG8i6T0fl2q62OBd
        op4twgFx0WrOccL1jrkk7afYVQ==
X-Google-Smtp-Source: ADUXVKKQm9jKjiSwD08JiSZP+/6HhXALgYuQ4a9bhCN34XpwXVpx7MWT4zi6lWb7sH8fkoU/6P5M+g==
X-Received: by 2002:ae9:e004:: with SMTP id m4-v6mr5617855qkk.436.1529549950221;
        Wed, 20 Jun 2018 19:59:10 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id a12-v6sm2326282qtk.57.2018.06.20.19.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 19:59:09 -0700 (PDT)
Date:   Wed, 20 Jun 2018 22:59:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
In-Reply-To: <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
Message-ID: <nycvar.YSQ.7.76.1806202210500.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180619130953.bxil552igfkckjmr@angband.pl> <nycvar.YSQ.7.76.1806191047070.16670@knanqh.ubzr> <20180621014317.ebslk3gwvpq3k6sq@angband.pl>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1898205314-1529549949=:16670"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1898205314-1529549949=:16670
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 21 Jun 2018, Adam Borowski wrote:

> On Tue, Jun 19, 2018 at 11:34:34AM -0400, Nicolas Pitre wrote:
> > On Tue, 19 Jun 2018, Adam Borowski wrote:
> > > Thus, it'd be nice to use the structure you add to implement full Unicode
> > > range for the vast majority of people.  This includes even U+2800..FF.  :)
> > 
> > Be my guest if you want to use this structure. As for U+2800..FF, like I 
> > said earlier, this is not what most people use when communicating, so it 
> > is of little interest even to blind users except for displaying native 
> > braille documents, or showing off. ;-)
> 
> It's meant for displaying braille to _sighted_ people.  And in real world,
> the main [ab]use is a way to show images that won't get corrupted by
> proportional fonts. :-þ

⠨⠺⠑⠇⠇⠂ ⠥⠎⠊⠝⠛ ⠇⠁⠞⠑⠎⠞ ⠨⠨⠃⠗⠇⠞⠞⠽ ⠊⠞ ⠊⠎ ⠏⠕⠎⠎⠊⠃⠇⠑ ⠞⠕ ⠞⠽⠏⠑ ⠁⠝⠙ ⠙⠊⠎⠏⠇⠁⠽ ⠝⠁⠞⠊⠧⠑ 
⠃⠗⠁⠊⠇⠇⠑ ⠕⠝ ⠁ ⠃⠗⠁⠊⠇⠇⠑ ⠞⠑⠗⠍⠊⠝⠁⠇ ⠕⠝⠉⠑ ⠞⠓⠊⠎ ⠏⠁⠞⠉⠓ ⠎⠑⠗⠊⠑⠎ ⠊⠎ ⠁⠏⠏⠇⠊⠑⠙ ⠞⠕ ⠞⠓⠑ 
⠅⠑⠗⠝⠑⠇⠂ ⠊⠗⠗⠑⠎⠏⠑⠉⠞⠊⠧⠑ ⠕⠋ ⠞⠓⠑ ⠁⠉⠞⠥⠁⠇ ⠉⠕⠝⠎⠕⠇⠑ ⠋⠕⠝⠞ ⠊⠝ ⠥⠎⠑⠲ ⠨⠁⠝⠙ ⠋⠕⠗ ⠞⠓⠁⠞ ⠺⠑ 
⠥⠎⠑ ⠉⠕⠗⠗⠑⠎⠏⠕⠝⠙⠊⠝⠛ ⠥⠝⠊⠉⠕⠙⠑ ⠉⠓⠁⠗⠁⠉⠞⠑⠗⠎⠲

> > If the core console code makes the switch to full unicode then yes, that 
> > would be the way to go to maintain backward compatibility. However 
> > vgacon users would see a performance drop when switching between VT's 
> > and we used to brag about how fast the Linux console used to be 20 years 
> > ago. Does it still matter today?
> 
> I've seen this slowness.  A long time ago, on a server that someone gave an
> _ISA_ graphics card (it was an old machine, and it was 1.5 decades ago). 
> Indeed, switching VTs took around a second.  But this was drawing speed, not
> Unicode conversion.
> 
> There are three cases when a character can enter the screen:
> * being printed by the tty.  This is the only case not sharply rate-limited.
>   It already has to do the conversion.  If we eliminate the old struct, it
>   might even be a speed-up when lots of text gets blasted to a non-active
>   VT.

That's a good point.

> * VT switch
> * scrollback
> 
> The last two cases are initiated by the user, and within human reaction time
> you need to convert usually 2000 -- up to 20k-ish -- characters.  The
> conversion is done by a 3-level array.  I think a ZX Spectrum can handle
> this fine without a visible slowdown.

In the scrollback case, currently each driver is doing its own thing. 
The vgacon driver is probably the most efficient as it only moves the 
base memory register around without copying anything at all. And that 
part doesn't have to change.

> The primary users would be:
> * people who want symbols uncorrupted (especially if their language uses a
>   non-latin script)
> * CJK people (as discussed below)
> 
> It could also simplify the life for distros -- less required configuration:
> a single font needed for currently supported charsets together has mere
> ~1000 glyphs, at 8x16 that's 16000 bytes (+ mapping).  Obviously for CJK
> that's more.
>  
> > > So I'm only mentioning possible changes; they could possibly go after
> > > your patchset goes in:
> > > 
> > > A) if memory is considered to be at premium, what about storing only one
> > >    32-bit value, masked 21 bits char 11 bits attr?  On non-vgacon, there's
> > >    no reason to keep the old structures.
> > 
> > Absolutely. As soon as vgacon is officially relegated to second class 
> > citizen i.e. perform the glyph translation each time it requires 
> > a refresh instead of dictating how the core console code works then the 
> > central glyph buffer can go.
> 
> Per the analysis above, on-the-fly translation is so unobtrusive that it
> shouldn't be a problem.
> 
> > > B) if being this frugal wrt memory is ridiculous today, what about instead
> > >    going for 32 bits char (wasteful) 32 bits attr?  This would be much nicer
> > >    15 bit fg color + 15 bit bg color + underline + CJK or something.
> > > You already triple memory use; variant A) above would reduce that to 2x,
> > > variant B) to 4x.
> > 
> > You certainly won't find any objections from me.
> 
> Right, let's see if your patchset gets okayed before building atop it.

May I add your ACK to it?


Nicolas
--8323328-1898205314-1529549949=:16670--
