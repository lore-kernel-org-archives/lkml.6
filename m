Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C422146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H7+f+o74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C422146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeK3Ut4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:49:56 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37666 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeK3Ut4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:49:56 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so4309533edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BlZOvymTYw44UyxMtxgGl5eBsS3i5N6wcCdoEYYmpvE=;
        b=H7+f+o74E2MSaZx410NGx5RICamNom9hKdqtsf3rc7SNVlM6jyYnh9Mi4qDAJbFZkg
         UA2dDfEDSN4t/O1v905cwX+CND7PcWZjzB/EjZ6OT3XU0OwaBkdQAClvfr/++t8vcYbQ
         eWF/Ve4aoH+WH4fTZ50d2C+16mXT58wA72B3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BlZOvymTYw44UyxMtxgGl5eBsS3i5N6wcCdoEYYmpvE=;
        b=r4SIQn3SlTA5dS+cU/WB+ql8SGpqxVmjLSz9fMAvQf/bLXL0e337naTwy1plczNFn1
         h0AWIbJaoalECnt83e4rGNlbv6q6ri5cM54l0c8zmW8BfHNOs1Gf+V9QxetHuG3pEg4B
         rXBvA62rkBrgoaBXXvMoH+DB71rl8yZYw6l9ebp14FD3jmMctAlrnx1yqsOFFk8Jy3tb
         tYNERrqgxZfDO7GcA9RYkHykL7ssIHT6YbuEO7Bt4fxnd3XDm68U+swGvea30OIIgtZm
         enzH9mo77A6qnLF5/zrfnV20LseEsDFV7cHX4J7YXOJNXQEAnUXjUuO5ZfbgnHVUMTXC
         2Mvw==
X-Gm-Message-State: AA+aEWYhH7Wnz687JXHwI4wwvA9INXRHVTYyEVXc1pJK3Rb4T/BwZ93x
        3vtlBau+8y/D6/NLE4heid9IrA==
X-Google-Smtp-Source: AFSGD/V9+bb+10oigL0NnoTZUlbax9DRldlg1lg174uJ5YTsVNIGNOpkEvTpg48yCyUoWoh9VLO43Q==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr4757340edp.258.1543570871268;
        Fri, 30 Nov 2018 01:41:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c29sm1244493eda.75.2018.11.30.01.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 01:41:10 -0800 (PST)
Date:   Fri, 30 Nov 2018 10:41:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Bobroff <sbobroff@linux.ibm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/ast: Fix connector leak during driver unload
Message-ID: <20181130094108.GT21184@phenom.ffwll.local>
Mail-Followup-To: Sam Bobroff <sbobroff@linux.ibm.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Dave Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <cover.1541397462.git.sbobroff@linux.ibm.com>
 <3350c5dd5ea08c71e4769ea3801290e7f9238a6c.1541397462.git.sbobroff@linux.ibm.com>
 <CAPM=9txRjd6E3DxdcM14mzWG1P-Cr70P61Eyce95bBhJtqfH7A@mail.gmail.com>
 <20181129020034.GA10328@tungsten.ozlabs.ibm.com>
 <CAKMK7uEY8C_9qwuUi5rR1+_xYOSXeKicopR1zTpQKaMEJTM-fA@mail.gmail.com>
 <20181130001750.GA6776@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130001750.GA6776@tungsten.ozlabs.ibm.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:17:51AM +1100, Sam Bobroff wrote:
> On Thu, Nov 29, 2018 at 09:56:53AM +0100, Daniel Vetter wrote:
> > On Thu, Nov 29, 2018 at 9:05 AM Sam Bobroff <sbobroff@linux.ibm.com> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 09:40:53AM +1000, Dave Airlie wrote:
> > > > On Mon, 5 Nov 2018 at 15:59, Sam Bobroff <sbobroff@linux.ibm.com> wrote:
> > > > >
> > > > > When unloading the ast driver, a warning message is printed by
> > > > > drm_mode_config_cleanup() because a reference is still held to one of
> > > > > the drm_connector structs.
> > > > >
> > > > > Correct this by calling drm_framebuffer_remove() in
> > > > > ast_fbdev_destroy().
> > > > >
> > > > > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > > > > ---
> > > > >  drivers/gpu/drm/ast/ast_fb.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> > > > > index 0cd827e11fa2..655372ea81e9 100644
> > > > > --- a/drivers/gpu/drm/ast/ast_fb.c
> > > > > +++ b/drivers/gpu/drm/ast/ast_fb.c
> > > > > @@ -263,6 +263,10 @@ static void ast_fbdev_destroy(struct drm_device *dev,
> > > > >  {
> > > > >         struct ast_framebuffer *afb = &afbdev->afb;
> > > > >
> > > > > +       /* drm_framebuffer_remove() expects us to hold a ref, which it
> > > > > +        * will drop, so take one: */
> > > > > +       drm_framebuffer_get(&afb->base);
> > > > > +       drm_framebuffer_remove(&afb->base);
> > > >
> > > > This doesn't seem corret, no other driver does this pattern, and I
> > > > can't believe ast is special here.
> > > >
> > > > The get just doesn't make sense.
> > >
> > > Thanks for having a look at this, as I said in the cover letter I was
> > > concerned that it might not be a good fix.
> > >
> > > But the AST driver does seem to be special (or just old?) because it
> > > embeds the drm_framebuffer directly into ast_fbdev and (almost all)
> > > other drivers dynamically allocate and reference count theirs.
> > >
> > > The drm_framebuffer_get() certainly looks weird but it is there in order
> > > to cause drm_framebuffer_remove() to call legacy_remove_fb(), which it
> > > won't do unless the refcount is at least 2. (And because the
> > > drm_framebuffer isn't dynamically allocated in this case we don't really
> > > care about the reference count anyway.)
> > >
> > > An alternative might be to call legacy_remove_fb() directly, but it's
> > > declared static.  Do you think it would be better to expose it and call
> > > it directly from the AST driver code? Or is there some other better way
> > > to put the drm_connectors?
> > 
> > Your problem isn't the dynamic fb vs. embedded fb for fbdev (you're
> > already using drm_framebuffer_unregister_private to handle that). Your
> > problem is you're not shutting down stuff on driver unload, which
> > means the fb is still in use. drm_atomic_helper_shutdown() takes care
> > of that for atomic drivers.
> > 
> > No idea anymore what to do for legacy code, probably need to open code
> > a shutdown sequence. Definitely not the above.
> > -Daniel
> 
> Well, it looks like drm_crtc_force_disable_all() would also do the job,
> and from looking at nouveau_display_fini() it's used there as an
> alternative to drm_atomic_helper_shutdown().

Ah right, I tried looking for that one but didn't find it with a quick
scan.
 
> Would it be reasonable to call that at the start of
> ast_fbdev_destroy() instead? (Testing shows that it does allow the
> drm_connector to be released. Is it enough/correct though?)

Yes.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
