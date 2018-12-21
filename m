Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E442C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A957221916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lwzzkMxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbeLUN0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:26:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40061 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeLUN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:26:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so4659198edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KIMbLSZDM+OnARH9pcTusJfIrW+7RdQTCXOT5ZWrBy0=;
        b=lwzzkMxr1nATM/bD8mQ8BRogGKxeUoYx23FEhII/ubrNwOUZiSwyyEdMQZ/JCxWSTF
         26kG2d/WBlvTgbR3fMRDsq5UDY8dzK+GCD9LNN/UNvaWV5N5lTviL/RRtoFg4914RmzY
         hYqS4VsajbNwvFDGiS4ludoTHttHqPJNQlPKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KIMbLSZDM+OnARH9pcTusJfIrW+7RdQTCXOT5ZWrBy0=;
        b=b4HNYXUAMgngWw7uBIDWg9zxIHx5r1aRgJJGDsoZml9SIOfT1WdVxiuamVr9+0Bixt
         Optsi6iy9sENoFCfpWRSfeVtX4QZooCUYWqv08bCtrz6eFJC/j/YtHJE5OZ9o7t1Fe5Z
         RlL4NR1CUQt8mDky5WvrOGjOOotkVIMhFH6zBWKX7ki/JsBAHqM3K1E54pp4lScE9dpG
         U8POjqsVzAGYOCkD+zmUBfNZlLUeBOgHvSEFkfI/07vjeYwiVSDAtahihYc/EjK66c9c
         1D3ttUvg4oQtXaYqmpsuUaXcDEKaHdT7VzaXb0Irc6CP1YpLslihiXBG7uV6zvwjW/89
         IJXg==
X-Gm-Message-State: AA+aEWZeHP0yXzuUH8cw8Od18/kzcLfVLplWpGvIDbaZmF366e3xLG2O
        Y8X2705M1GTzImE5v3jqxcht1A==
X-Google-Smtp-Source: AFSGD/W2EcN44QSFbO4rmaB9GEkOWBkmoSsmRxuIAGgXW+NEpklIHIT6NE470Ffp8nma7fHOnDL4fg==
X-Received: by 2002:a50:91a8:: with SMTP id g37mr2364426eda.216.1545398801563;
        Fri, 21 Dec 2018 05:26:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y53sm6899911edd.84.2018.12.21.05.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 05:26:40 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:26:37 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>, kernel@collabora.com,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
Message-ID: <20181221132637.GR21184@phenom.ffwll.local>
Mail-Followup-To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexdeucher@gmail.com>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>, kernel@collabora.com,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com>
 <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
 <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
 <CADnq5_P9nsquCV95CSZC4NCr7YNJ76ZmCruJA=f1N8dLGYm=ow@mail.gmail.com>
 <CAKMK7uHu5XMQzr7ocVEcpDS9H6pQ-BHfHNE51_YK7rLkTQC_9g@mail.gmail.com>
 <CADnq5_P1smiGhYyoZQsEAJG0+jBx6f75HwEFAf2RkaoNp0HEiA@mail.gmail.com>
 <CAKMK7uGSiBv9H_xAj2fuk=XYocefQU4bFk+fPr=iWGsaPxOwhw@mail.gmail.com>
 <fb45217c-d9ad-b208-d55d-51299ead108b@daenzer.net>
 <9be83a7f-aa5f-8d8f-0486-db68e12c5feb@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9be83a7f-aa5f-8d8f-0486-db68e12c5feb@daenzer.net>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:47:27AM +0100, Michel Dänzer wrote:
> On 2018-12-20 6:16 p.m., Michel Dänzer wrote:
> > On 2018-12-20 6:09 p.m., Daniel Vetter wrote:
> >> On Thu, Dec 20, 2018 at 6:03 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>> On Thu, Dec 20, 2018 at 11:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >>
> >>>> Not sure about the gamma thing since we had opposite bugs on i915
> >>>> about gamma not being vsynced and tearing terribly. Cursor is special
> >>>> since it tends to be too small to notice tearing.
> >>>
> >>> Our cursor hw (and possibly gamma as well Nicholas?  Harry?) is double
> >>> buffered, so we can update it any time for the most part and the
> >>> changes won't take affect until the next vupdate period.
> >>
> >> Hm, I guess we could make the gamma update optionally async, and let
> >> drivers deal. The issue is that the current async helper stuff won't
> >> cope with gamma updates (it's aimed at plane updates only, not at crtc
> >> property updates). Or we get userspace to do proper atomic updates. Or
> >> we do some faking in the kernel, e.g. waiting with the gamma update
> >> until the next atomic update happens. But that kinda breaks
> >> ->atomic_check.
> > 
> > Would it be possible to merge gamma changes into a pending commit, if
> > there is one, and create a new commit otherwise?
> > 
> > Otherwise the atomic API just moves this same problem to be solved by
> > userspace.
> 
> Actually, I'm not sure this is even solvable in a Xorg driver. When it
> gets called to update the gamma LUT:
> 
> 1. If there's a pending atomic commit, it cannot amend that, can it?

Yup, but on the kernel side we kinda have the same problem.

> 2. It has no way of knowing when the next atomic commit would be
> submitted e.g. for a page flip, so it kind of has to create its own
> commit for the gamma update.

Block handler is what I had in mind for the fallback commit, if no other
commit happened meanwhile (which would need to include it).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
