Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA1D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeLKKL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:11:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33921 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeLKKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:11:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so15765713qtp.1;
        Tue, 11 Dec 2018 02:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K88Q+4UPWm3MGt7NIY++snDrggQlrcXoLM+iHvEqE24=;
        b=EIOB3dAxYngAWQ1zzg1BvDOXtPohipJAZF+iavDDnr1NbgU1B0XdOGRqW7LA+YxSsf
         LoWBXmFudoifQh5XzNL+kRAC3lIt9sfD8fmsSW9squkAqIWjEvzsyIl4f4fP0diM2l4m
         HtMAmUx7IOCiS2XZWPk4oxCfUj21dmERDP8E54U8H3ZWZKBYyKmXws4JTZC6K45NelyM
         AKmmAW9rcw1TsHM35M9tDnx6YtBwaBQkTmCk9qhRTGoxNV+QOjazC+9uDdFR7eJeh93h
         XB17LKwDOce7166Tuap51HJ1Rhj7EzZzxzDjXwed54L9EtzXVmuzLLxVbNGQ9VSyoKJS
         uJbw==
X-Gm-Message-State: AA+aEWY7AP0iDktJTQ0iOyBUmnHi3whTEUMa4vCNpVRRiTEJg8YwNZQP
        MpaKM282HVmoGb/6FZEYugznQ5qWzNFj5juHtQw=
X-Google-Smtp-Source: AFSGD/XPgZhhj+V3Atexwouwj8vblN5EEa0tCWVgt28YvcdEU0aBOkappRucR6a3k6tFqh4DcQStNNlaF9HRw6zpDoE=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr14658569qtm.96.1544523117535;
 Tue, 11 Dec 2018 02:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20181210215119.1903413-1-arnd@arndb.de> <20181211100832.GE14426@ulmo>
In-Reply-To: <20181211100832.GE14426@ulmo>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 11:11:38 +0100
Message-ID: <CAK8P3a08VEReXUZ39f3iQS3wUZSwKYObnn-jQrUiMJ4Gyx6hVQ@mail.gmail.com>
Subject: Re: [PATCH] host1x: cdma: use completion instead of semaphore
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>,
        Dmitry Osipenko <digetx@gmail.com>, emil.fsw@goode.io,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:08 AM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 10:51:04PM +0100, Arnd Bergmann wrote:
> > In this usage, the two are completely equivalent, but the
> > completion documents better what is going on, and we generally
> > try to avoid semaphores these days.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/host1x/cdma.c | 6 +++---
> >  drivers/gpu/host1x/cdma.h | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
>
> My understanding is that potentially many userspace processes could be
> blocking on this, which I think is the reason for it being a semaphore.
> Is the completion going to work for those cases as well?

Yes, it behaves the exact same way here.

       Arnd
