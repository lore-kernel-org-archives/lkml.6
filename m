Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABCCECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D592084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAl+tw0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D592084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeGRG0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:26:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43093 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeGRG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:26:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id j26-v6so1656145pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIJlXF865OXEVXaijkMPmmMoPVxerT945rRCeRxn9PI=;
        b=kAl+tw0ALmzPBjWuXp4so6rBwvzbd59mfnZAZIa3uCwy1/JbmnsKY/zWXzCiqzJneR
         LbF1EO2cefJ97S6Meh6Tsfs99SW/1BpN8GsE41Dy6QxXkHqr4hFXTboWosIJbkzPBPXh
         LesptWsBYJb3rD8kHqYwVw5VCoYPCZuHqJXVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIJlXF865OXEVXaijkMPmmMoPVxerT945rRCeRxn9PI=;
        b=Pm41a62012TO0/JrcEY+d/jJAKNRiYhn/jPHrOz6LkYGK3KnSPOvybofy4hd1r6/+5
         /ndYmqrZtCUN4D2s3h0pVbHvNB+ktDF/C01prHZr/x/4EbcJ+IdZ6ZXq8RHfMj4BjF+S
         SlWqUr+TdlTAi2a/sXP1nTPiqdlIk0BMAzlSr1ZD7Xuti+BkMRzdPNCRZl1304oOHU9W
         6AoUXhNpv3vFP4cMRI29XasEM8cOTVA9PcLP7U0MpOZYGgUQHl0/btDP7eIC+8stfbPC
         zfDPwDYwVT3ZDxeKWgob3GjFTAauAPxe5ZFEvZVRQo/T0WqpOyLRrss5do9L3vsCZLmx
         wfjw==
X-Gm-Message-State: AOUpUlF1iGvM9GNUsGSPpVckFtkZMViGiGclaE4PiYKeTWr1sVAEwai2
        p70xDSGkjnHGcRswCdDdJfBtIg==
X-Google-Smtp-Source: AAOMgpflL/iCw/dAekw+0hAtBS6MkKEVwrpEh0eWSA7Ay/oCBuyw9QPx1vX0YtCyDsXucjKM17taJw==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr4392368pgq.174.1531893032649;
        Tue, 17 Jul 2018 22:50:32 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id u17-v6sm5565785pfa.176.2018.07.17.22.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 22:50:31 -0700 (PDT)
Date:   Wed, 18 Jul 2018 11:20:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linaro-kernel <linaro-kernel@lists.linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V3 11/16] cpufreq: dt: Pass regulator name to the OPP core
Message-ID: <20180718055029.rdo427kozpwqm2bc@vireshk-i7>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
 <ad55cd1a03e712e2c0c49701e87a37199cb8376e.1454992187.git.viresh.kumar@linaro.org>
 <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXgE3oOVdYFy3kzmOv4FXvjU4rC39gUDUtMNJCdB__2AA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-18, 09:46, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> CC device-tree folks
> 
> Replying to an old email, because that's the most accurate reference I
> could find.
> 
> On Tue, Feb 9, 2016 at 6:06 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > OPP core can handle the regulators by itself, and but it needs to know
> > the name of the regulator to fetch. Add support for that.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index 4c9f8a828f6f..2af75f8088bb 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> 
> > @@ -119,6 +120,30 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
> >         return ret;
> >  }
> >
> > +/*
> > + * An earlier version of opp-v1 bindings used to name the regulator
> > + * "cpu0-supply", we still need to handle that for backwards compatibility.
> > + */
> > +static const char *find_supply_name(struct device *dev, struct device_node *np)
> > +{
> > +       struct property *pp;
> > +       int cpu = dev->id;
> > +
> > +       /* Try "cpu0" for older DTs */
> > +       if (!cpu) {
> > +               pp = of_find_property(np, "cpu0-supply", NULL);
> > +               if (pp)
> > +                       return "cpu0";
> > +       }
> > +
> > +       pp = of_find_property(np, "cpu-supply", NULL);
> > +       if (pp)
> > +               return "cpu";
> 
> Despite the existence of lots of users of these properties, I couldn't find
> both the "earlier version" and the "current version" of the opp-v1 bindings
> documenting the "cpu0-supply" and "cpu-supply" properties?

They are part of the device nodes and don't fall under the
jurisdiction of OPP tables and so aren't defined there. We rely on the
"<name>-supply" property from the regulator bindings for the devices.

> Even for opp-v2, they are not documented in
> Documentation/devicetree/bindings/opp/opp.txt, but cpu-supply is used in
> the examples?

Same reasoning here as well.

> For v2, I did find "[PATCH 01/16] PM / OPP: Add 'supply-names' binding"
> https://lore.kernel.org/lkml/2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org/
> but presumably that's an even further evolution?

Yeah, that never made it to mainline is abandoned.

> Can you please document these properties?

I don't think we need to, do we ?

-- 
viresh
