Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F285C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082CE21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbaTlHbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBTXdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:33:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46693 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:33:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so12705059pfh.13;
        Wed, 20 Feb 2019 15:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g1deo3fsueysNO+Nsgz1lZLBc108QPexV+FPEku0HNk=;
        b=AbaTlHbm43fsQgqE8RDdnHpV/KiRTBTpnA9C4MEmup5Ijb9odno+CyAyCYN6H99sB+
         qluCeEOD4S6Vln20ed3lNnUjoDSVEBc63aNGkYjYMFyewm72odv9UYOFlo8JMEgADo/Y
         vNYGTdoZP7ptXYcU6OQEcUk4iXuuanDrxi4+nOJ1igyvg7N/o4LbAuP3x5f7wJ/W91CZ
         fMn9AIGQpPmFv/rO/5v7BoX5h7XN2T7pll99hqEUezpqGunIc+utd+CRmo6S2vzOqJod
         xp/WXthCkQiQlC3+Ov76BpE2d5+H5ZM9/TqUmkyP5bSSROdyacZ9KnNAZzuI+PV6KoQl
         kw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g1deo3fsueysNO+Nsgz1lZLBc108QPexV+FPEku0HNk=;
        b=LkEskBswbD2zVuZkdZWBMbXrx+oiD092g4m5wtW0YBMtErSI6zG6SXsAWtu5nUMggm
         ilGA/YCvU9wofjcyj0lwyOphtIYS1OWOdUa6yZgU9tq5wtCWG4dmD4gU4l0cTl7gSC0y
         9DyUwg+VJn1MxJwUl9s05wGk2vuxs0qRpBrmDiquxGtUtChEfg4XePUd20rDjcE30Hse
         kzpmwo8MHOTmjH5xOobovUQHxFvjKxgrguMGbix8wXMmHmezym/DAbvWtghA4QPQX/hM
         BOXHKX+gieJZUHw9j0AcITgOyCvabLAxYNLKcfwvfnWj15JXqlliI9yirn5gDKSwgFW7
         8V5w==
X-Gm-Message-State: AHQUAubmlDfTwbSy54VluK7EbCRX7x+25rxWkHE3PF8agbi2+tlB2IAZ
        WTy3qOUA4RNj3twpXXMGXzbZ73Vg
X-Google-Smtp-Source: AHgI3Ia4Y6H4TvcQlzX7aYxTfYC1t0zQ7e8ghZjcb7QMncLdxOpMhhO4RyAIAAMMYyQE3Bjz0N9LKQ==
X-Received: by 2002:a63:575d:: with SMTP id h29mr16966786pgm.442.1550705582185;
        Wed, 20 Feb 2019 15:33:02 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id k1sm23459314pgq.45.2019.02.20.15.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 15:33:01 -0800 (PST)
Date:   Wed, 20 Feb 2019 15:32:59 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 00/12] qcom: dts: thermal cleanups
Message-ID: <20190220233257.GA31479@localhost.localdomain>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
 <20190220012641.GH2811@localhost.localdomain>
 <CAP245DXn3db27wMPSaZazRhprXD89JKQ5qEkc8r0DpSL9A847w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DXn3db27wMPSaZazRhprXD89JKQ5qEkc8r0DpSL9A847w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 03:09:36PM +0530, Amit Kucheria wrote:
> On Wed, Feb 20, 2019 at 6:56 AM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > Hey
> > On Mon, Feb 18, 2019 at 06:05:14PM +0530, Amit Kucheria wrote:
> > > - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> > > - split up the register address map for msm8998
> > > - standardize names of the various thermal-zones across boards to make it
> > >   easy for test scripts to parse
> > >
> >
> > I am generally fine with the effort but please fix the following
> > (applies for the whole series) wrt to required properties for DT
> > thermal:
> > a. Trip points for your zones
> 
> Thanks for the review.
> 
> In some cases, the temperatures are just exposed so something in
> userspace might read it and do something with it. We don't expect
> kernel trips for them.

Would a hwmon driver make more sense here?

> 
> Adding trip points also requires me to add cooling-maps (your point b. below).

Yes.

> 
> I guess I'm looking for an example of how to just expose sensor
> temperatures w/o any associated trips and cooling maps.
> 
> > b. Cooling Mappings for zones that have passive trips.
> >
> 
> From what I can see currently only CPUs and GPUs (among the major heat
> sources) can passively reduce heat by reducing frequencies.
> 
> Things like cameras, display, video might have a more ON/OFF approach
> to throttling that might be controlled from userspace. And we don't
> have a way to tell in DT that these zones are managed in userspace

You can always add a Hot trip point. To my understanding that is for
notifying userspace.




> (https://patchwork.kernel.org/patch/10259487/)
