Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CEBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B1420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548841185;
	bh=YYXwcZMW46syTItt74nGITi1+Moy++U9QHnJ68lh884=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s32yLK+pDB33AEzajW04RI3tHTSU4Ezj8Sjmsn9lRz63KginSc6ya7nWup2XIo8BD
	 oZ6VJJ0tf3Yv6J+VA9qTDiqFW0BUph3lfJT/4cQedAUdbI4IzDiMwmvZ7qCDyZfHuR
	 LSXe24TPXjuJzlxo/Cz+aPkYLt/trXUWFdUWZ61E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbfA3Jjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:39:43 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37702 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:39:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so20556962otq.4;
        Wed, 30 Jan 2019 01:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfqJpYjLPJU9hr+vSJUe0Tk4KYpvDcwI3A9ccP1pAxM=;
        b=Hra0XOE6q/A/ZqZJiHO0jzdTTdLS9iRvOh7kslD9pCQdrgLYGelzMFs+vyVOYzloDM
         ykYuF8oQ/GurU4/9otCj+S3Pve67xFoP+gyLZoAQs8Tqh/lIz0uE6fbYgjoo/LQADVBZ
         f2F8ldr0qO+aNQ0V0rPGzz9Tx2htVVfBla0nNW7lG7WhBjrHysOI3FbVdvI5vAc5czAj
         cpE9LldvJX6EDKxP0kM1TZW/icxTdeLv93i7aPfstqyF9EDGtTFmSKC0wYAmo900LAB2
         XA/eJ/8cmUuXclnK7sjiSYBmIVU2y5HDNuec7RQk9ZMXmOkW631D4dnzsGCzUV8KkP0X
         eRhQ==
X-Gm-Message-State: AJcUukcWbenTZoBW4NE7GOjaVX9cBeuS04okdCcXeOi6V5Tsc6ursZC3
        10EzT+J8OIxtbCO16UEigltCBZny4bOyll15aAE=
X-Google-Smtp-Source: ALg8bN5MauY/nMq3uFyPzgxOQRmBBRts3X2/VtxUWgqIGzsRRphC0idmZbkMleVRGOLH/jR2f0kSTW77ScG1lMeNCsY=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr20185440otf.124.1548841182133;
 Wed, 30 Jan 2019 01:39:42 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
 <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com> <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
In-Reply-To: <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jan 2019 10:39:30 +0100
Message-ID: <CAJZ5v0jLJ8Tu7Gpt-4bhW59Q3=PX4wyb2rFBWuPKMFHcFXBxAA@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:14 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Geert,
>
> On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Vincent,
> >
> > On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> > >                 pm_runtime_mark_last_busy
> > >                     ktime_get
> > >                         do
> > >                             read_seqcount_begin
> > >                         while read_seqcount_retry
> > >     ....
> > >     write_seqcount_end
> > >
> > > Although we should be safe because we haven't yet changed the clocksource
> > > at that time, we can't because of seqcount protection.
> > >
> > > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> > >
> > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > Thanks for your patch!
> >
> > /**
> >  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
> >  *
> >  * This timestamp is not guaranteed to be monotonic across an update.
> >  * The timestamp is calculated by:
> >  *
> >  *      now = base_mono + clock_delta * slope
> >  *
> >  * So if the update lowers the slope, readers who are forced to the
> >  * not yet updated second array are still using the old steeper slope.
> >  *
> >  * tmono
> >  * ^
> >  * |    o  n
> >  * |   o n
> >  * |  u
> >  * | o
> >  * |o
> >  * |12345678---> reader order
> >  *
> >  * o = old slope
> >  * u = update
> >  * n = new slope
> >  *
> >  * So reader 6 will observe time going backwards versus reader 5.
> >  *
> >  * While other CPUs are likely to be able observe that, the only way
> >  * for a CPU local observation is when an NMI hits in the middle of
> >  * the update. Timestamps taken from that NMI context might be ahead
> >  * of the following timestamps. Callers need to be aware of that and
> >  * deal with it.
> >  */
> >
> > As this function is not guaranteed to be monotonic, have you checked how
> > the Runtime PM code behaves if time goes backwards? Does it just make
> > a suboptimal decision or does it crash?
>
> As a worst case this will generate a suboptimal decision around the update

So that should be explained in the changelog of the patch.  In detail,
if poss, please.
