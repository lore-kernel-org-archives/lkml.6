Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D11C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B791214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHeCElCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfA1MtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:49:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45650 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1MtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:49:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so14057044ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 04:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRhHTshRy93ZavvcEIkGkkKleavHMBYy/IVRyHzjjYk=;
        b=KHeCElCTAUQULHQkI6+LqXf1i+bdWtjRu+/A7TRxBL2YFMoufazuDbKR4fWzPJeBLa
         n1I3k8+JqMDDvERYpjK+Ya8Gx4L1HLbxVozIPVoQYsIoA2Lkdd65tOXs5HL5zvHq2XLv
         v5+j/MNwpoY1A0lAVUJEuGI7sUKT6vtAemA6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRhHTshRy93ZavvcEIkGkkKleavHMBYy/IVRyHzjjYk=;
        b=UqCxaBviCQ4oZ+oQcJ6lKRZ3r44xGPRxEkvZPYb/ToC4DjFuCJkNSfCN8msgDCrU4x
         kavz3XLNhvqjqskFxTUJR6MyXoKqQgByI8N1Cf795MIhLPQR8l2Sx8OCRZwTNDMWDpBc
         BSmqRKcyC2LPvGehvz8IMVn0O/2Ya+Hg4m1J2CU96Khm45eeY5CkeAESNtQZCcY70oEW
         IR6J5gul9TRRE27R9h+9WMvtEUmDV2ku/OcF9ZGacVmLgET/58YXizZvRxmRR4l5Vjun
         wrVLbSUSU8W72ihyqmBDtrnVLqZs084pIzkjkqZDLWKi7oAvk5HS0qoqaReqXxOB/05C
         PIpg==
X-Gm-Message-State: AJcUukd0gl/iUZ3r0zfjbA11V9Wms17HxA057TpzIq5OE2A0gCTGJYKA
        Xy3woOUI3JoXAs2QJdqFHlNL2kciAXvcamenN9GgxA==
X-Google-Smtp-Source: ALg8bN6hHc81mWUi5OEd/I/TqPaIgQATp+cVW3qkdu0pa8pQotv3LN8Y3OYJ8XT41iZ7yI1vFjaRM8paCX4pxAZwmOQ=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr16554297ljt.107.1548679756442;
 Mon, 28 Jan 2019 04:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20190125110600.GA29332@localhost.localdomain>
In-Reply-To: <20190125110600.GA29332@localhost.localdomain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 13:49:04 +0100
Message-ID: <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti!

Thanks for your patch.

We are going to have a problem with the power subsystem.

These charging drivers are growing wild. This is starting to get out
of hand, we need some more framework for properly handling charging
state machines the kernel. Not specifically your problem, but
when working on the driver try to keep generic support in mind.

On Fri, Jan 25, 2019 at 12:06 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> +#define CHG_STAT_SUSPEND       0x0
> +#define CHG_STAT_TRICKLE       0x1
> +#define CHG_STAT_FAST          0x3
> +#define CHG_STAT_TOPOFF                0xe
> +#define CHG_STAT_DONE          0xf
> +#define CHG_STAT_OTP_TRICKLE   0x10
> +#define CHG_STAT_OTP_FAST      0x11
> +#define CHG_STAT_OTP_DONE      0x12
> +#define CHG_STAT_TSD_TRICKLE   0x20
> +#define CHG_STAT_TSD_FAST      0x21
> +#define CHG_STAT_TSD_TOPOFF    0x22
> +#define CHG_STAT_BAT_ERR       0x7f

So what I am seeing is that these states are starting to turn up in more
and more drivers, so we really need to think about a central management
component for charging state machines. I do not think they are all
that different after all.

> +BD_ERR_IRQ_HND(BAT_OV_DET, "Battery overvoltage detected\n");
> +BD_ERR_IRQ_HND(DBAT_DET, "Dead battery detected\n");
> +BD_ERR_IRQ_HND(COLD_DET, "Battery cold\n");
> +BD_ERR_IRQ_HND(HOT_DET, "Battery hot\n");
> +BD_ERR_IRQ_HND(CHG_TSD, "Charger thermal shutdown\n");
> +BD_ERR_IRQ_HND(DCIN2_OV_DET, "DCIN2 overvoltage detected\n");
> +
> +BD_INFO_IRQ_HND(BAT_OV_RES, "Battery voltage back to normal\n");
> +BD_INFO_IRQ_HND(COLD_RES, "Battery temperature back to normal\n");
> +BD_INFO_IRQ_HND(HOT_RES, "Battery temperature back to normal\n");
> +BD_INFO_IRQ_HND(BAT_RMV, "Battery removed\n");
> +BD_INFO_IRQ_HND(BAT_DET, "Battery detected\n");
> +BD_INFO_IRQ_HND(DCIN2_OV_RES, "DCIN2 voltage back to normal\n");
> +BD_INFO_IRQ_HND(DCIN2_RMV, "DCIN2 removed\n");
> +BD_INFO_IRQ_HND(DCIN2_DET, "DCIN2 detected\n");
> +BD_INFO_IRQ_HND(DCIN1_RMV, "DCIN1 removed\n");
> +BD_INFO_IRQ_HND(DCIN1_DET, "DCIN1 detected\n");

So we have states and events, and these events form edges
between the states, right?

I am certain you must have a graphical picture of this state
machine somewhere, it seems to be how charging hardware people
do their thinking.

> +/*
> + * For BD70528 voltage/current limits we happily accept any value which
> + * belongs the range. We could check if value matching the selector is
> + * desired by computing the range min + (sel - sel_low) * range step - but
> + * I guess it is enough if we use voltage/current which is closest (below)
> + * the requested?
> + */
> +static int find_selector_for_value_low(struct linear_range *r, int selectors,
> +                                      unsigned int val, unsigned int *sel,
> +                                      bool *found)
> +{
> +       int i;
> +       int ret = -EINVAL;
> +
> +       *found = false;
> +       for (i = 0; i < selectors; i++) {
> +               if (r[i].min <= val) {
> +                       if (r[i].min + r[i].step * r[i].vals >= val) {
> +                               *found = true;
> +                               *sel = r[i].low_sel + (val - r[i].min) /
> +                                      r[i].step;
> +                               ret = 0;
> +                               break;
> +                       }
> +                       /*
> +                        * If the range max is smaller than requested
> +                        * we can set the max supported value from range
> +                        */
> +                       *sel = r[i].low_sel + r[i].vals;
> +                       ret = 0;
> +               }
> +       }
> +       return ret;
> +}

If I'm not mistaken this is yet another instance of linear interpolation
from a table?

We really need to think about abstracting this. Last time this
duplication appeared I suggested adding linear interpolation
primitives to:
include/linux/fixp-arith.h

I don't know what others say though?

Yours,
Linus Walleij
