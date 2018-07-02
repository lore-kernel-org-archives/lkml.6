Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB39C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6892E258EC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVO3hCcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6892E258EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeGBVRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeGBVRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:17:45 -0400
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com [209.85.214.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A54A25065;
        Mon,  2 Jul 2018 21:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530566264;
        bh=/Ss19kzvu80hvz7MUd1lNkxVuWrujg61vn8r6wLmhpU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GVO3hCcdbDr/NPQTuH9HCTl92EwKF40LRSP4wZLph1mjlq5LAtQVAXHd4us1btfro
         Y9PsoHdmF9MbiocFa/m+zUgrz7tw6GrhW3SdnRIlmmB54/qrNmbCRdC++SdS0UHLrc
         7hyXXOmmjyJgG3yayQ0eVOmOhk+q+8dCPDI/P4+M=
Received: by mail-it0-f44.google.com with SMTP id o5-v6so278888itc.1;
        Mon, 02 Jul 2018 14:17:44 -0700 (PDT)
X-Gm-Message-State: APt69E3/pJnx9i6/c3DibSem0IFEGPBZOIWbAevdKF3/ZMMKpYA4mMXL
        wuG/2T3WTT04eP9X7ai18GAE7QH5G0dh4k9z5A==
X-Google-Smtp-Source: AAOMgpfKwTozpMQgFCgqxLhvADzI78lo/qW0TRfW3bCaFYT/YtGM3/s1ch7P10nyPxxyu3YnvEEeyW7i+0oddtIsCjk=
X-Received: by 2002:a02:9936:: with SMTP id r51-v6mr5392839jaj.46.1530566263990;
 Mon, 02 Jul 2018 14:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180628204344.13973-1-robh@kernel.org> <20180628204344.13973-2-robh@kernel.org>
 <CAHp75Vf+o7aA8M6T+zM5r8i_YCzWkP=rO8sTHY0qtz-YjVRibA@mail.gmail.com>
In-Reply-To: <CAHp75Vf+o7aA8M6T+zM5r8i_YCzWkP=rO8sTHY0qtz-YjVRibA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Jul 2018 15:17:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jKa0kpC5TxhSJtGs2O-FB72AcO6nxUX==3AC1p6KpPA@mail.gmail.com>
Message-ID: <CAL_Jsq+jKa0kpC5TxhSJtGs2O-FB72AcO6nxUX==3AC1p6KpPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] driver core: allow stopping deferred probe after init
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 4:25 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jun 28, 2018 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:
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
>
> > The remaining deferred probe pending list will also be dumped after the
> > timeout. Not that this timeout won't work for the console which needs
> > to be enabled before userspace starts. However, if the console's
> > dependencies are resolved, then the kernel log will be printed (as
> > opposed to no output).
>
> There is another patch flying around with debugfs node to dump a list
> of deferred probe queue.
> I dunno if it makes sense to dump it here and there and if yes, some
> unification in output, perhaps?

Here makes sense because you may not be able to mount and read
debugfs. That's the reason for the timeout too. Otherwise, debugfs
could be used to trigger the same thing.

They are aligned at least in that both use dev_name(), but I don't
think we can align completely as we need the context in the log where
as reading a file you know the context already.

> > +       deferred_probe_timeout = simple_strtol(str, NULL, 0);
>
> Hmm... I don't think 16-base or 8-base values are useful to support.
> One subtle difference that people usually consider timeout values as
> 10-base and if at some point someone makes it as 0100 (no matter why),
> it would be much less than expected.
> 08 wouldn't parsed at all.

Agreed.

> > +       if (deferred_probe_timeout > 0) {
>
> Would it be harmful / useful if we skip this check and run the work immediately?

The default is -1 which is disabled. Scheduling work in that case
would give us a very long timeout instead.

If the timeout is 0, then this never needs to run because
driver_deferred_probe_check_state will immediately timeout. Running it
would be harmless though as it would just do an extra run of deferred
probe wq.

Rob
