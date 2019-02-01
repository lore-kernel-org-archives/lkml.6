Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90395C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1BB21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcnISmEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfBAPSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:18:01 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38762 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBAPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:18:01 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so4404214vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvTq9b3DdA64u9lJQtfTNkW68jUbrorPC34zC9807uM=;
        b=fcnISmEKHOhbBUESf342lHAwkq7740RLYqb8oloyuLiXjoWy+F2EesbJimnhqNoXE7
         7RsHUF/gazFEyzHvEqJ2PafgoC4kfXZ2AaCqBJW+RZ3ofEzwPiZurw2ddXLE9vFv/Wfu
         JlJ4+bkumf/G+8J/e5MHlwcnj3n0tiY+r0pow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvTq9b3DdA64u9lJQtfTNkW68jUbrorPC34zC9807uM=;
        b=PIBpPYI6V6rssY5Ple+KefrzXck7CpfBlFg0bO70BxeHVX7/XnXw+lfWjiBVfzYvaf
         FZWnip7suVdzT1iotTHjqaep6KcDBuyTvrJ6MSj7svYH8KgKZgxd6s+yMEkly8n8FbEU
         ZyUuAUhl0Y4LtTHlpzCQGF5iPHxIFBGyE32J9UsDCQEddLXdHea/gsuby5v5T9L3PhuK
         sXW81Ra8qm8od7RkxXcBqrIYIE2dlr2DuKBiZKd3wVDcTkOJiQjxQHuNHs3bChpE1oy5
         wfJRaiQ1OPnUovoHdZfRQUNjADnxzhHZi9+QHMilCrcEgvbctToPi2v6vOObwXY5NeKE
         Yhug==
X-Gm-Message-State: AJcUukdYF2LaNi2I/Z9UzIWYCHKVIvtTzOI0ZHV2ohn6PWIWNe22WjJL
        4cL1zY1ZkSKggXnVHfrBGikKEVZjJKQCRPh0OXVRrg==
X-Google-Smtp-Source: ALg8bN7nsE4JSWNbpWMhGh55kA0STWCr7ziadBiyG1kSUtf7NpTRpVKGMleEehwvQSYsUXBrO425XsAnw9d7YOxnNEc=
X-Received: by 2002:a67:7685:: with SMTP id r127mr16564129vsc.35.1549034279743;
 Fri, 01 Feb 2019 07:17:59 -0800 (PST)
MIME-Version: 1.0
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Feb 2019 16:17:23 +0100
Message-ID: <CAPDyKFqG-wN+=9i4X+BeREekzKNt0icE==P60Cu1FhsGRNcJjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core: Fix some device links issues and add
 "consumer autoprobe" flag
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 02:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi Greg at al,
>
> This is a combination of the two device links series I have posted
> recently (https://lore.kernel.org/lkml/2493187.oiOpCWJBV7@aspire.rjw.lan/
> and https://lore.kernel.org/lkml/2405639.4es7pRLqn0@aspire.rjw.lan/) rebased
> on top of your driver-core-next branch.
>
> Recently I have been looking at the device links code because of the
> recent discussion on possibly using them in the DRM subsystem (see for
> example https://marc.info/?l=linux-pm&m=154832771905309&w=2) and I have
> found a few issues in that code which should be addressed by this patch
> series.  Please refer to the patch changelogs for details.
>
> None of the problems addressed here should be manifesting themselves in
> mainline kernel today, but if there are more device links users in the
> future, they most likely will be encountered sooner or later.  Also they
> need to be fixed for the DRM use case to be supported IMO.
>
> On top of this the series makes device links support the "composite device"
> use case in the DRM subsystem mentioned above (essentially, the last patch
> in the series is for that purpose).
>

Rafael, Greg, I have reviewed patch 1 -> 7, they all look good to me.

If not too late, feel free to add for the first 7 patches:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Although, I want to point out one problem that I have found when using
device links. I believe it's already there, even before this series,
but just wanted to described it for your consideration.

This is what happens:
I have a platform driver is being probed. During ->probe() the driver
adds a device link like this:

link = device_link_add(consumer-dev, supplier-dev, DL_FLAG_STATELESS |
DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

At some point later in ->probe(), the driver realizes that it must
remove the device link, either because it encountered an error or
simply because it doesn't need the device link to be there anymore.
Thus it calls:

device_link_del(link);

When probe finished of the driver, the runtime PM usage count for the
supplier-dev remains increased to 1 and thus it never becomes runtime
suspended.

I haven't thought more in detail of how to address this problem, just
wanted to describe it for you, briefly. The test I have done is by
using a my local RPM testdriver and my local PM domain testdriver, so
no real bug has been reported, at least as far as I know.

Kind regards
Uffe
