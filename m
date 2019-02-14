Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B1EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC795222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CNQfU2/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405169AbfBNPMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:12:22 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52066 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfBNPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:12:22 -0500
Received: by mail-it1-f193.google.com with SMTP id y184so15784911itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/888/nm7tm0PpUJjpclyZqyXWVS95fzsi6iIMb2ozIw=;
        b=CNQfU2/p82Hz5RjUccogODhSsijt/nWjte5MSUrag3+hsT6NR1YEkyUibNfnPCHnfW
         kYDXhKUlYADvKn8vEFOC6H05OPTIevsShewUtTifRCadlWwivJWPqlSL1OM+GCrF3PMi
         lJdyE4bUdHEljGPQrorCrHbhbvsCdNigP8qiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/888/nm7tm0PpUJjpclyZqyXWVS95fzsi6iIMb2ozIw=;
        b=WD5x92bGD3N8VcGGW6ref8XqlDG1pYQzKDWM5FouskrG7Bxzkkke9kQN4uhInoqHWB
         N6ixsxDyoVik/Tx2zrRxyHKlmqRCcku4YiUEcCjSpVIXcylfVzIb0B2lOgVY4Jz0fAGe
         TDZY4MObFp1OhWTKUFXYJ0XRaaBYNUU+md3s5ryQTi3omi/NNkynvo0EWzaTGRc28ndn
         Qx4HFX9oEzBBryQzmGy/rLJwuHzbGDBFeJ+xurRz5fbzcZFziiomKdsxkBSQG/BK7LXi
         WpvXzkjkvyoFJCGlurOzdCSuVJSOnmjGxFgG2DUGrXYhlScw08jlEQLEHp+IkXzX5xtb
         iUbw==
X-Gm-Message-State: AHQUAuZtbjAoOyqYSKhjCZ7DuWnJ75SkvzgjN8JZZ65qNau/3qBPQ6Y4
        Sl1aaEZ2ySQlo0Sz4v4ecXCvxicLi/dWS7154Bnpvw==
X-Google-Smtp-Source: AHgI3IbwledWc4uAUTowpmsKFdRnrQkWsX8y2uT4kBuF16t/lcdJ5xlKS5DhvI0EujO2J8czcvbXi59R/W2hLN6F+xE=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr2828634ioa.34.1550157140804;
 Thu, 14 Feb 2019 07:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20190211141846.543045703@linuxfoundation.org> <20190211141846.783223749@linuxfoundation.org>
 <20190214135802.GB20918@arch-x1c3> <20190214141947.GA31965@kroah.com>
In-Reply-To: <20190214141947.GA31965@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 14 Feb 2019 16:12:08 +0100
Message-ID: <CAKMK7uGWpp3Jpqp29+eyBLfKcfo+=NDft+rbAGU-LY4bB=oc+w@mail.gmail.com>
Subject: Re: [PATCH 4.20 004/352] drm/vgem: Fix vgem_init to get drm device available.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Emil Velikov <emil.velikov@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 3:19 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 14, 2019 at 01:58:02PM +0000, Emil Velikov wrote:
> > Hi Greg,
> >
> > On 2019/02/11, Greg Kroah-Hartman wrote:
> > > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > [ Upstream commit d5c04dff24870ef07ce6453a3f4e1ffd9cf88d27 ]
> > >
> > > Modify vgem_init to take platform dev as parent in drm_dev_init.
> > > This will make drm device available at "/sys/devices/platform/vgem"
> > > in x86 chromebook.
> > >
> > > v2: rebase, address checkpatch typo and line over 80 characters
> > >
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Link: https://patchwork.freedesktop.org/patch/msgid/20181023163550.15211-1-emil.l.velikov@gmail.com
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > Zero objections to picking this for stable, although I'm curious what
> > flagged this commit as stable material.
> >
> > Especially since it's closer to a feature than a bug-fix.
> >
> > Can you share some light? Perhaps a link to a thread/document since I
> > would imagine you've been asked before.
>
> Sasha has a presentation all about how this gets picked up, but I can't
> find the link right now.  Sasha?

https://lwn.net/Articles/764647/

Afaiui the autoselected patches do get posted to dri-devel. At least I
see some mails show up there.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
