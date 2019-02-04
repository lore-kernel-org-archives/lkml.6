Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43693C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079D3217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="U1j+C7ph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfBDJNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:13:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33770 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfBDJNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:13:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so10650383eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCP75rNg9IJ+zSAGB8zvH5XUIDqP/1wPqbLj82tQ7dg=;
        b=U1j+C7phqLReDYlX9e7rtejoXvi5DkHQRcIQPjirZrm8IRiOz8q9oOyFONcQARrDw8
         v3B2/PV/RJf+o0mB2JYExBRV3am4LJBmQeKjgfAmR4wBlO+DSiT9JraEIAtoDa2x6qbT
         OhKBG9Jn/0y8ZlL9oTQnrUSrrdEAVJlmbzb3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FCP75rNg9IJ+zSAGB8zvH5XUIDqP/1wPqbLj82tQ7dg=;
        b=iPwJCUdcF0zkkOhIeWCTaG5af6SMcsRsx33UhpNl5PiKsw/Ng/iKf0PUEbI9xM3S/H
         xt3Xh86f5Z4N9g9qKNNb6S6e3TARsAygugDR/KZzwhdCkEw07bdMmSQMFvGvus5SXZyk
         KZeuBiX+rizap3+jUMn7rko/FgTbwdRbMWsLAh4cUFpLSTtA5YRru1njV3EPDaua8bNk
         LdMsRXY8mmFYtkYto0enHpHLs6R2OOdYQkTdCcxCei2bWzbS/8rDMWWdQ7V3NjGidf09
         dVR7rQuFeQTckqR7H5VyQ2BvD8RMaLxJRw5xHXXTq9HHownYCrl/6NoYVC3CdM/nciWo
         DuVw==
X-Gm-Message-State: AJcUuke9Znmo/L8Be+4yO3Rh/SI6DH/U+hwJ/TElFVHY4rDnRC4dYsi9
        oZuXiVrvPAXc+bp6flJj7PkNyw==
X-Google-Smtp-Source: ALg8bN5yK6CrwwIVNUWI1Xz9rq0Z3/rOjUnqx8bLORs5P/6iLVDQKuyZYfFbuZs89x7ypKnwOuhjpQ==
X-Received: by 2002:a17:906:5e01:: with SMTP id n1mr23834799eju.99.1549271615807;
        Mon, 04 Feb 2019 01:13:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 49sm4176271edz.59.2019.02.04.01.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 01:13:34 -0800 (PST)
Date:   Mon, 4 Feb 2019 10:13:32 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kent Russell <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>
Subject: Re: linux-next: Fixes tags need some work in the drm tree
Message-ID: <20190204091332.GJ3271@phenom.ffwll.local>
Mail-Followup-To: Alex Deucher <alexdeucher@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>, Leo Li <sunpeng.li@amd.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kent Russell <kent.russell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>
References: <20190201105736.1428c9fc@canb.auug.org.au>
 <CAKMK7uGf7X3m3Hp1r3-RSrKvGqsJK61WAMQ7goFP_28GAieP2w@mail.gmail.com>
 <CADnq5_O3rGYGi95pB_0-xxODpcKYdB_ZaHcNS9zzBRGorE2oMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_O3rGYGi95pB_0-xxODpcKYdB_ZaHcNS9zzBRGorE2oMg@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:34:46PM -0500, Alex Deucher wrote:
> On Fri, Feb 1, 2019 at 5:05 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Fri, Feb 1, 2019 at 12:57 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > In commit
> > >
> > >   a93587b31e34 ("drm/amd/display: Only get the connector state for VRR when toggled")
> > >
> > > Fixes tag
> > >
> > >   Fixes: 3cc22f281318 ("drm/amdgpu: Set FreeSync state using drm VRR properties")
> > >
> > > has these problem(s):
> > >
> > >   - Target SHA1 does not exist
> > >
> > > Maybe instead:
> > >
> > >   FIxes: bb47de736661 ("drm/amdgpu: Set FreeSync state using drm VRR properties")
> > >
> > > In commit
> > >
> > >   32e61361b82e ("drm/amd/display: Fix 64-bit division for 32-bit builds")
> > >
> > > Fixes tag
> > >
> > >   Fixes: https://lists.freedesktop.org/archives/dri-devel/2018-December/201008.html
> > >
> > > has these problem(s):
> > >
> > >   - No SHA1 recognised
> > >
> > > Maybe instead:
> > >
> > >   Fixes: 80604e27bc9 ("drm/amd/display: Use 100 Hz precision for pipe pixel clocks")
> > >
> > > In commit
> > >
> > >   c4312c27c826 ("drm/amdgpu: Cleanup 2 compiler warnings")
> > >
> > > Fixes tag
> > >
> > >   Fixes: e4ae0fc drm/amdgpu: implement gfx8 post_soft_reset
> > >
> > > has these problem(s):
> > >
> > >   - SHA1 should be at least 12 digits long
> > >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> > >     or later) just making sure it is not set (or set to "auto").
> > >
> > > Fixes tag
> > >
> > >   Fixes: 5e01c09 drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings
> > >
> > > has these problem(s):
> > >
> > >   - Target SHA1 does not exist
> > >
> > > Maybe instead:
> > >
> > >   Fixes: c6064de4b734 ("drm/amdgpu/gfx_v8_0: Reorder the gfx, kiq and kcq rings test sequence")
> >
> > Yeah the top 71 commits in the latest amdgpu pull got rebased, which
> > is a bit much. Where are we with the "direct group commit, no more
> > rebases" project for amd? Still stuck on CI troubles?
> 
> In fairness, some of the rebasing was to squash in some bug fixes to
> help with bisecting.  As to direct commit, not enough internal
> priority at the moment and too many other projects.  I'll try to
> double check them better going forward.

Yeah I think internal prioritiy is probably not going to happen. The
benefit imo is much more for everyone else, since it requires a more
open&transparent process. E.g. for drm-intel a big reason for the public
CI results is that we can make the committer model work for external
people (which we do have). Hence my regular nags from me with my upstream
community hat on, and AMD definitely can do this (viz radeonsi).

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
