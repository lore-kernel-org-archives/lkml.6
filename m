Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F6C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6542601D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EwwEUgL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6542601D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964991AbeFYSum (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:50:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38851 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeFYSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:50:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so6460869pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YmcmqVK5vQQJaHprEKdnvikJqs8v7fFFBkpsamsILdw=;
        b=EwwEUgL5rRcOWO7RPV4w9W/+mkxoLbyfCqXD5VTqqXeCP5sWx6ScbYwQ3qVQIeR011
         xzb76LJCKOp3Lqwqc2hpnk0Or1Y/W6zBNg9c2DpKCkh6xsApBr+T510AOW794XaL8h9C
         T03IQDgvfe//H1StMrurlQSjYcPw55q7gXu2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YmcmqVK5vQQJaHprEKdnvikJqs8v7fFFBkpsamsILdw=;
        b=P6o3z2Vm0D22MfDLp6AYc5Kd/PQZ0hQvYrnApncmmESVZvZ5LTwOAvEM67Dvl0AALN
         xjZdDJiXJngrETOFXgrS57fWc4RKh261kJK98gMo7/kDpsqLumuxMUDAHwV87+h1v89y
         9PbPDofKzzONkzve3iBF1ksiCerExn5nWayXUTvsioS1lvZLuDYXpsaCOvlGb78WYqch
         edOnKKAa7Vwtc+/JuIIm33tqzYWKBuG0j6BuUlHhn8G5DK6z22hTEZ/qg22FexDmJssZ
         dzrtEf86td15zHNFk/7Dfk37cIr2WPcFYeYTQDrTdD5DmDwxYhaknsPf59KEIobeydUX
         4Cqw==
X-Gm-Message-State: APt69E15+bJR06GNfhPmOUq/2YSV2mCSrzJx6XQzpqwLTiCiP8oD0LP+
        7trBlAfLTt2bt0psGldjTlVd/w==
X-Google-Smtp-Source: ADUXVKJ3EdbIp+jUdImo4WLxY+3udtoiDgQV4fX2/d9KCp/NcCIqjy/UojgCLBaS5zEzFIwpQsGUhg==
X-Received: by 2002:a63:6d8b:: with SMTP id i133-v6mr6346068pgc.215.1529952639095;
        Mon, 25 Jun 2018 11:50:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z10-v6sm22099465pfh.83.2018.06.25.11.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:50:38 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:50:37 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 09/12] dt-bindings: PM / OPP: add opp-throttlers
 property
Message-ID: <20180625185037.GE129942@google.com>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-10-mka@chromium.org>
 <20180625153341.GB23270@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625153341.GB23270@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jun 25, 2018 at 09:33:41AM -0600, Rob Herring wrote:
> On Wed, Jun 20, 2018 at 06:52:34PM -0700, Matthias Kaehlcke wrote:
> > The optional opp-throttlers property is used to configure the throttlers
> > (see drivers/misc/throttler/*) that use a given OPP to throttle the
> > corresponding device(s).
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Changes in v4:
> > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > 
> > Changes in v3:
> > - none
> > 
> > Changes in v2:
> > - patch added to series
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> > index c396c4c0af92..747e79740c75 100644
> > --- a/Documentation/devicetree/bindings/opp/opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/opp.txt
> > @@ -170,6 +170,9 @@ Optional properties:
> >    functioning of the current device at the current OPP (where this property is
> >    present).
> >  
> > +- opp-throttlers: Array with phandles of throttlers that use this OPP to
> > +  throttle the corresponding device(s).
> > +
> 
> I think it would be better to make this a boolean for each OPP entry and 
> then add "operating-points-v2" property to the EC node to point to the 
> OPP table.

Thanks for your suggestion. "operating-points-v2" would have to be an
array of phandles, a single thottler can have multiple throttling
devices.

> Unless there is some need for a different throttler for each OPP entry?

Having the option to use different OPPs per throttler would be my
preference. E.g. there could be configurations where one throttler
only interacts with certain throttling devices and another one
with others.

I see another option to achieve this, if you don't like the reference
to the throttlers in the OPPs. The throttler could have a list of OPPs
(as phandles, not frequencies as in v1). The main inconvenient I see
here is that the used OPPs would need a label, which they usually
don't have. Maybe this is no soooo bad, since the label could be added
at device level, only on devices that use a throttler, so it wouldn't
clutter the platform .dts files.

This could be a single array with all OPPs from different devices,
or multiple arrays, one for each throttling device:

throttler-opps-0 = <&cpu0_opp_03 &cpu0_opp_05>;
throttler-opps-1 = <&gpu_opp_02 &gpu_opp_04>;

My preference would be multiple arrays, because it's easier to read.

What do you think?

Thanks

Matthias
