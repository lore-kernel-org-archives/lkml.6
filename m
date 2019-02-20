Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE362086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaE2xMxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBTPTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:19:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34397 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:19:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so40816876oty.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kj9tjaVL9+M+7cFmixwKFQ4ymWN+OUpFMYAASPNiVKA=;
        b=OaE2xMxFPY0jREzIzefm90oSJ0AaLYnHUziLoeEAacps5/hCvsW4dfJbw8SSyETKHa
         yJ/ynmF2GrgNyTptRmoVwBGfxa970mxVXCKY96vzX93ag9MuucniZx3ZLF9r3g+jJruC
         fseob/iF1UWN62bPVv0dvl6/KBYP85EqwHACZsT8vR2ih0xtebBhnPw7Ymcx0IpFnwFw
         9B7FAIOz5yjQwtiqla3ZHvEyvor3hgUmkvSOCMQadvB8Eq/P8bQ5jm7K2wk4bW2O21MT
         RuG1itgxekqLKCXu08ZHr/JbVu2RSuK/y2uKScp5I9gnz891y+IFtUZurIPc1OjI6GWD
         qtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kj9tjaVL9+M+7cFmixwKFQ4ymWN+OUpFMYAASPNiVKA=;
        b=lXglhf6sg05vHmeVIP30OvXKbd9hpv44K3QyNy4BZLdAaAa4q0PnkoJeqG9K5PMxhJ
         yI7Pr1R96fFtyoVsiic3dxYKTtGvcT7bnCu0NGuHCDG5tThsYzY6xdjTJwTm9DjBCn5s
         MwRfX4rfTFlXvm9Vv7t9+py2bp6zMNgHXULJv2mJ+6L9ih/xsEdu7nqD5dicQTnBLGko
         tdTIy2Cz+h5Z8Vs1hsrg2vSLgJJeWQbghF0kgetuJG3VF9rAhruPvKJs3Sy08UT3s/Qn
         lq7XW5at4yKjv3tI+Pp8SgSvO0wlRIEnND+y+1Kuht8ZF0iKp/OBHpTBfHvnwNzxNmW3
         qCVA==
X-Gm-Message-State: AHQUAuYqyYMcuzMN8oglxdigGtFPCrfq8d3LvpjlYN0iGODPgjJ08kRT
        o8v/Of64C0kG7vAIBTGNvyKg70g5+X4goEGbmMb2rGFPMvA=
X-Google-Smtp-Source: AHgI3IZYy9Z3X6ZIWIF7ad57+FbYUzRejxWzuwXTvT5jZMRRT6ZtZShCr9cMmLEvSPot6c2/bSBH5udyGYYz2et0xds=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr14958022otr.242.1550675976158;
 Wed, 20 Feb 2019 07:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20190218220723.176737-1-jannh@google.com> <20190219204502.d0c4f95d1cda533990d96cd9@kernel.org>
 <20190219235122.b9f8c6c47392a27131526018@kernel.org>
In-Reply-To: <20190219235122.b9f8c6c47392a27131526018@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Feb 2019 16:19:10 +0100
Message-ID: <CAG48ez20Hipk2VWjXmbWmC+LVqywAcGOF_Wq-ooO-dLh+EadaQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: use strndup_user() instead of buggy open-coded version
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 3:51 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Tue, 19 Feb 2019 20:45:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > On Mon, 18 Feb 2019 23:07:23 +0100
> > Jann Horn <jannh@google.com> wrote:
> >
> > > The first version of this method was missing the check for
> > > `ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
> > > on error, so there was still a small memory leak in the error case.
> > > Fix it by using strndup_user() instead of open-coding it.
> > >
> >
> > This looks good to me.
> >
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> BTW, I think it should note that if the string is longer than PATH_MAX.
> caller will receive -EINVAL instead of -E2BIG with this fix.

Oh, whoops, I hadn't noticed that.

Do you want me to just add a note to the changelog, or do I have to
work around this in the code?

> > > Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > compile-tested only
> > >
> > >  kernel/trace/trace_event_perf.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> > > index 76217bbef815..c744b02081c3 100644
> > > --- a/kernel/trace/trace_event_perf.c
> > > +++ b/kernel/trace/trace_event_perf.c
> > > @@ -299,15 +299,11 @@ int perf_uprobe_init(struct perf_event *p_event,
> > >
> > >     if (!p_event->attr.uprobe_path)
> > >             return -EINVAL;
> > > -   path = kzalloc(PATH_MAX, GFP_KERNEL);
> > > -   if (!path)
> > > -           return -ENOMEM;
> > > -   ret = strncpy_from_user(
> > > -           path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
> > > -   if (ret == PATH_MAX)
> > > -           return -E2BIG;
> > > -   if (ret < 0)
> > > -           goto out;
> > > +
> > > +   path = strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
> > > +                       PATH_MAX);
> > > +   if (IS_ERR(path))
> > > +           return PTR_ERR(path);
> > >     if (path[0] == '\0') {
> > >             ret = -EINVAL;
> > >             goto out;
