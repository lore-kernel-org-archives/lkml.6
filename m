Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA1FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26322208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcX9OHzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26322208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933852AbeGIRr3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933537AbeGIRr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:47:26 -0400
Received: from mail-it0-f53.google.com (mail-it0-f53.google.com [209.85.214.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F13C208DE;
        Mon,  9 Jul 2018 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531158446;
        bh=jVgITrtZ3NgK2mp+Y5nFD1IeHv6NknAICD3usquZIBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FcX9OHzTpu6FdpG48zXsm3yP+V6a0i6igrOUpqp4/A+/6JB9l1Nxt1neRqXmnKTKd
         xJsmogl32ygsRCo4uujLW0VzFen82EPZp0TQqqNNWhsIBHh1CzOlXaPd/wVubdUUux
         tZUPG6IhiUh0e8gghZi9aXPBsKj2vWIFXtwXZ6T4=
Received: by mail-it0-f53.google.com with SMTP id j185-v6so27290082ite.1;
        Mon, 09 Jul 2018 10:47:26 -0700 (PDT)
X-Gm-Message-State: APt69E0em8jHYAyAKeDSrjgiy3AxC0f4LOUQ0phBhVk8PnPRcweW0yg+
        /K3Xrh/DusReZlGpjGl2Xxo1IO6ZYSrCiVvHPQ==
X-Google-Smtp-Source: AAOMgpfapg4T+gxqu+k/DtiSVNPL+hPCg0A33LEViEY9nyhm7tIAtl+3qT3Jul+iNl9sRAXclgm++bs6Nba2IsYlIAk=
X-Received: by 2002:a02:10c6:: with SMTP id 189-v6mr10974149jay.54.1531158445531;
 Mon, 09 Jul 2018 10:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180709154153.15742-1-robh@kernel.org> <20180709154153.15742-2-robh@kernel.org>
 <20180709155201.GG17271@n2100.armlinux.org.uk>
In-Reply-To: <20180709155201.GG17271@n2100.armlinux.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jul 2018 11:47:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKWxYWkdyVJbqeyP--LvkRJXN7kOd2cHS0izCJQ7cLmuA@mail.gmail.com>
Message-ID: <CAL_JsqKWxYWkdyVJbqeyP--LvkRJXN7kOd2cHS0izCJQ7cLmuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] driver core: allow stopping deferred probe after init
To:     Russell King <linux@armlinux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 9:52 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jul 09, 2018 at 09:41:48AM -0600, Rob Herring wrote:
> > Deferred probe will currently wait forever on dependent devices to probe,
> > but sometimes a driver will never exist. It's also not always critical for
> > a driver to exist. Platforms can rely on default configuration from the
> > bootloader or reset defaults for things such as pinctrl and power domains.
> > This is often the case with initial platform support until various drivers
> > get enabled. There's at least 2 scenarios where deferred probe can render
> > a platform broken. Both involve using a DT which has more devices and
> > dependencies than the kernel supports. The 1st case is a driver may be
> > disabled in the kernel config. The 2nd case is the kernel version may
> > simply not have the dependent driver. This can happen if using a newer DT
> > (provided by firmware perhaps) with a stable kernel version. Deferred
> > probe issues can be difficult to debug especially if the console has
> > dependencies or userspace fails to boot to a shell.
> >
> > There are also cases like IOMMUs where only built-in drivers are
> > supported, so deferring probe after initcalls is not needed. The IOMMU
> > subsystem implemented its own mechanism to handle this using OF_DECLARE
> > linker sections.
> >
> > This commit adds makes ending deferred probe conditional on initcalls
> > being completed or a debug timeout. Subsystems or drivers may opt-in by
> > calling driver_deferred_probe_check_init_done() instead of
> > unconditionally returning -EPROBE_DEFER. They may use additional
> > information from DT or kernel's config to decide whether to continue to
> > defer probe or not.
> >
> > The timeout mechanism is intended for debug purposes and WARNs loudly.
> > The remaining deferred probe pending list will also be dumped after the
> > timeout. Not that this timeout won't work for the console which needs
> > to be enabled before userspace starts. However, if the console's
> > dependencies are resolved, then the kernel log will be printed (as
> > opposed to no output).
>
> So what happens if we have a set of modules which use deferred probing
> in order to work?

It is opt-in by subsystem or drivers and mainly intended for
subsystems which can be optional or only support built-in drivers.
However, I don't really envision many other users other than the ones
I converted (pinctrl, iommu, pm-domains). If you look at patch 3,
you'll see it is dependent on !CONFIG_MODULES.

For the timeout, well, that's for debugging only. If you get to the
point of loading sound modules, you probably don't need the timeout.
It's for debugging not booting.

> For example, with sound stuff built as modules, and auto-loaded in
> parallel by udev, the modules get added in a random order.  The
> modules have non-udev obvious dependencies between them (resource
> dependencies) which result in deferred probing being necessary to
> bring the device up.
