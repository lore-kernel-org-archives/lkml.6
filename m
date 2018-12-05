Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F149C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D23206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ic8YoOYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D23206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeLELtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:49:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43752 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeLELtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:49:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id 83-v6so18028949ljf.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbUU9ajIcqAtVGpTu1ATzBV0x5RKPH6tCX3DaNaIjlE=;
        b=Ic8YoOYcZ4LW8IZWDI648wtsePNkfIIgb/Q09+s7lypZf3vaquMoP2UZwKoE9ne6Sv
         NC3YPm/xpcIde1s4NPXathP4bi32FgHsGrtmuXna+FuXohOzhnvOPDnFZ2YUk+iKaZho
         msPMINb9opCdd3AK3X5MFPPjQneOCWjXyPVAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbUU9ajIcqAtVGpTu1ATzBV0x5RKPH6tCX3DaNaIjlE=;
        b=Zx+b1380hinOGuKXTbhKxSBBpJezBgiqM/dFOxeWDW6eEFo/hiOBmNPct3geJuPrzS
         k1Vg7n1Dx85JmnJxdetdL56XngcbxHapheWzSIWiHdXtpx9Ok7HzsUBDWNqZMPFFthUK
         uzG2deS9zHgT4zfZi15ZtKk53Z1VYyt8puhL+uSY3Qy9YbrPYF1QdeW2hYaCI+cmHvcz
         hz5Tmx96PeDQrlRfK4kib1YayURknRfXJHpAQmxQeoGmdMj1SW+1Om6KzGT+nFg7TNOv
         c8U+Cu3F3hq885qql8bhZxZVpM5UlnCHASU42x9RyRPDTnWMj85OiYFXbd2MsP1TZOXC
         bBlQ==
X-Gm-Message-State: AA+aEWb64BajUGSJBkhQk2zpihDf4NossIYgb0d3P6vma95NLqPBz/+X
        H7YYmwLwbk0UfSAEGss1zpkiitUvWkmY/f29u4r7Vw==
X-Google-Smtp-Source: AFSGD/WG0gsdFPNu7rzSjCML2zJOcaZ2fGpt3LRUQai7S4KkRkDafHks3Y7cQqueCtrfxkwhMLG8R06NusbqXzpLm9M=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr15543702ljg.23.1544010539964;
 Wed, 05 Dec 2018 03:48:59 -0800 (PST)
MIME-Version: 1.0
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com> <20181205113535.GX16508@imbe.wolfsonmicro.main>
In-Reply-To: <20181205113535.GX16508@imbe.wolfsonmicro.main>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 12:48:47 +0100
Message-ID: <CACRpkdZs0uSrsY66X67=h=BPy=P_5korWVM8kDbzTXrhrvKvcQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        David Dajun Chen <dchen@diasemi.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Eric Miao <eric.miao@marvell.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        jinyoungp@nvidia.com,
        Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias NILSSON <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mike Rapoport <mike@compulab.co.il>,
        ext Tony Lindgren <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 12:36 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Sun, Dec 02, 2018 at 11:23:07PM -0500, Paul Gortmaker wrote:
> > The solution to #4 is similar - we delete the ".remove" function and
> > the binding into the platform_driver struct.  However, since the same
> > ".remove" function could also be triggered by an "unbind" (such as for
> > pass-through of a device to a guest instance)  - so we also explicitly
> > disable any unbind for the driver.
> >
> > The unbind mask allows us to ensure we will see if there was some odd
> > corner case out there that was relying on it.  Typically it would be a
> > multi-port ethernet card passing a port through to a guest, so a
> > sensible use case in MFD drivers seems highly unlikely.  This same
> > solution has already been used in multiple other mainline subsystems.
> >
>
> I guess if this is a general direction thing, but it does seem
> that module unload is not the only reason one might ever unbind a
> driver. So are we sure we want to remove the option to unbind
> these drivers? Certainly for testing it is sometimes useful.

I personally never understood why these attributes are even
present on non-modular drivers.

If testing is about exercising unbind/bind to reintialize
the code through a new call to .probe(), why would the developer
not take it all the way through and make it a module?
It just looks like a half-measure.

Yours,
Linus Walleij
