Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE5C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0498F20671
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkYL1Ovc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0498F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeKULbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:31:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43980 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeKULbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:31:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so2843011plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 16:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=SueHlyFVJ++hnnTVh5859U557Ripqy3MhgFlrhxUUYA=;
        b=AkYL1OvcwZEYBD3RS/eLKcI1v2r01wNaA7DCNa3NAdcxyYFAo71iLyVnaOOmLFt1ZX
         LMoM8faRrrHvFCypGD1u10n6E/wO6KusHB4B3RIjgnINYqPWVYzwDDHRAu9AGgmFtBie
         qliw/sUg+ka3lcaSuBcJI1/baArYkJVA3UH8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=SueHlyFVJ++hnnTVh5859U557Ripqy3MhgFlrhxUUYA=;
        b=nnpR+yCIz7kL4LkeJBnNcCz4XlC7gxvqWJH9dk3Vk3ds/LcUY54ZBI4cp4Xo9KNzo8
         J4W9dxiCCzNIQ0mXWRxpOz02y0DKOUIfuEDfQEaUSU9gEJPLjnEALjFYGISQEzUU8I2Y
         NZuEFOqjSeSN9CEaV/FJMW2RZVPl593dtYpAXg2Sf1coxY8exS8t4e5mDYFH9VIEsb5l
         r9iSWMa4eCXEo81yMg74AIeoQ+vv1hsdU8uKg9PMGcleMtAxplsCRk1kxTCD06d5OB0e
         FVHPxnYZT0Xym/7mMurhhN9b66N40ogTXpG7KWGIOa3aNl7hBHXCVz8M5UIEm2xu7JMv
         vm7w==
X-Gm-Message-State: AA+aEWZ5eYUseblxjNvN34thruR7peADeul1Srydc0NmF5R6iA7Q16g4
        tdormlG07Hsxm++exhfviqbjpQ==
X-Google-Smtp-Source: AFSGD/UnESDTl555q8AD6vZLr5326OnMwcBlb6Ljx2XTiwMcefMxfnRspZFuDypoJkdZjuKN8fPqoQ==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr4394917pla.272.1542761972434;
        Tue, 20 Nov 2018 16:59:32 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id w5sm13709880pfn.89.2018.11.20.16.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 16:59:31 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181116002337.GP22824@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
 <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
 <154130523254.88331.12609105382114756048@swboyd.mtv.corp.google.com>
 <3aa7b871-9cf9-9626-11fe-b9aa6009b477@codeaurora.org>
 <20181116002337.GP22824@google.com>
Message-ID: <154276197062.88331.8324696168748324451@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Tue, 20 Nov 2018 16:59:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-15 16:23:37)
> On Sun, Nov 11, 2018 at 06:12:29PM +0530, Taniya Das wrote:
> > On 11/4/2018 9:50 AM, Stephen Boyd wrote:
> > > Quoting Taniya Das (2018-11-02 20:06:00)
> > > > On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> > > > > Quoting Taniya Das (2018-10-11 04:36:01)
> > > > > > --- a/drivers/cpufreq/Kconfig.arm
> > > > > > +++ b/drivers/cpufreq/Kconfig.arm
> > > > > > @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> > > > > > =

> > > > > >             If in doubt, say N.
> > > > > > =

> > > > > > +config ARM_QCOM_CPUFREQ_HW
> > > > > > +       bool "QCOM CPUFreq HW driver"
> > > > > =

> > > > > Is there any reason this can't be a module?
> > > > > =

> > > > =

> > > > We do not have any use cases where we need to support it as module.
> > > =

> > > Ok, so it could easily be tristate then? Why not allow it?
> > > =

> > =

> > I have checked other vendors CPUfreq drivers and those too support only
> > "bool".
> =

> That's not entirely correct. Most drivers in Kconfig are 'tristate'
> and about 50% of those in KConfig.arm are. I'd say make it 'tristate'
> unless there are good reasons not to do so.

Yes, please make tristate.

> =

> > > > > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufre=
q/qcom-cpufreq-hw.c
> > > > > > new file mode 100644
> > > > > > index 0000000..fe1c264
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > > > > @@ -0,0 +1,354 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Copyright (c) 2018, The Linux Foundation. All rights reserv=
ed.
> > > > > > + */
> > > [...]
> > > > > > +
> > > > > > +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {
> > > > > =

> > > > > Is this going to change in the future?
> > > > > =

> > > > =

> > > > Yes, they could change and that was the reason to introduce the off=
sets.
> > > > This was discussed earlier too with Sudeep and was to add them.
> > > > =

> > > > > > +       [REG_ENABLE]            =3D 0x0,
> > > =

> > > This is only used once? Maybe it could be removed.
> > > =

> > > > > > +       [REG_LUT_TABLE]         =3D 0x110,
> > > =

> > > And this is only used during probe to figure out the supported
> > > frequencies. So we definitely don't need to store around the registers
> > > after probe in an array of iomem pointers. The only one that we need
> > > after probe is the one below.
> > > =

> > > > > > +       [REG_PERF_STATE]        =3D 0x920,
> > > > > > +};
> > > > > > +
> > =

> > As these address offsets could change, so I am of the opinion to leave =
them
> > as it is.
> =

> As of now there is only one set of offsets. Let's just keep the code
> simple while this is the case and address different offsets when it is
> actually needed, as suggested by Stephen and Sudeep.

Yes, please simplify by getting rid of this and not storing anything in
the struct that's only used during probe.

> =

> > > =

> > > With fast switching we can avoid incurring any extra instructions, so
> > > please make another iomem pointer in the cpufreq_qcom struct just for
> > > writing the index or if possible, just pass the iomem pointer that
> > > points to the REG_PERF_STATE as the policy->driver_data variable here.
> > > Then we have the address in hand without any extra load. If my
> > > understanding is correct, we don't need to keep around anything besid=
es
> > > this register address anyway so we should be able to just load it and
> > > write it immediately.
> > > =

> > =

> > The c->reg_bases[] is just an index to the updated bases addresses. I a=
m not
> > clear as to why it would incur an extra instruction.
> > =

> > The below code would already take care of it.
> > =

> > +     for (i =3D REG_ENABLE; i < REG_ARRAY_SIZE; i++)
> > +             c->reg_bases[i] =3D base + offsets[i];
> > +
> =

> From a performance point of view using a direct iomem pointer
> seems like a micro-optimization that probably doesn't have a
> measurable impact. However I think the code shouldn't be more complex
> than necessary, and at this point the indirection isn't needed.
> =


Yes it's a micro-optimization for sure, in the task switching path so it
may actually be useful. Either way, I think we can greatly simplify by
just having the iomem pointer be the only pointer that is stored in the
policy driver_data.

