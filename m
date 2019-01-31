Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCD7218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548935431;
	bh=RfjPDzwVmojJ7xgAr0l7n7k34DYo5eNpisdjUAB8rog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bap1boFxU+Mv+iaXMF5eF4xAki8LA6l6kNKNPjiPLz7JaUC/kZqFpLkPMFbPL2TGc
	 GQ6tW1DeSY5PsKW60U/ls/1Ae6USYsmQaAVDfwX5buYPOGkTFcyhH3xUR3WVEnT1P6
	 RiygUopUx36eG0niHXGR0Tf0Qr5w28bWGHFLf98w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfAaLu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:50:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36289 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfAaLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:50:29 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so2483012oix.3;
        Thu, 31 Jan 2019 03:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rln5o4HSQGSklTYfYgy8/ILGJY446Oyb3ELmRnbVAg=;
        b=n0KG5FvutLmQz/GoNuGU6kqgjClYp56JK0TjmAkmP10rEuRDuK6NSZsJCnMwcvwmjf
         W+GR0hU+cumE+ma81AVPq/r9+LNhSRjAEd6Lg+mkbok6K1IWX7GAGWuQ4FvrL53J1GZX
         34+pNezCz6t1Cif0dlL9r8pinhKbSOlffgfruDiPov1T8d0PPBiljgoPse927290Ju6v
         rOpKUi41HyyFTZC/YeJmUfwbW3GXUDFIHPZ+V7t3Si/2gR4Cj/Z+dgwjbV2cQ3QAoN5e
         yBY7gAXJDY7xlA7pTX0u3knd2dsUd3jLzx4afCVNoZIdgZNDanq/aeVwufGFK92Ltqig
         bjpw==
X-Gm-Message-State: AHQUAuZPewJHfkQLw9yxpE9cZFmYdxrGVJbaZvLmtV0XGnJJOp5GMVeM
        X3AYNhrNbvZ0002FhMkLkSPKkbXNklaTlTqQanwLHHbu
X-Google-Smtp-Source: ALg8bN5jvbykK/TniXhVUJ5RjjiIBPFYh5zEfDsTDC6M5uiGJU3uzWAcyhbHn8v8P3BphH1JQMzOBvxdHeadkoly69A=
X-Received: by 2002:aca:368a:: with SMTP id d132mr15628118oia.193.1548935427892;
 Thu, 31 Jan 2019 03:50:27 -0800 (PST)
MIME-Version: 1.0
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <b631310f-93fa-ef4b-7014-d97fcfb2dcdf@nvidia.com> <s5ha7jicd4l.wl-tiwai@suse.de>
 <20190131110530.GA23438@ulmo> <s5htvhpax8s.wl-tiwai@suse.de> <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_G36Cw3ZvDxyU2F+pBpiw9i=3_wfQ3tDh3_JgOAb3zw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 12:50:16 +0100
Message-ID: <CAJZ5v0iOkK+GQU8cnuH-T+futcvzPtLA5myEs=7u0WtazqaAew@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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

On Thu, Jan 31, 2019 at 12:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 31, 2019 at 12:21 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 31 Jan 2019 12:05:30 +0100,
> > Thierry Reding wrote:
> > >
> > > On Wed, Jan 30, 2019 at 05:40:42PM +0100, Takashi Iwai wrote:
>
> [cut]
>
> > > > If I understand correctly the code, the pm domain is already activated
> > > > at calling driver's probe callback.
> > >
> > > As far as I can tell, the domain will also be powered off again after
> > > probe finished, unless the device grabs a runtime PM reference. This is
> > > what happens via the dev->pm_domain->sync() call after successful probe
> > > of a driver.
> >
> > Ah, a good point.  This can be a problem with a probe work like this
> > case.
> >
> > > It seems to me like it's not a very well defined case what to do when a
> > > device needs to be powered up but runtime PM is not enabled.
> > >
> > > Adding Rafael and linux-pm, maybe they can provide some guidance on what
> > > to do in these situations.
> > >
> > > To summarize, what we're debating here is how to handle powering up a
> > > device if the pm_runtime infrastructure doesn't take care of it. Jon's
> > > proposal here was, and we use this elsewhere, to do something like this:
> > >
> > >       pm_runtime_enable(dev);
> > >       if (!pm_runtime_enabled(dev)) {
> > >               err = foo_runtime_resume(dev);
> > >               if (err < 0)
> > >                       goto fail;
> > >       }
> > >
> > > So basically when runtime PM is not available, we explicitly "resume"
> > > the device to power it up.
> > >
> > > It seems to me like that's a fairly common problem, so I'm wondering if
> > > there's something that the runtime PM core could do to help with this.
> > > Or perhaps there's already a way to achieve this that we're all
> > > overlooking?
> > >
> > > Rafael, any suggestions?
> >
> > If any, a common helper would be appreciated, indeed.
>
> I'm not sure that I understand the problem correctly, so let me
> restate it the way I understand it.
>
> What we're talking about is a driver ->probe() callback.  Runtime PM
> is disabled initially and the device is off.  It needs to be powered
> up, but the way to do that depends on some configuration of the board
> etc., so ideally
>
> pm_runtime_enable(dev);
> ret = pm_runtime_resume(dev);
>
> should just work, but the question is what to do if runtime PM doesn't
> work as expected.  That is, CONFIG_PM_RUNTIME is unset?

Well, we got rid of CONFIG_PM_RUNTIME, so that would be CONFIG_PM unset rather.

>  Or something else?
