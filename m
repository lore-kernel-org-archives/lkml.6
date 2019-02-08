Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D4C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9C32085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549621105;
	bh=4ifLVWqjLbcOMuaR9AbjVyw36idURwba8qrIFJ19wdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2MFhBgsRy/YoSJUwY/VYbBXtDJ+Myg6moEDcqkw7Jy9/uqNy1tai0t9cT6wEkbwVl
	 WvOjoB/MNaHlZomUEc698txxx31jnMtzQl2T4uEUSdkYhieEeLZAUWn6EIm32PGjUe
	 bigP8yHmwwsDzAn1QPWFpnPYE5kM7WIysZ5oc0gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfBHKSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:18:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43399 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:18:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so4935184otr.10;
        Fri, 08 Feb 2019 02:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ifLVWqjLbcOMuaR9AbjVyw36idURwba8qrIFJ19wdk=;
        b=NgIlXnkfPouWmj3/hdOM9h+voUI2/1In5OZPhIkV7+S/gJjNQqwZug5enDgru8zEfe
         g2ADCe0WNw8SdPVxZf7ugxbOvGKzkBceNgfUXI3Z08oHsFMLzDuJmw2N2l2zIy/q3cfe
         BFOdTYqjK2WI1CcPHCaPVFRhq1/jxxS/gGuptVGvkgtifyAPX8w4PsRSDEEMSEQF3p+i
         CleBNsBqPBftRfrVqOsOYy6jgjXPAiSOis/FIpGaqw8sYn5mnBqNgEj95zq4BwmOJiL7
         ds0xDnAf94lj5yfvr9sJODiYEYkrkpQflJ9c/pDXb+Ii8tANk9h9djUqN433eCYUjtr7
         O7dg==
X-Gm-Message-State: AHQUAuYgvnhwbgcOrNf1/FMlKlszaSCHmqFC6c889AXIcH66OuIYyzF5
        15wk+ECb9MPITFsEjyNFyb7DJvhgH4p4ByVDQ7E=
X-Google-Smtp-Source: AHgI3IYiVU2HdNaI84tUEWFIugKK8e/lFWekM+D2tcq+X+umdFk2jnEuZoaTpFD6L9maQoZUD7UvPhqvqfS7U2xxH5g=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr12552484oti.258.1549621102789;
 Fri, 08 Feb 2019 02:18:22 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com> <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
In-Reply-To: <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 11:18:11 +0100
Message-ID: <CAJZ5v0jB7CDd9+gX+R3e+yrEsJty1E2MwuJGnuaJS0QeHeJ5rg@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 9:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 09:12, Marek Szyprowski wrote:
> > On 2019-02-08 07:49, Viresh Kumar wrote:
> > > Why don't you get similar problem during suspend? I think you can get
> > > it when the CPUs are offlined as I2C would have gone by then. The
> > > cpufreq or OPP core can try and run some regulator or genpd or clk
> > > calls to disable resources, etc. Even if doesn't happen, it certainly
> > > can.
> >
> > CPUfreq is suspended very early during system suspend and thus it does
> > nothing when CPUs are being offlined.
>
> > > Also at resume the cpufreq core may try to change the frequency right
> > > from ->init() on certain cases, though not everytime and so the
> > > problem can come despite of this series.
> >
> > cpufreq is still in suspended state (it is being 'resume' very late in
> > the system resume procedure), so if driver doesn't explicitly change any
> > opp in ->init(), then cpufreq core waits until everything is resumed. To
> > sum up, this seems to be fine, beside the issue with regulator
> > initialization I've addressed in this patchset.
>
> Yeah, the governors are suspended very soon, but any frequency change
> starting from cpufreq core can still happen. There are at least two
> points in cpufreq_online() where we may end up changing the frequency,
> but that is conditional and may not be getting hit.
>
> > > We guarantee that the resources are available during probe but not
> > > during resume, that's where the problem is.
> >
> > Yes, so I've changed cpufreq-dt to the common approach, in which the
> > driver keeps all needed resources for the whole lifetime of the device.
>
> That's not what I was saying actually. I was saying that it should be
> fine to do a I2C transfer during resume,

Surely not before resuming the I2C controller involved?

> else we will always have
> problems and have to fix them with hacks like the one you proposed
> where you acquire resources for all the possible CPUs. Maybe we can
> fix it once and for all.

Obviously, all I2C transfers need to take place either before
suspending the I2C controller or after resuming it.
