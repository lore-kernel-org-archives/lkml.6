Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BBCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2293A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4zdV+V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeLSMyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:54:02 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42601 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:54:01 -0500
Received: by mail-vs1-f66.google.com with SMTP id b74so12152702vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jcFIssZ5uCnxarSbhhjy8lOdqNazHu2rLSIxhH6ZZ94=;
        b=P4zdV+V7D+kJ2OqmDWA+6CaNThu6p87cXk7tzR7cPP1nzGV/PgkkxXFWRpE22BGrCz
         kKUh7dMorNC16o3ZrXj/gLY//viyUdiS6zJlPQDjByvZz1QdSiJ5ctp2sTaCVNRZwAov
         +wejvtkYQLzZ9l27zP0bRucJFRuPmU3Fh08s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jcFIssZ5uCnxarSbhhjy8lOdqNazHu2rLSIxhH6ZZ94=;
        b=seJ/P0/NSFxInYZUKQWlyD/Cw5FYr/Btv3sEAZ149f4brHHB7oxBgZ3Y+XZWU5EUjW
         XFnZ/O7fOPsGS5DGj3ZrLfWO40GzyzpGngX+ks7rRYZnfCR1B7apknSXLCYkuPHBb7iW
         +aAuRLlO8BTQDIXC878hypU2XfPh2ZCCE01Nj/lQdD8xlZ7XxGpd954becLpVgRpPpEW
         H81ifRHCIoP6vO5Io46g3syc1MOPpPD5l2SR7RqVIaf9qwwTCA0ytmvwdJ5O+Ll1HGgj
         OdJzQKabD1KK69Of4/EDjvjtY2pdlekkSPIdke54IJnIoWx3nbOj7uxiSl8XT4+r3nPX
         MlGQ==
X-Gm-Message-State: AA+aEWYx8urfXarw3+6cSCvAzWcTcKWDgA/f1LmxDbgmjpnoQjvIvWQZ
        bdvaubc3+P24kQiwzzKQ+Rmfby9SBp6h2hL6+Wh2qg==
X-Google-Smtp-Source: AFSGD/Wh86tdW772GFuHMHhvw2DdDNpd3ZVUMAJgAka8VlI8rOlkT+Iwc3ty+6s4rvkmgNu0DKQFlrF5x8NX5sJKoZo=
X-Received: by 2002:a67:b245:: with SMTP id s5mr10207107vsh.200.1545224039014;
 Wed, 19 Dec 2018 04:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-14-ulf.hansson@linaro.org> <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
In-Reply-To: <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Dec 2018 13:53:23 +0100
Message-ID: <CAPDyKFpa6cCfQtfNo=CN0=BpY6bARfnVWRH0N=apQgVr1m24Og@mail.gmail.com>
Subject: Re: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical
 CPU idle states
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 at 13:11, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > From: Lina Iyer <lina.iyer@linaro.org>
> >
> > Currently CPU's idle states are represented in a flattened model, via t=
he
> > "cpu-idle-states" binding from within the CPU's device nodes.
> >
> > Support the hierarchical layout, simply by converting to calling the ne=
w OF
> > helper, of_get_cpu_state_node().
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
>
> Fold it with 07/27 ?

I can do that. However, normally we try to keep changes that touches
different subsystems, separate from each other. Of course sometimes
it's not possible and sometimes it just doesn't make sense to separate
changes.

Perhaps the PSCI maintainers and Rafael can give their opinion.

Kind regards
Uffe

>
> >
> > Changes in v10:
> >       - None.
> >
> > ---
> >  drivers/firmware/psci/psci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.=
c
> > index cbfc936d251c..631e20720a22 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -300,7 +300,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_dri=
ver *drv,
> >               return -ENOMEM;
> >
> >       for (i =3D 0; i < num_state_nodes; i++) {
> > -             state_node =3D of_parse_phandle(cpu_node, "cpu-idle-state=
s", i);
> > +             state_node =3D of_get_cpu_state_node(cpu_node, i);
> >               if (!state_node)
> >                       break;
> >
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
