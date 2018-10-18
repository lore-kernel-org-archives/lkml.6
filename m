Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54954C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0270C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="djr40ZuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0270C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeJSH47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:56:59 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33434 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:56:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id e206so24274333vsd.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bi3GIi6WZ/6zMjDSYyR8izGsXU5CKVn1b9rsYYPXPeI=;
        b=djr40ZuEN+8MvbhYYX5DGiCWT43X3IuSLvXTnYtMD6SDWICmdzpEyYvIMpRhdjdgGm
         GSSdQMzc0rPL5wyyaxT3zGAS71s1xG/idip6XyXIECL5EVnqH1vy2vxPLloqvOwi2rVP
         KHmk5/vwCTqcY8Xsj78Asmb2Co04znxvzdOQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bi3GIi6WZ/6zMjDSYyR8izGsXU5CKVn1b9rsYYPXPeI=;
        b=bvjuv+WsZiiFI/WL2qsuTV3l9g9Nq1Q9CTq5EyKaJyzgLOALMtIxKsGygyPRreH7d4
         EpVWFAJMmB0Km8cP4/h5jp1lsUuIMyu3dGme/CXxP7olzmPsbwjewqIYvISlatj9Kgwg
         GKX6OWftUesgXd/7GTdM1rd+KnTzZrH9EEwmHlzbRmsNO9J9bS33c0YloHjPyo3+UVDD
         A3N0juLNsVAtxBFGzc6QFPGLg1vS8/I3TwXk4XttKGeiNat2FaKPn2wUnBNHuoygiO+p
         LiM/Wi1oEVnzpLjm7htBWqnXMxlmGj1b2/qIT/PcUPx3vVsBAz5SchZy9FAxiWl9UNyx
         GNwg==
X-Gm-Message-State: ABuFfoiDBTFDOKaCfyjUorM6pZptNU6ht3nH4XilTg4TuoS+Yl/4NnMz
        QIFkgejj60nwaCrNmMxtIi2ngnXDUyk=
X-Google-Smtp-Source: ACcGV60aBwdbNomcgi+QBQUxthI+TFTzmPk4untovexOJQWUdhNL9wTTnH3vkEGbvzZ7Fyh2A5iyMQ==
X-Received: by 2002:a67:ce17:: with SMTP id s23mr13523125vsl.78.1539906816744;
        Thu, 18 Oct 2018 16:53:36 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id c83sm4718267vsa.28.2018.10.18.16.53.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:53:35 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id d141so4654112vke.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:53:35 -0700 (PDT)
X-Received: by 2002:a1f:310c:: with SMTP id x12mr9576764vkx.79.1539906815231;
 Thu, 18 Oct 2018 16:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181018210933.113592-1-evgreen@chromium.org> <20181018210933.113592-6-evgreen@chromium.org>
In-Reply-To: <20181018210933.113592-6-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Oct 2018 16:53:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAdZhb4Bq_MKni_-ep283v4dLw8i3Y7dy5-Y+7gwOKxg@mail.gmail.com>
Message-ID: <CAD=FV=XAdZhb4Bq_MKni_-ep283v4dLw8i3Y7dy5-Y+7gwOKxg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>, cang@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 18, 2018 at 2:10 PM Evan Green <evgreen@chromium.org> wrote:
>
> This change adds the second lane registers for the USB PHY, now that the
> QMP phy bindings have been updated. This way the driver can stop
> reaching beyond its register region to get at the second lane.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 9c72edb678ec..f28c50e93f5a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1188,10 +1188,12 @@
>                                  <&gcc GCC_USB3_PHY_PRIM_BCR>;
>                         reset-names = "phy", "common";
>
> -                       usb_1_ssphy: lane@88e9200 {
> +                       usb_1_ssphy: lanes@88e9200 {
>                                 reg = <0x88e9200 0x128>,
>                                       <0x88e9400 0x200>,
>                                       <0x88e9c00 0x218>,
> +                                     <0x88e9600 0x128>,
> +                                     <0x88e9800 0x200>,
>                                       <0x88e9a00 0x100>;
>                                 #phy-cells = <0>;
>                                 clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> @@ -1219,10 +1221,12 @@
>                                  <&gcc GCC_USB3_PHY_SEC_BCR>;
>                         reset-names = "phy", "common";
>
> -                       usb_2_ssphy: lane@88eb200 {
> +                       usb_2_ssphy: lanes@88eb200 {
>                                 reg = <0x88eb200 0x128>,
>                                       <0x88eb400 0x1fc>,
>                                       <0x88eb800 0x218>,
> +                                     <0x88eb600 0x128>,
> +                                     <0x88eb800 0x1fc>,

This is wrong and needs to be fixed.  The
"qcom,sdm845-qmp-usb3-uni-phy" is not dual-lane and thus shouldn't
have tx2/rx2.  The driver knows "qcom,sdm845-qmp-usb3-uni-phy" is not
dual lane and thus will try to map tx2 as pcs_misc.


Also overall I'll continue to point out that this patch needs to land
_after_ the driver fix since the new driver can cope with either style
device tree (at least temporarily) but the old driver can't cope with
the new device tree.  See patch #2 comments for details.

-Doug
