Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D960C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E65F2145D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ruqiq1Dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E65F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLAL6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:58:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35589 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeLAL6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:58:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so6559208ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9HJj8oQEV2tIq6wjZVCRS3Wb3cxGZvLkl9XqwuIovs=;
        b=Ruqiq1DyBvh9xaj9BiP5z75PTptbcHbQONvqi+pMje/q/DqwwsYLPi2Th6rcv/HcZ4
         UnKF5svkrTajzSW/r7RytDnCa5u2OTWKiuYcEFlrzjE+iAZpvj8gwYbX8gwsh7gkIKQv
         S4wiHnuF2P76oCPhdifJrPnIGnF+NqO8QolOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9HJj8oQEV2tIq6wjZVCRS3Wb3cxGZvLkl9XqwuIovs=;
        b=WedUKdIjOWeaw0INJSEELnY6QSo8CDidk1WVeH7OGoQw7q1WuF5OvTBeitbFYKUADx
         /YfNONxMsZOS3MbXpvSIodf9lhHCj3xiL9WkZWcjFF5ozq0eOI+HNN8vEW9yHnNUq8h2
         ZLqV5Y1WOYxki2BbjAyARuwB7SmrE2uG1fPrOYnha7szyk9cx4YBgtWOacc1HHfScpJU
         HgkaVEBoeFZy4my1MByfm38Cv+C3CdD+bi9991pVhL5HFQ2G8qP+cX5NM5ed2cjW//ym
         obdPl0Pr1FEf+zH5S6rh1Pz+tjTiB7DM4ktOP1mM7E7lOVbT7w4a+vtX0bpOVy5xk/BN
         MfZA==
X-Gm-Message-State: AA+aEWaX17XIk3KMx4vZoZLonH6JpNwGNJ+6jdGNfZCJR7tH2dPAMR+8
        aAszFhw/8b4hQUKTt8g1Vyf0N395/eM=
X-Google-Smtp-Source: AFSGD/Vznpxzx/Xe5FnolX+WstiuHLgv7jJecfBGoqEozxbcmnNHIm0Wz1g6+bQ7R+y1U1xvwS/9Sg==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr5536400ljb.52.1543625256794;
        Fri, 30 Nov 2018 16:47:36 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y24-v6sm1044225ljd.20.2018.11.30.16.47.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:47:36 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id s5-v6so6526749ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:47:36 -0800 (PST)
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr5132083lje.110.1543624788281;
 Fri, 30 Nov 2018 16:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org> <20181127180349.29997-7-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-7-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 30 Nov 2018 16:39:11 -0800
X-Gmail-Original-Message-ID: <CAE=gft4XEqkL4oON=Q1oji=AoYeEdL5DFjy3h6hN6uFR9oRA4A@mail.gmail.com>
Message-ID: <CAE=gft4XEqkL4oON=Q1oji=AoYeEdL5DFjy3h6hN6uFR9oRA4A@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] arm64: dts: sdm845: Add interconnect provider DT nodes
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        thierry.reding@gmail.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Add RSC (Resource State Coordinator) provider
> dictating network-on-chip interconnect bus performance
> found on SDM845-based platforms.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..856d33604e9c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1324,6 +1324,11 @@
>                                 compatible = "qcom,sdm845-rpmh-clk";
>                                 #clock-cells = <1>;
>                         };
> +
> +                       qnoc: qnoc {
> +                               compatible = "qcom,sdm845-rsc-hlos";
> +                               #interconnect-cells = <1>;
> +                       };

Should we alphabetize this node above rpmhcc?

>                 };
>
>                 intc: interrupt-controller@17a00000 {
