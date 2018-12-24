Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC058C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B2B21726
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CcYQoBmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLXJfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:35:22 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34462 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLXJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:35:21 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so21180514itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 01:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfwfirg7JSi9HR8TrUFqb3quyQ+igREC1Q0mQhKFKA8=;
        b=CcYQoBmd2uxz8jWaxv79i3KQnqlhNKcflwSj81LBZfHhCNUG4JlZvctfL41Ea9XELK
         RPZC0gL5LVqoJhXn+8BVjlFW9uv6L/aqlKkJS1K5yBA9kKtK+jDY+FjIUrMQntIt0Sf1
         YcteY47QZObtzogVo0E6+oKXGYzs65vLbQReE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfwfirg7JSi9HR8TrUFqb3quyQ+igREC1Q0mQhKFKA8=;
        b=p2uiEPxGqKg63G3PReML4VVCBPSYf0OK28gNGQ3iu7jr2yXaSX8uvryDN9nU4F7327
         Yz8ir6r8c6no7UJpuRrTaADXYBLx7xjKjAUoN8i1aFdR2f7GWc1JKNR97gwsVYwQS0Fd
         uzFrMklA5ie30FStJNgU0pms5Mzbjng1O8yhqUkBoP5RtmExnTt94BCkmtfGARt3VwWy
         R+1/GbQp4NYMATrNMKgV+IuSyEyCLrmMVH7Tp2s/lIh2tInM2TS7ZqkThUO7mdDYf8Nb
         9gA3sxr87yl860bDzdqh8TtVJ4IRbkBgK/AXn6xas8y/lTVxMUOdVqn9QXo4s+BHMAN2
         MHTw==
X-Gm-Message-State: AA+aEWYeAokOb7m45zjV46Qap+4G0Wg/EAUY8Z0HDisheRQAaejgF57f
        NRoJWLyT6GuKjlqqdHWMR/SUnG9SSgWBzHX6R8g+Ag==
X-Google-Smtp-Source: AFSGD/Vs/YzU0xs3HLU/Ha7t/4m2Vz+t6Hh8nfyjVqdz6/3x96D3g0MixFHvEEYNNIA7LTd8Evqjxdz20sycGuVSZFM=
X-Received: by 2002:a02:781e:: with SMTP id p30mr8318941jac.85.1545644120882;
 Mon, 24 Dec 2018 01:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20181221172305.195943-1-zwisler@google.com> <147663805b9a1ba7aa3bf4686090af27fbaad040.camel@intel.com>
 <20181221195318.GA6483@google.com>
In-Reply-To: <20181221195318.GA6483@google.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 24 Dec 2018 10:35:09 +0100
Message-ID: <CAKMK7uHhDTNhoGVWECHrHFN8qGTqdtHBL3zZvp2jLeuZnEA-=g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/psr: simplify enable_psr handling
To:     Ross Zwisler <zwisler@google.com>
Cc:     Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Jon Flatley <jflat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 8:53 PM Ross Zwisler <zwisler@google.com> wrote:
>
> On Fri, Dec 21, 2018 at 11:23:07AM -0800, Dhinakaran Pandiyan wrote:
> > On Fri, 2018-12-21 at 10:23 -0700, Ross Zwisler wrote:
> > > The following commit:
> > >
> > > commit 2bdd045e3a30 ("drm/i915/psr: Check if VBT says PSR can be
> > > enabled.")
> > >
> > > added some code with no usable functionality.  Regardless of how the
> > > psr
> > > default is set up in the BDB_DRIVER_FEATURES section, if the
> > > enable_psr
> > > module parameter isn't specified it defaults to 0.
> > Right, that was intentional and the commit message even makes a note of
> > it
> > " Note: The feature currently remains disabled by default for all
> > platforms irrespective of what VBT says."
> >
> >
> > Anyway, we've enabled the feature by default now and the current code
> > should take into account the VBT flag if the module parameter is left
> > to a default value. Please check git://anongit.freedesktop.org/drm-tip
> > drm-tip.
>
> Fair enough.  It's a bad pattern to introduce dead code as a placeholder for
> some future work, though.  This code has been in the tree for three major
> kernel releases (v4.{18,19,20}) without providing any useful functionality.

Getting PSR enabled by default on at least a few platforms took years.
Insisting that we do not ever merge such code also doesn't work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
