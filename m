Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4410C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB0B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLBEjgbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB0B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbeKOIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeKOIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:48:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so8014656pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDSNJFY8Zp0hTmNXEj1+V5KLRIdXjNpgce8IuFPtqKA=;
        b=fLBEjgbnp/x/vhcqBG71UAO2WvmDe03IVrWMQK3w95N+CcVg9bio18Oxcbcde3G21w
         dJJENrqBzxgQimt8tP+tQAu5gBh3JA8bGCX9jGcZzCCpiAV64RcaE2LK0XQJWY9f4vdu
         ZfL3VYhla/V62PDzI7XpvvkJ6oTN/3hT4HS2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDSNJFY8Zp0hTmNXEj1+V5KLRIdXjNpgce8IuFPtqKA=;
        b=GSfZ3aTs3KLu1f2t0wZClc8EdRHtN7HZacN335HPcjcUtTku4tsocrahHANGGoiYun
         tRenzMrMU8Y9/EOyh4XCBo0+Au90wyfZRbuaCjTPGiRHvjaOfbYKqa60rfopUxDK4OP9
         Rk6RQhr06BC+abuxNuz04oBL+bLMIj88AmrJuXWk8G5nIbQLiFt2cBh3+jLILANi0GHD
         OqqqbN0w9SYb7foAfJrj/LBuLcxEnF1swB+HJhQnA9msNEwvSCI/jLQJOj5Pv6jILIfv
         tz/zAhKtSDDpsOkrsox5vXg/KE48yI1WF6kJSXADwPjAs8E8FCMR6dWCLnnUcmquiEOw
         p2LA==
X-Gm-Message-State: AGRZ1gIn3o2FZ+F1PUxSyo039wDnwktxpa1WIgRcGr78qrOlmo8sHi1B
        0fZC+T+sxP+mz826bL6D5eg8Og==
X-Google-Smtp-Source: AJdET5cVhMzB4zPsNBn6fAe4rOon2fG/457gJglzbNp0aYfmM8qIWirmpjiM9T7l2cB2ilgZXs2d1A==
X-Received: by 2002:a63:4384:: with SMTP id q126mr3500904pga.160.1542235374082;
        Wed, 14 Nov 2018 14:42:54 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v12-v6sm31881889pfa.167.2018.11.14.14.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 14:42:53 -0800 (PST)
Date:   Wed, 14 Nov 2018 14:42:52 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: msm/dsi: Add ref clock for 10nm PHY
Message-ID: <20181114224252.GM22824@google.com>
References: <20181102214534.184593-1-mka@chromium.org>
 <154154578082.88331.1035410665298962611@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154154578082.88331.1035410665298962611@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:09:40PM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-11-02 14:45:33)
> > Allow the 10nm PHY driver to get the ref clock from the DT.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/display/msm/dsi.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > index dfc743219bd88..d0d2046ceff69 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > @@ -105,6 +105,10 @@ Required properties:
> >  - power-domains: Should be <&mmcc MDSS_GDSC>.
> >  - clocks: Phandles to device clocks. See [1] for details on clock bindings.
> >  - clock-names: the following clocks are required:
> > +  For 10nm PHY:
> > +  * "iface"
> > +  * "ref"
> > +  For other PHYs:
> >    * "iface"
> 
> Any reason we can't go back and do this for other phys too? They're all
> the same with regards to this reference clk input.

To avoid breaking existing users, at least the 28nm PHY is used by
msm8916. Also I don't have the hardware to test changes for other
PHYs.

Cheers

Matthias
