Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E95C1C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEAF2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jD/F4e06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEAF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeFMCAl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:00:41 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34317 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbeFMCAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:00:39 -0400
Received: by mail-pg0-f68.google.com with SMTP id q4-v6so468969pgr.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 19:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Py890PMstqOcXWoqrtw5FaRdH/xk5vhj4C0AzhCHURk=;
        b=jD/F4e06/1JNhAqrNEQF/6SrkGrFanloip8IqWueQOT/ukJrIQK8O+IXYRWKawc1JR
         1qbkZ8WfV/sEzi5C0nodCxUIKl8HaQXd9tFVcBXQhtY0SEM7IHoPiR7i6dkAsa9MdeHX
         hUGmsq24x0Mq1KC85+O4bju+MlCfvB5+AjPGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Py890PMstqOcXWoqrtw5FaRdH/xk5vhj4C0AzhCHURk=;
        b=LJT3fbdk/aMYzRN4RoHufAUi1/gnzJr0AnfUog0Zhu6VoUjqJ1adU+G7bI31CMU13s
         AWajTCCs4jYsgcz+PkVfuDsUu+jloxY0blQGg2PGAD4HZYwPBqZ9PGsHsZ1DpAm/JFUX
         nOb9b1IYMytWv4NkhiH7F/srS7L6JWfnTOlrAVyyeudgEP+e9WNDBiuL+6IopMenFj2y
         UF3KbFL37+C+RP37xIPZsWA3bG4K+601MfhKtdhAHLYqq/8y4qwIj0GzS/9An17CDi3t
         my//74VSSlEzjb1tbCcsBS11x5l1dv2tv+hDHJmZZXI/zas9AEQ/qoFY06dy1BiWlhrS
         F5VA==
X-Gm-Message-State: APt69E1TeVJT/STL/C93eWvjAGoS5+Bqa2S1ZtgIR5/SyQ2f6ycoUh8z
        T9XNApgn3Q1OBkDXa5isiPpMEg==
X-Google-Smtp-Source: ADUXVKIOJTBhpwlQmTlRf2lq+yI1mUibm1Aptlg8xyXnGVIQdNg+uaPETZ2HsosAmtcxogG/2nlgjg==
X-Received: by 2002:a65:6517:: with SMTP id x23-v6mr2428237pgv.268.1528855238826;
        Tue, 12 Jun 2018 19:00:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id b83-v6sm2074088pfe.159.2018.06.12.19.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 19:00:38 -0700 (PDT)
Date:   Tue, 12 Jun 2018 19:00:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
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
Message-ID: <20180613020037.GK88063@google.com>
References: <20180607181214.30338-1-mka@chromium.org>
 <20180607181214.30338-11-mka@chromium.org>
 <20180612191011.GA26266@rob-hp-laptop>
 <20180612204018.GB99983@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612204018.GB99983@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 01:40:22PM -0700, Brian Norris wrote:
> Hi Rob,
> 
> On Tue, Jun 12, 2018 at 01:10:11PM -0600, Rob Herring wrote:
> > On Thu, Jun 07, 2018 at 11:12:13AM -0700, Matthias Kaehlcke wrote:
> > > The cros_ec_throttler monitors events from the Chrome OS Embedded
> > > Controller to throttle the system if needed, using the mechanisms
> > > provided by the throttler core.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > Changes in v2:
> > > - patch added to series
> > > 
> > >  Documentation/devicetree/bindings/misc/cros_ec_throttler.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > > new file mode 100644
> > > index 000000000000..7316dcc0ef75
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/cros_ec_throttler.txt
> > > @@ -0,0 +1,4 @@
> > > +* cros_ec_throttler driver
> > 
> > Bindings are for h/w, not drivers.
> 
> (OK, sure, don't call this "driver". And maybe this could use some more
> description about what kind of events are emitted by this sort of
> device.)
> 
> > I continue to fail to see why this needs to be in DT. There are other 
> > ways to instantiate drivers.
> 
> This is mostly relevant to:
> [PATCH v2 08/11] dt-bindings: PM / OPP: add opp-throttlers property
> 
> so it's probably good to take a look at that one too.
> 
> The primary purpose is to have a target to point at when determining who
> is the source of throttling. This is similar to other CrOS EC subdevices
> (e.g., PWM) where we technically don't require a subnode (the EC
> firmware can its own PWM hardware without DT), but it is important that,
> e.g., a backlight device has something to point at when it's using a PWM
> attached to the EC. So we have a PWM subnode.
> 
> In this case, we're a little vague about what exactly the hardware is
> here, but there *is* hardware that's emitting "throttle" events (hint:
> here, it's related to sensing too high of system current). This is all
> abstracted by firmware, which simply tells us we need to scale back our
> power usage.
> 
> So, what do you think of patch 8? Should OPPs have phandles to such a
> throttler? If so, should the phandle just point at the main EC device
> (see mfd/cros-ec.txt), or is it reasonable to have a subnode to
> represent something more specific?
>
> Or maybe this is entirely on the wrong track. But this is the resulting
> proposal after your comments on v1, so it's probably best we have a
> clearer overall review of what makes sense here, so we don't just go in
> cycles on new proposals that get rejected.

I also think we need to clarify if this is the right direction. Since
Rob proposed the OPP hints and didn't object when I replied with the
opp-throttlers example I assumed he was ok with it.
