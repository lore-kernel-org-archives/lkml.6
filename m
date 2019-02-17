Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2A4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C0217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550438772;
	bh=NcEypruYJzcLAcM08IQRl2FzDOL0EuYs+wRlCM84luE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MlEzW4LK8moNVHdJof4EOb8BjiFtQ0laP1LloSKml3Alx65tVR+CPC1ZUFrTry4aE
	 KmQBRjuX9D9opXXT2uHksJZUyWkVR/DhJFHqccQGDuRhxSVNagbF7xKwf+LC78xFTl
	 4Xhh15mOnIKklqI56x0UvwtdmurTNtctdQE3zCiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfBQV0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:26:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42271 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfBQV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:26:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so25082857oto.9;
        Sun, 17 Feb 2019 13:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMju/mxaXk1kxjGwvpC36lXH8o3QSc8+PMhigawvNSE=;
        b=N9SS0ShUSMIV3kwZXxwyx1cvP5d3HZMs2lmrkUUHN+NmDgXczEBpULgAuL80aUWZ6r
         jWdqSfqElm5nLolWsiNFUMLcCZiqUPqBN/cp3wguU60Gch1L33j5+Ul20b+AjqvyZv80
         0Me17MHbxgl05R1FUg3l1n22CDSOcTBdCx/EDjk/gZHrin2/F+oenxdSyVXx5i3mxosY
         pqCGo3vOabcZv0di+dFTBCk9o9R0lH/xG2MkfFcji0AYZicO3DNe1N9crWrj/ndGRVMp
         D7rZVEcBt45DA5LDKTXWcZs5307U4XW4DXeBfvtneafrLvlMD57LJKFMWQUfj8158M2d
         jKJA==
X-Gm-Message-State: AHQUAuZguZDLrbd4nDudBgqUPcphXX3GpzbSG8t6R4ihm2tYrZw55eiK
        z79GomVaP2/DvzyzZISrpm1Zn6ACXVq0/sQ6EoFpvQ==
X-Google-Smtp-Source: AHgI3IaTe1HG3Kyyddwvx44zpD6PNsVMqisYkK+fyOK7dUcOuDV8vV6I7sU9WF9GCNYYrsXKI+1Nb8UPU+311n1d654=
X-Received: by 2002:a05:6830:2005:: with SMTP id e5mr12916811otp.258.1550438768625;
 Sun, 17 Feb 2019 13:26:08 -0800 (PST)
MIME-Version: 1.0
References: <2281684.8tZHfIXjiu@aspire.rjw.lan> <CADnq5_NmDYzZZPUh5Wp+a8bycRWFDt3Lhzf0AKx9BECJ_U-Kyg@mail.gmail.com>
 <20190216060058.gsiddsmj3f27e6v7@wunner.de> <CADnq5_OqaQA2HNcy+ZZvsN5MTEWLXoFEuirX4f4nzEOJ6NrdVA@mail.gmail.com>
In-Reply-To: <CADnq5_OqaQA2HNcy+ZZvsN5MTEWLXoFEuirX4f4nzEOJ6NrdVA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 17 Feb 2019 22:25:57 +0100
Message-ID: <CAJZ5v0g8-+cqQFspwYytTbzptZrt+GhT2RUX_nQnFD-rDbA7sA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "?????????????? ????????????????" <ukrkyi@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 12:37 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Sat, Feb 16, 2019 at 1:01 AM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Feb 15, 2019 at 11:01:04AM -0500, Alex Deucher wrote:
> > > On Fri, Feb 15, 2019 at 10:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
> > > > and the direct-complete optimization is used for the radeon device
> > > > during system-wide suspend, the system doesn't resume.
> > > >
> > > > Preventing direct-complete from being used with the radeon device by
> > > > setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
> > > > go away, which indicates that direct-complete is not safe for the
> > > > radeon driver in general and should not be used with it (at least
> > > > for now).
> > > >
> > > > This fixes a regression introduced by commit c62ec4610c40
> > > > ("PM / core: Fix direct_complete handling for devices with no
> > > > callbacks") which allowed direct-complete to be applied to
> > > > devices without PM callbacks (again) which in turn unlocked
> > > > direct-complete for radeon on HP ProBook 4540s.
> > >
> > > Do other similar drivers like amdgpu and nouveau need the same fix?
> > > I'm not too familiar with the direct_complete feature in general.
> >
> > direct_complete means that a discrete GPU which is in D3cold upon
> > entering system sleep is left as is, i.e. it is not woken.  It is
> > also expected to still be in D3cold when resuming from system sleep
> > from the PM core's point of view.  (If it is in D0uninitialized, the
> > GPU's driver needs to ensure it is transitioned to D3cold again.)
> >
> > I know for a fact that resuming the discrete GPU is not necessary
> > on my MacBook Pro with Nvidia GPU.  I'd expect those with AMD GPUs
> > to behave the same.  The apple-gmux driver takes care of putting
> > the GPU into D3cold on resume from system sleep if it was in D3cold
> > when entering system sleep (see drivers/platform/x86/apple-gmux.c,
> > gmux_resume()).
> >
> > I think it is desirable to use direct_complete because it saves power
> > (no need to gratuitously wake the GPU upon entering system sleep,
> > only to immediately cut its power) and it also speeds up the suspend
> > process by about half a second.
>
> Thanks for the info.  It sounds like we need a similar patch for
> amdgpu.  With dGPUs controlled by the ACPI ATPX method, I believe the
> dGPU is powered by automatically on resume from S3/S4.  I think there
> may be a way to change that behavior in some revisions of ATPX (i.e.,
> to keep the state across suspend cycles), but it's not the default.
> I'm not sure about the newer _PR3 stuff in Hybrid Graphics laptops.  I
> think it retains state.  In both radeon and amdgpu we probably need to
> check if the system is using ATPX or _PR3 and disable direct complete
> for ATPX at least.

I would disable direct-complete entirely for them then and possibly
consider using DPM_FLAG_SMART_SUSPEND in the cases when that would be
safe.

Anyway, I posted this patch for radeon, because it addresses a
specific regression and I'm not super-familiar with GPU drivers in
general.

Cheers,
Rafael
