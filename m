Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB9C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69820685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BicOWsgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED69820685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbeKUDTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:19:50 -0500
Received: from mail-vs1-f51.google.com ([209.85.217.51]:39885 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:19:50 -0500
Received: by mail-vs1-f51.google.com with SMTP id h78so1481106vsi.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wxg7mclD2ZN1H/ne/ZN4IVZm/6FSH7WB93EJJ2Arqi4=;
        b=BicOWsgZJzqXXIxp85iehjowDplP0UrFCtXjBcRmw2fp/NLaRrv3zKzYlKboEmSUeR
         AYwUd4UEofPzPLgsEFtwgCRTTMkmx5Id+1j1IfXPPqpCkdfgfGY6rzuL/e9y0WCJ5Kt7
         OaLOCfHGFFoQ0WVfGOfr0eIleE29l2dROCPSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxg7mclD2ZN1H/ne/ZN4IVZm/6FSH7WB93EJJ2Arqi4=;
        b=S9EoSpv693hgNUJo0zFLE3cO1PAZpbQAJEPlCuvthuHxGUMRU0fL30+/XtGVKHSCqe
         hiSWxC9/xLtMr2TMd+1jsPKfWbdVsUXq/Eou/ABNbd7z8Hx/NgMh+csI/PzwneOpfM2F
         cC4y6vKyiSNsnyasS4YD/2za45dYUwf7BbAvVIcyfcLZbAHp0x0uOwHzJ0X2I+m8leqz
         rRYtVKEpd511LUSg14S9NNUnhyfQJiC5+SYGgsf58riX+EqMhxzgtnsDBpc81hsDSJKN
         HEWyELs2tVqSTHoLCnHXfVtk+X8tG60nz4DQPcEQt/NFz7koTQWF155q63qvCXBwLD5+
         M6GA==
X-Gm-Message-State: AGRZ1gIsF0JqRbDcWM3KG1UJhw6T0l8/CKwNaTrZ69Zt/UVLWdwZoQDg
        PFhc27wYQDAqlbbN9KztZMcsjJWHBEY=
X-Google-Smtp-Source: AJdET5fH9IV1olVRSNNWMUgIHQ2l7zW2TZESyP+SWYODeDYSPnKaWIUrjiwZSzNi4+MRknNL6iw+rg==
X-Received: by 2002:a67:9c7:: with SMTP id 190mr1183561vsj.203.1542732584549;
        Tue, 20 Nov 2018 08:49:44 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id p143sm6759497vkf.1.2018.11.20.08.49.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:49:43 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id y14so555562vky.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 08:49:43 -0800 (PST)
X-Received: by 2002:a1f:4301:: with SMTP id q1mr1189796vka.70.1542732583213;
 Tue, 20 Nov 2018 08:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20181120162808.B73391124DC2@debutante.sirena.org.uk>
 <CAD=FV=W==50GsF+R3_qGbqDH2VF8VKXv3Y6Co90d2GdUbhn69g@mail.gmail.com>
 <20181120164125.GK3894@sirena.org.uk> <20181120164755.GL3894@sirena.org.uk>
In-Reply-To: <20181120164755.GL3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 08:49:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XPPiAM8koW+qqHBTqM-En2AaHqoqVYAeYWkB3w6HEWrg@mail.gmail.com>
Message-ID: <CAD=FV=XPPiAM8koW+qqHBTqM-En2AaHqoqVYAeYWkB3w6HEWrg@mail.gmail.com>
Subject: Re: Applied "regulator: core: add enable_count for consumers to debug
 fs" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:47 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Nov 20, 2018 at 04:41:25PM +0000, Mark Brown wrote:
> > On Tue, Nov 20, 2018 at 08:37:04AM -0800, Doug Anderson wrote:
> >
> > > Hold up!  How does this compile for you?  It looks as if you landed it
> > > before ("regulator: core: Only count load for enabled consumers")
> > > which is the patch that adds "enable_count" to the consumer structure.
> >
> > > I'm just working on my replies to you about the dependencies on these
> > > patches but they're definitely not separate...
> >
> > Dunno, but my script for applying things does a build after each patch
> > and didn't complain so...  are you sure it's not e-mails getting
> > reordered?
>
> Wait, no - I didn't apply that but my tree does compile at the minute
> because my test config doesn't have debugfs enabled.  If I turn that on
> then the relevant code gets built and I see an error.  I'll drop this.
>
> This does, however, beg the question why this is a separate patch in the
> first place?

I'll squash the two together for v2.  I felt it might be controversial
to add this to debugfs but I guess not.

-Doug
