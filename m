Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F58BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C30E217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wae96GsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfAVQBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:01:44 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39915 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfAVQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:01:43 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so20758778itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nftD0XO+/j6/Dw0JUCv51heda6BPvUcWvn4up1XrIw=;
        b=Wae96GsNXWSNdBQwr5d01k4uRI9vOQQYvRdID9cgNTNnvxA1UFyw/MAIlwde3chYck
         1bqkK6YgnSqkHfxUMVGTqBknLL9i1OvvDwJ5aQ9aUd58tIFzkl4ePyVHuPOJD7q5a2yK
         E650GE/j5wR8SxmrxiXjV+Jsvu9cD7T2BztkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nftD0XO+/j6/Dw0JUCv51heda6BPvUcWvn4up1XrIw=;
        b=bXAVX17Z8F1bKR/WArjXaVAeJeBCej7FfGZdNe5InVxSNud6ncdrSlEpwDQY+G8WnW
         CvBQftZQrVIXV0vPn6+oXp/LlhaD9DigRLNv5t0YxGV/qWHX/97Er8++Cr+YNYjtTY9l
         ds7dU6RVhpkZklUy7/8Y9o+JZTPJTwACU7DCLKAA/Gz0utdRjqa1+Grx/XBVFdCXF4R9
         StUq0Zze0y3LO+h4SrKObhuqDWxEZNvAcjiB/nUlq2WPqNpWRd0q+2C00zkgmHK2jOy3
         fVLzKx7MCQ8gf+8nW22K1vSQnXebp6JPsQBp4CoHDZ8M6zu/xmgl9d7TS3Ccfl74BVor
         /wTw==
X-Gm-Message-State: AJcUukf34IQpvpRlIXsAndbJ8X9aUWE3QEp0ygOJNS3RnqNvxBofmjn1
        S8OQuKT0v3yJga9ksdFQx/0fGA0J9LzPFfB7H39bKg==
X-Google-Smtp-Source: ALg8bN7SOUcTeS+MGOuBrxYQlT5ksIRyDn73gWgW/Kwf2uiOMPyEDGlBv4zMMoD4Mlt8qfrMGUrmMs53Jky/HGwXAIw=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr2517538itf.14.1548172902201;
 Tue, 22 Jan 2019 08:01:42 -0800 (PST)
MIME-Version: 1.0
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
 <1548167070-421-2-git-send-email-vincent.guittot@linaro.org> <CAJZ5v0gxYvDQZVrkQZ-eQgoQDhwRYR1x+SC_q7uxxbko0R03=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gxYvDQZVrkQZ-eQgoQDhwRYR1x+SC_q7uxxbko0R03=w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 22 Jan 2019 17:01:31 +0100
Message-ID: <CAKfTPtBfbUpnGOWJsDp06PeQSyOBreX31=3iRvkR1sdFOv29Mg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 16:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 22, 2019 at 3:24 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Initializing accounting_timestamp to something different from 0 during
> > pm_runtime_init() doesn't make sense and put useless ordering constraint between
> > timekeeping_init() and pm_runtime_init().
> > PM runtime should start accounting time only when it is enable and discard
> > the period when disabled.
> > Set accounting_timestamp to now when enabling PM runtime.
> >
> > Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/base/power/runtime.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index fb5e2b6..7df1d05 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
> >
> >         spin_lock_irqsave(&dev->power.lock, flags);
> >
> > +       /* About to enable runtime pm, set accounting_timestamp to now */
> > +       if (dev->power.disable_depth == 1)
> > +               dev->power.accounting_timestamp = jiffies;
>
> I would do this in the dev->power.disable_depth > 0 branch below.
> Just check if disable_depth is zero after decrementing it and update
> accounting_timestamp if so.

My goal was to prevent nested "if" which is sometime difficult to read.
I'm going to change that and send a new version

Vincent

>
> > +
> >         if (dev->power.disable_depth > 0)
> >                 dev->power.disable_depth--;
> >         else
> > @@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
> >         dev->power.request_pending = false;
> >         dev->power.request = RPM_REQ_NONE;
> >         dev->power.deferred_resume = false;
> > -       dev->power.accounting_timestamp = jiffies;
> > +       dev->power.accounting_timestamp = 0;
> >         INIT_WORK(&dev->power.work, pm_runtime_work);
> >
> >         dev->power.timer_expires = 0;
> > --
> > 2.7.4
> >
