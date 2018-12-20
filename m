Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A73C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD297218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCtp2BDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbeLTViU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:38:20 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43492 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:38:20 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so2012033vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hd1zjWHHpgD0qROv72UJYyj+0NjjOMgAjMEV9h/x22g=;
        b=jCtp2BDRUY2R3uheIzg4N7kRzaBByo93WohqCnuRnGazMNVAoEanS0NTcZQwnwMdPC
         G/9KMVmeZCIoOgWkZ+WydvJNC2bDXriMpkVWZ4QicCLiCR+wjLWacMj3Hogj0UQ6QxAW
         CRZzpvmQ6O3B3CCk9OmKydJWvqYoWPFMty+TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hd1zjWHHpgD0qROv72UJYyj+0NjjOMgAjMEV9h/x22g=;
        b=kgXh0D2OLm8vh8GLmDQhwzO2E5/FeCeIHnl0z6VSS/JYPKRyT8KYfMsTafOoDQgrlj
         9Ib1Dyq9+lnabX9LKJ9+UtxWnaCsQoESs6UcJQE7wqEMKR+9pUpX9mBEzYZc7YPfwscw
         y4P5k8AJCfcV3FDFzDnhu695Db4tuPmwmzy0sB44XL6b4fOQnN4/Irnes0sTPicWVEpz
         Pbs2B87b2mZCzxSRRPCCHn8mFU7k6a/mI2lR+yEKoi1/411mXdfh3q8hIs+Upk6hDewU
         JdgJDLOAo3Te3zemA+P0WFih0mcwRsc+gOKgsKxnnZjmMM2ABwXxSUZ7oCp2tiVg96eB
         53mg==
X-Gm-Message-State: AA+aEWbmM8Hc7NRsO3CSfd/Ui5sc+WqMA2eNMGlZy31rwyCPmFbZSjPr
        Y0CF/g9aWFr3VUtB34Ebwp7spe6ymuAR6sTmbydFhA==
X-Google-Smtp-Source: AFSGD/Xl0U7e1C23eyYbgTfrCIamlXLYgoLV92380Pg21ZCoVrY6/dmKMqSjrYRckNmY6he2GQRFRNrAKrSY/2JXK3c=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr12967616vsa.165.1545341899053;
 Thu, 20 Dec 2018 13:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org> <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com> <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
In-Reply-To: <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 22:37:43 +0100
Message-ID: <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM domains
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 at 19:06, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 20/12/2018 16:49, Ulf Hansson wrote:
>
> [ ... ]
>
> >>> +#ifdef CONFIG_CPU_IDLE
> >>
> >> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
> >> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
> >> CONFIG_CPU_IDLE, so the config options stay contained in their
> >> respective subsystems directory.
> >
> > I am all for simplifying the Kconfig options in here, as indeed it's
> > rather messy. However, I would rather avoid folding in additional
> > cleanup changes to this series, is already extensive enough.
> >
> > Would you be okay if we deal with that on top?
>
> IMO, there are patches in this series which can be grouped into a
> cleanup + set the scene patchset and merged immediately. An option
> similar to ARM_SCMI_POWER_DOMAIN can be part of it.

I certainly agree to that. The tricky is, to know what pieces people
are happy with to go in. :-)

Earlier, in v9 I tried your suggested approach (kind of), but then
Lorenzo stated that it's kind of all or nothing. Maybe we can bring up
that discussion again with him and see what we can figure out.

>
> However, if you swear you will do the change after and sign with your
> blood, I'm fine with that 0:)
>

Whatever it takes!

Anyway, as stated, the reason why I want to tackle that on top, is
that I don't want to make the series more extensive than it already
is.

Agree?

Kind regards
Uffe
