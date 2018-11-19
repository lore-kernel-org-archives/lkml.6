Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8587C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B310F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gxTG59YD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B310F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbeKTFu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:50:26 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39222 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKTFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:50:25 -0500
Received: by mail-ua1-f68.google.com with SMTP id k10so11105587ual.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfqOfUdxFZuxYLSh8LFoP7TkfeUuo24/KavyLESKG1Q=;
        b=gxTG59YDg7mouRSOT4hDJHwYaFSPbc3OxYiWzpXCoPJ1H+LtQlNoBYINMV6i938qlE
         pHYGyc39mzEhBvJf6qLarkMyOPOVN+1qsk8Yas4VjulQMq/nSMIfeMww4bA3gwi/Jzfu
         OAJhqnC55yaGFf9jc37ejA3yXy0HSAuodK8iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfqOfUdxFZuxYLSh8LFoP7TkfeUuo24/KavyLESKG1Q=;
        b=Ma87F7urBVJoFi7VUSRKoL+gOOLJUI2zq1YO6TNmuRUTXYFB71NvLvEtdk7YxgpRVS
         bdBEteOXtmNPe2/+dZWPF53wMI6DJQ9ZFx1lGBiIYJfEcBz+eTKRpHIx1epjKXNzvLXB
         SpbDYhFwwLG2GKVhb41ZjKRmPx1bNqLUru0VB0818wgraUA4OLXoS7ebOa1W4u8pvoWf
         oLfjVJTcQwRGcf34BbHSmcJDEXPgnP2CKs4B1NuxQiBUS8egVsox3Dl6gQB0nupGRYyn
         1PbrxOCedQTGHGfSkW6+BTXtxzi5IZ8bK4IXxI2dN/4M3Z7EYoKMfNNgTqEYPoHnFgpQ
         DCyw==
X-Gm-Message-State: AGRZ1gKr26S+V9o1zNxUEQ/QtirQA9jcSc8xKmrW7PECA65uoZC+BQT4
        HQJY4KBH61TVlMH2FaYZ3jQeIqTpN8Q=
X-Google-Smtp-Source: AJdET5fE21mXn55mM5T61rW0wqIg/XvaPHfqtJxj/TBYdZ68z/pibUQ/49KmJDpzo7u66lIzpAb4MQ==
X-Received: by 2002:ab0:5590:: with SMTP id v16mr9860553uaa.132.1542655522177;
        Mon, 19 Nov 2018 11:25:22 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id m79sm11342728vka.22.2018.11.19.11.25.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 11:25:20 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id z23so10888614uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:25:20 -0800 (PST)
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr7360810uaj.126.1542655520322;
 Mon, 19 Nov 2018 11:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20181026173544.136037-1-evgreen@chromium.org> <20181026173544.136037-5-evgreen@chromium.org>
 <154265514855.88331.12521366940818102477@swboyd.mtv.corp.google.com>
In-Reply-To: <154265514855.88331.12521366940818102477@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Nov 2018 11:25:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYhM2eJFdcum3aE2YhhhP9s=OzR=oRA2NXU4PFJc7Z5A@mail.gmail.com>
Message-ID: <CAD=FV=WYhM2eJFdcum3aE2YhhhP9s=OzR=oRA2NXU4PFJc7Z5A@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
To:     Stephen Boyd <swboyd@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 19, 2018 at 11:19 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Evan Green (2018-10-26 10:35:43)
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > index eedfaf8922e2..d5fddea71a85 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > @@ -356,6 +356,20 @@
> >         status = "okay";
> >  };
> >
> > +&ufshc1 {
> > +       status = "okay";
> > +
> > +       vcc-supply = <&vreg_l20a_2p95>;
> > +       vcc-max-microamp = <600000>;
>
> Is this board dependent? I would guess this is SoC specific and not
> board specific.
>
> > +};
> > +
> > +&ufsphy1 {
> > +       status = "okay";
> > +
> > +       vdda-phy-supply = <&vdda_ufs1_core>;
> > +       vdda-pll-supply = <&vdda_ufs1_1p2>;
>
> These two properties can be specified in the SoC dtsi file instead of
> each board variant file. This way we don't have to specify the things
> that are SoC independent in each board file. The board integrator just
> has to attach the labels to the right regulator nodes, in this case
> vdda_ufs1_core and vdda_ufs1_1p2, and then the sdm845.dtsi file will be
> matched up with the right regulator automatically. It's also nice so
> that board integrators don't have to know anything besides what
> regulator goes to what pin on the SoC.

This is an interesting proposal and it feels like we have to consider
the tradeoffs.

I agree that it would be nice not to have to specify this in every
single board .dts file, but at the same time what if you've got a
board that doesn't use UFS?  Such a board would bother adding the
labels "vdda_ufs1_core" and "vdda_ufs1_1p2".  This would lead to a
compile error in the device tree bindings.  That seems pretty
undesirable.

+Bjorn since I think Bjorn wasn't a huge fan of the labels like
"vdda_ufs1_core" to start with.


-Doug
