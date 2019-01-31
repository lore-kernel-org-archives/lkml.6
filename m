Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FC42086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548936616;
	bh=Q1nJp5Uh7SDlnX4xbUxoeBge4jaIsX7J7gQ0xwYevuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t1FmEDvlhDrfxnkZklyhRKJ/ab9iQebRmtppFoc/ycKpIDo/AL9VZGqITedYHUQtz
	 s0x55LZi32wuHwnRoAdqH1LULFTPtqMWeaNFiQaAbh1wbXkbuzA/zxRc8ZGWmxF69Z
	 J6zWtW96U6b30Ec/0EN4zQ/m3CWqhouYIuXj+ud0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbfAaMKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:10:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42351 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfAaMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:10:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so2492508oiw.9;
        Thu, 31 Jan 2019 04:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2Boz/eLSjY0lgw0CGlg/cg9G2dV/cfPqiIyI7MY8kg=;
        b=eICi5A/pEXwRocDIbp5jPi3+9JW5fQZIKHiL0fBP77cT4IAdJhsRZ5d0zZkyzd0ulW
         tdaLe+hXJZw4CNVG8Tv1sHbgkGsLrotWgGxHT2CuosA8WgmE8YxX/wsmhoHM/DEKRBZv
         1BTHkccCdIvHR0Lfdq5SbgXJafCbtTNy2xqtC31fJ3QfgEBc2ovwJD3K3hzPrRJdv2/A
         OKCCG+CV+TuqSgsH5ZzWS9vSWos5eROmB3teJcLAJJ17pOZStgQwvaSRU8J4tLX1mF0C
         xYeRJIrRAkjmjwshk/TVwxBPLoJyeD1BSD1xorBDDrB1/L9EWzWOMFeanKNZN5CDYlU2
         bk1g==
X-Gm-Message-State: AHQUAuYcLVaLqQ2jmkxn71ePP1qlIkeNASc2V792nAvSU3JplsQwEXUU
        av/VkYY5pNNgiGDR86BfP/q6RKOLD6yyVMzvmwY=
X-Google-Smtp-Source: ALg8bN5DT/pCraghFQfyYRLQdN01CtVgD5KFOFXWvefhLaeyp2DttRSnPxM2FlORw9EPMSVZgvlAw9bpb9gK+9RuK0U=
X-Received: by 2002:aca:b642:: with SMTP id g63mr14355775oif.195.1548936612892;
 Thu, 31 Jan 2019 04:10:12 -0800 (PST)
MIME-Version: 1.0
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com> <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo> <s5htvhpax8s.wl-tiwai@suse.de>
 <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com> <s5hh8dpavhw.wl-tiwai@suse.de>
In-Reply-To: <s5hh8dpavhw.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 13:10:01 +0100
Message-ID: <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, mkumard@nvidia.com,
        rlokhande@nvidia.com, sharadg@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:59 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Jan 2019 12:46:54 +0100,
> Rafael J. Wysocki wrote:
> >
> > On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Thu, 31 Jan 2019 12:05:30 +0100,
> > > Thierry Reding wrote:
> > > >
> > > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
> >
> > [cut]
> >
> > > > > If I understand correctly the code, the pm domain is already activated
> > > > > at calling driver's probe callback.
> > > >
> > > > As far as I can tell, the domain will also be powered off again after
> > > > probe finished, unless the device grabs a runtime PM reference. This is
> > > > what happens via the dev->pm_domain->sync() call after successful probe
> > > > of a driver.
> > >
> > > Ah, a good point.  This can be a problem with a probe work like this
> > > case.
> > >
> > > > It seems to me like it's not a very well defined case what to do when a
> > > > device needs to be powered up but runtime PM is not enabled.
> > > >
> > > > Adding Rafael and linux-pm, maybe they can provide some guidance on what
> > > > to do in these situations.
> > > >
> > > > To summarize, what we're debating here is how to handle powering up a
> > > > device if the pm_runtime infrastructure doesn't take care of it. Jon's
> > > > proposal here was, and we use this elsewhere, to do something like this:
> > > >
> > > >       pm_runtime_enable(dev);
> > > >       if (!pm_runtime_enabled(dev)) {
> > > >               err = foo_runtime_resume(dev);
> > > >               if (err < 0)
> > > >                       goto fail;
> > > >       }
> > > >
> > > > So basically when runtime PM is not available, we explicitly "resume"
> > > > the device to power it up.
> > > >
> > > > It seems to me like that's a fairly common problem, so I'm wondering if
> > > > there's something that the runtime PM core could do to help with this.
> > > > Or perhaps there's already a way to achieve this that we're all
> > > > overlooking?
> > > >
> > > > Rafael, any suggestions?
> > >
> > > If any, a common helper would be appreciated, indeed.
> >
> > I'm not sure that I understand the problem correctly, so let me
> > restate it the way I understand it.
> >
> > What we're talking about is a driver ->probe() callback.  Runtime PM
> > is disabled initially and the device is off.  It needs to be powered
> > up, but the way to do that depends on some configuration of the board
> > etc., so ideally
> >
> > pm_runtime_enable(dev);
> > ret = pm_runtime_resume(dev);
> >
> > should just work, but the question is what to do if runtime PM doesn't
> > work as expected.  That is, CONFIG_PM_RUNTIME is unset?  Or something
> > else?
>
> Yes, the question is how to write the code for both with and without
> CONFIG_PM (or CONFIG_PM_RUNTIME).

This basically is about setup, because after that point all should
just work in both cases.

Personally, I would do

if (IS_ENABLED(CONFIG_PM)) {
  do setup based on pm-runtime
} else {
  do manual setup
}

> Right now, we have a code like below, pushing the initialization in an
> async work and let the probe returning quickly.
>
>         hda_tegra_probe() {
>                 ....

So why don't you do

if (!IS_ENABLED(CONFIG_PM)) {
  do manual clock setup
}

here?

>                 pm_runtime_enable();
>                 schedule_work();
>                 return;
>         }
>
>         hda_tegra_probe_work() {
>                 pm_runtime_get_sync();
>                 ....
>                 pm_runtime_put_sync();
>         }
>
> Then it truned outhis code lacks of the clock initialization when
> runtime PM isn't enabled.  Normally it's done via runtime resume
>
>         hda_tegra_runtime_resume() {
>                 hda_tegra_enable_clocks();
>                 ....
>         }
>
> And now the question is what is the standard idiom in such a case.
>
> IMO, calling pm_runtime_resume() inside the probe function looks
> weird, and my preference was to initialize the clocks explicitly, then
> enable runtime PM.  But if using pm_runtime_resume() in the proc
> should be seen as a standard procedure, I'm fine with that.

Well, people do pm_runtime_resume() in ->probe() too, but
pm_runtime_resume() returns 1 for CONFIG_PM unset, so that won't give
you what you want anyway. :-)

Cheers,
Rafael
