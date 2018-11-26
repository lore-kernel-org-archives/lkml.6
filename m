Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32047C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E2520855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBu+vK0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E2520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeK0Eir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:38:47 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:36851 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeK0Eiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:38:46 -0500
Received: by mail-vs1-f41.google.com with SMTP id v205so11893690vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9ncKStqKYFpy5k5QNVfeTI2b4E4IW77gfoJb/WU5Is=;
        b=aBu+vK0B/l0RpppKE9HPNFwUCk4ch88TmvTrBZoSr+tGnMSVB4t3LMIkKwH+BeGI0e
         uTS1Q02d2EM9LLp1Ae0dWkBtxRahmE8hMMyUKiE1u0s3YYj6GQWT7+RrhZ4pi50oMYZk
         d94LlCg/PLiYETEf+XiimSCQuw6h7tws5Efpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9ncKStqKYFpy5k5QNVfeTI2b4E4IW77gfoJb/WU5Is=;
        b=PSnyGWeb6auftHzSd6Ik6Xn+R+Lh8k5UGn/YRcQGw6BMN5YKMNdSscLP+9lPUpcP0K
         Ye7WM0nn5+u6/9W4UW6WGod0lCMw65CrTYUWBNFIhlIrDL4K/Rg94c0H5sMRmfZWDD9o
         NcDg6FmzE/sTph1OGX12NU4Obn/e8F/H8rAeyN/1lrImVJh8KhXYBIyDfpG23v/xSU76
         lc/vKE2i4XRDu8TFUWVwgtfe178250FUYELl9PRQiOisiaHmU9llfG2t6xtbWOQKPKPe
         Yr6IxQO3YfAz9FifVvpJLTWpxOVIlQPJv/ZhC7P+6+Hr0M06+KvaiLYBKT5oMNwcZQWG
         aD1Q==
X-Gm-Message-State: AGRZ1gJd/saLJ7+LHhkZwyqjb3FDOIbS1zs+6xGdNPGMcgMd9DxR0pGl
        1a0ubLooluaJPbQ7JDNeHOoHhecZrx0=
X-Google-Smtp-Source: AJdET5dbrYIWD3pB74i9OmhfEIsx8k4dVwMX/7pO8fsW7p8CexaYXNzABk057yvpyi3gYJRHTHaibw==
X-Received: by 2002:a67:208:: with SMTP id 8mr12209698vsc.48.1543254236275;
        Mon, 26 Nov 2018 09:43:56 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id o8sm704548vkf.4.2018.11.26.09.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:43:55 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id z24so6603595ual.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:43:54 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr11018288uaj.126.1543254234308;
 Mon, 26 Nov 2018 09:43:54 -0800 (PST)
MIME-Version: 1.0
References: <20181125093750.GA28055@basecamp> <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
 <20181125232450.GA3774@basecamp>
In-Reply-To: <20181125232450.GA3774@basecamp>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Nov 2018 09:43:42 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V4WFYoKLQ72pico4HCGgLDTae7xougivv6VWOSoPhLpg@mail.gmail.com>
Message-ID: <CAD=FV=V4WFYoKLQ72pico4HCGgLDTae7xougivv6VWOSoPhLpg@mail.gmail.com>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
To:     masneyb@onstation.org
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 25, 2018 at 3:24 PM Brian Masney <masneyb@onstation.org> wrote:
>
> > I guess this is a workaround for drivers that don't set the load
> > properly themselves?
>
> I'm honestly not sure when the load should be set in the driver or in
> device tree. None of the drivers in drivers/mmc/ call
> regulator_set_load. The dt bindings describes the regulator-system-load
> property in Documentation/devicetree/bindings/regulator/regulator.txt.

My initial thought is that I'd expect that the load should be
associated with the consumer, not with the regulator.  The way you
have it specified in the device tree it's associated with the
regulator.  The distinction would only matter if:

A) there was another consumer of this rail

B) that other consumer could actually make due with a lower power mode
of the regulator.

C) we knew for sure that the SD card wouldn't draw (much) power from
this rail when the SD driver told it to be off.

In your system A) isn't true so thus it doesn't matter.  Even if A)
and B) were true though, I'm not sure I'd trust random SD cards
plugged into the system to not draw power.  Given that a random SD
card might draw power from the rail even if the driver wants the
regulator off then perhaps your "system-load" solution is the most
correct thing after all.

NOTE: another option would be to change the regulator driver to just
force this rail to a high power mode and never let it change.  That's
what we're doing on a SDM845-based board.  When the regulator is off
the mode doesn't matter and as per the above argument we always want
it in high power mode when it's on.


> I see that there are 8 users of regulator-system-load but most are all
> addressing this same issue with the SD card.
> qcom-msm8974-sony-xperia-castor.dts sets the load to 500 mA but all of
> the other msm8974-based SOCs use 200 mA. I'm not sure if this is
> correct.

Interestingly enough I think the max load here is specified by the SD
card specification.  My quick reading of the SD spec shows that you
could do all sorts of complex negotiation with the card about how much
load it could take up but Linux didn't actually support that.  If I'm
reading it right the default is 200 mA.

It's unlikely that really matters though.  I doubt your regulator has
a different mode for 200 mA vs. 500 mA.


> > +++ b/drivers/regulator/core.c
> > @@ -1344,6 +1344,12 @@ static int set_machine_constraints(struct
> > regulator_dev *rdev,
> >                         rdev_err(rdev, "failed to set initial mode: %d\n", ret);
> >                         return ret;
> >                 }
> > +       } else if (rdev->constraints->system_load) {
> > +               /*
> > +                * We'll only apply the initial system load if an
> > +                * initial mode wasn't specified.
> > +                */
> > +               drms_uA_update(rdev);
> >         }
>
> Yes, this patch corrects the issue for me. You can add my tags if you
> end up applying it:
>
> Reported-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Brian Masney <masneyb@onstation.org>

Sent.  See <http://lkml.kernel.org/r/20181126170827.160567-1-dianders@chromium.org>.
Looks like Mark already applied it.  Thanks, Mark!


> Thanks for the quick response!

Thanks for the quick report and testing.  I'm very happy that it was
something as simple as this and not some complex interaction.

-Doug
