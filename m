Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F9DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CE720673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Gccugtgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CE720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLAKbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:31:23 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37335 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:31:23 -0500
Received: by mail-io1-f67.google.com with SMTP id f14so429330iol.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 15:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OLitVEz1SetRn2MjAv+vIotpvPLKp4TtCihf1dsLlI=;
        b=Gccugtgpz0FXwW/8n/LVhHTFcPZFeRumcTxbzjN/ujeeaKvmH0pXPbuQsGdatcpn+O
         694wRbXMyrQdscYqTSzIe2A/N0Pd/iCNa079/FyasdcqkDbvX/3d9bIYN0TfTgCcTPO/
         gpwzr4FoP1w+9Fye2dyRMqjRd3aCKu+2DD+c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OLitVEz1SetRn2MjAv+vIotpvPLKp4TtCihf1dsLlI=;
        b=sZUiGjfUxyDhR/BYFMWS+vBq9wQUaA847OQXt0tOKEOsmPVV/v4EPLHdrhjgALuK7u
         GC0LXLBe/JgB82tC0RJWcolgk6+g3jCRdqbaoCE+vavlwQHOJmRfAVGM4fKEHKTOQtYL
         fXZjw5DLqEW+iU6uD1gmAdzAVA7WMtMsDdEDiKOKcXoUzo+i3IWvwwCWHE69xwZGAqPI
         fHedkLna8BdopqQCJlyW8Ge8hRt/FyCD5i9/7oXV0atl3URV7g3NefQqw8/05IoTX3t1
         +uilQn5qweSjP9RSUnxW5/PTHG9xFCa07scbViSnML1Md0QBCVpzlvKYxCJqQsy00V7Z
         uKiw==
X-Gm-Message-State: AA+aEWbpC+kg/7636MLiNcK379rhnAE/Z6zaGDtj3Do98bptLSpQrVIv
        +p3lgVE0N/z6wl0AyxiGHUL0nHJARX3FDcf4Dv96TQ==
X-Google-Smtp-Source: AFSGD/UthYa58zBLGA3f1x426lziwt2yWl5Ht7E2iaVuR1jvwTPR0sTEBkbhnNYJv+ElE+7l6qlmrB8oQEmxYWlrGJo=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr6892599ioa.34.1543620027279;
 Fri, 30 Nov 2018 15:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20181130203232.5743-1-robh@kernel.org> <CAKMK7uGrBnaip1E+vp6foGfvdRb2=bhPNOmmZfjTUt2HZPLQcA@mail.gmail.com>
 <CAL_JsqKwnzA+e6pbfUCzCX5ZCJAYixjJtDV2Dfh9u-bgOBKYHQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKwnzA+e6pbfUCzCX5ZCJAYixjJtDV2Dfh9u-bgOBKYHQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat, 1 Dec 2018 00:20:15 +0100
Message-ID: <CAKMK7uFoAKgKmqaz2GpTq958CijTp6EOJVYFcNKPcm1yEyqa0g@mail.gmail.com>
Subject: Re: [RFC PATCH] of: Add a GitLab CI config file for unittests
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:22 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 2:53 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> >
> > On Fri, Nov 30, 2018 at 9:32 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > This adds a GitLab CI config file running the DT unittest in a usermode
> > > Linux build. The corresponding CI job can be found here:
> > >
> > > https://gitlab.com/robherring/linux-dt-unittest/pipelines
> > >
> > > This CI job can be duplicated by others by creating a kernel repo on a
> > > GitLab instance and configuring GitLab CI to use
> > > drivers/of/.gitlab-ci.yml config file.
> > >
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Adding dri-devel.
> >
> > > ---
> > >  drivers/of/.gitlab-ci.yml | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >  create mode 100644 drivers/of/.gitlab-ci.yml
> > >
> > > diff --git a/drivers/of/.gitlab-ci.yml b/drivers/of/.gitlab-ci.yml
> > > new file mode 100644
> > > index 000000000000..44a4824f5c33
> > > --- /dev/null
> > > +++ b/drivers/of/.gitlab-ci.yml
> > > @@ -0,0 +1,18 @@
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +image: registry.gitlab.com/robherring/docker-images/ubuntu-kernel-build
> >
> > I think it's better to include the docker recipe too. One because
> > shipping pre-built dockers is a license nightmare, second because
> > better hackability. For a full on example see:
> >
> > https://gitlab.freedesktop.org/drm/igt-gpu-tools/blob/master/.gitlab-ci.yml
>
> Humm, but in the end you are still publishing the docker images either
> way. It's just a difference of publishing across projects and whether
> it's 2 jobs or 1 job with 2 stages.

Yeah, but it comes with sources for rebuilding the image :-)

> I do tend to prefer the Travis-CI simplicity of just listing packages
> to install. It seems like the same could be done with docker and some
> magic on the server side. At least for the simple case of 'install
> this list of packages'.

Yeah, gitlab is a bunch more explicit, and you need to do your caching
of the setup you want yourself.

> > For the kernel I guess the question is where we should put all the
> > docker files. There's going to be some need for subsystem specific
> > tooling (e.g. we want something that has igt installed eventually for
> > anything drm), so maybe just keeping them in subsystem directories is
> > best. Was at least my plan with drivers/gpu.
>
> My plan (to the extent I have one) was to put the common parts into
> the docker image and leave the small job specific things in the job
> setup. Then I can use the same docker image across jobs. Maybe that's
> a pointless goal in the docker world.

We do that too. The different docker images we have is for different
testing (new/old distros, and the cross build chain in userspace
conflicts, so need separate docker images for that). Aside from those
cases where we need different images because they're incompatible, we
do reuse them.

For the kernel there's much less of these userspace problems, so one
image should be good enough for all jobs.
-Daniel

> My dockerfile is simple enough, I could probably just create it within
> the .gitlab-ci.yml.
>
> Rob



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
