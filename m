Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866B52133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UgUMEmDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeLQTsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:48:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42050 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLQTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:48:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so5657193edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQkrog+vb9Zo11bWvBko2zaFnQCAnh4XM6dFqZhRm9A=;
        b=UgUMEmDJQYveHj+Jciy4klehxYubIVTs6qkUiYBFqXZdK8rEw+2s4lujN2pZFytvkT
         iKpKCGlolyV4M6EOGCAQbzcmFna1S90Q6ycXWBD7WzdcvFRSgw1dRdtgVqURXzQeYkV0
         Yg1FoJTDd6d+bszveT2DBELSr6EXGtcDfEx7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iQkrog+vb9Zo11bWvBko2zaFnQCAnh4XM6dFqZhRm9A=;
        b=DD0aOyJ3wfGvh02WLbU4BmAs8spKoNv0AQplLucQCV4G6/qQQzSUUwtp4u3GlShUq1
         +VYS1rNz2oJ1wgkaKv8Fh35zYYPud0I4zmr0sAA5RXxRNawZr6SVq+V65kOqPZYFNKZz
         mkng1R1+tFtcl7D6DjzxiyGxhxBg30er0jAnNKTTTUq5SOblVx2CW2+ls6eTrRgppdBe
         DgU2DUpdcY1BuBC38ZymjsPWT1eHoo/V9qtu8GSMxvl1ilLFkT4GIuy0m0O80YUIvY9/
         u0Y34AKb6HYKwfg6Eqsxke4/NOpt+yf5aQTNO/6AsKk+lJY01J+zsc+G4mItxJIF3pJV
         2aMg==
X-Gm-Message-State: AA+aEWZPX5REiu12hPXDSROoV19pWltPF1fLHwDL2GfqqMbV1MCTemRE
        F3GutAHL0DFKL7Bm/KctqizCTg==
X-Google-Smtp-Source: AFSGD/UFtvaQ8kWZdgb+cgHQyqNbljwoNnG6BA69zyDfZb3OymFNrBAGFGrkoeXISddjomkSOMuBjA==
X-Received: by 2002:a50:8e95:: with SMTP id w21mr13598462edw.198.1545076087341;
        Mon, 17 Dec 2018 11:48:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w56sm4044343edb.72.2018.12.17.11.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 11:48:06 -0800 (PST)
Date:   Mon, 17 Dec 2018 20:48:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
Message-ID: <20181217194804.GJ21184@phenom.ffwll.local>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
 <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
 <20181213095814.GC21184@phenom.ffwll.local>
 <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
 <CAKMK7uF7noCEgwE0QYZWQFx-OPxipAF1MojUZ8KTo_SXfQW8+w@mail.gmail.com>
 <CAJZ5v0g+-R8tbbJscL-3s23UPhyNX1v1Lj3aC=QdUBzdSCrspw@mail.gmail.com>
 <CAKMK7uHACB5-ak0b_BT-HoAmXHZ9EaCNTt7WuqckNWKQM-g2fQ@mail.gmail.com>
 <CAJZ5v0hOiL1oWGCmFv2N8-0UvCibXz02DhdFMyUQsQZ1hDjV=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hOiL1oWGCmFv2N8-0UvCibXz02DhdFMyUQsQZ1hDjV=w@mail.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 07:09:15PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 13, 2018 at 5:25 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > On Thu, Dec 13, 2018 at 5:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Dec 13, 2018 at 1:36 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> 
> [cut]
> 
> > > > I can do the old code exactly, but afaict the non-NULL parent just
> > > > takes care of the parent bus locking for us, instead of hand-rolling
> > > > it in the caller. But if I missed something, I can easily undo that
> > > > part.
> > >
> > > It is different if device links are present, but I'm not worried about
> > > that case honestly. :-)
> >
> > What would change with device links? We have some cleanup plans to
> > remove our usage for early/late s/r hooks with a device link, to make
> > sure i915 resumes before snd_hda_intel. Digging more into the code I
> > only see the temporary dropping of the parent's device_lock, but I
> > have no idea what that even implies ...
> 
> That's just it (which is why I said I was not worried).
> 
> Running device_links_unbind_consumers() with the parent lock held may
> deadlock if another child of the same parent also is a consumer of the
> current device (which really is a corner case), but the current code
> has this problem - it goes away with your change.
> 
> But dev->bus->need_parent_lock checks are missing in there AFAICS, let
> me cut a patch to fix that.

With your patch before this one, are you ok with mine? Or want me to
respin with a different flavour?

btw threading somehow broke apart, Chris Wilson r-b stamped this one on
intel-gfx:

https://patchwork.freedesktop.org/patch/267220/

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
