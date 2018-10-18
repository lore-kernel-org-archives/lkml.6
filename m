Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2564EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC40421473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mjFqUj2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC40421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeJRXjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:39:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33841 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbeJRXjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:39:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id j17-v6so28165085lja.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXrfVk16zNXEqijFqlsEMsOQlU7crDJ5P5ug1ROucUM=;
        b=mjFqUj2vDnm86NQaMjr2quDc/CblqcQqcEVIQ+TwDciXynfsmLIy9tGOAKjXjzJW1O
         Xd2RmcSz20lDINXkAjmlP9AoqlVgA3wqyWomTgJdKyMaOo25Fkxvdz3kttihf/4CITlc
         ORzjBzrr/PUSK6xnH0rRO5lnfQIlEKqFYaOc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXrfVk16zNXEqijFqlsEMsOQlU7crDJ5P5ug1ROucUM=;
        b=cLN+l8Gn6xfnlldoplqR3fn8v50hYcUpB4bosR7UH/U0dDrJs+hQwvKjCft1Ht1R8e
         vdWxlkTbMGLuA06bRwtof7EWJ7xdsqn7Hc2bCQozB+4XLAzaqmZAUksG6P/YBbVbo/H9
         Cay+EDXoMS4vyWY08+RpSO+gx6jseudg2X0vOF3H3corNt0qC9JTX/rvU4sp7551GuEg
         jovDHO3Z/ajDPkCYLnnajKLFg1z1q6dUAlulS8i/9d0Y4WiKFIoPppq3zgzFGV5fttt/
         9N+N/jzepT3W2/pU5O2C33qSjRRlbBggIn4n0WYFAammVxHs7WbNCXy1ezUN0s6RJhCu
         mYpw==
X-Gm-Message-State: ABuFfoi5fpPkxPu0IpUcVdmDLDdHjfgecfzrEOxKvRvs+Vki62qOF6xv
        dz5lMgbDAAbIhbUg3Nf8NGy/gstHQ+0=
X-Google-Smtp-Source: ACcGV61NZsHOQGX20YkhshuPFYn6CgyVSdU4kqgGaLl+USlOHtH0XMPIB6FpSE9S79ebG+BQMLPytA==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr17587910ljh.38.1539877098340;
        Thu, 18 Oct 2018 08:38:18 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n3-v6sm4424232lfe.8.2018.10.18.08.38.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 08:38:15 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id p89-v6so28161918ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 08:38:15 -0700 (PDT)
X-Received: by 2002:a2e:7c18:: with SMTP id x24-v6mr2062724ljc.174.1539877095144;
 Thu, 18 Oct 2018 08:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181017172312.194281-1-evgreen@chromium.org> <20181017172312.194281-2-evgreen@chromium.org>
 <CAFp+6iHRECKosJWQZoaZa6QxAmW0MZLNPsFAbD21vW+kG0xJ-A@mail.gmail.com>
In-Reply-To: <CAFp+6iHRECKosJWQZoaZa6QxAmW0MZLNPsFAbD21vW+kG0xJ-A@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 18 Oct 2018 08:37:37 -0700
X-Gmail-Original-Message-ID: <CAE=gft79oeGdTLsRiTgP_eSoCD452sfPLQEvFsOMKE+k2z=h=A@mail.gmail.com>
Message-ID: <CAE=gft79oeGdTLsRiTgP_eSoCD452sfPLQEvFsOMKE+k2z=h=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: add UFS controller
To:     vivek.gautam@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:33 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Evan,
>
> On Wed, Oct 17, 2018 at 10:55 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > This change adds the UFS controller and PHY to SDM845.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 66 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index b72bdb0a31a5..20b2c258816a 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -808,6 +808,72 @@
> >                         };
> >                 };
> >
> > +               ufshc1: ufshc@1d84000 {
> > +                       compatible = "qcom,sdm845-ufshc", "qcom,ufshc",
> > +                                    "jedec,ufs-2.0";
> > +                       reg = <0x1d84000 0x2500>;
> > +                       interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > +                       phys = <&ufsphy1_lanes>;
> > +                       phy-names = "ufsphy";
> > +                       lanes-per-direction = <2>;
> > +                       power-domains = <&gcc UFS_PHY_GDSC>;
> > +
> > +                       clock-names =
> > +                               "core_clk",
> > +                               "bus_aggr_clk",
> > +                               "iface_clk",
> > +                               "core_clk_unipro",
> > +                               "ref_clk",
> > +                               "tx_lane0_sync_clk",
> > +                               "rx_lane0_sync_clk",
> > +                               "rx_lane1_sync_clk";
> > +                       clocks =
> > +                               <&gcc GCC_UFS_PHY_AXI_CLK>,
> > +                               <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> > +                               <&gcc GCC_UFS_PHY_AHB_CLK>,
> > +                               <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> > +                               <&rpmhcc RPMH_CXO_CLK>,
> > +                               <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> > +                               <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> > +                               <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> > +                       freq-table-hz =
> > +                               <50000000 200000000>,
> > +                               <0 0>,
> > +                               <0 0>,
> > +                               <37500000 150000000>,
> > +                               <0 0>,
> > +                               <0 0>,
> > +                               <0 0>,
> > +                               <0 0>;
> > +
> > +                       resets = <&gcc GCC_UFS_PHY_BCR>;
> > +                       reset-names = "rst";
> > +
> > +                       status = "disabled";
> > +               };
> > +
> > +               ufsphy1: ufsphy@1d87000 {
>
> nit: s/ufsphy@1d87000/phy@1d87000

Ok, will change.

>
> > +                       compatible = "qcom,sdm845-qmp-ufs-phy";
> > +                       reg = <0x1d87000 0x18c>;
> > +                       #clock-cells = <1>;
>
> why do we need this clock-cells? ufsphy i think is not providing any
> clocks. Is it?

Right. USB provides the pipe clock, but you're right, UFS doesn't
provide any clocks, so I'll remove.

> Rest looks good.
>
> Best regards
> Vivek
>
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       ranges;
> > +                       clock-names = "ref",
> > +                                     "ref_aux";
> > +                       clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> > +                                <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> > +
> > +                       status = "disabled";
> > +
> > +                       ufsphy1_lanes: lanes@1d87400 {
> > +                               reg = <0x1d87400 0x108>,
> > +                                     <0x1d87600 0x1e0>,
> > +                                     <0x1d87c00 0x1dc>;

Doug, Stephen and I were looking more at the PHY driver and realized
it overreaches its registers here by adding 0x400 to get at the second
lane. We found this unappealing. Our current thinking is to add two
more reg regions here and fix up the binding, so that tx2 and rx2 are
properly specified. I'll try to come up with that patch today and
resend along with this.

-Evan
