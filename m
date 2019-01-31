Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52174C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D5420881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548950540;
	bh=wohEdbgOCuPdgkvHmnpRJPW8xKx4RpBpT9mqtD37Aic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kimTJFBby5Lq+OoFJ7wuCcgSmwnIsKjeUI6Jm5TQ3tC3rHPaiY3nwtINcZgEOmhIb
	 LUwJRpWLpgITDmAOj7/XvWjz4M9yocX49dn69kEHS2KZRMJyWfbsk9v6qxzBBzjDHp
	 QGIsV1jVggEoSB6t4cZ6Q8RtRm7pkIu6sQf7xU0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbfAaQCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:02:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45887 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbfAaQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:02:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so3179191ota.12;
        Thu, 31 Jan 2019 08:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHzLS7mIKc0ZR77vn0J6nivm+8YWR56sVzoII/qAshE=;
        b=dwJHkT7KVlZsBrNXgTq81bl/SmyeyAkVSUMYZgZnvfakA56z8nn57wciNGLfCn1q1n
         Za6H0ky525ogR6mycWsLv5ze5v/JRz1rbUnBQ9/b8bkpvL1+HJXoqzqDB/n+mLXZFkKI
         7u/irnWQqHuys3yMwvge5RBEZS53Zr1CAEn4QUnSMj12j2W4hIASvsE87djRt+U8n0ah
         TowoVBwNsdha6HnNdRo2ibmwgkb2KPkG/l1lwVvFRK9x4x11ke4kaWYtKX1ww61CECyw
         ZqiZQANm2pDV+BJlugwscf6j9eFEaxqQhXXPfPPqptpjoU4kRjk20va1crBNiP3dM/XQ
         XO2w==
X-Gm-Message-State: AJcUukd3HFle4j1LOaedvfaOHdq5F+oyXAstw0VFpZjeVtyE5ykjeHym
        AEU5ecKQ+UYtUyXnVOBc81++XyvG+c0snr15JKQ=
X-Google-Smtp-Source: ALg8bN4Hl6/WhmNF5d943lTQS3CLZr+dlG0FlhrsIRk5MBT9SRgP7NneN/Aw92TUH+naUcD6f6Clr2qLsGEbM4UKQFQ=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr26894774otg.139.1548950536774;
 Thu, 31 Jan 2019 08:02:16 -0800 (PST)
MIME-Version: 1.0
References: <2493187.oiOpCWJBV7@aspire.rjw.lan> <CAJZ5v0hsBNYZ7mu6SrhBY+LiOQZKz2K_3OtsCb9Jt8QR1YRhOA@mail.gmail.com>
 <20190131132247.GA6837@kroah.com> <20190131132409.GA16084@kroah.com>
In-Reply-To: <20190131132409.GA16084@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 17:02:05 +0100
Message-ID: <CAJZ5v0geMbgNKBFT104o4Jf38q7yo46ha+qFbd+9Mbr+P8n--A@mail.gmail.com>
Subject: Re: [PATCH 0/6] driver core: Fix some issues related to device links
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 2:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 02:22:47PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Jan 31, 2019 at 11:09:51AM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 24, 2019 at 12:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > Hi Greg at al,
> > > >
> > > > Recently I have been looking at the device links code because of the
> > > > recent discussion on possibly using them in the DRM subsystem (see for
> > > > example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> > > > found a few issues in that code which should be addressed by this patch
> > > > series.  Please refer to the patch changelogs for details.
> > > >
> > > > None of the problems addressed here should be manifesting themselves in
> > > > mainline kernel today, but if there are more device links users in the
> > > > future, they most likely will be encountered sooner or later.  Also they
> > > > need to be fixed for the DRM use case to be supported IMO.
> > > >
> > > > This series does not fix all issues in device links that have become
> > > > apparent (generally speaking, the idea of returning an existing link
> > > > in case there is one already for the given consumer-supplier pair
> > > > doesn't play well with stateful links and their flags), so there will
> > > > be a follow-up series of patches to clean that up.  Still, I don't see
> > > > a reason to sit on these fixes while working on the other patches, so
> > > > here they go.
> > >
> > > Any concerns regarding this lot?
> > >
> > > [Please note that patch 5 in the series was replaced with the v2 at
> > > https://patchwork.kernel.org/patch/10781205/]
> > >
> > > If not, and if you don't mind, I would like to queue it up next week,
> > > possibly along with the follow-up material posted on Monday
> > > (https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) if
> > > that is not problematic, so it gets some linux-next coverage before
> > > the next merge window.
> >
> > Can I queue it up in my tree, given that I have a number of other driver
> > core patches in there, and I don't know how the merge issues will be if
> > we start to diverge.
> >
> > Or do you need this for some other work?
>
> To make this clearer, I have no objection to take this through my tree
> now, along with your second set of patches.  Is that ok?

Yes, it is, AFAICS.  Thank you!

Do you need me to resend all of this as one series?
