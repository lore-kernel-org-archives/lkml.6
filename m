Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A98AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D63E2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 08:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NKx1Gz/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D63E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeK2UBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:01:45 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53536 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeK2UBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:01:45 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so2439037ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 00:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWmS5X3oWUwyLNW9cMpNUuMHuMWFjeAl5OoIeXLn3BY=;
        b=NKx1Gz/qnclh1q+jHuyh3xLQoheg9CKQisn6NytxcQzEe1UPev2p9g9s7/zq+JDfD4
         7N0IkwiCMMS9bMFxpIjpmmtizqsIK4Os2iR+z9I5FBFXv7WOGSfVZMbVBwdsTUYhi4BW
         xy49n8LTqPZfZij6ku//3hk2pcKgCz5KRoOak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWmS5X3oWUwyLNW9cMpNUuMHuMWFjeAl5OoIeXLn3BY=;
        b=AgiwomQw0QbbolTJxGNWYgjHqOmD9/hTy2fi08JQkFtRRxqTd5Abf0e7ZywvWhGyQ+
         zMJlrML9rr3S878ZuEnZzGmQiL0kpHznF5yVLCpw9GZmYVlsjW0RhKGrEzpf0FN4oQsq
         HaOokFeQrUi1Bj0C1yYt6ffEVI7/ugPZR7wro47lEtLzspdE5p+U/gYR3135Zh+kSzWC
         4j4QlR52Gm6A4exm6oMOX13lG5vGyz59ZT298rdDObdb69nCWwHi6uRZaBsMxFQKTJRD
         gqA6fITUv+U5NooztDe3R/lIFwF0pRORAnZIrYTAIqQT0S0HFKwnAAlIqlyasc1O8mjP
         8HSw==
X-Gm-Message-State: AA+aEWbpmFfJSdRmjiQeKGylDoEOQVAG2H2TL7vCo8bZWpXorjFb+/Ko
        +1GZdbshanelr1TLvz9+d56+RnjkU4r8bTtFMxQwuQ==
X-Google-Smtp-Source: AFSGD/UNTkubjbeVU0TIgrzN47MvpOMCLngt/bD7E4wmZ1cTX+W0oaZf+CQNMYMNc1W4KS1wbgySHnqyzLVHSGkDwnk=
X-Received: by 2002:a02:85ae:: with SMTP id d43mr490723jai.70.1543481825119;
 Thu, 29 Nov 2018 00:57:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541397462.git.sbobroff@linux.ibm.com> <3350c5dd5ea08c71e4769ea3801290e7f9238a6c.1541397462.git.sbobroff@linux.ibm.com>
 <CAPM=9txRjd6E3DxdcM14mzWG1P-Cr70P61Eyce95bBhJtqfH7A@mail.gmail.com> <20181129020034.GA10328@tungsten.ozlabs.ibm.com>
In-Reply-To: <20181129020034.GA10328@tungsten.ozlabs.ibm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 29 Nov 2018 09:56:53 +0100
Message-ID: <CAKMK7uEY8C_9qwuUi5rR1+_xYOSXeKicopR1zTpQKaMEJTM-fA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/ast: Fix connector leak during driver unload
To:     sbobroff@linux.ibm.com
Cc:     "airlied@gmail.com" <airlied@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:05 AM Sam Bobroff <sbobroff@linux.ibm.com> wrote:
>
> On Thu, Nov 29, 2018 at 09:40:53AM +1000, Dave Airlie wrote:
> > On Mon, 5 Nov 2018 at 15:59, Sam Bobroff <sbobroff@linux.ibm.com> wrote:
> > >
> > > When unloading the ast driver, a warning message is printed by
> > > drm_mode_config_cleanup() because a reference is still held to one of
> > > the drm_connector structs.
> > >
> > > Correct this by calling drm_framebuffer_remove() in
> > > ast_fbdev_destroy().
> > >
> > > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > > ---
> > >  drivers/gpu/drm/ast/ast_fb.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> > > index 0cd827e11fa2..655372ea81e9 100644
> > > --- a/drivers/gpu/drm/ast/ast_fb.c
> > > +++ b/drivers/gpu/drm/ast/ast_fb.c
> > > @@ -263,6 +263,10 @@ static void ast_fbdev_destroy(struct drm_device *dev,
> > >  {
> > >         struct ast_framebuffer *afb = &afbdev->afb;
> > >
> > > +       /* drm_framebuffer_remove() expects us to hold a ref, which it
> > > +        * will drop, so take one: */
> > > +       drm_framebuffer_get(&afb->base);
> > > +       drm_framebuffer_remove(&afb->base);
> >
> > This doesn't seem corret, no other driver does this pattern, and I
> > can't believe ast is special here.
> >
> > The get just doesn't make sense.
>
> Thanks for having a look at this, as I said in the cover letter I was
> concerned that it might not be a good fix.
>
> But the AST driver does seem to be special (or just old?) because it
> embeds the drm_framebuffer directly into ast_fbdev and (almost all)
> other drivers dynamically allocate and reference count theirs.
>
> The drm_framebuffer_get() certainly looks weird but it is there in order
> to cause drm_framebuffer_remove() to call legacy_remove_fb(), which it
> won't do unless the refcount is at least 2. (And because the
> drm_framebuffer isn't dynamically allocated in this case we don't really
> care about the reference count anyway.)
>
> An alternative might be to call legacy_remove_fb() directly, but it's
> declared static.  Do you think it would be better to expose it and call
> it directly from the AST driver code? Or is there some other better way
> to put the drm_connectors?

Your problem isn't the dynamic fb vs. embedded fb for fbdev (you're
already using drm_framebuffer_unregister_private to handle that). Your
problem is you're not shutting down stuff on driver unload, which
means the fb is still in use. drm_atomic_helper_shutdown() takes care
of that for atomic drivers.

No idea anymore what to do for legacy code, probably need to open code
a shutdown sequence. Definitely not the above.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
