Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6690EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34867218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFydvYEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfAYN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:29:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35449 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:29:52 -0500
Received: by mail-io1-f66.google.com with SMTP id f4so7739503ion.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 05:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G4QzuC+ZKMoTiYj4W9byPDHdN7qj/96L4I+3Bz2JbzI=;
        b=UFydvYEosyJLqaSjmoDr45Y64ShHj7jJZioif7pYl5IJWZCOXiFwjuetm+/ohHrtvU
         Ycmoj7MYvXMphgwvDNBRc7A4WlSFnwNljkp/ufrOQZy2Tim4sTITrvQJ6lb50JVPKKIy
         OnGqMs13rczRdS+gUikN6bMnYCQggKiW0warY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G4QzuC+ZKMoTiYj4W9byPDHdN7qj/96L4I+3Bz2JbzI=;
        b=lI7MjOvhyyqJ4S/PnXnf0Hlw+bsxt8BQNTWdM+wf8NWFA0NmGLvDHBxCweU9ZiUNYc
         upF9eCjbU2j3whYfEWx4sBNG8mPjuhaTb4fBV+kFHZOFDSZaoHDiI4QpZcx3Y979Sg6P
         jkOJAlSB6PoDvKDtyPmti1hQoaBG88LgHuYqNPsqfIYH1AO7DDqXPbUhPG6ZrxK+221I
         gFh0pPMK5nuvdIRQFvthNWicLp03zhD4JJXhQD9RF62FpfabYcIC0zHCV56zVHLBLK/Y
         4qGsrP79vBOXGHSqwe4caLkErjuhI4xOD77gF43XpCPF3Im7r6YpqHebZsSV60itK/7N
         gbMg==
X-Gm-Message-State: AHQUAub3IUjQHuT8jazysXPA5dTguG+SAFwYUeEIiuWKstK0Oye+HURJ
        BiG6s49JCVrbRBcNsAr2kKr0oOV8SUUMN/y4hRHQiQ==
X-Google-Smtp-Source: AHgI3Ia+TuE3dRlUHwInfp+Z5t+kud1Rw3rZ7FrthxGVOZRWiZLuynhdmcKff+PXFPfA9Do8wKeaHR4ADF0BVpkaXwE=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr6215402iob.170.1548422991301;
 Fri, 25 Jan 2019 05:29:51 -0800 (PST)
MIME-Version: 1.0
References: <1547765160-15502-1-git-send-email-eugene.loh@oracle.com> <CAKv+Gu8BeYsq-_7KiANOjSN2fp25BP=71uLqKnkkYYJdhD2Bfw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8BeYsq-_7KiANOjSN2fp25BP=71uLqKnkkYYJdhD2Bfw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 25 Jan 2019 14:29:40 +0100
Message-ID: <CAKv+Gu_6_K0ZrRLMST6bYxqgSfhDJACoiArQg+K3pFaYjJxQsA@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: Handle too long symbols in kallsyms.c
To:     eugene.loh@oracle.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andi@firstfloor.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ masahiro)

On Fri, 25 Jan 2019 at 14:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 17 Jan 2019 at 23:46, <eugene.loh@oracle.com> wrote:
> >
> > From: Eugene Loh <eugene.loh@oracle.com>
> >
> > When checking for symbols with excessively long names,
> > account for null terminating character.
> >
> > Fixes: f3462aa952cf ("Kbuild: Handle longer symbols in kallsyms.c")
> > Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> > ---
> >  scripts/kallsyms.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 77cebad..f75e7bd 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -118,8 +118,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
> >                         fprintf(stderr, "Read error or end of file.\n");
> >                 return -1;
> >         }
> > -       if (strlen(sym) > KSYM_NAME_LEN) {
> > -               fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
> > +       if (strlen(sym) >= KSYM_NAME_LEN) {
> > +               fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
> >                                 "Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
> >                         sym, strlen(sym), KSYM_NAME_LEN);
> >                 return -1;
> > --
> > 1.8.3.1
> >
