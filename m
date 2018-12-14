Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B58C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DFF20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1o8gAFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DFF20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeLNEwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:52:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46773 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeLNEwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:52:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so2202449pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 20:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHs3+jMqcXv7Y9PmgiBMwaoiJJF+xI2UheDha2MJ/IQ=;
        b=S1o8gAFlmqv7f703J4MZEzBG9GqAH+QVTVTFigaK8pgCOn1iBbB1tpB/FhvBa85INK
         LWKkM4m1I/qhBNnJCKhScx1n18G906CGVL23V1FIu/u0qhYjRyIwnYmUWPxsqiBlstzx
         616CDCATb8/8nFdOTqpSVJAzEh76vUm+3Xl5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHs3+jMqcXv7Y9PmgiBMwaoiJJF+xI2UheDha2MJ/IQ=;
        b=ucXpJI58R4Af7ezmOaVzqcDk6sUShNREEUE/d3Xg7Wy3Tc2cWpOKdIpveDPOU2dpDM
         NwV8YgbCwFIlZtEU1IyuGsZIyoppxnk6qwivctR8XEYiGpTTOzaSHrGT0bQWUysXKAiJ
         f5KW1ecxBAu394cF/qpFh5n0UOIImLQw0DxRKamC+su+NhD9KEOYJyuav4AK7Z5mXpb1
         1OuzEk8xMEViEoVUh4Gka8+39tnpYlLWaP3aR1QkSjYuiT1xuGtMITu/blOU3uyMvLJ/
         8rdSW4NBdBpOUjtlR3J9XN3Z3V1Q+9lcXiFxlmcw2dUTnJH+EVpEpLQkZGTj/pHBPOHT
         8eTQ==
X-Gm-Message-State: AA+aEWYhT9sLBtSRdbegoh5snKjHpcUHapzl5eUXqenltEScQDtq/ReF
        w2hO9SX9N4xoWRbKPLCg+4ICfQ==
X-Google-Smtp-Source: AFSGD/XRwZw6eeOFG5Wb3EdkLs/lZ4qhWXbmfqTFG2SlSc1bHk5aJlcuaVJKa7EaLjSGf6MyXphvNA==
X-Received: by 2002:a63:585c:: with SMTP id i28mr1495216pgm.178.1544763141579;
        Thu, 13 Dec 2018 20:52:21 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j185sm3906150pge.72.2018.12.13.20.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 20:52:20 -0800 (PST)
Date:   Thu, 13 Dec 2018 20:52:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     sibis@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Message-ID: <20181214045218.GJ1578@tuxbook-pro>
References: <20181127085828.17908-1-sibis@codeaurora.org>
 <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Dec 14:17 PST 2018, Doug Anderson wrote:
> On Tue, Nov 27, 2018 at 12:58 AM Sibi Sankar <sibis@codeaurora.org> wrote:
[..]
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 58870273dbc9..df16ee464872 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1095,6 +1095,69 @@
> >                         };
> >                 };
> >
> > +               remoteproc@4080000 {
> > +                       compatible = "qcom,sdm845-mss-pil";
> > +                       reg = <0x04080000 0x408>, <0x04180000 0x48>;
> 
> s/0x04080000/0x4080000 to appease the DT folks.
> 

Andy requests this to be padded to 8 digits, and I've come to really
appreciate this as it makes sorting much easier.

But perhaps there's a verdict on this?

Regards,
Bjorn
