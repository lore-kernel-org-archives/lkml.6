Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA6C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6353220854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PVt8PbLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfAVSOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:14:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45307 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:14:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so21447416ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm7EySKtcW0vc0v5ouaoa1srnOUbcsVIKJbJS15qy3k=;
        b=PVt8PbLQcTHGuat/x2woRKupR8GJtTa80TKinuBsAt/Gl37BwoKGieTHm2ODh+TB0j
         hWR17ER/x3flA5KaCFsiYKSnxreE9RifO6OYREEPBYedLHe/H0xZ3p8vyZWfA2RV4Jnz
         t+t0TdlwXmV4tx8ZaiT6BVCejCKqnNaZtc7AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm7EySKtcW0vc0v5ouaoa1srnOUbcsVIKJbJS15qy3k=;
        b=QnRXR/dkCIYuGc9nrIhZ0YkfpUCzAJP8RkaTIe5c/U+P7nFn7F1hM6pp2exkMlINSI
         WgtqGExyfVTdIVccm+KEqdBGwlyGt8iBloxPJ4A5AFHUYwUy3wgvOBvcLBEd3KwJpvZT
         uWolbOILImln+6aMEFcMjDaeO3bc5nnLHXx6deorm7ZPMqIb+qdcpyKdwBfOfGyj0qnN
         M02AivWrxYC/b3TnbIjU23e9FjyKgYINDkFbwG1gOJmVhEVvw/NL42eA6VKMRgYiiClj
         MTf/8Vme7ddxM2/4/+kb17zavllIZAVWkRKLCM0mz9wEyhXNT+ubo0Ry+Sz8vxeUpA2W
         N2kw==
X-Gm-Message-State: AJcUukfb/j5A+z3iREgjk4qt9BFu7Hrnhdu1LePXeWbyEVHCiIMhZhbw
        VWo8UJJ9Fdfai6MxRUuinvOp3t4CAaA=
X-Google-Smtp-Source: ALg8bN4bIZuQbt5kR883YRpa37ur2T+gvxG+Yzr1jCuM/JLZVK9XBEtEU2EqPPZtVJz7Op56p9P+Zg==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr21559405ljc.172.1548180863025;
        Tue, 22 Jan 2019 10:14:23 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id p89-v6sm114870ljp.60.2019.01.22.10.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:14:22 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id c19-v6so21498368lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:14:21 -0800 (PST)
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr9312342ljc.97.1548180861093;
 Tue, 22 Jan 2019 10:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-4-evgreen@chromium.org>
 <20190122002549.GA20481@bogus>
In-Reply-To: <20190122002549.GA20481@bogus>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 10:13:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft6=WdPyA6WF_3oSNGYPEhqjGVB7Cpwybr0kzp+9ys821Q@mail.gmail.com>
Message-ID: <CAE=gft6=WdPyA6WF_3oSNGYPEhqjGVB7Cpwybr0kzp+9ys821Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] arm64: dts: sdm845: Add UFS PHY reset
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:25 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 11, 2019 at 03:01:24PM -0800, Evan Green wrote:
> > Wire up the reset controller in the Qcom UFS controller for the PHY.
> > This will be used to toggle PHY reset during initialization of the PHY.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > This commit is based atop the series at [1]. Patches 1 and 2 of that
> > series have landed, but 3, 4, and 5 are still outstanding.
> >
> > [1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index b29332b265d9e..029ab66405cf4 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -990,6 +990,7 @@
> >                       phy-names = "ufsphy";
> >                       lanes-per-direction = <2>;
> >                       power-domains = <&gcc UFS_PHY_GDSC>;
> > +                     #reset-cells = <1>;
>
> Is this documented?
>

No, I'll add this in my next spin. Thanks.
-Evan
