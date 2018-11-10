Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3676C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BA820858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CkSTL1ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BA820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeKJKg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:36:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42036 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeKJKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:36:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so1659696plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=2ZPVavSvc+rE/Af+1J4sVWaUj6tJVEBqKkg1NHqwjSw=;
        b=CkSTL1ub40u6gCO3EqNcbcEXu7TXCatrZ0+VRnGxtGHYVkLhy5w1s2wreOfFl1G3EU
         Q41mqVCiAg6tn5sF/183siB2VSpiCuymN5pk0eyc+xYQw8CT/aaxqF30BJv2uoMrgV03
         EY2QIMlzK3aq/Kk5jIFn9v+0vzRF1m1Mtx4+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=2ZPVavSvc+rE/Af+1J4sVWaUj6tJVEBqKkg1NHqwjSw=;
        b=f0UPADH15g1L901/0eV2VmE6qA/kHEEzNK22U5yCMB2K3o5bUUQVPrEmGbew7niNPE
         3E+6o4PjU9rJmvznEZ3gw1LgdL6QfBttU6RNP+WUdfOVr4p0ZyFSjv/7OA43G4o7qcMd
         MSO2jhziALislpXLgainMuFzLJrYo1N5AoPAGlua3lL2aB11tl1sIjtpCeM/Lw8Dalfo
         SkLwDDmspI7KMXICpza+tg5qlIlHgwvtjC3s/mM6H8IkGMMMD/HG/+rvHAbrBeWjTpWX
         xhNjKZE6rbojT9x73Z8Rhrm//97NgBiwyAoIrEvIemkOb0VLQOljcdprVaxXWKhvqH0J
         REeg==
X-Gm-Message-State: AGRZ1gKGZjuby/RvpQcvZBx2S2k9yKP7m5SFrr/h+oQBTnNieFZ782gS
        py4XplIFYEhm1PTA/UU71gzX9g==
X-Google-Smtp-Source: AJdET5d18NWYydWDFOLBAnbIIqXN9aegpyIyoajs5dpwDSwULqtyWG/4vN1Q5oekgkqU0b2iRZgRhw==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4-v6mr11143834pls.13.1541811200154;
        Fri, 09 Nov 2018 16:53:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id p2sm7495302pgc.94.2018.11.09.16.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 16:53:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=UKfDsthT4W3H4jR0Qvw-izLShCjWngN2uBrY-FUEtDDQ@mail.gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        cang@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-2-evgreen@chromium.org>
 <154129921872.88331.15831802252403117971@swboyd.mtv.corp.google.com>
 <CAD=FV=UKfDsthT4W3H4jR0Qvw-izLShCjWngN2uBrY-FUEtDDQ@mail.gmail.com>
Message-ID: <154181119838.88331.10401425771645606506@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
Date:   Fri, 09 Nov 2018 16:53:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-11-05 08:52:39)
> On Sat, Nov 3, 2018 at 7:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > +                       clocks =3D <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> > > +                       clock-names =3D "pipe0";
> > > +                       clock-output-names =3D "usb3_uni_phy_pipe_clk=
_src";
> >
> > If this has clock-output-names then I would expect to see a #clock-cells
> > property, but that isn't here in this node. Are we relying on the same
> > property in the parent node?
> =

> If I had to guess, I believe it's yet more confusing than that.  I
> believe you actually point to the parent phandle if you want to use
> the clock.  I notice that the parent has #clock-cells as 1 so
> presumably this is how you point to one child or the other?  ...but I
> don't think it's documented how this works.

There are 'clock-ranges', that almost nobody uses. It might be usable
for this purpose.

> The lane nodes don't have
> any sort of ID as far as I can tell.  ...and in any case having
> #clock-cells of 1 makes no sense for USB 3 PHYs which are supposed to
> only have one child?
> =

> Let's look at the code, maybe?  Hrm, phy_pipe_clk_register() takes no
> ID or anything.  Huh?  OK, so as far as I can tell
> of_clk_add_provider() is never called on this clock...
> =

> So I think the answer is that #clock-cells should be <0> and should
> move to the child node to match with clock-output-names.  Then I guess
> (if anyone references this clock from the device tree rather than
> relying on the global clock-output-names) we should add the
> of_clk_add_provider() into the code?
> =

> Maybe we can add that as a patch to the end of this series?  There are
> so many crazy / random things wrong with these bindings that it makes
> sense to make smaller / incremental changes?
> =


Sure that sounds fine. It would be another case where a driver would
want to call the proposed devm_of_clk_add_parent_provider() API.

