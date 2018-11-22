Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F39C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E1320864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9UdEhfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E1320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404869AbeKVRmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:42:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33340 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404856AbeKVRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:42:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so8822914plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytw0fZ8VMpQrXGXgWwgJbATdHns5ad1rjiijgPOBw0k=;
        b=a9UdEhfQqywQEyABtcGxIj66ZL+1CAMEIK2n5YklBsxIhHat2VfrEc15xorv8/xDIH
         Z+tUdKN+ouTKZVivR6rsKmB+4jXIy1so5APkt0GCgw69RBbBECucazf8YlBgld56geIk
         /AIfxPbkTPV8GZmvnFadK7ElvFUxzh1ROHJzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytw0fZ8VMpQrXGXgWwgJbATdHns5ad1rjiijgPOBw0k=;
        b=jkiOlXbn2PSLtGL8nEslgu2Mfq9JUOQG7ynl7kiovjzzg6o1HqU7N/GV9Lr5Bt9dfr
         HN55VWG+Ad5lwl5eCefAv+A8b7E6RTPSo2Giqp+3cHKCiz9Lvwok7JaKsdHtUd0lwJWf
         mxhiCLim6qIk3znPZ48pfihkyA9sCwjFXZ+ePOJkJgwNKFoVTLy2zfduPcMwvefjj9gR
         0jnXET0DI+hWpGkRgiM/OnZ9DNz8F/BVo/WR+KsqJxbft7Rk+Dz9A8yix6e0Txt23RMY
         pCrw3YBdi+/oGhqvHH3hjixmqaxI0kpryqP8NoY3FbTlS93MCLW+rM2MjHAHaUmSzFvn
         SdZA==
X-Gm-Message-State: AA+aEWZ5DcZStoP7OZ1kr+KO72/jUulwWVrhRgyXciLKb+N4HDLvwxL0
        IFS+OQZ+H7QoRlhIkMG5E5SBnQ==
X-Google-Smtp-Source: AFSGD/XCggRZF6ZOzTpnjNaJVKXcI1inyJIqhU2Q27jbuAhXk8ZKqimi6fCzVb4EKqdDD0ni+n9SIw==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr10108962pll.341.1542870255657;
        Wed, 21 Nov 2018 23:04:15 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i193sm61014228pgc.22.2018.11.21.23.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:04:14 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:04:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, cang@codeaurora.org,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for
 sdm845-mtp
Message-ID: <20181122070412.GJ2225@minitux>
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-5-evgreen@chromium.org>
 <154265514855.88331.12521366940818102477@swboyd.mtv.corp.google.com>
 <CAD=FV=WYhM2eJFdcum3aE2YhhhP9s=OzR=oRA2NXU4PFJc7Z5A@mail.gmail.com>
 <154265653027.88331.11231439952253219107@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154265653027.88331.11231439952253219107@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19 Nov 11:42 PST 2018, Stephen Boyd wrote:

> Quoting Doug Anderson (2018-11-19 11:25:08)
> > On Mon, Nov 19, 2018 at 11:19 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Evan Green (2018-10-26 10:35:43)
> > >
> > > > +};
> > > > +
> > > > +&ufsphy1 {
> > > > +       status = "okay";
> > > > +
> > > > +       vdda-phy-supply = <&vdda_ufs1_core>;
> > > > +       vdda-pll-supply = <&vdda_ufs1_1p2>;
> > >
> > > These two properties can be specified in the SoC dtsi file instead of
> > > each board variant file. This way we don't have to specify the things
> > > that are SoC independent in each board file. The board integrator just
> > > has to attach the labels to the right regulator nodes, in this case
> > > vdda_ufs1_core and vdda_ufs1_1p2, and then the sdm845.dtsi file will be
> > > matched up with the right regulator automatically. It's also nice so
> > > that board integrators don't have to know anything besides what
> > > regulator goes to what pin on the SoC.
> > 
> > This is an interesting proposal and it feels like we have to consider
> > the tradeoffs.
> > 
> > I agree that it would be nice not to have to specify this in every
> > single board .dts file, but at the same time what if you've got a
> > board that doesn't use UFS?  Such a board would bother adding the
> > labels "vdda_ufs1_core" and "vdda_ufs1_1p2".  This would lead to a
> > compile error in the device tree bindings.  That seems pretty
> > undesirable.
> > 
> 
> A workaround for this somewhat rare case would be to specify
> /delete-property/ on those nodes that aren't used. Unless that can't
> even work because the phandle is parsed before properties are deleted? I
> haven't tried. Or we could try to have dtc ignore broken phandles in
> status = "disabled" nodes or omit them entirely from the dtb so this
> isn't a problem.
> 
> Either way, I would push for making it easier for the users of the SoC
> to not need to know the SoC internal details too much and rely on the
> SoC dtsi file to get it right. From the user perspective it's just a
> bunch of pins connected to something. We could also have a 0 volt
> "ground" regulator for any grounded/unconnected pins if that helps. It
> could be marked as status = "disabled" so that no runtime code is used
> while dtc is still happy to have the disabled node with a label.
> 

I dislike the use of the labels "vdda_ufs1_core" as that doesn't tell me
which regulator this is actually wired to, without having to jump around
in the board dts file. It's annoying, but it's pretty much write-once so
it's not a big issue.

But I really don't like the idea of having sdm845.dtsi depend on labels
specified in the board dtsi. This just means that in order to add a new
board I need to figure out the information and the way to specify it is
to change a label in the board file.


The static configuration here is that vdda-phy-supply is connected to
the vdda_ufs1_core pin on the SoC, which is connected to some board
specific regulator.  If anything I think we should model that
intermediate entity, in which case we could move the link between the
phy and the pin to the platform dtsi.


But I'm fine with us just merging Evan's patch as is.

Regards,
Bjorn
