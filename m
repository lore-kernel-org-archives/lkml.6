Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D89C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D1F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5x5AUP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAYRGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:06:18 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44675 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:06:18 -0500
Received: by mail-vk1-f195.google.com with SMTP id h128so2278543vkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUabPGz8yxEC1nqOm2ma+2b8lb7Wa5vt/5vpF/8V8jA=;
        b=H5x5AUP8IWsNn7ChNxbTAS39D80wbTm3Y0ZS3bG8D5NqWjTRQg2VximVPdpjdii7WZ
         p/kWB3+wBZav1Hg5Uww9neGCL763af0VE4p/TN8AXtgpqkR+4zYRvFD4om1w33VNPQST
         V12qOHkrF4OAPb8r14y/QEB6w7CHq5A0+/yjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUabPGz8yxEC1nqOm2ma+2b8lb7Wa5vt/5vpF/8V8jA=;
        b=kn06QebRWLfILTARIE1ZZ8r9AkPZcGrbkCasHHTSPpTxVFFlRWYiGaSCVfij78Egz8
         VdKT2u9uONwmLQDdTwJj++qlsgZUr2P+DMOCBcZtEtwSq8lbQ1yw3qXVFEVbjKbnRREa
         Tjfzl0xqfe8oIQMXrUdAdBh4OyDF14IWaJSGn+hkPiMsjzXFSk73gy0muNWYMSIxPVxE
         HP/Pn6cIgvVUptct7qOzdsQkN5E+2no+BjIsCOuWyQlPsq8bc+vs7dGjLb+pqw6hOO8i
         nMEW+O3WD6630vdKmAbZDdmzal57JGYftH0E16zMMCD8ZIfDUNl6Q7cdXm94cN5zAzA+
         eyIg==
X-Gm-Message-State: AJcUukeXJvoLSIoIfhfWy8TwGM6UcRCRvWcmbLRdzYbtfAte/OaqlswW
        rDq8LiTSJe4Qp98AgwCeuWvM4rFdkmg=
X-Google-Smtp-Source: ALg8bN6GKLqxAgs7PdYF9cn1ovlBez13UEQoYQtiKpkOFTGU3D++O9DyMczpiAEBGk1iQ/1yLeNZHQ==
X-Received: by 2002:a1f:9042:: with SMTP id s63mr4564391vkd.17.1548435976015;
        Fri, 25 Jan 2019 09:06:16 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a137sm28755320vsd.24.2019.01.25.09.06.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:06:14 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id b18so2286664vke.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 09:06:14 -0800 (PST)
X-Received: by 2002:a1f:3d10:: with SMTP id k16mr4753889vka.13.1548435973936;
 Fri, 25 Jan 2019 09:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20190118193200.32691-1-malat@debian.org> <CAH7mPvi2TN0b=j-6fqDpjGPkZVSEQnDiT2nj9NWmoBOhUiwKEg@mail.gmail.com>
 <CA+7wUsz6Rm58VOOTRA1+URKvONzsGcUT+A8F_sctyqMEOfs=yw@mail.gmail.com>
In-Reply-To: <CA+7wUsz6Rm58VOOTRA1+URKvONzsGcUT+A8F_sctyqMEOfs=yw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 26 Jan 2019 06:06:02 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+CQLk6u8iMmOfbvk5=B5PdDvc8qkkHBAjpXquhYgWTwg@mail.gmail.com>
Message-ID: <CAGXu5j+CQLk6u8iMmOfbvk5=B5PdDvc8qkkHBAjpXquhYgWTwg@mail.gmail.com>
Subject: Re: [PATCH] writeback: tracing: Copy only up to 31 characters in
 strncpy() calls
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 9:18 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Fri, Jan 25, 2019 at 5:26 AM Nick Desaulniers
> <nick.desaulniers@gmail.com> wrote:
> >
> > On Fri, Jan 18, 2019 at 11:32 AM Mathieu Malaterre <malat@debian.org> wrote:
> > >
> > > In the past an attempt was made to remove a set of warnings triggered by
> > > gcc 8.x and W=1 by changing calls to strncpy() into strlcpy(). This was
> > > rejected as one of the desired behavior is to keep initializing the rest
> > > of the destination string whenever the source string is less than the
> > > size.
> > >
> > > However the code makes it clear that this is not a desired behavior to
> > > copy the entire 32 characters into the destination buffer, since it is
> > > expected that the string is NUL terminated. So change the maximum number
> > > of characters to be copied to be the size of the destination buffer
> > > minus 1.
> > >
> > > Break long lines and make this patch go through `checkpatch --strict` with
> > > no errors.
> > >
> > > This commit removes the following warnings:
> > >
> > >   include/trace/events/writeback.h:69:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:99:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:179:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:223:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:277:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:299:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:324:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:375:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:586:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >   include/trace/events/writeback.h:660:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
> > >
> > > Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> > > Link: https://lore.kernel.org/patchwork/patch/910830/
> > > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > > ---
> > >  include/trace/events/writeback.h | 30 ++++++++++++++++++++----------
> > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> > > index 32db72c7c055..7bc58980f84f 100644
> > > --- a/include/trace/events/writeback.h
> > > +++ b/include/trace/events/writeback.h
> > > @@ -67,7 +67,8 @@ TRACE_EVENT(writeback_dirty_page,
> > >
> > >         TP_fast_assign(
> > >                 strncpy(__entry->name,
> > > -                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
> > > +                       mapping ? dev_name(inode_to_bdi(mapping->host)->dev) :
> > > +                       "(unknown)", sizeof(__entry->name) - 1);
> >
> > Does strncpy guarantee that destination will be NULL terminated if
> > (sizeof(src) > sizeof(dst)) || (32 > sizeof(dst))?
>
> No, that's the point here:
>
> https://www.kernel.org/doc/htmldocs/kernel-api/API-strncpy.html
>
> ...
> The result is not NUL-terminated if the source exceeds count bytes.
>
> In the case where the length of src is less than that of count, the
> remainder of dest will be padded with NUL.
> ...
>
> One should use strlcpy for the use case you describe:
>
> https://www.kernel.org/doc/htmldocs/kernel-api/API-strlcpy.html

Please use strspy() -- strlcpy() will read the source beyond the length limit.
https://www.kernel.org/doc/htmldocs/kernel-api/API-strscpy.html

-- 
Kees Cook
