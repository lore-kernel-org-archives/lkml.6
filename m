Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7C422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VjQKofxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7C422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeKOJiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:38:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46551 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeKOJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:38:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so8669906pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=fGvsWsW6Kteq77ULrkAXfs6/LGYRAaA9EZJgq26lBOY=;
        b=VjQKofxbQumMAuf8vSgUk9E3mqzipRHrWqyugGGc1zpbMVSv3Esm1yH3CgrvxEDmLS
         +mpHkcCnrweqnw0vL3MUum0uYKUX60RbDBF1Oyn0yCLz5hTibQa88JZ6H39W27b/simo
         XxRqXjjtMBOl+h/xUhT28laiM/xRxKCboj9hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=fGvsWsW6Kteq77ULrkAXfs6/LGYRAaA9EZJgq26lBOY=;
        b=eg3RLUsuqHxF331lRX5GFHFlvsx0iiyRf+Za1DFJL2menKxTDo/p6xbmMGPeGQEzCc
         q82wlPgf5TW/72J2OlOr7738rmiJv0uDOI0fqVF6mEXPCF5MorLYVK2RVrwGbOcDa7YM
         b6SXCKrOmxnaf+kydBNoIuuDCa3EF5eW+41vZ+YcjqNLRZCqza4b0wnUtkB5P5v0d8BR
         wAiFEwsMCBZz8t8R6ETlJnuFdi67BbVfWFwJOKwJNPmqnN2i73EMGOLWYYFiNizt3R8j
         gLa/KcoxFeLbMdipcBAft/vgVaWn8fo/R7MDLXLtjejpJlu0mOfi18ToB4LDDxjhT4gk
         TKJQ==
X-Gm-Message-State: AGRZ1gILqC/PWTlJV1Bf0ytvR/XxntDyFWRR3k6AKaUntEbqCQQQ9XXI
        MRSqMLadOtpaSW4bMy8OGfH4wg==
X-Google-Smtp-Source: AJdET5dQx4k8XlJxIA3CacGqsO7YWgl+HC5YzOKs43f4LkkcwD97Ft35aj+CirsAQsxjorSpbgu2DA==
X-Received: by 2002:a63:2a4a:: with SMTP id q71mr3618614pgq.374.1542238357329;
        Wed, 14 Nov 2018 15:32:37 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id k14sm26488428pgs.52.2018.11.14.15.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 15:32:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Kaehlcke <mka@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181114224252.GM22824@google.com>
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
References: <20181102214534.184593-1-mka@chromium.org>
 <154154578082.88331.1035410665298962611@swboyd.mtv.corp.google.com>
 <20181114224252.GM22824@google.com>
Message-ID: <154223835618.88331.10714694524244533922@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: msm/dsi: Add ref clock for 10nm PHY
Date:   Wed, 14 Nov 2018 15:32:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-14 14:42:52)
> On Tue, Nov 06, 2018 at 03:09:40PM -0800, Stephen Boyd wrote:
> > Quoting Matthias Kaehlcke (2018-11-02 14:45:33)
> > > Allow the 10nm PHY driver to get the ref clock from the DT.
> > > =

> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >  Documentation/devicetree/bindings/display/msm/dsi.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > =

> > > diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/=
Documentation/devicetree/bindings/display/msm/dsi.txt
> > > index dfc743219bd88..d0d2046ceff69 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> > > +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> > > @@ -105,6 +105,10 @@ Required properties:
> > >  - power-domains: Should be <&mmcc MDSS_GDSC>.
> > >  - clocks: Phandles to device clocks. See [1] for details on clock bi=
ndings.
> > >  - clock-names: the following clocks are required:
> > > +  For 10nm PHY:
> > > +  * "iface"
> > > +  * "ref"
> > > +  For other PHYs:
> > >    * "iface"
> > =

> > Any reason we can't go back and do this for other phys too? They're all
> > the same with regards to this reference clk input.
> =

> To avoid breaking existing users, at least the 28nm PHY is used by
> msm8916. Also I don't have the hardware to test changes for other
> PHYs.
> =


Hmmm I don't see why we need to worry about breaking "legacy" users. If
they're using an undocumented but still working method of doing
something that should be OK, but I'd like to see us update the DTS and
binding to be more forward looking so that future designs don't carry
forward badness. And not having hardware hasn't really been a problem in
the past either. We can probably have someone from Linaro test on any
affected platforms.

