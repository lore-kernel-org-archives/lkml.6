Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1DAC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867532081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GMC6Lg5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867532081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeKDLxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:53:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44840 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeKDLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:53:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so2752900plq.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 19:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=1BRg6uqAH1R7GorNJrsvqS5VAN/pTjBPIRnpfvGZDzM=;
        b=GMC6Lg5ttRRrbhIMSYO2Z0ikTJgmXfS5crQ14PCFN27A8hqHmx/+pM0QngMF+boWJk
         pBYrakfhtlZ2mxyRdQQYz50mg33KXqerXMI9RxkV/3yPfEpWxECdtPczaNSphthWZ6hx
         v4nBEOQXrgrWab9NJcLnrphI/Vi/rIkje3oc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=1BRg6uqAH1R7GorNJrsvqS5VAN/pTjBPIRnpfvGZDzM=;
        b=tpzesKSMyaxRuXiQdt8AYCdH+wGg0AGeHGBrjVSO8Xw8j+LdWINs/TJg3ETbCxK3cm
         A49Gh+YeGAPpJWn4WKbG00XNZ/m5D7Ms4wVZifgEMIVV66K2KF2XRLdLV2Ij7VFWLSF8
         Qc06zri4N6M8J49+Z14UNPZvNTlANUjLKJgue+uSJx9HT/z+DEABJeQ5jP3qMPbDNeGb
         LtqVZ7nUE3M9awf5nf8Ws7MTbz+j8FCeJLwk5rbdG5eTPZMQEAVH0l3GJcHgass6JjYd
         K9FXebZd5eD5brhCnUp/vbWZdfGNprEgF1AXTam+0B7/1u/ac4FtCgyD87ANuxZxC5nq
         xdDQ==
X-Gm-Message-State: AGRZ1gKUdPT4V1K5HKvxWxRxg4YftHfHFtr5UBtPoOHYTibccgLIF4No
        2YxOmwD1n9V4C7oHV1MGFTU0ig==
X-Google-Smtp-Source: AJdET5f2Z5YHgpQNSzpPEH7IAycti8ZDkEHe0Wv9XU/AEgo+pIx99m+0WFmsxFUvpjK4dhrpS6DW3A==
X-Received: by 2002:a17:902:5c4:: with SMTP id f62-v6mr17434270plf.18.1541299220103;
        Sat, 03 Nov 2018 19:40:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id b185sm4606049pga.85.2018.11.03.19.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 19:40:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181026173544.136037-2-evgreen@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-2-evgreen@chromium.org>
Message-ID: <154129921872.88331.15831802252403117971@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/5] dt-bindings: phy-qcom-qmp: Fix register underspecification
Date:   Sat, 03 Nov 2018 19:40:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-10-26 10:35:40)
>                         (or)
> @@ -150,3 +153,54 @@ Example:
>                 ...
>                 ...
>         };
> +
> +       phy@88eb000 {
> +               compatible =3D "qcom,sdm845-qmp-usb3-uni-phy";
> +               reg =3D <0x88eb000 0x18c>;
> +               #clock-cells =3D <1>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +
> +               clocks =3D <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
> +                        <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
> +                        <&gcc GCC_USB3_SEC_CLKREF_CLK>,
> +                        <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
> +               clock-names =3D "aux", "cfg_ahb", "ref", "com_aux";
> +
> +               resets =3D <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
> +                        <&gcc GCC_USB3_PHY_SEC_BCR>;
> +               reset-names =3D "phy", "common";
> +
> +               lane@88eb200 {
> +                       reg =3D <0x88eb200 0x128>,
> +                             <0x88eb400 0x1fc>,
> +                             <0x88eb800 0x218>,
> +                             <0x88eb600 0x70>;
> +                       #phy-cells =3D <0>;
> +                       clocks =3D <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
> +                       clock-names =3D "pipe0";
> +                       clock-output-names =3D "usb3_uni_phy_pipe_clk_src=
";

If this has clock-output-names then I would expect to see a #clock-cells
property, but that isn't here in this node. Are we relying on the same
property in the parent node?

> +               };
> +       };
