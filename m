Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD62420844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIM29BjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD62420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeIGTjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbeIGTjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:39:32 -0400
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com [209.85.216.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2382077C;
        Fri,  7 Sep 2018 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536332294;
        bh=rjxB2sKnuYU0IGxZeuR58sYl6DzuKOHfmfnT+pGSEpo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PIM29BjIgnTUphXzRI5wRBq2HhCDJqtIHJUzeT9YJErZkVqjXgggIUvLqWxiN3FOK
         SNBYZGCBILCObChVfjIbx1F3A7qW38mmwSF+E20iOJDpH2VxXM/nYWNWe7/8u4Zxtx
         bMUhLZuh5qYDHHcK0vu+DvA8UFG3QSYDsC6QVZXQ=
Received: by mail-qt0-f172.google.com with SMTP id n6-v6so16502726qtl.4;
        Fri, 07 Sep 2018 07:58:14 -0700 (PDT)
X-Gm-Message-State: APzg51DJkF/hA0ZSdBqIcWszFqJ3dGLmSu7lmz0RtnYza8nc96jzXzol
        ADoUAEuaSjUSqjofJzi8CpHfDznUxgZq/CAfKw==
X-Google-Smtp-Source: ANB0Vdbnx/z+84NWDf0ASLeYj3ALcZ0jTuOE7uNL/kGY3tpZKaAUPlKCeAXk0hErbUwTfjLNmFz8aHnbGITLF2L3Bro=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr6381907qto.188.1536332293258;
 Fri, 07 Sep 2018 07:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180828155254.10709-1-robh@kernel.org> <20180828155254.10709-4-robh@kernel.org>
 <20180907122928.GA5821@ulmo>
In-Reply-To: <20180907122928.GA5821@ulmo>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Sep 2018 09:58:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKg+Y=BNWEXZY=TR5S8Vi9rpmN8LFpGjLt=qWG3WtUwrg@mail.gmail.com>
Message-ID: <CAL_JsqKg+Y=BNWEXZY=TR5S8Vi9rpmN8LFpGjLt=qWG3WtUwrg@mail.gmail.com>
Subject: Re: [PATCH 3/4] of: Convert to using %pOFn instead of device_node.name
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 7:29 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Aug 28, 2018 at 10:52:53AM -0500, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/of/device.c   |  4 ++--
> >  drivers/of/of_mdio.c  | 12 ++++++------
> >  drivers/of/of_numa.c  |  4 ++--
> >  drivers/of/overlay.c  |  4 ++--
> >  drivers/of/platform.c |  8 ++++----
> >  drivers/of/unittest.c | 12 ++++++------
> >  6 files changed, 22 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 5957cd4fa262..daa075d87317 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -219,7 +219,7 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
> >               return -ENODEV;
> >
> >       /* Name & Type */
> > -     csize = snprintf(str, len, "of:N%sT%s", dev->of_node->name,
> > +     csize = snprintf(str, len, "of:N%pOFnT%s", dev->of_node,
> >                        dev->of_node->type);
> >       tsize = csize;
> >       len -= csize;
>
> This seems to cause the modalias to be improperly constructed. As a
> consequence, automatic module loading at boot time is now broken. I
> think the reason why this fails is because vsnprintf() will skip all
> alpha-numeric characters after a call to pointer(). Presumably this
> is meant to be a generic way of skipping whatever specifiers we throw
> at it.
>
> Unfortunately for the case of OF modaliases, this means that the 'T'
> character gets eaten, so we end up with something like this:
>
>         # udevadm info /sys/bus/platform/devices/54200000.dc
>         [...]
>         E: MODALIAS=of:Ndc<NULL>Cnvidia,tegra124-dc
>         [...]
>
> instead of this:
>
>         # udevadm info /sys/bus/platform/devices/54200000.dc
>         [...]
>         E: MODALIAS=of:NdcT<NULL>Cnvidia,tegra124-dc
>         [...]

Oops. Thanks for finding this.

> Everything is back to normal if I revert this patch. However, since
> that's obviously not what we want, I think perhaps what we need is a
> way for pointer() (and its implementations) to report back how many
> characters in the format string it consumed so that we can support
> these kinds of back-to-back strings.

I don't think we can change it because if I have something like
%pOFMoreWords and then later on want to add 'M' as a new modifier we'd
break any existing cases with 'M'. Of course, I could search the tree
for that case and find unused characters, but that seems fragile
(though silently throwing away the characters does too).

> If nobody else has the time I can look into coding up a fix, but in the
> meantime it might be best to back this one out until we can handle the
> OF modalias format string.

There's an easy fix though. Just replace the 'T' with a '%c'.

I found one other case in the clock code and one in soundbus (which I
haven't posted yet).

Rob
