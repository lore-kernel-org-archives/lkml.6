Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA50AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9749820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9zKrskf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9749820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030314AbeFSRnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:43:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41480 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966738AbeFSRni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:43:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so224998ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qU7oJL2Zd1ozHsZ4fUHL8HQc1NAE7BidrXPvBhzNAUE=;
        b=k9zKrskfSkrUyrRNMk0rt862hzYLR4q4oDSuYcsBixWpY1FcBIATAWlSgjnzKqbBvi
         BTuNfncZozJCi8VzicVelnzDQ0t2TGJHlzSzlNmk3e8tI5F+WpgwCDvPXoJcEVViUEjq
         cyBeihKQ01hMeVrzuqhcsrV/jCinPZyjvFJAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qU7oJL2Zd1ozHsZ4fUHL8HQc1NAE7BidrXPvBhzNAUE=;
        b=MPQp5M6+U8u97uFCbObPDWAsc5k9K8gd7P1MIckeuO6zfZkOtqU95cFz6RHJP8fZ9a
         Ay5qHCT1XWSCnBmE+jvfI8WBDJYzJP4S4uKrysegG/VU7kZSFdiV73XSsJJ6EdLkRIq/
         U4KghEwWGsf0TfywDHgDOANV27XsWly77mu7Ms63Jc6RikDj1iJi8rT2gGBRR8ErKEw6
         IRrL3RxV0YyD/xKsW5RquP8VjwgpUQ7amHgyDaBhgdVhFOZHJoPv8v9JKWb0JKzljJs4
         048GSdBsj1ZXdr4PGeGVlpkWLKJslPyg1vQ24q1ZSS28PZqxnbRcbp60yVA9SjVFYP9S
         8e5Q==
X-Gm-Message-State: APt69E2xG4gkt7hB4BdEDIFgLiXG0aE/XO8AtbWSEpIbc4XujOTCmkXu
        +PdSRGjgnXWo4jKrWuADm87l5w==
X-Google-Smtp-Source: ADUXVKKO9vow+VVxA1K7F/FjvRtokYp4A54zKlfFM60ziwabQZu0PmKBXcgKDGIrXp9oTfpknw3QgA==
X-Received: by 2002:a17:902:52ee:: with SMTP id a101-v6mr19728742pli.131.1529430217647;
        Tue, 19 Jun 2018 10:43:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id e16-v6sm282221pfn.46.2018.06.19.10.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:43:36 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:43:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 12/12] mfd: cros_ec: Add throttler sub-device
Message-ID: <20180619174336.GY88063@google.com>
References: <20180614194712.102134-1-mka@chromium.org>
 <20180614194712.102134-13-mka@chromium.org>
 <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180618232109.GB154056@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:21:10PM -0700, Brian Norris wrote:
> Hi,
> 
> On Thu, Jun 14, 2018 at 12:47:12PM -0700, Matthias Kaehlcke wrote:
> > Instantiate the CrOS EC throttler if it is enabled in the kernel
> > configuration.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v3:
> > - patch added to series
> > 
> >  drivers/mfd/cros_ec.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> > index 36156a41499c..5f52b6e2c21a 100644
> > --- a/drivers/mfd/cros_ec.c
> > +++ b/drivers/mfd/cros_ec.c
> > @@ -91,6 +91,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >  	return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> >  }
> >  
> > +static const struct mfd_cell ec_throttler_cell = {
> > +	.name = "cros-ec-throttler",
> > +};
> > +
> >  int cros_ec_register(struct cros_ec_device *ec_dev)
> >  {
> >  	struct device *dev = ec_dev->dev;
> > @@ -153,6 +157,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
> >  		}
> >  	}
> >  
> > +	if (IS_ENABLED(CONFIG_CROS_EC_THROTTLER)) {
> > +		err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> > +				      &ec_throttler_cell, 1, NULL, ec_dev->irq,
> > +				      NULL);
> 
> Most of this similar sub-device registration seems to have moved to
> cros_ec_dev.c, in ec_device_probe(). Should this do the same?

Not sure about this, the only device that is registered in
ec_device_probe() are the sensors.

I cc-ed Benson and Olof, the maintainers of CrOS platform stuff,
maybe they can help to clarify what the preference is and why.

> And on a similar note: is there a way to determine EC support for this
> feature (e.g., EC_FEATURE_*)? Or do we just have to listen for
> appropriate throttling events that may never come?

To my knowledge there is no such way as of now. There is no
EC_FEATURE_* for throttling support
(https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h#1174).
though we could probably add one.

> Also, is this very useful on non-DT systems? Does this fail gracefully?

It is not useful on non-DT systems, however the throttler core has a
dependency on CONFIG_OF, so the device wouldn't be added.
