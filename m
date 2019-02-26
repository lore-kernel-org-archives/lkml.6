Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981A421873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551217970;
	bh=ALD06dr1NofgAPuZnf1i/43HotaoohR17M3n8y6gjUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AFm3qzFXMwLVN197dzI9/TVF5XE+WnKnvthf3cgHlPBHBo/PiJlFTfrpo82jRWOaq
	 nN0pcGaA4YQTSNkpl9NsFKOR48FMcoEMdVKS9UUFv/PS45D7CHb3w6OJP1Taq5Ookd
	 CXp0o0XQK5terIPjXOZEPEHNhKbntbuSNYLUYtQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfBZVwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:52:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33331 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:52:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id z14so11743934oid.0;
        Tue, 26 Feb 2019 13:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZ0vdhu4OSNTZ1Xtlcnd8Gwn2tIT2qEa6s/zqooA5GM=;
        b=sTMM4ZkJnUnTqOFLaVxhbcMBDIyZy/vrwAxwBvqRmHhIUGcE/le9ny2Zk1sZqOAj4C
         HSrXFO63IgjUrDV0Q6n4E6QjufamVgno8J5u8hiL54S4ca3OYAVW3LQtYTmix89NKOKV
         Pz9Pd9Hp4K5zJ7tH5m1vXvq2vl6Nw4BHdfbyHeRq4tQdyIUxYQkoTzp7PXgtCM7f1iq7
         7CwnwD4s1flvj8PmFLl+mqu+CTUuliGHK/jVBHFEmvIN7cc/c4xUQoRZLuQFbcd0HkJw
         HWPYarQSr6nYVwBOWvNmzCx8BA1OapdJwHcybtfO+RVVGCogwU65tM++RLIyYYzuqymU
         NUGg==
X-Gm-Message-State: AHQUAuZPPo2+66RkBw7H70IVGLJ/cm47OWIWNs721U7NoZ08Q8OdN5Mo
        d+hEJ0y0w53WwctQA+62X9eqmS0YS4GKka7ajr4=
X-Google-Smtp-Source: AHgI3IaJrQUjRbYVqGFNCg9Dq/B3y0Q8h/eDz7MRzU2Cxsecmz9TxiJUSZiWOhnsVKSoJnQ+KkI+zgqnnjAi++41/qo=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3822130oii.95.1551217967444;
 Tue, 26 Feb 2019 13:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com> <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
In-Reply-To: <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Feb 2019 22:52:35 +0100
Message-ID: <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v11:
> > >  - This version contains only the infrastructure changes that is needed for
> > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > post them separately. Still, to provide completeness, I have published a branch
> > > containing everything to a git tree [1], feel free to have a look and test.
> > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > which has been replaced by a couple of new patches, whom reworks the existing
> > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > instead of the duration.
> > >  - More changelogs are available per patch.
> >
> > NAK for patches [4-6/8].
> >
> > The code as is specifically avoids calling ktime_get() from the
> > governors as that can be quite expensive, so these patches potentially
> > make things worse.
>
> Yeah, good point! What do you think about folding in a patch into the
> series, like below, and then let the cpuidle governors use it?

It is not objectionable as it stands, but that also depends on what
the new function is used for.

In particular, I don't really think that the menu and teo governors
need to call it at all.

> One questions about when CONFIG_NO_HZ_COMMON is unset for the below
> suggested code, does it make sense to "return -1" for that case, or
> should I return ktime_get()? Does it matter?

Again, it may or may not matter depending on what the caller is going
to do with the value returned by it.
