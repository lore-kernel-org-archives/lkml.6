Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0497C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EC12089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WgKyCe8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EC12089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934655AbeFLUk1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:40:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41850 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbeFLUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:40:26 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so123697pgl.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MYwB6n9zCgYujY43O0TQ4YTY4TOTrp3OwTyejFfqZHI=;
        b=WgKyCe8WUVkORo6kCpzL2v9JP7X6NjWBn1zUzs7zr/m2uJujpuFDKqhCALZpBDuPEJ
         YkmDqCCqxNgBzQlq7ECHFNbSbRZiMbzXA6D49Y9+sYu/ftnduw+5DH1W4cA4smcWKW9V
         alURfQTkN271OrwPt+WSa/xEo4ZZDWz5Y2w7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MYwB6n9zCgYujY43O0TQ4YTY4TOTrp3OwTyejFfqZHI=;
        b=M0j/8hbbl319koIPCx/r0z/Z1yp80bTqbNaDqbjf9f3daD7jmNGTB/U4syRrbafmG5
         hLZGd1xtSvUThmjYlHxS6KlrGWvegPi+LyiN1f0YO2Qms3T7ASwj9TgtOd2YCwdWgZJt
         G6oDRIzC5XSQHuBVxz7I8t0bpt9D0dNSf5kHjYPqlbS36T8Ctt41Wgfamt9Ev9zB+sjv
         EJ6OyrvMKxDs7lyVRjTvl/EGBwCGPof4pGOiEXxaAe5VAmZaUby9dvz5N74Wdkg2xVUy
         +X/XVboYPKsW/F6JcAdBSb4dTFj0YRikCJLE7P4GxcksDyn0FHp99hk5s8SiFGXuB32/
         bV5w==
X-Gm-Message-State: APt69E1P+YusML4YLaCfI/0YAHoMjMGP4Z/9c7NlA0YQym/XBPeVg8Fb
        VgJ66uGDygMx191zsktyymiC5g==
X-Google-Smtp-Source: ADUXVKIBeeylKtzQSkhXiuB2TixGvRl3q4GLvYLhmm+QehIsw7cSoKxUZt0SBfE0TI5Mc9OcThRSpQ==
X-Received: by 2002:a63:ba56:: with SMTP id l22-v6mr1605380pgu.161.1528836025572;
        Tue, 12 Jun 2018 13:40:25 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id y11-v6sm1119751pfn.92.2018.06.12.13.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:40:24 -0700 (PDT)
Date:   Tue, 12 Jun 2018 13:40:22 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v2 10/11] dt-bindings: misc: add bindings for
 cros_ec_throttler
Message-ID: <20180612204018.GB99983@rodete-desktop-imager.corp.google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-11-mka@chromium.org>
 <20180612191011.GA26266@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612191011.GA26266@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jun 12, 2018 at 01:10:11PM -0600, Rob Herring wrote:
> On Thu, Jun 07, 2018 at 11:12:13AM -0700, Matthias Kaehlcke wrote:
> > The cros_ec_throttler monitors events from the Chrome OS Embedded
> > Controller to throttle the system if needed, using the mechanisms
> > provided by the throttler core.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - patch added to series
> > 
> >  Documentation/devicetree/bindings/misc/cros_ec_throttler.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > new file mode 100644
> > index 000000000000..7316dcc0ef75
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > @@ -0,0 +1,4 @@
> > +* cros_ec_throttler driver
> 
> Bindings are for h/w, not drivers.

(OK, sure, don't call this "driver". And maybe this could use some more
description about what kind of events are emitted by this sort of
device.)

> I continue to fail to see why this needs to be in DT. There are other 
> ways to instantiate drivers.

This is mostly relevant to:
[PATCH v2 08/11] dt-bindings: PM / OPP: add opp-throttlers property

so it's probably good to take a look at that one too.

The primary purpose is to have a target to point at when determining who
is the source of throttling. This is similar to other CrOS EC subdevices
(e.g., PWM) where we technically don't require a subnode (the EC
firmware can its own PWM hardware without DT), but it is important that,
e.g., a backlight device has something to point at when it's using a PWM
attached to the EC. So we have a PWM subnode.

In this case, we're a little vague about what exactly the hardware is
here, but there *is* hardware that's emitting "throttle" events (hint:
here, it's related to sensing too high of system current). This is all
abstracted by firmware, which simply tells us we need to scale back our
power usage.

So, what do you think of patch 8? Should OPPs have phandles to such a
throttler? If so, should the phandle just point at the main EC device
(see mfd/cros-ec.txt), or is it reasonable to have a subnode to
represent something more specific?

Or maybe this is entirely on the wrong track. But this is the resulting
proposal after your comments on v1, so it's probably best we have a
clearer overall review of what makes sense here, so we don't just go in
cycles on new proposals that get rejected.

Brian

> > +
> > +Required properties:
> > +- compatible: "google,cros-ec-throttler"
> > -- 
> > 2.18.0.rc1.242.g61856ae69a-goog
> > 
