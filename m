Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A772C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168D20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YfK6IR5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C168D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030350AbeFSRz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:55:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42576 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966999AbeFSRz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:55:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id w17-v6so241860pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VuZ48z+peeyQY1/AwvcY8tt6GoMvZmEMjmO0YYPNK6U=;
        b=YfK6IR5AMmnAcJ/J9Ph4E0IQQk65rd3KgXej8YzDoO/wVhhgkvKBmzTDWE6LvLMoj4
         LurzWI3RiOZ3EhdTWRGxOz70fBjoiY4XKtKuv/hvtI3TDEc3sdo1JReQdkPfGSK8t5dz
         k6Z/PS1GNJRbhxlRKVUOaIAWMP67rw7uAUOmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuZ48z+peeyQY1/AwvcY8tt6GoMvZmEMjmO0YYPNK6U=;
        b=GZU8E675r4uAVOQ0xmfS8wgExnOfbZdXJDNCQDHyTk+fxGj4ZFynTsECWzio3OeQL1
         4ztUPtd81i1Tial8OhLL8rKXoY6sPsIhc/onaMe9SVIX5AGjrTam6E9k07H+yLmu6D1c
         LKKMYA5ye2pNnfh6KLb8DdChyyQXa3i4bKErNS3adJt8idB7AHrEExK5DVWfKDBYBW7z
         u0xMwHQgAhaeGooSINg0jJRRFh+buJGbXwBBiohjJ7uY7kp/9hmxkhX/f4FGezd3+y6x
         6mM0XhwUE4CTntsLHS2Q7/OcLuJoIyQmQs6hjMSlerDczbAXs7Q4clmm1fFV3HxFLVC5
         DcZQ==
X-Gm-Message-State: APt69E1BLlLLh9CaLEMb2FUOLmEj1sNi0KUbyP6w0qYsAxlLodl+gdJL
        LmPE4fbn6N9jkqv1yHXiHppGCA==
X-Google-Smtp-Source: ADUXVKKuioYLs4Wcrk1kEHNF0YeCPy5w4xq05mbQK1VMaNN+YSSBOUKIT9sG34vfvM5hNml6Ad0XWQ==
X-Received: by 2002:a17:902:103:: with SMTP id 3-v6mr19994470plb.229.1529430926061;
        Tue, 19 Jun 2018 10:55:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id j15-v6sm488448pfk.40.2018.06.19.10.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:55:25 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:55:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Message-ID: <20180619175524.GZ88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-13-mka@chromium.org>
 <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
 <CAFqH_520Z4nAkXsnKeO9ZGqSSfPg_7f7pjJs=t=ryQTBExfwoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqH_520Z4nAkXsnKeO9ZGqSSfPg_7f7pjJs=t=ryQTBExfwoA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Tue, Jun 19, 2018 at 10:41:01AM +0200, Enric Balletbo Serra wrote:
> Hi Matthias,
> 
> I am also interested on the answer of Brian comments :). One small comment.
> 
> Missatge de Brian Norris <briannorris@chromium.org> del dia dt., 19 de
> juny 2018 a les 1:22:
> >
> > Hi,
> >
> > On Thu, Jun 14, 2018 at 12:47:12PM -0700, Matthias Kaehlcke wrote:
> > > Instantiate the CrOS EC throttler if it is enabled in the kernel
> > > configuration.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v3:
> > > - patch added to series
> > >
> > >  drivers/mfd/cros_ec.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > > index 36156a41499c..5f52b6e2c21a 100644
> > > --- a/drivers/mfd/cros_ec.c
> > > +++ b/drivers/mfd/cros_ec.c
> > > @@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> > >       return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> > >  }
> > >
> > > +static const struct mfd_cell ec_throttler_cell = {
> > > +     { .name = "cros-ec-throttler" }
> > > +};
> > > +
> 
> As Brian said I think that this should go in cros_ec_dev?

Not sure about this, see my reply to Brian.

> Even when only there is one cell we tend to use the array format (see
> i.e the cros-ec-rtc and the others in cros_ec_dev).
> 
> +static const struct mfd_cell ec_throttler_cells[] = {
> +     { .name = "cros-ec-throttler" }
> +};

Ok, will change.

> > >  int cros_ec_register(struct cros_ec_device *ec_dev)
> > >  {
> > >       struct device *dev = ec_dev->dev;
> > > @@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> > >               }
> > >       }
> > >
> > > +     if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
> > > +             err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> > > +                                   &ec_throttler_cell, 1, NULL, ec_dev->irq,
> 
> ARRAY_SIZE(ec_throttler_cells)

Ack

Thanks

Matthias
