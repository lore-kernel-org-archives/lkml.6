Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66159C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30120222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550014551;
	bh=o9l5o+x0OXRmvObkwzEowgIMAlUHvxHOTooagf+QIRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T8mOGgI0Q6g66gEMQYEsU3qh38pyRwPRCFlJVhRY8tGAKZ/TUCGVr7UP6VH28gbpp
	 3i48ioEPg4SXF14+seXHoEGIKKTvwxAb9DvLhTS7xrgvHE4H/jwwbTIlrWsw/8ap2l
	 6VCIG9y6lID55umoha7D68ilfT/7ykPOsoqE8KqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfBLXft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:35:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42336 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbfBLXft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:35:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so827886oto.9;
        Tue, 12 Feb 2019 15:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXICgiUJr/5Ldkwhfhho6WPg0umAL8GWDjXXTbEiweU=;
        b=t/IbHvbSUaU3+l3nTo2e2VQmR+rTCVEQcdYf/MWJxX2khhRvp9pQDT2o4QpQIGKcI/
         CL/+fSiayvCRMd/wOlVJsWlB1KT+8ELmmy4sEfvjvzKoi03l+RzYeTFeLpPaslSnGqOY
         U1O1de+zkTDFJf9cbV243ZJoBmZXi6FNAgJJZXRsExuUsDVLcb9U/KuRiHo9i0ftgaJG
         opbG7nbWw2tCO2DT7Li+iaOqrOQcwj/SxHhlL7z304GXNg6+IYfiBD4uoQORe6rNoQkE
         ZfIiqGiPYDO9VT/vUhC8U4dOpaz3HrYGimfw0iuqOkAnkSMvrDg6AHMP1DiGu+Ift4kc
         OryA==
X-Gm-Message-State: AHQUAub8btjYLx9cGQJCZqVosX3iHRj6gGC0CzANuFoJpUUAZv/dbL4y
        XTJrJu3oxbieNsjn9YXW4sSibcv9NrxWXOBP4z0=
X-Google-Smtp-Source: AHgI3IaYS5xDylhYQhdwc99LGZM5/uJVhXK+mDNS1yB7xoWCjvWqhwUgt5FzXYPQ6Of4/P14BbvZTrmF9KW5zXpMh7Q=
X-Received: by 2002:a05:6830:2005:: with SMTP id e5mr6651895otp.258.1550014548257;
 Tue, 12 Feb 2019 15:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20190203052007.27392-1-harry.pan@intel.com> <20190206144257.21464-1-harry.pan@intel.com>
 <CAJZ5v0j+JEs5G+ySmkxEc0kbomTckX=wRg_DbnQ6svnX+EZaTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+JEs5G+ySmkxEc0kbomTckX=wRg_DbnQ6svnX+EZaTg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Feb 2019 00:35:37 +0100
Message-ID: <CAJZ5v0j3pDoLnxNqZRvNW8+hdBs_MLf22OsNivkBpcCG_if0DA@mail.gmail.com>
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Harry Pan <gs0622@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 12:21 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 6, 2019 at 4:57 PM Harry Pan <harry.pan@intel.com> wrote:
> >
> > This patch gives the reader an intuitive metric of the time cost by
> > the kernel issuing a filesystem sync during suspend; although developer
> > can guess by the timestamp of next log or enable the ftrace power event
> > for manual calculation, this manner is easier to read and benefits the
> > automatic script.
> >
> > v2: simplify the variables, apply the simplest form of ktime API.
> >
> > Signed-off-by: Harry Pan <harry.pan@intel.com>
> > ---
> >  kernel/power/suspend.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 0bd595a0b610..87c0073f0c9d 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -550,6 +550,8 @@ static void suspend_finish(void)
> >  static int enter_state(suspend_state_t state)
> >  {
> >         int error;
> > +       ktime_t start;
> > +       unsigned int elapsed_msecs;
>
> You only need these two if CONFIG_SUSPEND_SKIP_SYNC is set, ->

s/set/unset/

Sorry for the confusion.
