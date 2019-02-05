Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB0AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091C5217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H4hQWD0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfBESp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:45:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37055 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBESp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:45:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so3780304edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgHd+/tXyRLLI1GSTcavyt+PhTLMwHoOpDHnz9uNS6g=;
        b=H4hQWD0mzctlcT6WF9OJA9LNvO18uh0Y9B6Mw7qZYz/RndueimXun8WM+EDl55kLZK
         J4KleNWDyUB0DWRUgJcZAGHGzTOtIeIGDKEb/ljJKIVdcUi7FLJ/CbxuvWKPLsgoVZ2m
         Px6jgDJEVDyLjPYoFnoz/Ax0+HBGisb1+kRoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YgHd+/tXyRLLI1GSTcavyt+PhTLMwHoOpDHnz9uNS6g=;
        b=onI4zvz/Xgw9S1EAQA4uJKyqst/ae67D5nO8x49WzP1tWTLZw2gmB9dITQqZxkPtuI
         miqzvg8xkaO5kL2I/m2GMcvxQQqS0/HeCSGlkpzkBon6IIOjJEKxN6FlrT4dNPsFhwUe
         8xLRiHNhRwsi82E3ECHku58TScVpexhbB5Xa020wwDnaPKQlb9XP4gLLQbwTHQjOp4bx
         GQfsQqS3bpXpV6FlEi9ckiP3EtmXkCeU88fy/m+omohv4xr3b/fjO8U74401k0/oBBrn
         CRTjumEgdQ1PECKrrb2ujjvn5SZC2lZpQbIwo5megboyq6Svwbf7ed/3CnhOv4fnxg8o
         aQ9Q==
X-Gm-Message-State: AHQUAubOs1536pcPB1AkNy7p5F/evlnql6C3mbVREppXuY6zayGAg0uU
        TDPkvAYTPQQIs+P9xRiuNTM/ag==
X-Google-Smtp-Source: AHgI3IarO+QxoN2m9UOruqEArxxLzEETBIgWZO5GrTUzKXS6y8diuPz/BLqgB+A+4eJg16x8gAz5Og==
X-Received: by 2002:a50:bc12:: with SMTP id j18mr5204794edh.50.1549392324663;
        Tue, 05 Feb 2019 10:45:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3180907ejk.50.2019.02.05.10.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:45:23 -0800 (PST)
Date:   Tue, 5 Feb 2019 19:45:21 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] component: Add documentation
Message-ID: <20190205184521.GH3271@phenom.ffwll.local>
Mail-Followup-To: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190131144640.17896-1-daniel.vetter@ffwll.ch>
 <20190205162107.17633-1-daniel.vetter@ffwll.ch>
 <20190205164902.7uuw36rcs6ake7hy@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205164902.7uuw36rcs6ake7hy@shell.armlinux.org.uk>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 04:49:02PM +0000, Russell King - ARM Linux admin wrote:
> On Tue, Feb 05, 2019 at 05:21:07PM +0100, Daniel Vetter wrote:
> > Someone owes me a beer ...
> 
> I find that deeply offensive - it is clearly directed at me personally
> as author of the component helper.
> 
> There are double-standards in the kernel ecosystem with respect to
> documentation - there are entire subsystems way more complicated than
> the component *helper* which are lacking in documentation, and the
> subsystem authors response to requests to change that basically get
> ignored, or the response is "write the documentation yourself".
> 
> Why does there seem to be one rule for me and one rule for everyone
> else?
> 
> Please remove this line.

Will do, but wasn't aimed at you at all, but at Greg for asking for the
documentation. But yeah that wasn't clear at all, my apologies.

Will apply all your suggestions except for the ones I'm commenting on here
in my reply.

[snip]

> > +/**
> > + * component_master_add_with_match - register an aggregate driver
> > + * @dev: device with the aggregate driver
> > + * @ops: callbacks for the aggregate driver
> > + * @match: component match list for the aggregate driver
> > + *
> > + * Registers a new aggregate driver consisting of the components added to @match
> > + * by calling one of the component_match_add() functions. Once all components in
> 
> As there is a function called component_match_add(), this doesn't
> make too much sense as it directs people only to that function.  It
> would be better to mention both here.  (Have you checked how it comes
> out as a HTML document with the hyperlinks?)

component_match_add() creates a link to the kerneldoc for the
component_match_add. There I've added some text to point to all the other
variants of this family of functions. Same for all the other variants,
those should all have links to the others.


[snip]

> > +/**
> > + * struct component_master_ops - callback for the aggregate driver
> > + *
> > + * Aggregate drivers are registered with component_master_add_with_match() and
> > + * unregistered with component_master_del().
> > + */
> >  struct component_master_ops {
> > +	/**
> > +	 * @bind:
> > +	 *
> > +	 * Called when all components or the aggregate driver, as specified in
> > +	 * the match list passed to component_master_add_with_match(), are
> > +	 * ready. Usually there are 3 steps to bind an aggregate driver:
> > +	 *
> > +	 * 1. Allocate a structure for the aggregate driver.
> > +	 *
> > +	 * 2. Bind all components to the aggregate driver by calling
> > +	 *    component_bind_all() with the aggregate driver structure as opaque
> > +	 *    pointer data.
> 
> These two aren't part of the component helper specification, although
> nailing down what is passed per subsystem would be a good idea to allow
> components to be re-used within the subsystem.  For DRM, it should be
> the struct drm_device.

Hm, great point. I have no idea where we should put it so people find
this. Definitely not here, since this isn't drivers/gpu. I think adding a
small section to the driver initialization docs we already have would make
sense.

I'll add another patch for that in this series, with this one here that
drm paragraph will even have somewhere meaningful to point to!

Thanks for your review.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
