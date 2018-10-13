Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E4BC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B256220877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWlo4v4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B256220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJMWgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:36:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36442 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeJMWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:36:52 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so22061201itd.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmMgcMZ3Bi7yDFgOClL/kYFrkcoISXSJfVtqo6AgyXk=;
        b=aWlo4v4dyOV+J20bV1tJLnxCPd+4H6cPAyyLAKMzOC+uNZWixSlYUltqICHVLPWmQj
         e1cR/moxP7mrMNOPJHYcvjxULv53bISuw17K9W9/1iVr30eczmTOcoCUni4zxu3gnEC9
         TRUvozrj9prXB29sTBUypGOOy2iz+1bE9Fve4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmMgcMZ3Bi7yDFgOClL/kYFrkcoISXSJfVtqo6AgyXk=;
        b=n99o91azeHFLJWZU9/IV/dxpDQOwjccc5DlKsv6dRdJ+PfiA12yz1xIkLWSDtN/mOX
         zCqlPEAw4lngEqY63GFa1xiUE8zoEmIfi7gM72lNUK/79HB+1RVuKu+oZxA7gn/UakAD
         a6bj9pIYf0ir3ymEFAZp2UJy6daOClz/Ec5IrR7Rg6QzfhOwweCNAoNuin5ydt4buzSo
         NZqTvYmXRhTxh0/bbWYt4UM1OdhcBtqrFtzVtonugY1vmU19NCHwQmky0lIK3j6ulTj5
         HXwgpcNJ69qY9IyTyUqwJoS/NFyHlhv0kU63/itF68rync6kCtHjxGa0RxCe4BcLo5Po
         xYHg==
X-Gm-Message-State: ABuFfoj8iCGPDz+LwnPfb6OezOW13fSfgJ/XHbyAGztV6gRsoAS5to8u
        3emid6gdilPOWwh0oiAXvlLIsDfwbTCIjU+3ynffnA==
X-Google-Smtp-Source: ACcGV6339aTNAQJ3hb1j1QBesLCefwrEWlHSKoyCVpGBbDN9ZhubpojYTpac6OsjGl65HvnOnJ5wUm7yoBymHIuH84U=
X-Received: by 2002:a24:5e50:: with SMTP id h77-v6mr7894172itb.58.1539442764850;
 Sat, 13 Oct 2018 07:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181012125412.21324-1-linus.walleij@linaro.org>
 <20181012142612.GJ7677@w540> <20181012164424.GE2340@sirena.org.uk>
In-Reply-To: <20181012164424.GE2340@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 13 Oct 2018 16:59:12 +0200
Message-ID: <CACRpkdZ3O+=BiXqasVA-f_0qJCcY2UzWjR3=ri=SxY1et=PzVQ@mail.gmail.com>
Subject: Re: [PATCH v2] regulator/gpio: Allow nonexclusive GPIO access
To:     Mark Brown <broonie@kernel.org>
Cc:     jacopo <jacopo@jmondi.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        cychiang@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 6:44 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Oct 12, 2018 at 04:26:12PM +0200, jacopo mondi wrote:

> > Do you think extending gpiod_lookup_flags with this newly introduced
> > NONEXCLUSIVE one is an acceptable solution to avoid handling this in
> > the sensor driver like we're doing today?
>
> One problem you've got there is that you need the two devices to know
> about each other so they coordinate their use of the reset line.  This
> was relatively easy in the sysetm Cheng-yi has as it's just one driver
> but what if there's mutiple drivers?  That's relatively likely with
> audio where you might have something like a CODEC with a separate power
> amplifier.  The regulator enable stuff is handling this in the core but
> it's less clear where to put that for reset lines.

Yes spot on.

What we need to do for that to work is to move the reference
counting for shared lines over to gpiolib as well, else every subsystem
that needs to share a GPIO line essentially has to reimplement it.

If the consumers are in different subsystems they would even
have to share a reference count and this would lead to a big mess.

So I was thinking to pull that over to gpiolib for the next kernel :)

Hopefully I could do that without breaking anything, but I don't
have a good track record on that so I think the fine people who saw this
breakage will have to help me out.

Yours,
Linus Walleij
