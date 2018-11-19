Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E0EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DEF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fjv2jY6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DEF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbeKTGHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:07:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeKTGHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:07:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so12660181pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=wfnIvkxIpRR6dWuUu0ytlpCQYqs+zzLc0iSp1We/lIE=;
        b=fjv2jY6oGKLcsVBJKey0/MnQS9hAEAKdAJOVtpJAUQNz5nTba3P/jyUjALaL07FDG4
         ADOUU11/Jq6l4pO5M3BTfDGJdyfcw60Vj41CWSfXat5Ze55iDUtsb+vKPcjfMx6SSnMp
         WKwhz0tQPMbDgrkRp46zpKa36WZLLrw5Yo7cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=wfnIvkxIpRR6dWuUu0ytlpCQYqs+zzLc0iSp1We/lIE=;
        b=Int5KquPK3VWTqHklHsPRTuP9ZUka0W9GlJhLKZt9g+J+odXFY5r6eC813nHTf4pfq
         QaArMbDEQSkmafkU7/tZMAMKdNl9NA4Q7UP6UYiy0reMwn+yIduJ6GUur+Bk+jx3Efnp
         WUlStPyznMiP7hBIKmtOlUp3EzOP7aeaMY5SijpnC4KEJm7bgitvuyoLZXy/sBkQ56+6
         x/lcqnI9cPlPlXCNmsqvMa+gArafVp/jUBl+EiDtBb/fTu1r+MMryi8egWgqg7z0fHfy
         oE/NFT45htmelNXHVLvOI0yT9HFGSpNzlVI/VSxijEwbSBOOzK2V2HpNMh2xp/r5TVL3
         Mj+g==
X-Gm-Message-State: AA+aEWYSMfutjdhz14jQoCddq9woSO7dUlrv3Lup2SxcbtgtLXf42IaE
        zn2VNB+GBHZhY10xEJ1QQB6Bmw==
X-Google-Smtp-Source: AJdET5c9pam42UN/k2enIpC8AH/LLgS3H7FbQZenxdms4KJ3VcOd5a90IzWsbHcG/JRGhLnVtuhKkw==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr1482683pgv.31.1542656531872;
        Mon, 19 Nov 2018 11:42:11 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id h10sm39385259pgn.11.2018.11.19.11.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 11:42:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=WYhM2eJFdcum3aE2YhhhP9s=OzR=oRA2NXU4PFJc7Z5A@mail.gmail.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, cang@codeaurora.org,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-5-evgreen@chromium.org>
 <154265514855.88331.12521366940818102477@swboyd.mtv.corp.google.com>
 <CAD=FV=WYhM2eJFdcum3aE2YhhhP9s=OzR=oRA2NXU4PFJc7Z5A@mail.gmail.com>
Message-ID: <154265653027.88331.11231439952253219107@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Mon, 19 Nov 2018 11:42:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-11-19 11:25:08)
> On Mon, Nov 19, 2018 at 11:19 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Evan Green (2018-10-26 10:35:43)
> >
> > > +};
> > > +
> > > +&ufsphy1 {
> > > +       status =3D "okay";
> > > +
> > > +       vdda-phy-supply =3D <&vdda_ufs1_core>;
> > > +       vdda-pll-supply =3D <&vdda_ufs1_1p2>;
> >
> > These two properties can be specified in the SoC dtsi file instead of
> > each board variant file. This way we don't have to specify the things
> > that are SoC independent in each board file. The board integrator just
> > has to attach the labels to the right regulator nodes, in this case
> > vdda_ufs1_core and vdda_ufs1_1p2, and then the sdm845.dtsi file will be
> > matched up with the right regulator automatically. It's also nice so
> > that board integrators don't have to know anything besides what
> > regulator goes to what pin on the SoC.
> =

> This is an interesting proposal and it feels like we have to consider
> the tradeoffs.
> =

> I agree that it would be nice not to have to specify this in every
> single board .dts file, but at the same time what if you've got a
> board that doesn't use UFS?  Such a board would bother adding the
> labels "vdda_ufs1_core" and "vdda_ufs1_1p2".  This would lead to a
> compile error in the device tree bindings.  That seems pretty
> undesirable.
> =


A workaround for this somewhat rare case would be to specify
/delete-property/ on those nodes that aren't used. Unless that can't
even work because the phandle is parsed before properties are deleted? I
haven't tried. Or we could try to have dtc ignore broken phandles in
status =3D "disabled" nodes or omit them entirely from the dtb so this
isn't a problem.

Either way, I would push for making it easier for the users of the SoC
to not need to know the SoC internal details too much and rely on the
SoC dtsi file to get it right. From the user perspective it's just a
bunch of pins connected to something. We could also have a 0 volt
"ground" regulator for any grounded/unconnected pins if that helps. It
could be marked as status =3D "disabled" so that no runtime code is used
while dtc is still happy to have the disabled node with a label.

