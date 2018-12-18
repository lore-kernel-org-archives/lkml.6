Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1976DC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D354621871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCH4B9Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLROfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:35:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40470 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeLROfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:35:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id v5so12451495lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjtDy5LCCPCxU08g/WY8ZETjRs/RcgYVHI8wzk4RLPc=;
        b=TCH4B9Sx8zA8ePT/xOySX0oG4gKueOSsJuNwS/1mw/4VdhisSdI7+EgmovbgAGqYZ/
         q8dsA+lbLP7/HlZa/EKut+PzX7YfV1le+RiJ/GGv2Oyo1h68cLYsYp7sZMFqeQnKLd2S
         lyxy+S6RAjO6kZiVH6Y9xuRkzg8zL4xRUt/8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjtDy5LCCPCxU08g/WY8ZETjRs/RcgYVHI8wzk4RLPc=;
        b=nWEYFlSUK2o/zE/pHnzKzcMsfzFsXzOMkLgHkDKghxQHfAiT6Sfk13DEdGaYWfbO14
         qMvNqtrkcqUXoXBuFfqRQye2WyqsLyzwEkk1TMyzYXDcz/ACI6aqm3Q8Ymf4gcJXzIX7
         q6pthqvrMt0vqhgzIlX5r2DoPQNkeRx1kAvYzIpMd/LyWNbQRF5oDL3AnpmNY8CF/PAu
         ++LqicxiPrW7Q+jkjjaYiadYrwOwLgTtBQ2MlY2ut7sHkPHpZ/LxPQlTepg88IWgzb20
         YYnS9C1whGw14cI9b23KHwBRqety1j1zMEKM4TBIBBt8EgezKPQNITsw/ONdAcHBqfaA
         UMng==
X-Gm-Message-State: AA+aEWbWaR3P3Lx43fNZ1wiPdwHQ8czD+pBrvKsNxfqQJV/4YPayU+Cr
        xfuyzm4Qmnku4Om0A4BhbRdfMQ==
X-Google-Smtp-Source: AFSGD/U20A6CEFVSajvQAN+pviytKaYVlOmZX9yKcEB9j6OzbKJBo8x4a2G9O1BD33zRmMyUtSOS1A==
X-Received: by 2002:a19:9904:: with SMTP id b4mr9734560lfe.95.1545143706995;
        Tue, 18 Dec 2018 06:35:06 -0800 (PST)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id a62sm3284092lfa.37.2018.12.18.06.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:35:06 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:35:03 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, bjorn.andersson@linaro.org, vkoul@kernel.org,
        sibis@codeaurora.org, georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
Message-ID: <20181218143503.GA32562@centauri.ideon.se>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
> > Allow accessing the parent clock names required for the driver
> > operation by using the device tree node.
> > 
> > This permits extending the driver to other platforms without having to
> > modify its source code.
> > 
> > For backwards compatibility leave previous values as default.
> 
> Why do we need to maintain backwards compatibility? Isn't is required
> that the nodes have clocks properties?
> 

Hello Stephen,


This is the existing DT nodes for msm8916:

               a53pll: clock@b016000 {
                        compatible = "qcom,msm8916-a53pll";
                        reg = <0xb016000 0x40>;
                        #clock-cells = <0>;
                };

                apcs: mailbox@b011000 {
                        compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
                        reg = <0xb011000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&a53pll>;
                        #clock-cells = <0>;
                };


This is the (suggested) DT nodes for qcs404:

                apcs_hfpll: clock-controller@0b016000 {
                        compatible = "qcom,hfpll";
                        reg = <0x0b016000 0x30>;
                        #clock-cells = <0>;
                        clock-output-names = "apcs_hfpll";
                        clocks = <&xo_board>;
                        clock-names = "xo";
                };

                apcs_glb: mailbox@b011000 {
                        compatible = "qcom,qcs404-apcs-apps-global", "syscon";
                        reg = <0x0b011000 0x1000>;
                        #mbox-cells = <1>;
                        clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
                        clock-names = "aux", "pll";
                        #clock-cells = <0>;
                };

qcs404 specifies two clocks, with an accompanied clock-name for each clock.

msm8916 specifies a single clock, without an accompanied clock-name.

It is possible to append clock-names = "pll" for the existing clock,
as well as to define the aux clock in the apcs node in the msm8916 DT:
clocks = <&gcc GPLL0_VOTE>;
clock-names = "aux";

However, since the DT is treated as an ABI, the existing DT for msm8916 must
still work, so I don't think that it is possible to ignore having backwards
compability in the apcs clock driver.


Kind regards,
Niklas
