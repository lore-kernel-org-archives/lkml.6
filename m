Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EAEC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56B7214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NV7bqcDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfA2EVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:21:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39770 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfA2EVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:21:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so20896352qtj.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZUGePzewCDuBQaqaR//yZGnCYqK5GX39SVrw/5G1MA=;
        b=NV7bqcDKTpjDZoepx1hw05JWtXOTanvrEruIQbTfLne+jjvNT0LzQQI6DD9I00lxw4
         8qPaanfSsbUsiVjUfgZqoV7laDqG0K0s0H8UDA7+O0KKMLLlDzw84l7FaBW9o8y24dIj
         XBFa6pfpL3Qn7MYOl98TLN8KQTum2ElKB/7M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZUGePzewCDuBQaqaR//yZGnCYqK5GX39SVrw/5G1MA=;
        b=SayJKFA01pBw1ADgCIW3vDx1eIS62I6fHE5U6+mGt+E8N4py7D48vV1ugROCbPiLn5
         pKwwE+gNDGWARGNrdRykk4A/uwd4Z73rHKWWl23kUTqf6xXKsXd1/kH4Eht+3xR6kecT
         MkOnSkeUGrmoHVPDomOdqfTtrzsJ3AjvIssSyI+rFMR5bZxQpLheH7R14PpTWPX5SIPk
         6LStQRot/6qG0cmsdprw72s1ltnqwQHmB7kGjDZPou/x03chdvPRVH3ttqPVkLUrqMsK
         aNu2N2UVYfSScQ7GX0p7S6O7OwohEfVJw0u361dg+dW4S2xCQPnQifVueN8ccLDt4eKx
         Fmyg==
X-Gm-Message-State: AJcUukdrGSJVANwrfFFlEYzJDQYv+2yNcrcn6RByJOUN6Ru2ZquYegBB
        XSfp/5XyVkyle0zjHmC1DJGbeC4CSMn6wjwLVA/UwQ==
X-Google-Smtp-Source: ALg8bN6yPzgeh08YhtX+jvoJtPMPsFkXMkPyIat8ntC34dKOKMZHlM2ei70my7xITKvhHCUt0sAUbCuVw1P6fu6mLSI=
X-Received: by 2002:aed:3bd7:: with SMTP id s23mr23919693qte.207.1548735693893;
 Mon, 28 Jan 2019 20:21:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
 <3afd5b04-5caf-053d-48c9-f719eec58da0@linaro.org> <12294707.IXbBkGfcfl@aspire.rjw.lan>
In-Reply-To: <12294707.IXbBkGfcfl@aspire.rjw.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 29 Jan 2019 09:51:21 +0530
Message-ID: <CAP245DUBUYybm0efnczhEbSrCEfdBb0pX9t-Xw6vnaVN8_3hLg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 5:34 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, January 28, 2019 9:32:44 AM CET Daniel Lezcano wrote:
> > On 28/01/2019 07:41, Amit Kucheria wrote:
> > > All cpufreq drivers do similar things to register as a cooling device.
> > > Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> > > to register the cooling device on their behalf. This allows us to get
> > > rid of duplicated code in the drivers.
> > >
> > > In order to allow this, we add a struct thermal_cooling_device pointer
> > > to struct cpufreq_policy so that drivers don't need to store it in a
> > > private data structure.
> > >
> > > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> >
> > [ ... ]
> >
> > > +/*
> > > + * Set by drivers that want the core to automatically register the cpufreq
> > > + * driver as a thermal cooling device.
> > > + */
> > > +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV  BIT(7)
> > > +
> >
> > Isn't the CPUFREQ_IS_COOLING_DEV more appropriate? We define a property
> > of the cpufreq driver and the resulting action is to auto-register, no?
>
> Yes.

OK, will send out another series with this change and the IS_ENABLED guards.

Thank you everyone for the review.
